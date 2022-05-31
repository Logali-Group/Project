*&---------------------------------------------------------------------*
*& Report z_reduce_logali
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_reduce_logali.

TYPES: BEGIN OF lty_flights,
         iduser     TYPE /aif/docu_id,
         aircode    TYPE s_carr_id,
         flightnum  TYPE s_conn_id,
         key        TYPE land1,
         seat       TYPE s_seatsocc,
         flightdate TYPE s_date,
         price      TYPE s_price,
       END OF lty_flights.

DATA: gt_my_flights   TYPE STANDARD TABLE OF  lty_flights,
      gt_flights_info TYPE SORTED TABLE OF lty_flights WITH UNIQUE KEY iduser.


gt_my_flights = VALUE #( FOR i = 1 UNTIL i > 30
                         ( iduser     =  | { 123456 + i }-USER |
                           aircode    =  'LH'
                           flightnum  =  0000 + i
                           key        =  |US|
                           seat       =  0 + i
                           flightdate =  sy-datum + i
                           price      =  100 + i  ) ).


gt_flights_info = VALUE #( FOR gs_my_flight IN gt_my_flights
                           WHERE ( flightnum GT 0012 )
                           ( iduser     =  gs_my_flight-iduser
                             aircode    =  gs_my_flight-aircode
                             flightnum  =  gs_my_flight-flightnum
                             key        =  gs_my_flight-key
                             seat       =  gs_my_flight-seat
                             flightdate =  gs_my_flight-flightdate
                             price      =  gs_my_flight-price * 2  ) ).


DATA(gv_price_flights) = REDUCE i( INIT total = 0
                                   FOR gs_flights_info IN gt_flights_info
                                   NEXT total = total + gs_flights_info-price  ).

*cl_demo_output=>write( gt_my_flights ).
*cl_demo_output=>write( gt_flights_info ).
*cl_demo_output=>write( gv_price_flights ).
*cl_demo_output=>display(  ).


***********************************************************************

SELECT FROM sflight
   FIELDS *
   WHERE currency EQ 'EUR'
   INTO TABLE @DATA(gt_flights).

DATA(gv_price_flights2) = REDUCE #( INIT i = 0
                                    FOR gs_flight IN gt_flights
                                    NEXT i = i + gs_flight-price  ).
                                    .
data gv TYPE decfloat16 VALUE '25,5'.

cl_demo_output=>write( gt_flights ).
cl_demo_output=>write( gv_price_flights2 ).
cl_demo_output=>display(  ).

*WRITE: / |Sum of flight prices = { gv_price_flights2 }  | .

**********************************************************************
