*&---------------------------------------------------------------------*
*& Report z_msg_logali
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_msg_logali.

"Tipos de mensajes en ABAP
" I - Information / Mensaje de información
" S - Success / Mensaje de éxito
" E - Error / Mensaje error lógico
" W - Warning / Mensaje de advertencia
" A - Abend / Mensaje de cancelación
" X - Error / Mensaje de error de progamación DUMP

DATA lv_num TYPE i.

PARAMETERS pa_msg TYPE c.

AT SELECTION-SCREEN ON pa_msg.

IF pa_msg EQ 'E'.

   MESSAGE e012(sabapdocu).

ELSEIF pa_msg EQ 'W'.

   MESSAGE w013(sabapdocu).

ENDIF.

START-OF-SELECTION.

CASE pa_msg.

  WHEN 'I'.
    MESSAGE i014(sabapdocu).
"    MESSAGE 'Information message type' TYPE 'I'. "No se debe utilizar
"    MESSAGE ID 'SABAPDOCU' TYPE 'I' NUMBER '095'.

  WHEN 'S'.
    MESSAGE s015(sabapdocu).

  WHEN 'A'.
    MESSAGE a016(sabapdocu).

  WHEN 'X'.
    MESSAGE x012(sabapdocu).


  WHEN OTHERS.
    WRITE: / 'The message type does not exist'.

ENDCASE.


DATA(lv_msg) = |Hello, { sy-uname }. Today is { sy-datum DATE = ENVIRONMENT } |.

MESSAGE lv_msg TYPE 'I' DISPLAY LIKE 'S'.


WRITE: / 'The program continues with the logic'.
