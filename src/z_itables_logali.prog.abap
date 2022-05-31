*&---------------------------------------------------------------------*
*& Report z_itables_logali
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_itables_logali.

"Before ABAP 7.4
DATA: gt_employees TYPE STANDARD TABLE OF zemp_logali.
*     gs_employee  TYPE zemp_logali.

*gs_employee-id     = '0001' .
*gs_employee-name   = 'Luis'.
*gs_employee-lastn1 = 'Perez'.
*gs_employee-lastn2 = 'Mora'.
*gs_employee-email  = 'LPEREZ@LOGALIGROUP.COM'.
*gs_employee-birthd = '19950205'.
*gs_employee-regisd = sy-datum.
*
*APPEND gs_employee TO gt_employees.
*
*APPEND gs_employee TO gt_employees.
*
*APPEND INITIAL LINE TO gt_employees.
*
*SELECT * FROM zemp_logali
*   APPENDING TABLE gt_employees
*   WHERE regisd GT '20220101'.


"After ABAP 7.4

"Option 1 VALUE

gt_employees =  VALUE #( ( id    = '0002'
                          name   = 'Flor'
                          lastn1 = 'Hernandez'
                          lastn2 = 'Martinez'
                          email  = 'FHERNANDEZ@LOGALIGROUP.COM'
                          birthd = '19990205'
                          regisd =  sy-datum       ) ).

*cl_demo_output=>display( gt_employees ).

"Option 2 APPEND

APPEND VALUE #(    id   = '0003'
                 name   = 'Valentina'
                 lastn1 = 'Lopez'
                 lastn2 = 'Mora'
                 email  = 'VLOPEZ@LOGALIGROUP.COM'
                 birthd = '19900205'
                 regisd =  sy-datum   ) TO gt_employees  .

*cl_demo_output=>display( gt_employees ).

"Option 3 INSERT VALUE

INSERT VALUE #(    id   = '0004'
                 name   = 'Daniela'
                 lastn1 = 'Linares'
                 lastn2 = 'Mora'
                 email  = 'DLINARES@LOGALIGROUP.COM'
                 birthd = '20000205'
                 regisd =  sy-datum   ) INTO gt_employees INDEX 2.

*cl_demo_output=>display( gt_employees ).


"WITH HEADER LINE
DATA gt_employees_he TYPE STANDARD TABLE OF zemp_logali WITH HEADER LINE.

gt_employees_he-id     = '0005' .
gt_employees_he-name   = 'Martha'.
gt_employees_he-lastn1 = 'Prada'.
gt_employees_he-lastn2 = 'Mendez'.
gt_employees_he-email  = 'MPRADA@LOGALIGROUP.COM'.
gt_employees_he-birthd = '19980205'.
gt_employees_he-regisd = sy-datum.

APPEND gt_employees_he.


"OCCURS
DATA: BEGIN OF gt_employees_occurs OCCURS 0,
        id     TYPE string,
        name   TYPE string,
        lastn1 TYPE string,
        lastn2 TYPE string,
        email  TYPE string,
        birthd TYPE d,
        regisd TYPE d,
      END OF gt_employees_occurs.



*DATA: gt_flights TYPE STANDARD TABLE OF spfli.

SELECT FROM spfli
   FIELDS *
   WHERE distid EQ 'KM'
   INTO TABLE @DATA(gt_flights).

IF sy-subrc EQ 0.

  "DESCRIBE
*  DESCRIBE TABLE gt_flights LINES DATA(gv_lines).
*  WRITE: / 'Total number of flights in the LH airline' , gv_lines.

  WRITE: / | INDEX = { line_index( gt_flights[ connid = '0401' ] ) } |.
  WRITE: / | Total number of flights in the LH airline { lines( gt_flights ) } |.

  "READ TABLE
*  READ TABLE gt_flights INTO DATA(gs_flight)
*    WITH KEY connid = '2402'.
*
*  IF sy-subrc EQ 0.
*    WRITE: / 'Departure city =' , gs_flight-cityfrom.
*  ENDIF.

  SKIP.
  DATA(gs_flight) = gt_flights[ connid = '0401' ].
  DATA(gv_flight) = gt_flights[ connid = '0401' ]-cityfrom .

  IF sy-subrc EQ 0.
    WRITE: / | Departure city = { gs_flight-cityfrom } { gs_flight-countryfr } { gs_flight-distid } |.
    WRITE: / | Departure city = { gv_flight } |.
  ENDIF.

  SKIP.

  SORT gt_flights ASCENDING BY carrid connid.
*   SORT gt_flights DESCENDING BY carrid connid.

*  cl_demo_output=>write( gt_flights ).

  "LOOP
  LOOP AT gt_flights INTO gs_flight.
*    WHERE connid GT '0401' .


    IF gs_flight-deptime GT '130000'.
      gs_flight-deptime  = sy-timlo.
      MODIFY gt_flights FROM gs_flight TRANSPORTING deptime.
    ENDIF.

    IF gs_flight-cityfrom EQ 'FRANKFURT'.
      gt_flights[ cityfrom = 'FRANKFURT' ]-cityfrom = 'CDMX'.
    ENDIF.

  ENDLOOP.

ENDIF.

*cl_demo_output=>display( gt_flights ).


"DELETE ITAB WITH HEADER LINE

DATA gt_flights_head TYPE STANDARD TABLE OF spfli WITH HEADER LINE.

SELECT FROM spfli
  FIELDS *
  WHERE distid EQ 'MI'
  INTO TABLE @gt_flights_head.

IF sy-subrc EQ 0.

  WRITE: / 'Internal table BEFORE deleting data'.
  SKIP.

  LOOP AT gt_flights_head.
    WRITE: / gt_flights_head-connid , gt_flights_head-carrid , gt_flights_head-cityfrom.
  ENDLOOP.

  LOOP AT gt_flights_head.

    IF sy-tabix GT 3.
      DELETE gt_flights_head.
    ENDIF.

  ENDLOOP.

  SKIP.

  WRITE: / 'Internal table AFTER deleting data'.
  SKIP.

  DELETE gt_flights_head INDEX 1.

  LOOP AT gt_flights_head.
    WRITE: / gt_flights_head-connid , gt_flights_head-carrid , gt_flights_head-cityfrom.
  ENDLOOP.

ENDIF.


"DELETE ITAB WITH STRUCTURE

DATA: gt_flights_struc TYPE STANDARD TABLE OF spfli,
      gs_flights_struc TYPE spfli.

SELECT FROM spfli
   FIELDS *
   WHERE deptime GT '120000'
   INTO TABLE @gt_flights_struc.

IF sy-subrc EQ 0.

*  cl_demo_output=>write( data = gt_flights_struc
*                         name = 'Initial table' ).

  LOOP AT gt_flights_struc INTO gs_flights_struc.


    IF gs_flights_struc-connid EQ '0005' OR
       gs_flights_struc-connid EQ '0401' OR
       gs_flights_struc-connid EQ '0407' .

      DELETE TABLE gt_flights_struc FROM gs_flights_struc.


    ENDIF.


  ENDLOOP.

  DELETE gt_flights_struc INDEX 2.

  DELETE gt_flights_struc WHERE fltype IS INITIAL.

ENDIF.


*cl_demo_output=>display( data = gt_flights_struc
*                       name = 'Table with deleted data' ).



"MOVE-CORRESPONDING BEFORE ABAP 7.4

TYPES: BEGIN OF lty_flights,
         iduser     TYPE /aif/docu_id,
         aircode    TYPE s_carr_id,
         flightnum  TYPE s_conn_id,
         key        TYPE land1,
         seat       TYPE s_seatsocc,
         flightdate TYPE s_date,
       END OF lty_flights.

DATA: gt_my_flights TYPE STANDARD TABLE OF lty_flights.
*      gs_my_flight  TYPE lty_flights.

gt_my_flights = CORRESPONDING #( gt_flights MAPPING  aircode   = carrid
                                                     flightnum = connid
                                                     EXCEPT key
                                                                  ).

*LOOP AT gt_flights INTO gs_flight.
*
*  MOVE-CORRESPONDING gs_flight TO gs_my_flight.
*
*  APPEND gs_my_flight TO gt_my_flights.
*
*ENDLOOP.

*cl_demo_output=>write( gt_flights ).
*cl_demo_output=>write( gt_my_flights ).
*cl_demo_output=>display(  ).



"FOR
DATA gt_flights_info TYPE STANDARD TABLE OF lty_flights.

gt_my_flights = VALUE #( FOR i = 1 UNTIL i > 30
                        ( iduser     =  | { 123456 + i }-USER |
                          aircode    =  'LH'
                          flightnum  =  0000 + i
                          key        =  |US|
                          seat       =  0 + i
                          flightdate =  sy-datum + i ) ).


*gt_flights_info =  VALUE #( FOR i = 1 WHILE i <= 20
*                           ( iduser     =  | { 123456 + i }-USER |
*                             aircode    =  'LH'
*                             flightnum  =  0000 + i
*                             key        =  |US|
*                             seat       =  0 + i
*                             flightdate =  sy-datum + i ) ).

gt_flights_info = VALUE #( FOR gs_my_flights IN gt_my_flights
                           WHERE ( aircode = 'LH' AND flightnum GT 0012 )
                           ( iduser     =  gs_my_flights-iduser
                             aircode    =  'AA'
                             flightnum  =  gs_my_flights-flightnum + 10
                             key        =  'DE'
                             seat       =  gs_my_flights-seat
                             flightdate =  gs_my_flights-flightdate
                                   ) ).


*cl_demo_output=>write( gt_my_flights ).
*cl_demo_output=>write( gt_flights_info ).
*cl_demo_output=>display(  ).

**********************************************************************

"FOR anidados - Parallel cursor

SELECT FROM sflight
    FIELDS *
    INTO TABLE @DATA(gt_flights_type).

SELECT FROM spfli
    FIELDS carrid, connid, countryfr
    INTO TABLE @DATA(gt_airline).


DATA: gt_final TYPE SORTED TABLE OF lty_flights WITH NON-UNIQUE KEY flightnum.


gt_final = VALUE #(  FOR gs_flight_type IN gt_flights_type "WHERE ( carrid = 'LH' )

                        FOR gs_airline  IN gt_airline  FROM line_index( gt_airline[ connid = gs_flight_type-connid ] )
                            WHERE ( connid = gs_flight_type-connid )

                          ( aircode   =  gs_flight_type-carrid
                           flightnum  =  gs_airline-connid
                           key        =  gs_airline-countryfr
                           seat       =  gs_flight_type-seatsocc
                           flightdate =  gs_flight_type-fldate    )  ).

*cl_demo_output=>display( gt_final ).

**********************************************************************

"COLLECT

DATA: BEGIN OF lty_seats,
        carrid TYPE sflight-carrid,
        connid TYPE sflight-connid,
        seats  TYPE sflight-seatsocc,
        price  TYPE sflight-price,
      END OF lty_seats.

DATA: gt_seats LIKE HASHED TABLE OF lty_seats WITH UNIQUE KEY carrid connid.

SELECT carrid, connid, seatsocc, price
    FROM sflight
    INTO @lty_seats.

  COLLECT lty_seats INTO gt_seats.

ENDSELECT.

*cl_demo_output=>display( gt_seats ).


**********************************************************************

"GROUP BY

SELECT FROM spfli
    FIELDS *
    INTO TABLE @DATA(gt_spfli).

DATA: gt_members LIKE gt_spfli.


LOOP AT gt_spfli INTO DATA(gs_spfli)

*"Grouping one column
*    GROUP BY gs_spfli-carrid.

"Grouping by more than one column

GROUP BY (  airline = gs_spfli-carrid
            city    = gs_spfli-cityfrom )
*            index   = GROUP INDEX
*            size    = GROUP SIZE
*            WITHOUT MEMBERS
*         INTO DATA(gs_key).
          ASSIGNING FIELD-SYMBOL(<gfs_key>).


  "Members

  CLEAR gt_members.

  LOOP AT GROUP <gfs_key> ASSIGNING FIELD-SYMBOL(<gfs_member>).

    gt_members = VALUE #( BASE gt_members ( <gfs_member> ) ) .

  ENDLOOP.


*  cl_demo_output=>write( gt_members ).

*  cl_demo_output=>write( gs_key ).

ENDLOOP.


*cl_demo_output=>display(  ).


**********************************************************************

TYPES: lty_group_keys TYPE STANDARD TABLE OF spfli-cityfrom WITH EMPTY KEY.

*cl_demo_output=>display( VALUE lty_group_keys(  FOR GROUPS  gv_group OF gs_group IN gt_spfli
*                                                GROUP BY gs_group-cityfrom
*                                                ASCENDING
*                                                WITHOUT MEMBERS ( gv_group )
*                                                    )        ).


**********************************************************************

"LET

SELECT FROM sflight
    FIELDS *
    INTO TABLE @DATA(lt_flights).

SELECT FROM scarr
    FIELDS *
    INTO TABLE @DATA(lt_airline).

LOOP AT lt_flights INTO DATA(ls_flight).

  DATA(lv_flights) = CONV string(  LET lv_airline_name = lt_airline[ carrid = ls_flight-carrid ]-carrname
                                       lv_flight_price = lt_flights[ carrid = ls_flight-carrid
                                                                     connid = ls_flight-connid ]-price
                                       lv_carrid       = lt_airline[ carrid = ls_flight-carrid ]-carrid
                                   IN | { lv_carrid } / Airline name: { lv_airline_name }  /  Flight price: { lv_flight_price }   |  ).

*cl_demo_output=>write( lv_flights  ).

ENDLOOP.

*cl_demo_output=>display(   ).

**********************************************************************

"BASE

DATA lt_seats LIKE gt_seats.

lt_seats = VALUE #( BASE gt_seats (   carrid  = 'XX'
                                      connid  = '001'
                                      seats   = '125'
                                      price   = '250'            )         ).


*cl_demo_output=>display( lt_seats ).


**********************************************************************

"FILTER

DATA: lt_flights_all   TYPE STANDARD TABLE OF spfli,
      lt_flights_final TYPE STANDARD TABLE OF spfli,
      "Filter table
      lt_filter        TYPE SORTED TABLE OF scarr-carrid WITH UNIQUE KEY table_line.


SELECT FROM spfli
    FIELDS *
    INTO TABLE @lt_flights_all.


lt_filter = VALUE #( ( 'AA ' ) ( 'LH ' ) ( 'UA ' ) ).

lt_flights_final  = FILTER #( lt_flights_all IN lt_filter WHERE carrid = table_line   ).


*cl_demo_output=>write( lt_flights_all ).
*cl_demo_output=>write( lt_flights_final ).
*cl_demo_output=>write( lt_filter ).
*cl_demo_output=>display(  ).


**********************************************************************
ULINE.

"ENUM

TYPES:
  BEGIN OF ENUM gty_colors STRUCTURE gs_colors,
    c_initial ,
    c_white   ,
    c_black   ,
    c_purple  ,
    c_red     ,
    c_blue    ,
  END OF ENUM gty_colors STRUCTURE gs_colors.

DATA: gv_color TYPE gty_colors VALUE gs_colors-c_red.

CASE gv_color.

  WHEN gs_colors-c_white.
    WRITE 'The color is white'.
  WHEN gs_colors-c_black.
    WRITE 'The color is black'.
  WHEN gs_colors-c_purple.
    WRITE 'The color is purple'.
  WHEN gs_colors-c_red.
    WRITE 'The color is red'.
  WHEN gs_colors-c_blue.
    WRITE 'The color is blue'.
  WHEN OTHERS.
    WRITE 'Unregistered color'.

ENDCASE.

*WRITE: / gv_color.


*TYPES:
*       gbty_colors TYPE c LENGTH 8,
*       BEGIN OF ENUM gty_colors BASE TYPE gbty_colors,
*         c_initial VALUE IS INITIAL,
*         c_white   VALUE 'white',
*         c_black   VALUE 'black',
*         c_purple  VALUE 'purple',
*         c_red     VALUE 'red',
*         c_blue    VALUE 'blue',
*       END OF ENUM gty_colors.
*
*DATA: gv_color TYPE gty_colors VALUE c_purple.
*
*WRITE: / gv_color.

*gv_color = 'blue'.
*WRITE: / gv_color.

**********************************************************************

"Tablas de rangos / TYPE RANGE OF

TYPES: gty_price TYPE RANGE OF sflight-price.

DATA(gt_range) = VALUE gty_price(  ( sign   = 'I'
                                     option = 'BT'
                                     low    = '600'
                                     high   = '1000')  ).


SELECT FROM sflight
    FIELDS *
    WHERE price IN @gt_range
    INTO TABLE @DATA(gtr_sflight).

SORT gtr_sflight BY price.

DELETE ADJACENT DUPLICATES FROM gtr_sflight COMPARING price.

*cl_demo_output=>write( gt_range ).
*cl_demo_output=>write( gtr_sflight ).
*cl_demo_output=>display(  ).

**********************************************************************

"MESH

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

    "Inverse association
    DATA(gs_scarr) = gt_flights2-spfli_node\^_spfli~scarr_node[ gt_flights2-spfli_node[ carrid = 'LH' connid = '2402' ] ].

    DATA(gv_price) = gt_flights2-scarr_node\_spfli[ gt_flights2-scarr_node[ carrname = 'Lufthansa' ]
                                                                            connid   = '0400' ]\_sflight[ seatsmax = '330' ]-price.

    "Field symbols
    ASSIGN gt_flights2-scarr_node\_spfli[ gt_flights2-scarr_node[ carrname = 'Lufthansa' ]
                                                                  connid   = '0400' ]\_sflight[ seatsmax = '330' ]
                                                                 TO FIELD-SYMBOL(<gs_flight>).

  CATCH cx_sy_itab_line_not_found INTO DATA(gx_sy_itab_line_not_found).
    WRITE gx_sy_itab_line_not_found->get_text(  ).


ENDTRY.


cl_demo_output=>write( gs_flight2 ).
cl_demo_output=>write( gs_flight3 ).
cl_demo_output=>write( gs_flight4 ).
cl_demo_output=>write( gs_scarr ).
cl_demo_output=>write( gv_price ).
cl_demo_output=>write( <gs_flight> ).
cl_demo_output=>display(  ).
