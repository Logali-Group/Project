*&---------------------------------------------------------------------*
*& Report ztest_logali
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ztest_logali.

TYPES: BEGIN OF lty_flights,
         iduser     TYPE /aif/docu_id,
         aircode    TYPE s_carr_id,
         flightnum  TYPE s_conn_id,
         key        TYPE land1,
         seat       TYPE s_seatsocc,
         flightdate TYPE s_date,
       END OF lty_flights.

SELECT FROM sflight
    FIELDS *
    INTO TABLE @DATA(gt_flights_type).

SELECT FROM spfli
    FIELDS carrid, connid, countryfr
    INTO TABLE @DATA(gt_airline).


DATA: gt_final TYPE SORTED TABLE OF lty_flights WITH NON-UNIQUE KEY flightnum.


gt_final = VALUE #(  FOR gs_flight_type IN gt_flights_type WHERE ( carrid = 'SQ' )

                        FOR gs_airline  IN gt_airline  FROM line_index( gt_airline[ connid = gs_flight_type-connid ] )
                            WHERE ( connid = gs_flight_type-connid )

                         ( iduser     = sy-mandt
                           aircode    =  gs_flight_type-carrid
                           flightnum  =  gs_airline-connid
                           key        =  gs_airline-countryfr
                           seat       =  gs_flight_type-seatsocc
                           flightdate =  gs_flight_type-fldate    )  ).

*cl_demo_output=>display( gt_final ).


"COLLECT


SELECT FROM spfli
    FIELDS *
    INTO TABLE @DATA(gt_spfli).

DATA gt_members LIKE gt_spfli.

LOOP AT gt_spfli INTO DATA(gs_spfli)

"Agrupación por más de una columna de grupos

 GROUP BY (  airline = gs_spfli-countryfr
             city    = gs_spfli-airpfrom  )

          ASSIGNING FIELD-SYMBOL(<gfs_key>).

"Miembros de una columna de grupos

  CLEAR gt_members.

  LOOP AT GROUP <gfs_key> ASSIGNING FIELD-SYMBOL(<gfs_member>).

    gt_members = VALUE #(  BASE gt_members ( <gfs_member> ) ).

  ENDLOOP.

* cl_demo_output=>write( gt_members ).

ENDLOOP.

*cl_demo_output=>display( ).



"LET

SELECT FROM sflight
    FIELDS *
    INTO TABLE @DATA(lt_flights).

SELECT FROM scarr
   FIELDS  *
   INTO TABLE @DATA(lt_airline).

LOOP AT lt_flights INTO DATA(ls_flight).

  DATA(lv_flights) = CONV string( LET lv_airline_name  = lt_airline[ carrid = ls_flight-carrid ]-carrname
                                      lv_flight_price  = lt_flights[ carrid =  ls_flight-carrid
                                                                     connid =  ls_flight-connid ]-price
                                      IN | Airline name: { lv_airline_name } /  Flight price: { lv_flight_price } |  ).

*cl_demo_output=>write( lv_flights ).

ENDLOOP.

*cl_demo_output=>display(  ).


"FILTER

DATA: lt_flights_all   TYPE STANDARD TABLE OF spfli,
      lt_flights_final TYPE STANDARD TABLE OF spfli,
      "Filter table
      lt_filter        TYPE SORTED TABLE OF scarr-carrid WITH UNIQUE KEY table_line.


SELECT FROM spfli
    FIELDS *
    INTO TABLE @lt_flights_all.


lt_filter = VALUE #( ( 'SQ ' ) ).

lt_flights_final  = FILTER #( lt_flights_all IN lt_filter WHERE carrid = table_line   ).


*cl_demo_output=>write( lt_flights_all ).
*cl_demo_output=>write( lt_flights_final ).
*cl_demo_output=>write( lt_filter ).
*cl_demo_output=>display(  ).


"ENUM
TYPES:
       gbty_currency   TYPE c LENGTH 5,
       BEGIN OF ENUM gty_currency BASE TYPE gbty_currency,
         c_initial VALUE IS INITIAL,
         c_dollar  VALUE 'USD',
         c_euros   VALUE 'EUR',
         c_colpeso VALUE 'COP',
         c_mexpeso VALUE 'MEX',
       END OF ENUM gty_currency.

DATA: gv_currency TYPE gty_currency VALUE c_colpeso.

WRITE: / gv_currency.

gv_currency = c_euros.

WRITE: / gv_currency.


"TABLA DE RANGOS

TYPES gty_price TYPE RANGE OF sflight-seatsocc.

DATA(gt_range) = VALUE gty_price(  ( sign = 'I' option = 'BT' low = '200' high = '400') ).

SELECT *
       FROM sflight
       WHERE seatsocc IN @gt_range
       INTO TABLE @DATA(gtr_sflight).

SORT gtr_sflight BY seatsocc.

*cl_demo_output=>write(  gt_range ).
*cl_demo_output=>write(  gtr_sflight ).
*cl_demo_output=>display(  ).

**********************************************************************

TYPES:
  gty_scarr    TYPE HASHED TABLE OF scarr    WITH UNIQUE KEY carrid,
  gty_spfli    TYPE HASHED TABLE OF spfli    WITH UNIQUE KEY carrid connid,
  gty_sflight  TYPE HASHED TABLE OF sflight  WITH UNIQUE KEY carrid connid fldate,
  gty_sairport TYPE HASHED TABLE OF sairport WITH UNIQUE KEY id,

  BEGIN OF MESH gty_flights,

    "Nodes
    sflight_node  TYPE gty_sflight,
    sairport_node TYPE gty_sairport,
    scarr_node    TYPE gty_scarr  ASSOCIATION _spfli TO spfli_node
                                    ON carrid = carrid,
    spfli_node    TYPE gty_spfli  ASSOCIATION _sflight TO sflight_node
                                    ON  carrid = carrid
                                    AND connid = connid
                           ASSOCIATION _sairport TO sairport_node
                                    ON id = airpfrom,
  END OF MESH gty_flights.

DATA gt_flights2 TYPE gty_flights.

"sflight
SELECT FROM sflight
    FIELDS *
    INTO TABLE @gt_flights2-sflight_node.

"sairport
SELECT FROM sairport
   FIELDS *
   INTO TABLE @gt_flights2-sairport_node.

"scarr
SELECT FROM scarr
   FIELDS *
   INTO TABLE @gt_flights2-scarr_node.

"spfli
SELECT FROM spfli
   FIELDS *
   INTO TABLE @gt_flights2-spfli_node.


"Mesh path

"scarr node
DATA(gs_flight2) = gt_flights2-scarr_node\_spfli[ gt_flights2-scarr_node[ carrid = 'LH' ] ].

TRY.

    "spfli node
    DATA(gs_flight3) = gt_flights2-spfli_node\_sflight[ gt_flights2-spfli_node[ carrid = 'AA' connid = '0017' ] ].
    DATA(gs_flight4) = gt_flights2-spfli_node\_sairport[ gt_flights2-spfli_node[ airpfrom = 'JFK' ] ].


  CATCH cx_sy_itab_line_not_found INTO DATA(gx_sy_itab_line_not_found).
    WRITE gx_sy_itab_line_not_found->get_text(  ).


ENDTRY.


cl_demo_output=>write( gs_flight2 ).
cl_demo_output=>write( gs_flight3 ).
cl_demo_output=>write( gs_flight4 ).
cl_demo_output=>display(  ).













*DATA: gv_date    TYPE d      VALUE '20250101',
*      gv_time    TYPE t      VALUE '124500',
*      gv_num     TYPE i      VALUE  7,
*      gv_string  TYPE string VALUE 'Logali-group-Academia-SAP',
*      gv_stringa TYPE string VALUE 'Laura',
*      gv_stringb TYPE string VALUE 'Martínez'.
*
*CONSTANTS gc_constant TYPE i VALUE 5.
*
*DATA(gv_sum)      = gv_num + gc_constant.
*DATA(gv_subtract) = gv_num - gc_constant.
*DATA(gv_multip)   = gv_num * gc_constant.
*
*REPLACE ALL OCCURRENCES OF '-' IN gv_string WITH '/'.
*
*CONCATENATE gv_stringa gv_stringb INTO DATA(gv_stringfin) SEPARATED BY space.
*
*
*WRITE: / 'Fecha:'         , gv_date DD/MM/YY,
*       / 'Hora:'          , gv_time ENVIRONMENT TIME FORMAT,
*       / 'Número:'        , gv_num,
*       / 'Cadena:'        , gv_string,
*       / 'Constante:'     , gc_constant,
*       / 'Concatenación:' , gv_stringfin.
*
*"IF
*IF gv_num EQ 7.
*  WRITE: / 'Número igual 7'.
*ELSE.
*  WRITE: / 'Número distinto de 7'.
*ENDIF.
*
*"DO
*
*DATA(gv_num2) = 5.
*
*DO 10 TIMES.
*
*  gv_num2 += 1.
*  WRITE: / 'Número:' , gv_num2.
*
*ENDDO.
*
*"LECTURA
*SELECT FROM scarr
*  FIELDS *
*  WHERE currcode EQ 'USD'
*  INTO TABLE @DATA(gt_flights).
*
*APPEND VALUE #(  carrid   = 'XX'
*                 carrname = 'Colombia airline'
*                 currcode = 'COP'
*                 url      = 'www.colombiaair.com'    ) TO gt_flights.
*
*
*cl_demo_output=>display( gt_flights ).





*TYPES wa TYPE sflight WITH INDICATORS ind.
*
*DATA itab TYPE TABLE OF wa WITH EMPTY KEY.
*
*SELECT carrid, connid, fldate, price
*       FROM sflight
*       WHERE carrid = char`LH` AND
*             connid = numc`0400` AND
*             fldate > '20180601'
*       INTO CORRESPONDING FIELDS OF TABLE @itab.
*
*IF sy-subrc  = 0.
*
*  LOOP AT itab ASSIGNING FIELD-SYMBOL(<wa>).
*    <wa>-price *= '0.8'.
*    <wa>-ind-price = '01'.
*  ENDLOOP.
*
*  UPDATE sflight FROM TABLE @itab INDICATORS SET STRUCTURE ind.
*
*ENDIF.
