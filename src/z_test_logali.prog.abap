*&---------------------------------------------------------------------*
*& Report z_test_logali
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_test_logali.

DATA gv_employee TYPE string.

*FIELD-SYMBOLS <gv_employee> TYPE string.

*FIELD-SYMBOLS <gs_employee> TYPE zemp_logali.

ASSIGN gv_employee TO FIELD-SYMBOL(<gv_employee>).

<gv_employee> = 'Laura '.

WRITE: / gv_employee.

*UNASSIGN <gv_employee>.
*<gv_employee> = 'Maria'.

SELECT FROM zemp_logali
    FIELDS *
    INTO TABLE @DATA(gt_employees).

*LOOP AT gt_employees INTO DATA(gs_employee).
*    gs_employee-email = 'NEW-EMAIL@LOGALIGROUP.COM'.
*ENDLOOP.
*
*cl_demo_output=>write( data = gt_employees
*                       name = 'Structure' ).

*LOOP AT gt_employees ASSIGNING FIELD-SYMBOL(<gs_employee>).
*    <gs_employee>-email =  'NEW-EMAIL@LOGALIGROUP.COM'.
*ENDLOOP.
*
*cl_demo_output=>display( data = gt_employees
*                       name = 'Field symbol' ).

APPEND INITIAL LINE TO gt_employees ASSIGNING FIELD-SYMBOL(<gs_employee_apd>).

<gs_employee_apd> = VALUE #( id     = '123456Y'
                             name   = 'LAURA'
                             lastn1 = 'MARTINEZ'
                             lastn2 = 'LOPEZ'
                             email  = 'LMARTINEZ@LOGALIGROUP.COM'
                             birthd = '19981022'
                             regisd = sy-datum  ).

INSERT INITIAL LINE INTO gt_employees ASSIGNING <gs_employee_apd> INDEX 1.

<gs_employee_apd> = VALUE #( id     = '123456Y'
                             name   = 'VALENTINA'
                             lastn1 = 'RUIZ'
                             lastn2 = 'LINARES'
                             email  = 'VRUIZ@LOGALIGROUP.COM'
                             birthd = '19950101'
                             regisd = sy-datum  ).

cl_demo_output=>display( data = gt_employees
                         name = 'Field symbol' ).
