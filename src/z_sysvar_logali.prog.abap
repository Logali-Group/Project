*&---------------------------------------------------------------------*
*& Report z_sysvar_logali
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_sysvar_logali.

IF sy-uname EQ 'LOGALI'.

  WRITE: / 'User of Master Logali group =' , sy-uname.

ENDIF.

 WRITE: / 'Connection client =' , sy-mandt,
        / 'Connection language =' , sy-langu,
        / 'Current Dynpro number =' , sy-dynnr.
