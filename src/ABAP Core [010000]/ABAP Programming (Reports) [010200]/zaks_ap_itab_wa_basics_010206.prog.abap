*&---------------------------------------------------------------------*
*& Report ZAKS_AP_ITAB_WA_BASICS_010206
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaks_ap_itab_wa_basics_010206.

*DATA : lv_ono1(10) type n,
*      lv_ono2 TYPE s_conn_id.
*
** data object is the instance of data type / data element, which stores the data.

*_________________________________________________________________________________________________________________*
*x.STRUCTURE, ITab and WA declaration ----------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

* local scope - structure --------------------------------------------------------------*
TYPES : BEGIN OF lty_data,
          carrid TYPE s_carr_id,
          connid TYPE s_conn_id,
          fldate TYPE s_date,
        END OF lty_data.

DATA : lt_data  TYPE TABLE OF lty_data,            "structure type - complex data type (combination of elementary data types)
       lwa_data TYPE lty_data.                     "WA is declared with 'TYPE' not 'TYPE TABLE OF', as WA is not a table it only stores single record

* global scope - structure ------------------------*
DATA : lt_data2 TYPE TABLE OF zaks_ap_itab_str_010206,   "ZAKS_AP_ITAB_STR_010206 | structure created in SE11
       lwa_data2 TYPE zaks_ap_itab_str_010206.

*_________________________________________________________________________________________________________________*
*x.TABLE TYPE for declaring Itab ---------------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

*(NOTE (Golden Rule) : Table type is never used to declare Workarea)
* local scope - table type ------------------------*
TYPES : ltty_data TYPE TABLE OF lty_data.

DATA : lt_data3 TYPE ltty_data.

* global scope - table type ------------------------*
DATA : lt_data4 TYPE ZAKS_AP_ITAB_TTY_010206.             "ZAKS_AP_ITAB_TTY_010206 | Table Type created in SE11 using Structure ZAKS_AP_ITAB_STR_010206
