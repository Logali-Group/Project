*&---------------------------------------------------------------------*
*& Report z_icon_logali
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_icon_logali.

DATA:
   ls_icon TYPE icon,
   lt_icon TYPE TABLE OF icon.

SELECT * FROM icon
   INTO TABLE lt_icon.

LOOP AT lt_icon INTO ls_icon.

WRITE: / ls_icon-name,
         33 '@',
         34 ls_icon-id+1(2),
         36 '@',
         40 ls_icon-id.

ENDLOOP.
