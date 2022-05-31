*&---------------------------------------------------------------------*
*& Report z_bifurcaciones_logali
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_bifurcaciones_logali.

"IF / ELSEIF / ELSE / ENDIF

DATA(lv_letra) = 'X'.

WRITE: / 'Bifurcaciones condicionales'.

SKIP 2.

IF lv_letra EQ 'A'.
   WRITE: / 'Letra =' , lv_letra.
ELSEIF lv_letra EQ 'B'.
   WRITE: / 'Letra =' , lv_letra.
ELSEIF lv_letra EQ 'C'.
   WRITE: / 'Letra =' , lv_letra.
ELSE.
   WRITE: / 'Es otra letra, no identificada'.

ENDIF.

DATA(lv_num) = 3.

IF lv_num EQ 3 OR lv_letra EQ 'D'.
   WRITE: / 'Valores correctos'.
ENDIF.

"IF anidados

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

"Valor inicial

CLEAR lv_num.

IF lv_num IS INITIAL.
   WRITE: / 'La variable no tiene contenido'.
ENDIF.

SKIP 3.



"CASE / WHEN / ENDCASE

DATA lv_cliente TYPE i VALUE 11.

CASE lv_cliente.

  WHEN 1.
   WRITE: / 'Cliente Empresa 1'.

  WHEN 2.
   WRITE: / 'Cliente Empresa 2'.

  WHEN 3.
   WRITE: / 'Cliente Empresa 3'.

  WHEN OTHERS.
   WRITE: / 'Cliente no registrado en la base de datos'.

ENDCASE.

WRITE: / 'Programa finalizado'.

SKIP 3.


"DO/ENDDO/CHECK

lv_num = 0.

DO.


 lv_num += 1.
 WRITE: / 'Número =' , lv_num.


 IF lv_num GT 10.
  EXIT.
 ENDIF.

 IF lv_num GT 3.
  CONTINUE.
 ENDIF.

 WRITE:/ 'Continue =' , lv_num.

ENDDO.

SKIP 2.


"CHECK

DO 20 TIMES.

  DATA(gv_resto) = sy-index MOD 2.
  CHECK gv_resto = 0.
  WRITE: / sy-index.

ENDDO.

SKIP 3.


"WHILE/ENDWHILE

lv_num = 11.

WHILE lv_num LE 10.

 WRITE: / 'Número = ' , lv_num.
*       / 'Número de iteración ' , sy-index.

 lv_num = lv_num + 1.

CONTINUE.

 IF lv_num GT 5.
  EXIT.
 ENDIF.

ENDWHILE.

WRITE: / 'FIN DEL PROGRAMA'.

SKIP 2.


"COND

DATA(lv_id) = '002'.

DATA(lv_customer) = COND string(
     WHEN lv_id = '001' THEN |Customer invoice 1|
     WHEN lv_id = '002' THEN |Customer invoice 2|
     WHEN lv_id = '003' THEN |Customer invoice 3|
     ELSE |Customer null|
     ).

WRITE: / lv_customer.

SKIP 2.

****
DATA(lv_time) = COND #(
     WHEN sy-timlo < '120000' THEN |{ sy-timlo TIME = ISO } AM |
     WHEN sy-timlo > '120000' THEN |{ CONV t( sy-timlo - 12 * 3600 ) TIME = ISO } PM |
     WHEN sy-timlo = '120000' THEN |Medio día|
     ELSE |Hora no identificada|
     ).

WRITE: / lv_time.

SKIP 2.


"SWITCH

DO 6 TIMES.
   DATA(lv_value) = SWITCH #( sy-index
                    WHEN 1 THEN |Iteración 1|
                    WHEN 2 THEN |Iteración 2|
                    WHEN 3 THEN |Iteración 3|
                    ELSE |# de iteración mayor a 3|
                     ).

WRITE: / lv_value.

ENDDO.

SKIP 3.


"BOOLC

DATA(lv_string) = ''.

IF strlen( lv_string ) GT 0.
ENDIF.

DATA(lv_boolc) = boolc( strlen( lv_string ) GT 0 ).
WRITE: / lv_boolc.

IF lv_boolc EQ abap_false.
 WRITE: / 'IS INITIAL'.

ELSE.
 WRITE: / 'IS NOT INITIAL'.

ENDIF.


"XSDBOOL

DATA(lv_xsdbool) = xsdbool( strlen( lv_string ) GT 0 ).
WRITE: / lv_xsdbool.

IF lv_xsdbool EQ abap_false.
 WRITE: / 'IS INITIAL'.

ELSE.
 WRITE: / 'IS NOT INITIAL'.

ENDIF.

***********MENSAJES
"Tipos de mensajes en ABAP
"I - Information/Mensaje de información

PARAMETERS pa_msg TYPE c.

CASE pa_msg.

  WHEN 'I'.
   MESSAGE i014(sabapdocu).
   MESSAGE 'Tipo de mensaje de información' TYPE 'I'.
   MESSAGE ID 'SABAPDOCU' TYPE 'I' NUMBER '095'.

  WHEN OTHERS .

   WRITE: / 'El tipo de mensaje no existe'.

ENDCASE.

WRITE: / 'El programa sigue con la lógica'.


MESSAGE 'Message text to display' TYPE 'S' DISPLAY LIKE 'E'. "MOSTRAR
