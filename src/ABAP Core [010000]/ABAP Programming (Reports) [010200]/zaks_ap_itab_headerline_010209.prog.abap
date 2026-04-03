*&---------------------------------------------------------------------*
*& Report ZAKS_AP_ITAB_HEADERLINE_010209
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaks_ap_itab_headerline_010209.

TYPES : BEGIN OF lty_fl_data,
          carrid(3) TYPE c,
          connid(4) TYPE n,
          fldate    TYPE s_date,
        END OF lty_fl_data.

*_________________________________________________________________________________________________________________*
*1. INTERNAL TABLE with HEADER LINE ------------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

DATA : lt_fl_data TYPE TABLE OF lty_fl_data WITH HEADER LINE.   "we don't need to declare the WA explicitly here, SAP does it.

*NOTE:
" lt_fl_data is the WA | lt_fl_data[] is the ITAB

CLEAR : lt_fl_data.
lt_fl_data-carrid = 'ABC'.
lt_fl_data-connid = '2397'.
lt_fl_data-fldate = '20231119'.
APPEND lt_fl_data.

CLEAR : lt_fl_data.
lt_fl_data-carrid = 'CBC'.
lt_fl_data-connid = '2389'.
lt_fl_data-fldate = '20131119'.
APPEND lt_fl_data.

LOOP AT lt_fl_data.
  WRITE : / lt_fl_data-carrid, lt_fl_data-connid, lt_fl_data-fldate.

ENDLOOP.

*_________________________________________________________________________________________________________________*
*1. INTERNAL TABLE without HEADER LINE ---------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

DATA : lt_fl_data  TYPE TABLE OF lty_fl_data,
       lwa_fl_data TYPE lty_fl_data.            " WA explicity declared.

CLEAR : lwa_fl_data.
lwa_fl_data-carrid = 'ABC'.
lwa_fl_data-connid = '2397'.
lwa_fl_data-fldate = '20231119'.
APPEND lwa_fl_data TO lt_fl_data.

CLEAR : lwa_fl_data.
lwa_fl_data-carrid = 'CBC'.
lwa_fl_data-connid = '2389'.
lwa_fl_data-fldate = '20131119'.
APPEND lwa_fl_data TO lt_fl_data.

LOOP AT lt_fl_data INTO lwa_fl_data.
  WRITE : / lwa_fl_data-carrid, lwa_fl_data-connid, lwa_fl_data-fldate.

ENDLOOP.
