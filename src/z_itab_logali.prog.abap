*&---------------------------------------------------------------------*
*& Report z_itab_logali
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_itab_logali.

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



*DATA: gt_flights TYPE STANDARD TABLE OF spfli WITH DEFAULT KEY.

SELECT FROM spfli
   FIELDS *
   WHERE distid EQ 'KM'
   INTO TABLE @DATA(gt_flights).

IF sy-subrc EQ 0.

  "Describe
*  DESCRIBE TABLE gt_flights LINES DATA(gv_lines).
*  WRITE: / 'Total number of flights in the LH airline' , gv_lines.

  WRITE: / | INDEX = { line_index( gt_flights[ connid = '0401' ] ) } |.
  WRITE: / | Total number of flights in the LH airline { lines( gt_flights ) } |.

  SKIP.

  "Read
*  READ TABLE gt_flights INTO DATA(gs_flight)
*    WITH KEY connid = '2402'.
*
*  IF sy-subrc EQ 0.
*    WRITE: / 'First departure city =' ,gs_flight-cityfrom.
*  ENDIF.

  DATA(gs_flight) = gt_flights[ connid = '0401'  ].
  DATA(gv_flight) = gt_flights[ connid = '0401' ]-cityfrom.

  IF sy-subrc EQ 0.
    WRITE: / | Departure city = { gs_flight-cityfrom } { gs_flight-countryfr } { gs_flight-distid } |.
    WRITE: / | Departure city = { gv_flight } |.
  ENDIF.

  SKIP.

  SORT gt_flights ASCENDING BY carrid connid.
*  SORT gt_flights DESCENDING BY connid.

*  cl_demo_output=>write( gt_flights ).

  "Loop
  LOOP AT gt_flights INTO gs_flight.
*       WHERE connid GT '0401'.


    IF gs_flight-deptime GT '130000'.
      gs_flight-deptime = sy-timlo.
      MODIFY gt_flights FROM gs_flight TRANSPORTING deptime.
    ENDIF.

*    WRITE: / gs_flight-carrid,
*             gs_flight-connid,
*             gs_flight-distid,
*             gs_flight-arrtime.


    IF gs_flight-cityfrom EQ 'FRANKFURT'.
      gt_flights[ cityfrom = 'FRANKFURT' ]-cityfrom = 'CDMX'.
    ENDIF.

  ENDLOOP.

  SKIP.

*  LOOP AT gt_flights TRANSPORTING NO FIELDS
*       WHERE carrid EQ 'JL'.
*  ENDLOOP.
*
*  IF sy-subrc EQ 0.
*    WRITE: / 'There are flights with the airline code JL'.
*  ENDIF.

ENDIF.

*cl_demo_output=>display( gt_flights ).

*&---------------------------------------------------------------------*

"Delete
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


"DELETE WITH STRUCTURE

DATA: gt_flights_struc TYPE STANDARD TABLE OF spfli,
      gs_flight_struc  TYPE spfli.

SELECT FROM spfli
   FIELDS *
   WHERE deptime GT '120000'
   INTO TABLE @gt_flights_struc.

IF sy-subrc EQ 0.

  cl_demo_output=>write( data = gt_flights_struc
                         name = 'Initial table' ).

  LOOP AT gt_flights_struc INTO gs_flight_struc.

    IF gs_flight_struc-connid EQ '0005' OR
       gs_flight_struc-connid EQ '0401' OR
       gs_flight_struc-connid EQ '0407'.

      DELETE TABLE gt_flights_struc FROM gs_flight_struc.

    ENDIF.

  ENDLOOP.

  DELETE gt_flights_struc INDEX 2.

  DELETE gt_flights_struc WHERE fltype IS INITIAL.

ENDIF.

cl_demo_output=>display( data = gt_flights_struc
                         name = 'Table with deleted data' ).


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

gt_my_flights = CORRESPONDING #( gt_flights MAPPING aircode    = carrid
                                                    flightnum  = connid
                                                    EXCEPT key ).

*LOOP AT gt_flights INTO gs_flight.
*  MOVE-CORRESPONDING gs_flight TO gs_my_flight.
*  APPEND gs_my_flight TO gt_my_flights.
*ENDLOOP.

*cl_demo_output=>write( gt_flights ).
*cl_demo_output=>write( gt_my_flights ).
*cl_demo_output=>display(  ).


"FOR

DATA: gt_flights_info TYPE STANDARD TABLE OF lty_flights.

gt_my_flights =   VALUE #( FOR i = 1 UNTIL i > 30
                         ( iduser     = | { 123456 + i }-USER |
                           aircode    = 'LH'
                           flightnum  =  0000 + i
                           key        = | US |
                           seat       =   0 + i
                           flightdate =   sy-datum + i    ) ).


*gt_flights_info   =  VALUE #( FOR i = 1 WHILE i <= 20
*                         ( iduser     = | { 123456 + i }-USER |
*                           aircode    = 'LH'
*                           flightnum  =  0000 + i
*                           key        = | US |
*                           seat       =   0 + i
*                           flightdate =   sy-datum + i    ) ).

*gt_flights_info = VALUE #( FOR gs_my_flights IN gt_my_flights
*                         ( iduser     = gs_my_flights-iduser
*                           aircode    = gs_my_flights-aircode
*                           flightnum  = gs_my_flights-flightnum
*                           key        = gs_my_flights-key
*                           seat       = gs_my_flights-seat
*                           flightdate = gs_my_flights-flightdate ) ) .

gt_flights_info = VALUE #( FOR gs_my_flights in gt_my_flights
                           WHERE ( aircode    = 'LH' AND flightnum GT 0012 )
                                 ( iduser     = gs_my_flights-iduser
                                   aircode    = 'AA'
                                   flightnum  = gs_my_flights-flightnum + 10
                                   key        = 'DE'
                                   seat       = gs_my_flights-seat
                                   flightdate = gs_my_flights-flightdate ) ) .



cl_demo_output=>write( gt_my_flights ).
cl_demo_output=>write( gt_flights_info ).
cl_demo_output=>display(  ).
