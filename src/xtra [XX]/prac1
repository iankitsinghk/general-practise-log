*&---------------------------------------------------------------------*
*& Report ZAKS_BP_STR_OP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaks_bp_str_op.
** NOTE : String operations are 'ONLY APPLICABLE' on Character-like i.e. C, N, D, T and String data types.


*1. Concatenation------------------------------------------------------*

DATA : lv_input1(10) type c value 'Welcome!',
      lv_input2(10) type c value 'Hello!',
      lv_input3(10) type c value 'Namaste!',
      lv_output type string. " string is the elementary data type and it automatically calculates the lenght. so we don't go for lenght specification of string.


*CONCATENATE lv_input1 lv_input2 lv_input3 into lv_output.
CONCATENATE lv_input1 lv_input2 lv_input3 into lv_output SEPARATED BY '<>'.
write : / 'the result string is :', lv_output.

*2. Split------------------------------------------------------*

DATA : lv_input type string value 'Hi Hello Welcome Namaste',
      lv_op1(10), lv_op2(10), lv_op3(10), lv_op4(10) type c.

SPLIT lv_input at ' ' into lv_op1 lv_op2 lv_op3 lv_op4.
write : / 'Splited Strings are :', / lv_op1, / lv_op2, / lv_op3, / lv_op4.

*3. Condense------------------------------------------------------*

DATA : lv_str type string value '      H       el        lo         '.
write : / 'Before Condense:', lv_str.
CONDENSE lv_str.
write : / 'After Condense:', lv_str.
CONDENSE lv_str NO-GAPS.
write : / 'After Condense NO-GAPS:', lv_str.

*4. STRLEN------------------------------------------------------*

DATA : lv_len TYPE i,
       lv_str TYPE string VALUE 'Hello world! how are you doing?'.

lv_len = strlen( lv_str ).
WRITE : / 'String Length is :', lv_len.

*5. FIND------------------------------------------------------*

DATA : lv_input(50) TYPE c VALUE 'System Application Product'.

FIND 'system' IN lv_input.
IF sy-subrc = 0.
  WRITE : / 'Successful!', sy-subrc.
ELSE.
  WRITE : / 'Unsucessful!', sy-subrc.
ENDIF.

FIND 'system' IN lv_input IGNORING CASE.
IF sy-subrc = 0.
  WRITE : / 'Successful!', sy-subrc.
ELSE.
  WRITE : / 'Unsucessful!', sy-subrc.
ENDIF.

*6. Translate------------------------------------------------------*

DATA : lv_input(50)  TYPE c VALUE 'Hello! How are you guys?',
       lv_input1(50) TYPE c VALUE 'hello! how are you guys?'.

TRANSLATE lv_input TO LOWER CASE.
WRITE : / lv_input.

TRANSLATE lv_input1 TO UPPER CASE.
WRITE : / lv_input1.

*6.1 Translate using pattern------------------------------------------------------*

DATA : lv_rule(10) type c value 'hHoOwXgM'. " 'hHoOwXgM' <- this is the pattern : 'h' will be replaced by 'H', 'o' by 'O'........
write : / lv_input.
TRANSLATE lv_input using lv_rule.
write : / lv_input.

*7. Shift------------------------------------------------------*

DATA : lv_input1(10) TYPE c VALUE '0123456789',
       lv_input2(10) TYPE c VALUE '0123456789',
       lv_input3(10) TYPE c VALUE '0123456789'.

*SHIFT lv_input1 by 5 places.  " by default it will consider it 'left'
SHIFT lv_input1 BY 5 PLACES LEFT. " it will remove 5 places starting from left and shift the rest to left. 5 trailing spaces are created
WRITE : / 'Left', lv_input1.

SHIFT lv_input2 BY 5 PLACES RIGHT. " it will remove 5 places starting from right and shift the rest to right. 5 leading spaces are created
WRITE : / 'Right', lv_input2.

SHIFT lv_input3 BY 5 PLACES CIRCULAR. " it picks the 5 places from left and attach it to the right. it's circular -- length remains same
WRITE : / 'Circular', lv_input3.

*7.1. Shift (to remove trailing zeros--------------------------------------------------------*

DATA : lv_res1(10) TYPE c VALUE '7000000000',
       lv_res2(10) TYPE c VALUE '0000000007'.

SHIFT lv_res1 RIGHT DELETING TRAILING '0'.
*CONDENSE lv_res1.  " to remove the leading spaces
*WRITE : / strlen( lv_res1 ).
WRITE : / 'Trailing :', lv_res1.

SHIFT lv_res2 LEFT DELETING LEADING '0'.
*CONDENSE lv_res2.   " to remove the trailing spaces
*WRITE : / strlen( lv_res2 ).
WRITE : / 'Leading', lv_res2.

*8. Substring Processing------------------------------------------------------*

DATA : lv_num(20)    TYPE c VALUE '91-012-4563526251',
       lv_country(2) TYPE c,
       lv_city(3)    TYPE c,
       lv_phn(10)    TYPE c.

lv_country = lv_num+0(2).  "from 0th position to 2 char
WRITE : / 'Country Code is', lv_country.

lv_city = lv_num+3(3).
WRITE : / 'City code is', lv_city.

lv_phn = lv_num+7(10).
WRITE : / 'Phone number is ', lv_phn.
