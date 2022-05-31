*&---------------------------------------------------------------------*
*& Report z_debug_logali
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_debug_logali.

DATA(lv_num)  = 10.
DATA(lv_num2) = 20.
DATA(lv_string) = 15.


DATA(lv_total) = lv_num + lv_string.

WRITE lv_total.

*BREAK logali.
