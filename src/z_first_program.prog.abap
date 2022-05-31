*&---------------------------------------------------------------------*
*& Report z_first_program
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_first_program.
*

DATA(gv_love) = 'real'.

IF gv_love EQ 'real'.

   WRITE: / 'It is', gv_love.

ENDIF.
*
*"Variables
*DATA gv_first TYPE c LENGTH 2.
*DATA gv_myvar(15) TYPE n.
*DATA(gv_myvar2) = '20250101'.
*
*
*"Estructuras
*DATA:
*  BEGIN OF gty_structure,
*    field1 TYPE c LENGTH 2,
*    field2 TYPE d,
*  END OF gty_structure.
*
*TYPES:
*  BEGIN OF gty_demo,
*   field1 TYPE c,
*   field2 TYPE f,
*  END OF gty_demo.
*
*"Tablas internas
*DATA gt_demo TYPE STANDARD TABLE OF gty_demo.
*
*"Literales
*WRITE 'My first program'.
*
*WRITE / `ABAP Tutorial `.
*
*
*"Constantes
*CONSTANTS gc_first TYPE c LENGTH 1 VALUE 'X'.
*
*CONSTANTS gc_pi TYPE decfloat34
*             VALUE '3.141592653589793238462643383279503'.
*
**"Anterior a la versión 7.4
**DATA gv_number TYPE i.
**gv_number = 10.
*
*"Posterior a la versión 7.4
*DATA(gv_number) = 10.
*
*DATA hex type xstring value '12F'.
*WRITE / hex.
*
*
*DATA tipoc type c value '554'.
*write tipoc.

*
*CLASS start DEFINITION.
*  PUBLIC SECTION.
*    CLASS-DATA name(80) TYPE c.
*    CLASS-METHODS main.
*ENDCLASS.
*
*SELECTION-SCREEN BEGIN OF SCREEN 100.
*  PARAMETERS: dbtab  TYPE c LENGTH 30 DEFAULT 'SFLIGHT',
*              column TYPE c LENGTH 30 DEFAULT 'CARRID'.
*SELECTION-SCREEN END OF SCREEN 100.
*
*SELECTION-SCREEN BEGIN OF SCREEN 500 AS WINDOW.
*  SELECT-OPTIONS selcrit FOR (start=>name).
*SELECTION-SCREEN END OF SCREEN 500.
*
*START-OF-SELECTION.
*  start=>main( ).
*
*CLASS start IMPLEMENTATION.
*  METHOD main.
*    CALL SELECTION-SCREEN 100 STARTING AT 10 10.
*    IF sy-subrc <> 0.
*      RETURN.
*    ENDIF.
*    name = dbtab && '-' && column.
*    CALL SELECTION-SCREEN 500 STARTING AT 10 10.
*    IF sy-subrc <> 0.
*      RETURN.
*    ENDIF.
*    cl_abap_demo_services=>list_table( selcrit[] ).
*  ENDMETHOD.
*ENDCLASS.
