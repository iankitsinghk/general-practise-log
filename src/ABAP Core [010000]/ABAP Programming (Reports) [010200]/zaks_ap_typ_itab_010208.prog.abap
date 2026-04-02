*&---------------------------------------------------------------------*
*& Report ZAKS_AP_TYP_ITAB_010208
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaks_ap_typ_itab_010208.


TYPES : BEGIN OF lty_fl_data,
          carrid(3) TYPE c,
          connid(4) TYPE n,
          fldate    TYPE s_date,
        END OF lty_fl_data.

*_________________________________________________________________________________________________________________*
*1.STANDARD INTERNAL TABLE ---------------------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

*1.1. -----------------------------------------------------------------------*

DATA : lt_fl_data TYPE TABLE OF lty_fl_data.    "if not specified, it's STANDARD INTERNAL TABLE by default
*DATA : lt_data TYPE STANDARD TABLE OF lty_data.
DATA : lwa_fl_data TYPE lty_fl_data.

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

*1.2/3. -----------------------------------------------------------------------*

*NOTE:
"standard internal tables are indexed based. In debugging mode, when we see the internal table - it has a additional coloumn 'ROW' which stores the index of each row.
"we can use APPEND or INSERT in the internal table. (APPEND inserts the record at the last of the itab, but using INSERT we can insert as record anywhere in the itab.)

lwa_fl_data-carrid = 'SSJ'.
lwa_fl_data-connid = '1993'.
lwa_fl_data-fldate = '20130311'.
INSERT lwa_fl_data INTO TABLE lt_fl_data.       "without 'INDEX' specified, INSERT works as APPEND.
CLEAR : lwa_fl_data.

lwa_fl_data-carrid = 'SMJ'.
lwa_fl_data-connid = '1903'.
lwa_fl_data-fldate = '20130311'.
INSERT lwa_fl_data INTO lt_fl_data INDEX 3.
CLEAR : lwa_fl_data.

*1.4. -----------------------------------------------------------------------*

*NOTE:
"in standard internal table, data is not sorted by default. 'SORT' is used to sort itab.
"by default 'ASCENDING' (if not specified), -- 'DESCENDING'

SORT lt_fl_data BY connid.

*1.5. -----------------------------------------------------------------------*

*NOTE:
"we can read the standard internal table using KEY or INDEX | REF : READ TABLE - Internal Table Operations [010207]

*1.6. -----------------------------------------------------------------------*

*NOTE:
"by default in STANDARD INTERNAL TABLE it's LINEAR SEARCH, but we can also use BINARY SEARCH to improve the performance of std itab
"we need to sort the itab before BINARY SEARCH, much use for high volume of data.

SORT lt_fl_data BY connid.
READ TABLE lt_fl_data INTO lwa_fl_data WITH KEY connid = '1533' BINARY SEARCH.  "is not specified 'BINARY SEARCH' it will be LINEAR SEARCH by default
IF sy-subrc = 0.
  WRITE : / lwa_fl_data-carrid, lwa_fl_data-connid, lwa_fl_data-fldate.

ENDIF.

*_________________________________________________________________________________________________________________*
*2.SORTED INTERNAL TABLE -----------------------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

*2.1. -----------------------------------------------------------------------*

DATA : lt_fl_data  TYPE SORTED TABLE OF lty_fl_data WITH UNIQUE KEY carrid connid,   "we can specify single key or combination of key to be unique or non-unique
       "lt_fl_data  TYPE SORTED TABLE OF lty_fl_data WITH NON-UNIQUE KEY carrid connid,
       lwa_fl_data TYPE lty_fl_data.

*2.2. -----------------------------------------------------------------------*

*NOTE:
"SORTED INTERNAL TABLE is also a INDEXED based internal table
"UNIQUE - duplicate values of (single/combination 'or composite' as declared) is not allowed, NON-UNIQUE - duplicates values of (single/combination as declared) are allowed
"we don't use APPEND here as it makes no sense, as the itab is sorted so the new record can't be added at the last. we use INSERT
"APPEND can only be used if the row is inserted in sorted manner wrt the key(s) defined
"INSERT is used as it can insert row in any positon of itab, so it automatically inserts the row a/c to the sorted position

CLEAR : lwa_fl_data.
lwa_fl_data-carrid = 'ABC'.
lwa_fl_data-connid = '1223'.
lwa_fl_data-fldate = '20210318'.
INSERT lwa_fl_data INTO TABLE lt_fl_data.

CLEAR : lwa_fl_data.
lwa_fl_data-carrid = 'AKK'.
lwa_fl_data-connid = '1923'.
lwa_fl_data-fldate = '20210318'.
INSERT lwa_fl_data INTO TABLE lt_fl_data.

CLEAR : lwa_fl_data.
lwa_fl_data-carrid = 'JCK'.
lwa_fl_data-connid = '6223'.
lwa_fl_data-fldate = '20210318'.
INSERT lwa_fl_data INTO TABLE lt_fl_data.

CLEAR : lwa_fl_data.
lwa_fl_data-carrid = 'SSL'.
lwa_fl_data-connid = '0223'.
lwa_fl_data-fldate = '20210318'.
INSERT lwa_fl_data INTO TABLE lt_fl_data.

CLEAR : lwa_fl_data.
lwa_fl_data-carrid = 'CMS'.
lwa_fl_data-connid = '1223'.
lwa_fl_data-fldate = '20210318'.
INSERT lwa_fl_data INTO TABLE lt_fl_data.

*NOTE:
"if a duplicate value for key(s)[unique - declared] is inserted, it doesn't get inserted/not considered.
"if we want duplicate vaules/record of the declared KEY(s), we should use 'NON-UNIQUE KEY' to declare the sorted itab

CLEAR : lwa_fl_data.
lwa_fl_data-carrid = 'CMS'.
lwa_fl_data-connid = '1223'.
lwa_fl_data-fldate = '20210318'.
INSERT lwa_fl_data INTO TABLE lt_fl_data.


*2.3. -----------------------------------------------------------------------*

*NOTE:
"we can read the standard internal table using KEY or INDEX | REF : READ TABLE - Internal Table Operations [010207]
"same as STANDARD INTERNAL TABLE

*2.4. -----------------------------------------------------------------------*

*NOTE:
"in SORTED ITAB 'BINARY SEARCH' is the default search. so we don't need to use the keyword 'BINARY SEARCH' for it.
"in default case, performance of 'SORTED ITAB' >> 'STANDARD ITAB' [response time : SORTED ITAB < STD ITAB]. but if BS is used in STANDARD ITAB, than both types have similar performance.

*_________________________________________________________________________________________________________________*
*x.STANDARD ITAB vs SORTED ITAB-----------------------------------------------------------------------------------*

"STD ITAB is most commonly used and most popular ITAB, easiest way to to declare ITAB
"sorting and binary search, both are also possible in STD ITAB
"ADV of SORTED ITAB : by declaring itself you specify the key, so if there's a insertion of wrong record here, the itab will not accept (not go for wrong data)
"but STD ITAB  will accept everything, as it is not declared with UNIQUE / NON-UNIQUE KEY(s)
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

*_________________________________________________________________________________________________________________*
*3.HASHED INTERNAL TABLE -----------------------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

*3.1. -----------------------------------------------------------------------*

*NOTE:
"HASHED ITAB is never based on 'INDEX'. no role of index at all. it direclty points to the address of the record.
"UNIQUE KEY only, as if there's a non-unique key than duplicate records cause problem while pointing on address which is based on the key.
"no concept of INDEX or NON-UNIQUE KEY

DATA : lt_fl_data  TYPE HASHED TABLE OF lty_fl_data WITH UNIQUE KEY connid,
       lwa_fl_data TYPE lty_fl_data.

*3.2. -----------------------------------------------------------------------*

*NOTE:
"cannot use APPEND to insert record, it will give system error.
"only INSERT can be used.

CLEAR : lwa_fl_data.
lwa_fl_data-carrid = 'ABC'.
lwa_fl_data-connid = '1223'.
lwa_fl_data-fldate = '20210318'.
INSERT lwa_fl_data INTO TABLE lt_fl_data.

CLEAR : lwa_fl_data.
lwa_fl_data-carrid = 'AKK'.
lwa_fl_data-connid = '1923'.
lwa_fl_data-fldate = '20210318'.
INSERT lwa_fl_data INTO TABLE lt_fl_data.

CLEAR : lwa_fl_data.
lwa_fl_data-carrid = 'JCK'.
lwa_fl_data-connid = '6223'.
lwa_fl_data-fldate = '20210318'.
INSERT lwa_fl_data INTO TABLE lt_fl_data.

CLEAR : lwa_fl_data.
lwa_fl_data-carrid = 'SSL'.
lwa_fl_data-connid = '0223'.
lwa_fl_data-fldate = '20210318'.
INSERT lwa_fl_data INTO TABLE lt_fl_data.

CLEAR : lwa_fl_data.
lwa_fl_data-carrid = 'CMS'.
lwa_fl_data-connid = '1223'.
lwa_fl_data-fldate = '20210318'.
INSERT lwa_fl_data INTO TABLE lt_fl_data.

*NOTE:
"if a duplicate value for key(s)[unique - declared] is inserted, it doesn't get inserted/not considered.

CLEAR : lwa_fl_data.
lwa_fl_data-carrid = 'CMS'.
lwa_fl_data-connid = '1223'.
lwa_fl_data-fldate = '20210318'.
INSERT lwa_fl_data INTO TABLE lt_fl_data.

*3.3. -----------------------------------------------------------------------*

*NOTE:
"no impact of SORT (sorting) in performace or response time and it doesn't work on linear search or binary search as in STD and SORTED ITAB
"here HASH algorithm is used to search the record in the HASHED ITAB.
"performace and response time is alwase the same
"performace is irrespective of the position of the record, as it directly points to it's address no relation with position

*3.4. -----------------------------------------------------------------------*

*NOTE:
"can only be read using KEY. INDEX doesn't exist here, irrelevant.

*3.4.1 'INDEX'---------------------------------------------------------------------*

*ERROR for below code-snippet : Explicit or implicit index operations cannot be used on tables with types "HASHED TABLE" or "ANY TABLE".
*"LT_FL_DATA" has the type "HASHED TABLE". It is possible that the addition "TABLE" was not specified	before "LT_FL_DATA".

*READ TABLE lt_fl_data INTO lwa_fl_data INDEX 4.
*IF sy-subrc = 0.
*  WRITE : / lwa_fl_data-carrid, lwa_fl_data-connid, lwa_fl_data-fldate.
*
*ENDIF.

*3.4.2 'WITH KEY' ------------------------------------------------------------------*

READ TABLE lt_fl_data INTO lwa_fl_data WITH KEY connid = '1223'.
IF sy-subrc = 0.
  WRITE : / lwa_fl_data-carrid, lwa_fl_data-connid, lwa_fl_data-fldate.

ENDIF.

*_________________________________________________________________________________________________________________*
*x.STANDARD vs SORTED vs HASHED-----------------------------------------------------------------------------------*

"1. better response-time / Performance : HASHED > SORTED = STANDARD (BS) > STANDARD (default : LS)
"2. if number of records increased, than performance : HASHED (no impact, no searching) > |SORTED = STANDARD (BS) > STANDARD (default : LS) - performance of both will be impacted|
"3. if you want/go for INDEX or NON-UNIQUE KEY(s), than you can't use HASHED ITAB
"4. Most common, highly used : STANDARD ITAB. Specific or Rare case : SORTED / HASHED
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*



*_________________________________________________________________________________________________________________*
*x.OUTPUT LOOP ---------------------------------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

*LOOP AT lt_fl_data INTO lwa_fl_data.
*  WRITE : / lwa_fl_data-carrid, lwa_fl_data-connid, lwa_fl_data-fldate.
*ENDLOOP.
