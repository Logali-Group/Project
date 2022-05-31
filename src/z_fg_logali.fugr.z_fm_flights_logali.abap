FUNCTION z_fm_flights_logali.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_CARRID) TYPE  S_CARRID
*"     REFERENCE(IV_LIST) TYPE  FLAG OPTIONAL
*"  EXPORTING
*"     REFERENCE(ET_FLIGHTS) TYPE  LTVF_TT_SFLIGHT
*"  EXCEPTIONS
*"      EX_FLIGHTS
*"----------------------------------------------------------------------
  SELECT FROM sflight FIELDS *
      WHERE carrid EQ @iv_carrid
      INTO TABLE @et_flights.

  IF lines( et_flights ) GT 0 AND iv_list EQ abap_true.

    LOOP AT et_flights ASSIGNING FIELD-SYMBOL(<gs_flight>).

      WRITE:
       / <gs_flight>-carrid,
       / <gs_flight>-connid.

    ENDLOOP.

   ELSEIF lines( et_flights ) EQ 0.

    RAISE ex_flights.

  ENDIF.


ENDFUNCTION.
