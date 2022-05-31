*&---------------------------------------------------------------------*
*& Report z_imp_exp_logali
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_imp_exp_logali.


SELECT *
   FROM sflight
   INTO TABLE @DATA(lt_sflight).

EXPORT lt_sflight TO MEMORY ID 'LT_SFLIGHT'.

SUBMIT z_imp_exp_recept_logali.
