*&---------------------------------------------------------------------*
*& Report ZAKS_BP_02_COND
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaks_ap_cs_loop_010202.

**_________________________________________Conditional Statements_______________________________________*
*
**1. IF-ENDIF Conditional Statements -----------------------------------------*
*
*DATA lv_inp(2) TYPE n.
*
*lv_inp = 10.
*
*IF lv_inp > 5.
*  WRITE 'The output is 1'.
*ELSEIF lv_inp < 5.
*  WRITE 'The output is 2'.
*ELSE.
* WRITE 'The output is 0'.
*ENDIF.
*
**2. CASE Conditional Statements -----------------------------------------*
*
*DATA lv_inp(2) TYPE n value 5.
*
*CASE lv_inp.
*  WHEN 1.
*    write : 'the output is :', lv_inp.
*  WHEN 2.
*    write : 'the output is :', lv_inp.
*    WHEN 3.
*      write : 'the output is :', lv_inp.
*
*  WHEN OTHERS.
*    write : 'Wrong Input'.
*ENDCASE.

*__________________________________________________Loops_______________________________________*

**1. Do Loop (first syntax)-----------------------------------------*
*
*DATA : lv_input(2) type n value 10.
*
*DO 10 TIMES.
*  write : / 'The value is :', lv_input.
*  lv_input += 1.
*
*ENDDO.
*
**1.1. Do Loop (second syntax)-----------------------------------------*
*
**DO.               "its a endless loop
**  write : / 'The value is :', lv_input.
**  lv_input += 1.
**
**ENDDO.
*
*DO.
*  IF lv_input = 15.
*    EXIT.  "Exit statement helps us from the current loop.
*  ENDIF.
*  write : / 'The value is :', lv_input.
*  lv_input += 1.
*
*ENDDO.


*2. While Loop ---------------------------------------------------------*

*DATA : lv_input(2) TYPE n VALUE 10.
*
*WHILE lv_input < 15. "CAN ALSO BE WRITTEN AS lv_input LT 15.
*  WRITE : / 'The output is :', lv_input.
*  lv_input += 1.
*
*ENDWHILE.

*// Loop Statements ----------------------------------------------*

DATA : lv_input(2) TYPE n VALUE 12.


*// 1. Exit Statement------------------------------*
*WHILE lv_input > 0.
*  if lv_input = 20.
*    exit.
*    endif.
*    write : / 'The output is :', lv_input.
*    lv_input += 1.
*
*ENDWHILE.

*// 2. Continue Statement------------------------------*
*WHILE lv_input < 20.
*  lv_input += 1.
*  IF lv_input = 17.
*    CONTINUE.
*  ENDIF.
*  WRITE : / 'The output is :', lv_input.
*
*
*ENDWHILE.

*// 2. Check Statement------------------------------*
DO 10 TIMES.
  lv_input += 1.
  CHECK lv_input = 15.
  write : / 'The output is :', lv_input.

ENDDO.
