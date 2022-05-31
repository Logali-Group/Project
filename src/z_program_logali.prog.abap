*&---------------------------------------------------------------------*
*& Report z_screen_logali
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_screen_logali.
*
*TABLES: trdir , tstc.
*
*SELECTION-SCREEN BEGIN OF BLOCK block1 WITH FRAME TITLE TEXT-b01.
*
*  SELECTION-SCREEN SKIP.
*
*
*  SELECTION-SCREEN BEGIN OF BLOCK block7 WITH FRAME TITLE TEXT-b07.
*
*    "Process type - CRUD
*    PARAMETERS: p_create RADIOBUTTON GROUP crud, "Create employee
*                p_read   RADIOBUTTON GROUP crud, "Read employee
*                p_update RADIOBUTTON GROUP crud, "Update employee
*                p_delete RADIOBUTTON GROUP crud, "Delete employee
*                p_modify RADIOBUTTON GROUP crud. "Modify employee
*
*  SELECTION-SCREEN END OF BLOCK block7.
*
*
*  SELECTION-SCREEN SKIP.
*
*  SELECTION-SCREEN BEGIN OF BLOCK block2 WITH FRAME TITLE TEXT-b02.
*
*    PARAMETERS: p_lastn1 TYPE c LENGTH 20 , " First last name
*                p_lastn2 TYPE c LENGTH 20 , " Second last name
*                p_name   TYPE c LENGTH 30 . " Name
*
*
*    SELECTION-SCREEN SKIP.
*
*    PARAMETERS: p_birthd TYPE sydatum,                " Birth date
*                p_id     TYPE c LENGTH 15 OBLIGATORY, " Identity document ID
*                p_addr   TYPE c LENGTH 50,            " Address
*                p_email  TYPE c LENGTH 30.            " Email
*
*  SELECTION-SCREEN END OF BLOCK block2.
*
**&---------------------------------------------------------------------*
**& DATA RELATED TO THE REGISTRATION REQUEST
**&---------------------------------------------------------------------*
*
*  SELECTION-SCREEN BEGIN OF BLOCK block3 WITH FRAME TITLE TEXT-b03.
*
**&------------------------------------------------------*
**& CONTRACT TYPE AND BENEFITS
**&------------------------------------------------------*
*
*    SELECTION-SCREEN SKIP.
*
**Contract type
*    SELECTION-SCREEN BEGIN OF BLOCK block4 WITH FRAME TITLE TEXT-b04.
*
*      PARAMETERS: p_cntr_u RADIOBUTTON GROUP cntr, " Undefined
*                  p_cntr_t RADIOBUTTON GROUP cntr, " Temporary
*                  p_cntr_i RADIOBUTTON GROUP cntr. " Internships
*
*    SELECTION-SCREEN END OF BLOCK block4.
*
*    SELECTION-SCREEN SKIP.
*
*
**Benefits
*    SELECTION-SCREEN BEGIN OF BLOCK block5 WITH FRAME TITLE TEXT-b05.
*
*      SELECTION-SCREEN BEGIN OF LINE.
*
*        PARAMETERS p_ticket AS CHECKBOX DEFAULT 'X'.  " Restaurant ticket
*        SELECTION-SCREEN COMMENT (22) c_ticket.
*
*        PARAMETERS  p_med_i  AS CHECKBOX.             " Medical insurance
*        SELECTION-SCREEN COMMENT (22) c_med_i.
*
*        PARAMETERS  p_prof_t AS CHECKBOX.             " Professional training
*        SELECTION-SCREEN COMMENT (22) c_prof_t.
*
*      SELECTION-SCREEN END OF LINE.
*
*    SELECTION-SCREEN END OF BLOCK block5.
*
*
**&------------------------------------------------------*
**& DATA RELATED TO WORK ACTIVITY
**&------------------------------------------------------*
*
*    SELECTION-SCREEN SKIP.
*
*    PARAMETERS: p_hours  TYPE i,       " Weekly hours
*                p_mont_s TYPE i,       " Monthly salary
*                p_regisd TYPE sydatum. " Registration date
*
*    SELECTION-SCREEN SKIP.
*
*    SELECTION-SCREEN BEGIN OF BLOCK block6 WITH FRAME TITLE TEXT-b06.
*
*
**Access
*      SELECT-OPTIONS: s_prog  FOR trdir-name, " Programs
*                      s_tcode FOR tstc-tcode. " Transaction code
*
*      SELECTION-SCREEN SKIP.
*
*    SELECTION-SCREEN END OF BLOCK block6.
*
*  SELECTION-SCREEN END OF BLOCK block3.
*
*SELECTION-SCREEN END OF BLOCK block1.
*
*
**&------------------------------------------------------*
**& EVENTS
**&------------------------------------------------------*
*
*INITIALIZATION.
*  p_regisd = sy-datum.
*
**Comments values
*  c_ticket = TEXT-c01.    " Restaurant ticket
*  c_med_i  = TEXT-c02.    " Medical insurance
*  c_prof_t = TEXT-c03.    " Professional training
*
*
*
*AT SELECTION-SCREEN ON p_lastn1.
*
**IF p_lastn1 IS INITIAL.
**   MESSAGE e001(z_mcl_logali).
**ENDIF.
*
*  IF p_lastn1 CA '0123456789' .
*    MESSAGE e000(z_mcl_logali).
*  ENDIF.
*
*
*AT SELECTION-SCREEN ON p_lastn2.
*
*  IF p_lastn2 CA '0123456789' .
*    MESSAGE e000(z_mcl_logali).
*  ENDIF.
*
*AT SELECTION-SCREEN ON p_name.
*
*  IF p_name CA '0123456789' .
*    MESSAGE e000(z_mcl_logali).
*  ENDIF.
*
*
*START-OF-SELECTION.
*
**WRITE 'This is the program execution'.
*
*  DATA gs_employee TYPE zemp_logali.
*
**gs_employee-id     = p_id.
**gs_employee-name   = p_name.
**gs_employee-lastn1 = p_lastn1.
**gs_employee-lastn2 = p_lastn2.
**gs_employee-email  = p_email.
**gs_employee-birthd = p_birthd.
**gs_employee-regisd = p_regisd.
*
**gs_employee = VALUE #( id     = p_id
**                       name   = p_name
**                       lastn1 = p_lastn1
**                       lastn2 = p_lastn2
**                       email  = p_email
**                       birthd = p_birthd
**                       regisd = p_regisd ).
*
*
*  IF p_read   EQ abap_true OR
*     p_update EQ abap_true OR
*     p_delete EQ abap_true.
*  ENDIF.
*
*  SELECT FROM zemp_logali
*    FIELDS *
*    ORDER BY lastn1
*    INTO @gs_employee.
*  ENDSELECT.
*
*
*
*  CASE abap_true.
*
*
*    WHEN p_create.
*
*      gs_employee = VALUE zemp_logali( id     = p_id
*                                       name   = p_name
*                                       lastn1 = p_lastn1
*                                       lastn2 = p_lastn2
*                                       email  = p_email
*                                       birthd = p_birthd
*                                       regisd = p_regisd ).
*
*      INSERT zemp_logali FROM gs_employee.
*
*      IF sy-subrc EQ 0.
*        MESSAGE i002(z_mcl_logali).
*      ELSE.
*        MESSAGE i003(z_mcl_logali).
*      ENDIF.
*
*    WHEN p_read.
*
*
*      IF sy-subrc EQ 0.
*
*        WRITE: / 'ID ='                 , gs_employee-id,
*               / 'E-mail ='             , gs_employee-email,
*               / 'First last name ='    , gs_employee-lastn1,
*               / 'Second last name ='   , gs_employee-lastn2,
*               / 'Name ='               , gs_employee-name,
*               / 'Birth date ='         , gs_employee-birthd,
*               / 'Registration date ='  , gs_employee-regisd.
*
*      ELSE.
*        MESSAGE i004(z_mcl_logali).
*
*      ENDIF.
*
*
*    WHEN p_update.
*
**      UPDATE zemp_logali SET name = p_name
**        WHERE id EQ p_id.
*
**      IF sy-subrc EQ 0.
**        MESSAGE i005(z_mcl_logali).
**      ELSE.
**        MESSAGE i006(z_mcl_logali).
**      ENDIF.
*
*
*      IF sy-subrc EQ 0.
*
*        gs_employee-name   = p_name.
*        gs_employee-regisd = p_regisd.
*
*        UPDATE zemp_logali FROM gs_employee.
*
*        IF sy-subrc EQ 0.
*          MESSAGE i005(z_mcl_logali).
*        ELSE.
*          MESSAGE i006(z_mcl_logali).
*        ENDIF.
*
*      ELSE.
*        MESSAGE i004(z_mcl_logali).
*
*      ENDIF.
*
*
*    WHEN p_delete.
*
*      IF sy-subrc EQ 0.
*
*        DELETE zemp_logali FROM gs_employee.
*
*        IF sy-subrc EQ 0.
*          MESSAGE i007(z_mcl_logali).
*        ELSE.
*          MESSAGE i008(z_mcl_logali).
*        ENDIF.
*
*      ELSE.
*        MESSAGE i004(z_mcl_logali).
*
*      ENDIF.
*
*
*    WHEN p_modify.
*
*      gs_employee = VALUE zemp_logali( id     = p_id
*                                       name   = p_name
*                                       lastn1 = p_lastn1
*                                       lastn2 = p_lastn2
*                                       email  = p_email
*                                       birthd = p_birthd
*                                       regisd = p_regisd ).
*
*      MODIFY zemp_logali FROM gs_employee.
*
*      IF sy-subrc EQ 0.
*
*        MESSAGE i009(z_mcl_logali).
*
*      ENDIF.
*
*
*  ENDCASE.

SELECT FROM scarr
       FIELDS carrid, carrname
       ORDER BY carrid
       INTO TABLE @DATA(result1).

SELECT carrid, carrname
       FROM scarr
       ORDER BY carrid
       INTO TABLE @DATA(result2).

ASSERT result1 = result2.
