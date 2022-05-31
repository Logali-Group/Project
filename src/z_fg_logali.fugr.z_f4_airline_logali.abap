FUNCTION Z_F4_AIRLINE_LOGALI.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  TABLES
*"      SHLP_TAB TYPE  SHLP_DESCT
*"      RECORD_TAB STRUCTURE  SEAHLPRES
*"  CHANGING
*"     VALUE(SHLP) TYPE  SHLP_DESCR
*"     VALUE(CALLCONTROL) TYPE  DDSHF4CTRL
*"----------------------------------------------------------------------
IF callcontrol-step = 'DISP'.

DELETE record_tab WHERE string+3(2) NE 'AA'.


ENDIF.




ENDFUNCTION.
