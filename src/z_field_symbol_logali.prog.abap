*&---------------------------------------------------------------------*
*& Report z_field_symbol_logali
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_field_symbol_logali.

DATA gv_employee TYPE string.

*FIELD-SYMBOLS <gv_employee> TYPE string.

*FIELD-SYMBOLS <gs_employee> TYPE zemp_logali.


ASSIGN gv_employee TO FIELD-SYMBOL(<gv_employee>).

<gv_employee> = 'Laura '.

*WRITE: / gv_employee.

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
*
*cl_demo_output=>display( data = gt_employees
*                       name = 'Field symbol' ).


APPEND INITIAL LINE TO gt_employees ASSIGNING FIELD-SYMBOL(<gs_employee_apd>).

<gs_employee_apd> = VALUE #( id       = '1232458I'
                             name     = 'VALENTINA'
                             lastn1   = 'LOPEZ'
                             lastn2   = 'MENDEZ'
                             email    = 'VLOPEZ@LOGALIGROUP.COM'
                             birthd   = '19900202'
                             regisd   =  sy-datum  ).

INSERT INITIAL LINE INTO gt_employees ASSIGNING <gs_employee_apd> INDEX 1.

<gs_employee_apd> = VALUE #( id       = '10101B'
                             name     = 'LAURA'
                             lastn1   = 'RUIZ'
                             lastn2   = 'MARTINEZ'
                             email    = 'LRUIZ@LOGALIGROUP.COM'
                             birthd   = '19990202'
                             regisd   =  sy-datum  ).



READ TABLE gt_employees ASSIGNING FIELD-SYMBOL(<gs_employee_read>) WITH KEY name = 'LAURA'.

<gs_employee_read>-name  = 'XIMENA'.
<gs_employee_read>-email = 'XRUIZ@LOGALIGROUP.COM'.

UNASSIGN <gs_employee_read>.


*cl_demo_output=>display( data = gt_employees
*                         name = 'Field symbol' ).

**********************************************************************

TYPES: BEGIN OF gty_date,
         year(4)  TYPE n,
         month(2) TYPE n,
         day(2)   TYPE n,
       END OF gty_date.

FIELD-SYMBOLS: <fs_date>  TYPE gty_date,
               <fs_date1> TYPE any,
               <fs_date2> TYPE n.

ASSIGN: sy-datum TO <fs_date> CASTING,
        sy-datum TO <fs_date1> CASTING TYPE gty_date.

DO.

  ASSIGN COMPONENT sy-index OF STRUCTURE <fs_date1> TO <fs_date2>.

  IF sy-subrc NE 0.
    EXIT.
  ENDIF.

  WRITE: <fs_date2>.

ENDDO.


*WRITE: / <fs_date>-year,
*       / <fs_date>-month,
*       / <fs_date>-day.


**********************************************************************

DATA gv_value TYPE i VALUE 10.

DATA go_ref TYPE REF TO i.


GET REFERENCE OF gv_value INTO go_ref.

FIELD-SYMBOLS <fs_value>.

ASSIGN go_ref->* TO <fs_value>.

<fs_value> = 12.

WRITE: / <fs_value> , gv_value.

**********************************************************************
