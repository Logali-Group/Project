*&---------------------------------------------------------------------*
*& Include          Z_SCREEN_LOGALI_TOP
*&---------------------------------------------------------------------*

TABLES: trdir , tstc.

DATA: gs_employee  TYPE zemp_logali,
      gt_employees TYPE STANDARD TABLE OF zemp_logali,
      gv_flag      TYPE c.
