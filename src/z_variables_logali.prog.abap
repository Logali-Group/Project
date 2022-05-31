*&---------------------------------------------------------------------*
*& Report z_variables_logali
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_variables_logali.

"Declaración de variables tipo D y T

DATA: gv_fecha TYPE d VALUE '20250101',
      gv_hora  TYPE t VALUE '124500'.

WRITE: / 'FECHA:' , gv_fecha DD/MM/YY,
       /  'HORA:' , gv_hora ENVIRONMENT TIME FORMAT.


*Declaración de variables tipo I y F

SKIP.

DATA: gv_numero   TYPE i VALUE 256322454,
      gv_flotante TYPE f VALUE '5.66'.

SKIP.

WRITE: / 'NUMERO:'   , gv_numero,
       / 'FLOTANTE:' , gv_flotante.

SKIP.

"Declaración de variables tipo DECFLOAT

DATA : gv_decimal16 TYPE decfloat16 VALUE '24.68',
       gv_decimal34 TYPE decfloat34 VALUE '32.689'.

WRITE : / 'Decimal16' , gv_decimal16,
        / 'Decimal34' , gv_decimal34.

SKIP.

"Declaración de variables de tipo de cadena de caracteres de longitud dinámica

DATA : gv_string      TYPE string  VALUE 'Hola mundo',
       gv_hexadecimal TYPE xstring VALUE '10A'.

WRITE : / 'Variable string:' , gv_string.

gv_string = 'Bienvenido al curso de SAP'.

WRITE : / 'Variable string nuevo:' , gv_string,
        / 'Variable xstring:'      , gv_hexadecimal.

SKIP.


"Declaración de variables tipo C y tipo P


DATA : gv_cadenac TYPE c LENGTH 10 VALUE 'LOGALI',
       gv_numerop TYPE p LENGTH 10 DECIMALS 2 VALUE '1402.25'.


WRITE : / 'Cadena tipo c' , gv_cadenac,
        / 'Número p' , gv_numerop.



"Declaración de variables tipo N y tipo X

DATA : gv_num TYPE n LENGTH 4  VALUE 35,
       gv_hex TYPE x LENGTH 10 VALUE 'F07'.



WRITE : / 'Tipo n' ,10 gv_num,
        / 'Tipo x' ,10 gv_hex.


 "Constantes


 DATA : numero_a  TYPE i VALUE 5,
        numero_b  TYPE i VALUE 10,
        resultado TYPE i.



 CONSTANTS constante TYPE i value 5.

 resultado = numero_a + numero_b.

 WRITE : / numero_a,
         / numero_b,
         / resultado.


 ADD 10 TO resultado.
 WRITE : / resultado.

 resultado += constante.
*resultado += 5.
 WRITE : / resultado.
 CLear resultado.
  WRITE : / resultado.
