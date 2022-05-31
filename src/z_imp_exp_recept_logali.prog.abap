*&---------------------------------------------------------------------*
*& Report z_imp_exp_recept_logali
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_imp_exp_recept_logali.

DATA: lt_sflight2 TYPE STANDARD TABLE OF sflight.
*      ls_sflight2 TYPE sflight.

IMPORT lt_sflight TO lt_sflight2 FROM MEMORY ID 'LT_SFLIGHT'.

cl_demo_output=>display( lt_sflight2 ).

FREE MEMORY ID 'LT_SFLIGHT'.
