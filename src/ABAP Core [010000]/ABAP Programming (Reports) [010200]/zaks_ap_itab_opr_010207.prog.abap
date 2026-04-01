*&---------------------------------------------------------------------*
*& Report ZAKS_AP_ITAB_OPR_010206
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaks_ap_itab_opr_010207.

*_________________________________________________________________________________________________________________*
*x.STRUCTURE AND VARIABLE DECLARATION ----------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

TYPES : BEGIN OF lty_fl_data,
          carrid TYPE s_carr_id,
          connid TYPE s_conn_id,
          fldate TYPE s_date,
        END OF lty_fl_data.

DATA : lt_fl_data  TYPE TABLE OF lty_fl_data,
       lwa_fl_data TYPE lty_fl_data.

*DATA : lt_fl_data TYPE TABLE OF ZAKS_AP_ITAB_STR_010206,
*      lwa_fl_data TYPE ZAKS_AP_ITAB_STR_010206.

*_________________________________________________________________________________________________________________*
*1. APPEND -------------------------------------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

lwa_fl_data-carrid = 'AKS'.
lwa_fl_data-connid = '1267'.
lwa_fl_data-fldate = '20261025'.
APPEND lwa_fl_data TO lt_fl_data.
CLEAR : lwa_fl_data.

lwa_fl_data-carrid = 'SS'.
lwa_fl_data-connid = '1433'.
lwa_fl_data-fldate = '20230312'.
APPEND lwa_fl_data TO lt_fl_data.
CLEAR : lwa_fl_data.

lwa_fl_data-carrid = 'BMD'.
lwa_fl_data-connid = '1467'.
lwa_fl_data-fldate = '20261005'.
APPEND lwa_fl_data TO lt_fl_data.
CLEAR : lwa_fl_data.

lwa_fl_data-carrid = 'CCF'.
lwa_fl_data-connid = '1533'.
lwa_fl_data-fldate = '20241025'.
APPEND lwa_fl_data TO lt_fl_data.
CLEAR : lwa_fl_data.

lwa_fl_data-carrid = 'SS'.
lwa_fl_data-connid = '1933'.
lwa_fl_data-fldate = '20230311'.
APPEND lwa_fl_data TO lt_fl_data.
CLEAR : lwa_fl_data.

*_________________________________________________________________________________________________________________*
*2. DELETE -------------------------------------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

*2.1 Using 'WHERE'
delete lt_fl_data WHERE fldate = '20261005'.

*2.2 Using 'Index'
delete lt_fl_data INDEX 2.

*_________________________________________________________________________________________________________________*
*3. MODIFY -------------------------------------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

LOOP AT lt_fl_data INTO lwa_fl_data.
  IF lwa_fl_data-carrid = 'AKS'.
    lwa_fl_data-connid = '7777'.
    MODIFY lt_fl_data FROM lwa_fl_data TRANSPORTING connid.
  ENDIF.
ENDLOOP.


*_________________________________________________________________________________________________________________*
*4. READ TABLE----------------------------------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*
*NOTE : only reads the first matching record from the internal table | Never forget to use SY-SUBRC to check successful or not.

*4.1 WITH KEY -----------------------------------------------------------------*

READ TABLE lt_fl_data INTO lwa_fl_data WITH KEY carrid = 'SS'.
IF sy-subrc = 0.
  WRITE : / lwa_fl_data-carrid, lwa_fl_data-connid, lwa_fl_data-fldate.
ELSE.
  WRITE : / 'No Matching Record found'.
ENDIF.

READ TABLE lt_fl_data INTO lwa_fl_data WITH KEY carrid = 'SSL'.
IF sy-subrc = 0.
  WRITE : / lwa_fl_data-carrid, lwa_fl_data-connid, lwa_fl_data-fldate.
ELSE.
  WRITE : / 'No Matching Record found'.
ENDIF.

*4.2 INDEX ------------------------------------------------------------------*

READ TABLE lt_fl_data INTO lwa_fl_data INDEX 3.
IF sy-subrc = 0.
  WRITE : / lwa_fl_data-carrid, lwa_fl_data-connid, lwa_fl_data-fldate.
ELSE.
  WRITE : / 'No Matching Record Found'.

ENDIF.

*_________________________________________________________________________________________________________________*
*5. CLEAR & REFRESH-----------------------------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

CLEAR : lt_fl_data.             "it can be used for both WA and Itab
*or
REFRESH : lt_fl_data.           "it can only be used for internal table.

*_________________________________________________________________________________________________________________*
*6. DESCRIBE TABLE------------------------------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

DATA : lv_lines TYPE i.
DESCRIBE TABLE lt_fl_data LINES lv_lines.
WRITE : / lv_lines.

*_________________________________________________________________________________________________________________*
*7. SORT ---------------------------------------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

*7.1 Sorting based on single column-------------------------------------------------*

SORT lt_fl_data BY connid.        "by default ascending
*SORT lt_fl_data by connid DESCENDING.

*7.2 Sorting based on multiple columns (sorting + sub-sorting)---------------------------*

sort lt_fl_data by carrid connid DESCENDING.   "here descending is specified for 'connid', so the carrid will be default asc as not specified.
"NOTE : the sorting of the 2nd column is according to the sorted 1st column, i.e if there are some common items in column 1 after sorting the 2nd sorting will be based on that common sorting. i.e. subsorting

sort lt_fl_data by carrid DESCENDING carrid DESCENDING.

*_________________________________________________________________________________________________________________*
*x. Loop at itab (for displaying output) -------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

LOOP AT lt_fl_data INTO lwa_fl_data.
  WRITE : / lwa_fl_data-carrid, lwa_fl_data-connid, lwa_fl_data-fldate.

ENDLOOP.

*_________________________________________________________________________________________________________________*
*8. COLLECT-------------------------------------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

TYPES : BEGIN OF lty_comp_pay,
          company(3)     TYPE c,
          department(10) TYPE c,
          amount         TYPE s_price,
        END OF lty_comp_pay.

DATA : lt_comp_data  TYPE TABLE OF lty_comp_pay,
       lwa_comp_data TYPE lty_comp_pay.
DATA : lt_comp_data2 TYPE TABLE OF lty_comp_pay.

lwa_comp_data-company = 'ABC'.
lwa_comp_data-department = 'HR'.
lwa_comp_data-amount = '12000.00'.
APPEND lwa_comp_data TO lt_comp_data.
CLEAR : lwa_comp_data.

lwa_comp_data-company = 'ABC'.
lwa_comp_data-department = 'ADMIN'.
lwa_comp_data-amount = '11000'.
APPEND lwa_comp_data TO lt_comp_data.
CLEAR : lwa_comp_data.

lwa_comp_data-company = 'ABC'.
lwa_comp_data-department = 'HR'.
lwa_comp_data-amount = '10000.95'.
APPEND lwa_comp_data TO lt_comp_data.
CLEAR : lwa_comp_data.

lwa_comp_data-company = 'ABC'.
lwa_comp_data-department = 'TRAINING'.
lwa_comp_data-amount = '16000.22'.
APPEND lwa_comp_data TO lt_comp_data.
CLEAR : lwa_comp_data.

lwa_comp_data-company = 'ABC'.
lwa_comp_data-department = 'ADMIN'.
lwa_comp_data-amount = '6000.99'.
APPEND lwa_comp_data TO lt_comp_data.
CLEAR : lwa_comp_data.

*lwa_comp_data-company = 'ABC'.
*lwa_comp_data-department = 'admin'.           "strings are case-senstive so 'ADMIN' & 'admin' are two different strings, so go as unique results
*lwa_comp_data-amount = '6000.99'.
*APPEND lwa_comp_data TO lt_comp_data.
*CLEAR : lwa_comp_data.

LOOP AT lt_comp_data INTO lwa_comp_data.
  COLLECT lwa_comp_data INTO lt_comp_data2. "never use the same itab to collect the data, as it will make it a endless loop

ENDLOOP.

LOOP AT lt_comp_data2 INTO lwa_comp_data.
  WRITE : / lwa_comp_data-company, lwa_comp_data-department, lwa_comp_data-amount.

ENDLOOP.
