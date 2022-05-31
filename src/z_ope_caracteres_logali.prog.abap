*&---------------------------------------------------------------------*
*& Report z_ope_caracteres_logali
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ope_caracteres_logali.

DATA : gv_cadenaa   TYPE string VALUE 'Bienvenido      a   Logali        Group',
       gv_cadenab   TYPE string VALUE 'alumno abap',
       gv_cadenafin TYPE string.

*Concatenar

CONCATENATE gv_cadenaa
            gv_cadenab
            INTO gv_cadenafin SEPARATED BY space.

WRITE : / gv_cadenafin.


DATA(gv_cadena) = |Nueva concatenación : { gv_cadenaa } / { gv_cadenab } |.

WRITE : / gv_cadena.

SKIP.


*Condensar

WRITE : / gv_cadenaa. "inicial

CONDENSE gv_cadenaa.

WRITE : / gv_cadenaa. "condense

CONDENSE gv_cadenaa NO-GAPS.

WRITE : / gv_cadenaa.

SKIP.


*Reemplazar

DATA(gv_reempl) = 'Logali-Group-Academia-SAP'.
DATA(gv_sig) = '-'.

WRITE : / 'Valor inicial =' , gv_reempl.

REPLACE '-' WITH '/' INTO gv_reempl.

*WRITE : / 'Valor Reemplazado =' , gv_reempl.
*REPLACE ALL OCCURRENCES OF '-' IN gv_reempl WITH '/'.
*WRITE : / 'Valor Reemplazado =' , gv_reempl.

gv_reempl = replace( val = gv_reempl regex = gv_sig with = '/' occ = 0 ).

WRITE : / 'Valor Reemplazado =' , gv_reempl.

SKIP 2.



*Búsqueda SEARCH - FIND

WRITE : / gv_cadenab,
        / 'Valor inicial de la variable de sistema = ' , sy-fdpos.

SEARCH gv_cadenab FOR 'B'.

WRITE : / 'Valor de la variable de sistema = ' , sy-fdpos.

DATA(gv_posicion) = sy-fdpos + 1.

WRITE : / 'Posición real = ' , gv_posicion.


DATA : gv_cadenac TYPE string VALUE '123AFS**01',
       gv_regex   TYPE string VALUE '[0-9]'.

DATA(gv_find) = find( val = gv_cadenac regex = gv_regex ).

WRITE : / gv_find.

FIND ALL OCCURRENCES OF '*' IN gv_cadenac MATCH COUNT DATA(gv_num).

WRITE: / 'contiene el simbolo *' , gv_num , 'veces'.

SKIP 2.



*SHIFT

CONSTANTS gc_inicial(10) TYPE c VALUE '    ABC123'.

gv_cadenafin = gc_inicial.

WRITE: / 'Valor inicial ' , gv_cadenafin.

SHIFT gv_cadenafin LEFT DELETING LEADING space.
*SHIFT gv_cadenafin RIGHT DELETING TRAILING '123'.
*SHIFT gv_cadenafin BY 3 PLACES LEFT.

*WRITE: / 'Valor final: ', gv_cadenafin.


gv_cadenafin = gc_inicial.

gv_cadenafin = shift_right( val = gv_cadenafin places = 4 ).

WRITE: / 'Valor final: ', gv_cadenafin.

gv_cadenafin = gc_inicial.

gv_cadenafin = shift_left( val = gv_cadenafin places = 2 ).

WRITE: / 'Valor final: ', gv_cadenafin.

gv_cadenafin = gc_inicial.

gv_cadenafin = shift_left( val = gv_cadenafin circular = 5 ).

WRITE: / 'Valor final: ', gv_cadenafin.

gv_cadenafin = gc_inicial.

gv_cadenafin = shift_right( val = gv_cadenafin sub = '123' ).

WRITE: / 'Valor final: ', gv_cadenafin.

gv_cadenafin = gc_inicial.

gv_cadenafin = shift_left( val = gv_cadenafin ).

WRITE: / 'Valor final: ', gv_cadenafin.

SKIP 2.



*TRANSLATE

WRITE : / gv_cadenab.

TRANSLATE gv_cadenab TO UPPER CASE.

WRITE : / gv_cadenab.

TRANSLATE gv_cadenab TO LOWER CASE.

WRITE : / gv_cadenab.

SKIP.

"ABAP 7.4

gv_cadenab = to_upper( gv_cadenab ).

WRITE : / gv_cadenab.

gv_cadenab = to_lower( gv_cadenab ).

WRITE : / gv_cadenab.

WRITE : / sy-abcde.

DATA(gv_alf) = to_mixed( sy-abcde ).

WRITE : / gv_alf.

gv_alf = from_mixed( sy-abcde ).

WRITE : / gv_alf.

SKIP 2.



"SPLIT

gv_reempl = 'Logali-Group-Academia-SAP'.

WRITE : / gv_reempl.

SPLIT gv_reempl AT '-' INTO DATA(gv_palabra1)
                            DATA(gv_palabra2)
                            DATA(gv_palabra3).


WRITE : /  gv_palabra1 ,
        /  gv_palabra2 ,
        /  gv_palabra3 .

SKIP 2.



"SUBSTRING

gv_cadenaa = 'LOGALI GROUP'.

WRITE : / gv_cadenaa.

gv_cadenaa = substring( val = gv_cadenaa off = 7 len = 4 ).

WRITE : / gv_cadenaa.

gv_cadenaa = 'LOGALI GROUP'.

gv_cadenaa = substring_from( val = gv_cadenaa sub = 'GA' ).

WRITE : / gv_cadenaa.

gv_cadenaa = 'LOGALI GROUP'.

gv_cadenaa = substring_after( val = gv_cadenaa sub = 'GA' ).

WRITE : / gv_cadenaa.


gv_cadenaa = 'LOGALI GROUP'.

gv_cadenaa = substring_before(  val = gv_cadenaa sub = 'GA' ).

WRITE : / gv_cadenaa.


gv_cadenaa = 'LOGALI GROUP'.

WRITE : / gv_cadenaa.

SKIP 2.



"CONV

DATA:
  lv_nombre(255) TYPE c,
  lv_apellido    TYPE string.

lv_apellido = CONV #( lv_nombre ).


DATA(lv_float) = sqrt( 10 ) + sqrt( 15 ).
WRITE: / 'Resultado', lv_float.

DATA(lv_int) = CONV i( sqrt( 10 ) ) +  CONV i( sqrt( 15 ) ).
WRITE: / 'Resultado CONV', lv_int.

SKIP 2.



"ALPHA

DATA: lv_mtrl1 TYPE string VALUE '2297'.

DATA(lv_mtrl2) = | { lv_mtrl1 ALPHA = OUT } |.

WRITE: / | Código material 1 = { lv_mtrl1 } | ,
        / | Código material 1 = { lv_mtrl1 ALPHA = IN WIDTH = 10 } | ,
        / | Código material 2 = { lv_mtrl2 } | .

SKIP 2.



"Expresiones regulares

DATA(lv_regex) = '^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$'.
DATA(lv_email) = 'alumno@logaligroupcom'.

FIND REGEX lv_regex IN lv_email.

IF sy-subrc EQ 0.
    WRITE : / 'Correo electrónico válido'.
ELSE.
    WRITE : / 'Correo electrónico inválido, verifique sus datos'.
ENDIF.


DATA(lv_text) = '123A?*Z100004#~€¬AA'.
REPLACE ALL OCCURRENCES OF REGEX '[^A-Za-z0-9]+'  IN lv_text WITH space.
WRITE : / lv_text.
