*&---------------------------------------------------------------------*
*& Report z_sentencias_logali
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_sentencias_logali.

*"Suma / Sentencia ADD
*
*DATA : numero_a  TYPE i VALUE 10,
*       numero_b  TYPE i VALUE 15,
*       resultado TYPE i.
*
*resultado = numero_a  + numero_b.
*
*WRITE : / 'numero a'  , numero_a,
*        / 'numero b'  , numero_b,
*        / 'resultado' , resultado.
*
*ADD 5 TO resultado.
*
*WRITE : / 'resultado' , resultado.
*
*resultado = resultado + 5.
*
*resultado += 5.
*
*WRITE : / 'resultado' , resultado.
*
*
*resultado = resultado + numero_a + numero_b.
*
*WRITE : / 'resultado' , resultado.
*
*CLEAR resultado.
*
*WRITE : / 'resultado' , resultado.
*SKIP.
*
*"Resta / Sentencia SUBTRACT
*
*DATA : gv_numeroa   TYPE i VALUE 10,
*       gv_numerob   TYPE i VALUE 4,
*       gv_resultado TYPE p LENGTH 6 DECIMALS 2.
**       gv_resultado(6) TYPE p DECIMALS 2.
*
*
*gv_resultado = gv_numeroa - gv_numerob.
*
*
*WRITE : / 'A =' ,10 gv_numeroa ,
*        / 'B =' ,10 gv_numerob ,
*        / 'Resultado =' ,10 gv_resultado.
*
*
*SUBTRACT 2 FROM gv_resultado.
*
*WRITE : / 'Resultado =' ,  gv_resultado.
*
*
*gv_resultado = gv_resultado - 1.
*
*
*WRITE : / 'Resultado =' ,  gv_resultado.
*
*SKIP.
*
*"Multiplicación / Sentencia MULTIPLY
*
*gv_numeroa = 15.
*gv_numerob = 10.
*
*
*gv_resultado = gv_numeroa * gv_numerob.
*
*
*WRITE : / 'A =' ,       gv_numeroa ,
*        / 'B =' ,       gv_numerob ,
*        / 'Resultado' , gv_resultado.
*
*WRITE : / 'Resultado multiplicación' , gv_numeroa , '*' , gv_numerob , '=' , gv_resultado.
*
*MULTIPLY gv_resultado BY 5.
**MULTIPLY gv_resultado BY gv_numeroa.
*
*WRITE : / 'Resultado multiplicación' , gv_resultado.
*
*gv_resultado = gv_resultado * 2.
*
*WRITE : / 'Resultado multiplicación' , gv_resultado.
*
*SKIP.
*
*
*"División / Sentencia DIVIDE
*
*gv_numeroa = 20.
*gv_numerob = 8.
*
*gv_resultado = gv_numeroa / gv_numerob.
*
*WRITE : / 'A ='        , gv_numeroa ,
*        / 'B ='        , gv_numerob ,
*        /'Resultado =' , gv_resultado.
*
*DIVIDE gv_resultado BY 2.
*
*WRITE : / 'Resultado División =' , gv_resultado.
*
*gv_resultado = ( gv_numeroa + gv_numerob ) * 3.
*
*WRITE : / 'Resultado operación =' , gv_resultado.
*
*SKIP.
*
*
*"División sin resto / Sentencia DIV
*
*gv_numeroa = 9.
*gv_numerob = 4.
*
*gv_resultado = gv_numeroa / gv_numerob.
*
*WRITE : / 'Resultado División' , gv_numeroa , '/' , gv_numerob , '=' , gv_resultado.
*
*gv_resultado = gv_numeroa DIV gv_numerob.
*
*WRITE : / 'Resultado DIV sin resto'  , gv_resultado.
*
*SKIP 2.
*
*
*
*"Resto de división / Sentencia MOD
*
*gv_resultado = gv_numeroa / gv_numerob.
*
*WRITE : / 'Resultado División' , gv_resultado.
*
*gv_resultado = gv_numeroa MOD gv_numerob.
*
*WRITE : / 'Resto de la división' , gv_resultado.
*
*
*gv_resultado = gv_numeroa MOD 50000.
*
*SKIP 2.
*
*
*"Exponeciación **
*
*gv_numeroa = 3.
*
*WRITE : / 'Número a =' , gv_numeroa.
*
*gv_numeroa = gv_numeroa ** 2.
*
*WRITE : / 'Número a =' , gv_numeroa.
*
*gv_numeroa = 3.
*
*gv_numeroa = gv_numeroa ** 3.
*
*WRITE : / 'Resultado exponenciación' , gv_numeroa , 'elevado a la' , 3.
*
*gv_numeroa = 3.
*
*DATA(gv_expo) = 3.
*
*gv_numeroa = gv_numeroa ** gv_expo.
*
*WRITE : / 'Resultado exponenciación' , gv_numeroa , 'elevado a la' , gv_expo.
*
*SKIP 2.
*
*
*
*"Raíz Cuadrada SQRT
*
*
*gv_numeroa = sqrt( 25 ).
*
*WRITE : / 'Raíz cuadrada' , gv_numeroa.
*
*gv_numeroa = 9.
*
*gv_numeroa = sqrt( gv_numeroa ).
*
*WRITE : / 'Raíz cuadrada' , gv_numeroa.
*
*
"práctica de CONCATENAR


DATA : gv_cadenaa   TYPE string VALUE 'Bienvenido      a Logali        Group',
       gv_cadenab   TYPE string VALUE 'Alumno ABAP',
       gv_cadenafin TYPE string.


CONCATENATE gv_cadenaa gv_cadenab INTO gv_cadenafin SEPARATED BY ' '.

WRITE : / 'Cadena final' , gv_cadenafin.

SKIP.
"nueva sentencia

DATA(gv_cadena) = | Nueva concatenación :    { gv_cadenaa }  { gv_cadenab }|.

WRITE : / gv_cadena.
*
*"condensar
*


* Reemplazar

DATA(gv_reempl) = 'Logali-Group-academia-SAP-'.
DATA(gv_sig) = '-'.

WRITE: / 'Valor inicial: ', gv_reempl.

* Option 1 OLD
*REPLACE '-' WITH '/' INTO gv_reempl. "Cambia solo la primera ocurrencia del string
*WRITE: / 'Valor inicial: ', gv_reempl.
**REPLACE ALL OCCURRENCES OF '-' IN gv_ reempl WITH '/'. "Cambia todas las ocurrencias del string
*WRITE: / 'Valor inicial: ', gv_reempl.+6

*Option 2
gv_reempl = replace( val   = gv_reempl
                     regex = gv_sig
                     with  = '/'
                     occ   = 0 ). "si cambiamos el numero de la posicion, empezará a cambiarse desde la posicion que se indica

WRITE: / 'Valor reemplazado: ', gv_reempl.






*************** Prueba COndicionales.
 DATA(lv_letra) = 'A'.


WRITE : / 'Bifurcaciones condicionales'.

SKIP 2.

IF lv_letra EQ 'A'.
   WRITE: / 'Letra =' , lv_letra.

ELSEIF lv_letra = 'B'.
   WRITE: / 'Letra =' , lv_letra.

ELSEIF lv_letra = 'C'.
   WRITE: / 'Letra =' , lv_letra.

ELSE.
   WRITE: / 'Es otra letra, no identificada'.
ENDIF.


DATA(lv_num) = 3.

IF lv_num EQ 3.
   WRITE: / 'Número =' , lv_num.
ENDIF.

IF lv_num EQ 3 AND lv_letra EQ 'D'.
   WRITE: / 'Valores correctos'.
ENDIF.

IF lv_num EQ 3 OR lv_letra EQ 'D'.
   WRITE: / 'Valores correctos'.
ENDIF.


*anidadas
DATA(lv_texto1) = 'ABAP'.
DATA(lv_texto2) = 'Clases'.
DATA(lv_texto3) = 'de programación'.

IF lv_texto1 = 'ABAP'.
   IF lv_texto2 = 'Clases'.
      IF lv_texto3 = 'de programación'.
        WRITE: / 'Correcto'.
      ELSE.
        WRITE: / 'Incorrecto'.
      ENDIF.
   ENDIF.
ENDIF.


CLEAR lv_num.

IF lv_num IS INITIAL.
   WRITE: / 'La variable no tiene contenido'.
ENDIF.







*DO Cancela una pasada de bucle usando CHECK si el índice de bucle sy-index es un número impar.
*DATA gv_resto TYPE i.
DO 20 TIMES.
  DATA(gv_resto) = sy-index MOD 2.
  CHECK gv_resto = 0.
WRITE : / sy-index  .
ENDDO.
