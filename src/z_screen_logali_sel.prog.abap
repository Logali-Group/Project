*&---------------------------------------------------------------------*
*& Include z_screen_logali_sel
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK block1 WITH FRAME TITLE TEXT-b01.

  SELECTION-SCREEN SKIP.


  SELECTION-SCREEN BEGIN OF BLOCK block7 WITH FRAME TITLE TEXT-b07.

    "Process type - CRUD
    PARAMETERS: p_create RADIOBUTTON GROUP crud, "Create employee
                p_read   RADIOBUTTON GROUP crud, "Read employee
                p_update RADIOBUTTON GROUP crud, "Update employee
                p_delete RADIOBUTTON GROUP crud, "Delete employee
                p_modify RADIOBUTTON GROUP crud. "Modify employee

  SELECTION-SCREEN END OF BLOCK block7.


  SELECTION-SCREEN SKIP.

  SELECTION-SCREEN BEGIN OF BLOCK block2 WITH FRAME TITLE TEXT-b02.

    PARAMETERS: p_lastn1 TYPE c LENGTH 20 , " First last name
                p_lastn2 TYPE c LENGTH 20 , " Second last name
                p_name   TYPE c LENGTH 30 . " Name


    SELECTION-SCREEN SKIP.

    PARAMETERS: p_birthd TYPE sydatum,                " Birth date
                p_id     TYPE c LENGTH 15 OBLIGATORY, " Identity document ID
                p_addr   TYPE c LENGTH 50,            " Address
                p_email  TYPE c LENGTH 30.            " Email

  SELECTION-SCREEN END OF BLOCK block2.

*&---------------------------------------------------------------------*
*& DATA RELATED TO THE REGISTRATION REQUEST
*&---------------------------------------------------------------------*

  SELECTION-SCREEN BEGIN OF BLOCK block3 WITH FRAME TITLE TEXT-b03.

*&------------------------------------------------------*
*& CONTRACT TYPE AND BENEFITS
*&------------------------------------------------------*

    SELECTION-SCREEN SKIP.

*Contract type
    SELECTION-SCREEN BEGIN OF BLOCK block4 WITH FRAME TITLE TEXT-b04.

      PARAMETERS: p_cntr_u RADIOBUTTON GROUP cntr, " Undefined
                  p_cntr_t RADIOBUTTON GROUP cntr, " Temporary
                  p_cntr_i RADIOBUTTON GROUP cntr. " Internships

    SELECTION-SCREEN END OF BLOCK block4.

    SELECTION-SCREEN SKIP.


*Benefits
    SELECTION-SCREEN BEGIN OF BLOCK block5 WITH FRAME TITLE TEXT-b05.

      SELECTION-SCREEN BEGIN OF LINE.

        PARAMETERS p_ticket AS CHECKBOX DEFAULT 'X'.  " Restaurant ticket
        SELECTION-SCREEN COMMENT (22) c_ticket.

        PARAMETERS  p_med_i  AS CHECKBOX.             " Medical insurance
        SELECTION-SCREEN COMMENT (22) c_med_i.

        PARAMETERS  p_prof_t AS CHECKBOX.             " Professional training
        SELECTION-SCREEN COMMENT (22) c_prof_t.

      SELECTION-SCREEN END OF LINE.

    SELECTION-SCREEN END OF BLOCK block5.


*&------------------------------------------------------*
*& DATA RELATED TO WORK ACTIVITY
*&------------------------------------------------------*

    SELECTION-SCREEN SKIP.

    PARAMETERS: p_hours  TYPE i,       " Weekly hours
                p_mont_s TYPE i,       " Monthly salary
                p_regisd TYPE sydatum. " Registration date

    SELECTION-SCREEN SKIP.

    SELECTION-SCREEN BEGIN OF BLOCK block6 WITH FRAME TITLE TEXT-b06.


*Access
      SELECT-OPTIONS: s_prog  FOR trdir-name, " Programs
                      s_tcode FOR tstc-tcode. " Transaction code

      SELECTION-SCREEN SKIP.

    SELECTION-SCREEN END OF BLOCK block6.

  SELECTION-SCREEN END OF BLOCK block3.

SELECTION-SCREEN END OF BLOCK block1.
