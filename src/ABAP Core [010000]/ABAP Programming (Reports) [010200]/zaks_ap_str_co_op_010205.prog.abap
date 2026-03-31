*&---------------------------------------------------------------------*
*& Report ZAKS_STR_COMP_OP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaks_str_comp_op.

*1. CO (contains only)-------------------------------------------------------------*

DATA : lv_string1(10) TYPE c VALUE 'Welcome',
       lv_string2(30) TYPE c VALUE 'Welcome home, How are you?'.

IF lv_string1 CO lv_string2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.
ENDIF.

lv_string1 = 'Welcomex'.
IF lv_string1 CO lv_string2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.
ENDIF.

lv_string1 = 'welcome'.                         "CO is case-sensitive but it will give true are 'w' is present in 'How'.
IF lv_string1 CO lv_string2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.
ENDIF.

lv_string2 = 'Welcome home, hoW are you?'.      "now it will give false as 'w' is no where in lv_string2
IF lv_string1 CO lv_string2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.
ENDIF.


*2. CN (contains not only)-------------------------------------------------------------*
*its not of CO

DATA : lv_str1(20) TYPE c VALUE 'System',
       lv_str2(30) TYPE c VALUE 'System Application Product'.

IF lv_str1 CN lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.
ENDIF.

lv_str1 = 'Systemx'.
IF lv_str1 CN lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.
ENDIF.

lv_str1 = 'system'.                         "CN is case-sensitive but it will give false are 's' is present in 'System'.
IF lv_str1 CN lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.
ENDIF.

lv_str2 = 'SyStem Application Product'.     "now it will give true as 's' is no where in lv_str2
IF lv_str1 CN lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.
ENDIF.

*3. CA (contains any)-------------------------------------------------------------*
*V1 should contains atleast 1 which is present in V2
*widely used to validate password (as atleast 1 Uppercase, 1 Number, 1 Special Char)

DATA : lv_str1(10) TYPE c VALUE 'Wbirqn',
       lv_str2(20) TYPE c VALUE 'Welcome Home'.

IF lv_str1 CA lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

lv_str1 = 'wbnq'.                    "Here it will give true result, as altough there is no char in lv_str1 present in lv_str2 but lv_str1 has length 10 so the position [5,9] is ' ' space and ' ' is present in lv_str2
IF lv_str1 CA lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

lv_str1 = 'wbqwbqwbqw'.              "it also shows CA is case sensitive.
IF lv_str1 CA lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

*4. NA (contains any)-------------------------------------------------------------*
*not of CA

DATA : lv_str1(10) TYPE c VALUE 'Te23456789',
       lv_str2(20) TYPE c VALUE 'Test@12345'.

IF lv_str1 NA lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

lv_str1 = 'SE23456789'.         "show's it is case sensitive
IF lv_str1 NA lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

lv_str1 = 'SE67890000'.
IF lv_str1 NA lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

*5. CS (contains string)-------------------------------------------------------------*
* it is not case-sensitive

DATA : lv_str1(30) TYPE c VALUE 'System Application Product',
       lv_str2(10) TYPE c VALUE 'System'.

IF lv_str1 CS lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

lv_str2 = 'system'.            "is not case-sensitive
IF lv_str1 CS lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

lv_str2 = 'systemx'.            "it needs exact string in lv_str2 to be present in lv_str1
IF lv_str1 CS lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

*NOTE*- CO vs CS-----------------------------------------------------------*
*CO vs CS : CO takes in consideration of characters i.e. if V1 CO V2 is true than, all characters in V1 are present in V2 (doesn't depends on order or position) & is case sensitive.
*But CS i.e. if V1 CS V2 is true, the entire string V2 is present in V1, but is not case-sensitive.

DATA : lv_str1(10) TYPE c VALUE 'Madam',
       lv_str2(5)  TYPE c VALUE 'damam'.

IF lv_str2 CO lv_str1.
  WRITE : / 'CO True', sy-fdpos.
ELSE.
  WRITE : / 'CO False', sy-fdpos.

ENDIF.

IF lv_str1 CS lv_str2.
  WRITE : / 'CS True', sy-fdpos.
ELSE.
  WRITE : / 'CS False', sy-fdpos.

ENDIF.

*6. NS (contains no string)-------------------------------------------------------------*
* not of CS | it is not case-sensitive

DATA : lv_str1(10) TYPE c VALUE 'systemx',
       lv_str2(30) TYPE c VALUE 'System Application Products'.

IF lv_str2 NS lv_str1.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.
ENDIF.

lv_str2 = 'Systemx Application Products'.
IF lv_str2 NS lv_str1.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

lv_str1 = 'Systemx'.
IF lv_str2 NS lv_str1.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

*7. CP (contains pattern)-------------------------------------------------------------*
*not case-sensitive
*   * Match any sequence of character
*   + Match any single character
*   # Interpret the next character

DATA : lv_str1(30) TYPE c VALUE 'System Application Product',
       lv_str2(10) TYPE c VALUE '*App*'.

IF lv_str1 CP lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

lv_str2 = '*App'.               "system thinks is like App is the last and anything before it.
IF lv_str1 CP lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

lv_str2 = '*st*Ca*Uc*'.
IF lv_str1 CP lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

*   # is called an escape character.
*   1. # can be used to make a search case sensitive.
*   2. The wildcard characters * and +
*   3. the escape character itself
** note -- after # whatever character we'll put, it will interpret it as it is.

lv_str2 = '*#App*'.
IF lv_str1 CP lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

lv_str2 = '*#app*'.          "will give false, as # makes the just next char case-sensitive
IF lv_str1 CP lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

lv_str2 = '*#APP*'.           "will give true output as # only takes the just next character into consideration
IF lv_str1 CP lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

lv_str2 = '*#A#p#P*'.
IF lv_str1 CP lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

**if you want to look for the character '*' or '+', so we use # for it
lv_str2 = '*#**'.           "it is anything in start, character '*' in between, and anything after it.
IF lv_str1 CP lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

lv_str1 = 'System* Application+ Products'.
lv_str2 = '*#**#+*'.           "now it gives true.
IF lv_str1 CP lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

** if we want to search for escape character '#' itself.

lv_str1 = 'System# Application Product'.
lv_str2 = '*##*'.
IF lv_str1 CP lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

* '+' is used to match any single character.

DATA : lv_str1(5) type c VALUE 'ABCDE',
      lv_str2(5) type c VALUE 'AB+DE'.

IF lv_str1 CP lv_str2.
  write : / 'True', sy-fdpos.
  else.
    write : / 'False', sy-fdpos.

ENDIF.

lv_str2 = 'AB+'.
IF lv_str1 CP lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

lv_str2 = 'AB+++'.
IF lv_str1 CP lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

lv_str2 = '*++D*'.
IF lv_str1 CP lv_str2.
  WRITE : / 'True', sy-fdpos.
ELSE.
  WRITE : / 'False', sy-fdpos.

ENDIF.

*8. NP (contains no pattern)-------------------------------------------------------------*
*not of CP

DATA : lv_str1(30) type c VALUE 'System Application Product',
      lv_str2(10) type c VALUE '*#q+'.

IF lv_str1 NP lv_str2.
  write : / 'True', sy-fdpos.
  else.
    write : / 'False', sy-fdpos.

ENDIF.

lv_str2 = '*s*#n*+*'.
IF lv_str1 NP lv_str2.
  write : / 'True', sy-fdpos.
  else.
    write : / 'False', sy-fdpos.

ENDIF.

lv_str2 = '*s*#N*+*'.
IF lv_str1 NP lv_str2.
  write : / 'True', sy-fdpos.
  else.
    write : / 'False', sy-fdpos.

ENDIF.
