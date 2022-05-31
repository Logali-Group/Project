*&---------------------------------------------------------------------*
*& Report z_fm_call_logali
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_fm_call_logali.

DATA: gt_flights TYPE ltvf_tt_sflight.

CALL FUNCTION 'Z_FM_FLIGHTS_LOGALI'
  EXPORTING
    iv_carrid  = 'ZZ'
    iv_list    = abap_true

  IMPORTING
    et_flights = gt_flights

  EXCEPTIONS
    ex_flights = 1.

IF sy-subrc NE 0.

  WRITE: / 'There are no flights for the indicated airline'.

ENDIF.

cl_demo_output=>display( gt_flights ).
