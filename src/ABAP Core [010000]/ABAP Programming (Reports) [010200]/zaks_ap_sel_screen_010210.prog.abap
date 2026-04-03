*&---------------------------------------------------------------------*
*& Report ZAKS_AP_SEL_SCREEN_010210
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaks_ap_sel_screen_010210.


*_________________________________________________________________________________________________________________*
*1. PARAMETERS ---------------------------------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

*1. Declaration ---------------------------------------------------------------------------------*

*1.1 Normal --------------------------------------------*
PARAMETERS : p_carrid TYPE s_carr_id.

*1.2 DEFAULT --------------------------------------------*
PARAMETERS : p_carrid TYPE s_carr_id DEFAULT 'ABC'.

*1.3 OBLIGATORY (Mandatory) ------------------------------*
PARAMETERS : p_carrid TYPE s_carr_id OBLIGATORY.    "compulsory to provide the value for this parameter
PARAMETERS : p_carrid TYPE s_carr_id OBLIGATORY DEFAULT 'SS'.

*1.4 RADIO BUTTON -----------------------------------------*
PARAMETERS : p_r1 TYPE c RADIOBUTTON GROUP r1. "if length of parameter is not specified, it will by default consider 1.
PARAMETERS : p_r2 TYPE c RADIOBUTTON GROUP r1 DEFAULT 'X'.   "if you don't declare default to any button, then 1st button is tick by default
PARAMETERS : p_r3 TYPE c RADIOBUTTON GROUP r1.

*1.4 CHECK BOX ---------------------------------------------*
PARAMETERS : p_chk1 AS CHECKBOX. "by default the length will be 1 as not specified
PARAMETERS : p_chk2 AS CHECKBOX.

*_________________________________________________________________________________________________________________*
*2. SELECT-OPTIONS -----------------------------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

*2.1 Normal ---------------------------------------------*
DATA : lv_connid TYPE s_conn_id.

*SELECT-OPTIONS : s_con FOR lv_connid.

*2.2 DEFAULT ---------------------------------------------*
SELECT-OPTIONS : s_con FOR lv_connid DEFAULT '1000' to '1200'.

*2.2 DEFAULT ---------------------------------------------*
SELECT-OPTIONS : s_con FOR lv_connid OBLIGATORY.

*2.3 NO-EXTENSION (to hide the multiple selection button) ---*
SELECT-OPTIONS : s_con FOR lv_connid OBLIGATORY NO-EXTENSION.

*2.3 NO INTERVALS (to hide the high value/interval) -----------*
SELECT-OPTIONS : s_con FOR lv_connid OBLIGATORY NO INTERVALS.
SELECT-OPTIONS : s_con FOR lv_connid OBLIGATORY NO INTERVALS NO-EXTENSION.   "this is same as the parameter in terms of display only


*=================================================================================================================================================*


  DATA : lv_connid TYPE s_conn_id.

*_________________________________________________________________________________________________________________*
*x.1 SELECTION SCREEN BLOCK and FRAME ----------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

SELECTION-SCREEN : BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-000.

*Note:
  "TEXT-000 are text symbols (its number varies from 000 - 999)
  "Text symbol is also a data object. it is not declared in the program itself.
  "it is defined as a part of the text elements of the program.
  "Goto > Text Elements (F5)

  PARAMETERS : p_carrid TYPE s_carr_id OBLIGATORY DEFAULT 'SS'.
  SELECT-OPTIONS : s_con FOR lv_connid OBLIGATORY NO INTERVALS.

*_________________________________________________________________________________________________________________*
*x.2 SELECTION SCREEN LINE and COMMENT ---------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

  SELECTION-SCREEN : BEGIN OF LINE.

    PARAMETERS : p_r1 TYPE c RADIOBUTTON GROUP r1.
    SELECTION-SCREEN : COMMENT 3(3) TEXT-001.

    PARAMETERS : p_r2 TYPE c RADIOBUTTON GROUP r1 DEFAULT 'X'.
    SELECTION-SCREEN : COMMENT 9(11) TEXT-002.
*
    PARAMETERS : p_r3 TYPE c RADIOBUTTON GROUP r1.
    SELECTION-SCREEN : COMMENT 23(8) TEXT-003.

  SELECTION-SCREEN : END OF LINE.


  SELECTION-SCREEN : BEGIN OF LINE.

    PARAMETERS : p_chk1 AS CHECKBOX.
    SELECTION-SCREEN : COMMENT 3(5) TEXT-004.
    PARAMETERS : p_chk2 AS CHECKBOX.
    SELECTION-SCREEN : COMMENT 11(6) TEXT-005.

  SELECTION-SCREEN : END OF LINE.


*x.1 END OF SELECTION SCREEN BLOCK --------------------------------------------------------------------------------*

SELECTION-SCREEN : END OF BLOCK b1.


*=================================================================================================================================================*


*_________________________________________________________________________________________________________________*
*x. SAMPLE OUTPUT ------------------------------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*
WRITE : / '1'.
