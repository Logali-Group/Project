*&---------------------------------------------------------------------*
*& Report z_ext_program_logali
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ext_program_logali.

DATA: gt_employees TYPE STANDARD TABLE OF zemp_logali,
      gv_flag      TYPE c.


*PERFORM get_information IN PROGRAM z_screen_logali.

PERFORM get_information(z_screen_logali) TABLES gt_employees.

PERFORM view_employees IN PROGRAM z_screen_logali TABLES  gt_employees
                                                  CHANGING gv_flag.
