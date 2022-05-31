*&---------------------------------------------------------------------*
*& Include z_screen_logali_f01
*&---------------------------------------------------------------------*

FORM initialize_variables.

  p_regisd = sy-datum.

*Comments values
  c_ticket = TEXT-c01.    " Restaurant ticket
  c_med_i  = TEXT-c02.    " Medical insurance
  c_prof_t = TEXT-c03.    " Professional training


ENDFORM.

*&---------------------------------------------------------------------*
*& Form get_information
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_information TABLES pt_employees STRUCTURE zemp_logali .

  IF p_read   EQ abap_true OR
     p_update EQ abap_true OR
     p_delete EQ abap_true.
  ENDIF.

  SELECT SINGLE FROM zemp_logali
    FIELDS *
    WHERE id EQ @p_id
    INTO @gs_employee.

  SELECT FROM zemp_logali
    FIELDS *
    WHERE id NE @space
    INTO TABLE @pt_employees.


ENDFORM.

*&---------------------------------------------------------------------*
*& Form create_employee
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GS_EMPLOYEE
*&---------------------------------------------------------------------*
FORM create_employee  USING p_employee TYPE zemp_logali.

  p_employee = VALUE zemp_logali( id     = p_id
                                        name   = p_name
                                        lastn1 = p_lastn1
                                        lastn2 = p_lastn2
                                        email  = p_email
                                        birthd = p_birthd
                                        regisd = p_regisd ).

  INSERT zemp_logali FROM p_employee.

  IF sy-subrc EQ 0.
    MESSAGE i002(z_mcl_logali).
  ELSE.
    MESSAGE i003(z_mcl_logali).
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form view_employees
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> GT_EMPLOYEES
*&---------------------------------------------------------------------*
FORM view_employees  TABLES  pt_employees STRUCTURE zemp_logali
                     CHANGING pv_flag TYPE c.

  DATA ls_employee TYPE zemp_logali.


  IF sy-subrc EQ 0.

    LOOP AT pt_employees INTO ls_employee.


      WRITE: / 'ID ='                 , ls_employee-id,
             / 'E-mail ='             , ls_employee-email,
             / 'First last name ='    , ls_employee-lastn1,
             / 'Second last name ='   , ls_employee-lastn2,
             / 'Name ='               , ls_employee-name,
             / 'Birth date ='         , ls_employee-birthd,
             / 'Registration date ='  , ls_employee-regisd.

      SKIP 2.

    ENDLOOP.

  ELSE.
    MESSAGE i004(z_mcl_logali).

  ENDIF.


ENDFORM.
