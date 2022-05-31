*&---------------------------------------------------------------------*
*& Report z_screen_logali
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_screen_logali.

INCLUDE: z_screen_logali_top,
         z_screen_logali_sel,
         z_screen_logali_f01.

*&------------------------------------------------------*
*& EVENTS
*&------------------------------------------------------*

INITIALIZATION.

PERFORM initialize_variables.


AT SELECTION-SCREEN ON p_lastn1.

*IF p_lastn1 IS INITIAL.
*   MESSAGE e001(z_mcl_logali).
*ENDIF.

  IF p_lastn1 CA '0123456789' .
    MESSAGE e000(z_mcl_logali).
  ENDIF.


AT SELECTION-SCREEN ON p_lastn2.

  IF p_lastn2 CA '0123456789' .
    MESSAGE e000(z_mcl_logali).
  ENDIF.

AT SELECTION-SCREEN ON p_name.

  IF p_name CA '0123456789' .
    MESSAGE e000(z_mcl_logali).
  ENDIF.


START-OF-SELECTION.

PERFORM get_information TABLES gt_employees.

*WRITE 'This is the program execution'.



*gs_employee-id     = p_id.
*gs_employee-name   = p_name.
*gs_employee-lastn1 = p_lastn1.
*gs_employee-lastn2 = p_lastn2.
*gs_employee-email  = p_email.
*gs_employee-birthd = p_birthd.
*gs_employee-regisd = p_regisd.

*gs_employee = VALUE #( id     = p_id
*                       name   = p_name
*                       lastn1 = p_lastn1
*                       lastn2 = p_lastn2
*                       email  = p_email
*                       birthd = p_birthd
*                       regisd = p_regisd ).



  CASE abap_true.


    WHEN p_create.

    PERFORM create_employee USING gs_employee.


    WHEN p_read.

    PERFORM view_employees TABLES gt_employees CHANGING gv_flag .


    WHEN p_update.

*      UPDATE zemp_logali SET name = p_name
*        WHERE id EQ p_id.

*      IF sy-subrc EQ 0.
*        MESSAGE i005(z_mcl_logali).
*      ELSE.
*        MESSAGE i006(z_mcl_logali).
*      ENDIF.


      IF sy-subrc EQ 0.

        gs_employee-name   = p_name.
        gs_employee-regisd = p_regisd.

        UPDATE zemp_logali FROM gs_employee.

        IF sy-subrc EQ 0.
          MESSAGE i005(z_mcl_logali).
        ELSE.
          MESSAGE i006(z_mcl_logali).
        ENDIF.

      ELSE.
        MESSAGE i004(z_mcl_logali).

      ENDIF.


    WHEN p_delete.

      IF sy-subrc EQ 0.

        DELETE zemp_logali FROM gs_employee.

        IF sy-subrc EQ 0.
          MESSAGE i007(z_mcl_logali).
        ELSE.
          MESSAGE i008(z_mcl_logali).
        ENDIF.

      ELSE.
        MESSAGE i004(z_mcl_logali).

      ENDIF.


    WHEN p_modify.

      gs_employee = VALUE zemp_logali( id     = p_id
                                       name   = p_name
                                       lastn1 = p_lastn1
                                       lastn2 = p_lastn2
                                       email  = p_email
                                       birthd = p_birthd
                                       regisd = p_regisd ).

      MODIFY zemp_logali FROM gs_employee.

      IF sy-subrc EQ 0.

        MESSAGE i009(z_mcl_logali).

      ENDIF.


  ENDCASE.
