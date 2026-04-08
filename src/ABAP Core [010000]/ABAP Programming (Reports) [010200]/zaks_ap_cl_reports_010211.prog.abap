*&---------------------------------------------------------------------*
*& Report ZAKS_AP_CL_REPORTS_010211
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaks_ap_cl_reports_010211.

*_________________________________________________________________________________________________________________*
*1. Basic Classical Program (Sum) --------------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

DATA : lv_out TYPE numc3.
PARAMETERS : p_inp1 TYPE numc2,
             p_inp2 TYPE numc2.

lv_out = p_inp1 + p_inp2.
WRITE : / 'The Sum is :', lv_out.


TYPES : BEGIN OF lty_scarr,
          air_id       TYPE s_carr_id,
          air_name     TYPE s_carrname,
          air_currcode TYPE s_currcode,
          air_url      TYPE s_carrurl,
        END OF lty_scarr.

DATA : lt_air_data  TYPE TABLE OF lty_scarr,
       lwa_air_data TYPE lty_scarr.

*_________________________________________________________________________________________________________________*
*2. Classical Report- Fetching SCARR Table (single input) --------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

*Requirement : Input will be the single value of s_carr_id and the output will be the details according to it.

PARAMETERS : p_carr TYPE s_carr_id.


SELECT carrid AS air_id, carrname AS air_name, currcode AS air_currcode, url AS air_url
  FROM scarr
  INTO TABLE @lt_air_data
  WHERE carrid = @p_carr        "we will recieve only one record for each carrid as it's a primary key (unique).


LOOP AT lt_air_data INTO lwa_air_data.
  WRITE : / lwa_air_data-air_id, lwa_air_data-air_name, lwa_air_data-air_currcode, lwa_air_data-air_url.

ENDLOOP.

*NOTE:
" 1. as carrid is the primary key and only 1 record for each matching carrid -- we can use READ TABLE also for displaying the data. But we need to be completely sure that it has 1 record to display only as READ TABLE only displays 1st matching record
" if you can avoid loop, you should avoid but after being completely sure.
" 2. as per the current requirement we have only one record to display if the carrid matches, so we can use WA directly instead of ITAB as it has only one record. But use only if sure. for multiple records to store we'll have to use ITAB.
" 3. we can also fetch the data (single records) by declaring variable(s) according to the required fields
" when you have mutiple records to fetch and display, use ITAB and don't use SELECT SINGLE.
" or if confusion or not sure directly go with ITAB , SELECT and LOOP

*1. ------------------------------------------------------------------------------------------------------------------*

READ TABLE lt_air_data INTO lwa_air_data INDEX 1.
IF sy-subrc = 0.
  WRITE : / lwa_air_data-air_id, lwa_air_data-air_name, lwa_air_data-air_currcode, lwa_air_data-air_url.
ENDIF.

*2. -------------------------------------------------------------------------------------------------------------------*

SELECT SINGLE carrid AS air_id, carrname AS air_name, currcode AS air_currcode, url AS air_url
  FROM scarr
  INTO @lwa_air_data           "don't use INTO TABLE here as WA is not a table.
  WHERE carrid = @p_carr.


  IF sy-subrc = 0.
    WRITE : / lwa_air_data-air_id, lwa_air_data-air_name, lwa_air_data-air_currcode, lwa_air_data-air_url.
  ENDIF.

*3. -------------------------------------------------------------------------------------------------------------------*

  DATA : lv_carrid   TYPE s_carr_id,
         lv_carrname TYPE s_carrname,
         lv_currcode TYPE s_currcode,
         lv_url      TYPE s_carrurl.

  SELECT SINGLE carrid, carrname, currcode, url
    FROM scarr
    INTO ( @lv_carrid, @lv_carrname, @lv_currcode, @lv_url )
    WHERE carrid = @p_carr.


    IF sy-subrc = 0.
      WRITE : / lv_carrid, lv_carrname, lv_currcode, lv_url.

    ENDIF.

*_________________________________________________________________________________________________________________*
*3. Classical Report- Fetching SCARR Table (multiple inputs / range) ---------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

*Requirement : Input will be the multiple value or range of s_carr_id and the output will be the details according to it.

    DATA : lv_scarr TYPE s_carr_id.
    SELECT-OPTIONS : s_carr FOR lv_scarr.

    SELECT carrid AS air_id, carrname AS air_name, currcode AS air_currcode, url AS air_url
      FROM scarr
      INTO TABLE @lt_air_data
      WHERE carrid IN @s_carr.

      LOOP AT lt_air_data INTO lwa_air_data.
        WRITE : / lwa_air_data-air_id, lwa_air_data-air_name, lwa_air_data-air_currcode, lwa_air_data-air_url.

      ENDLOOP.


*_________________________________________________________________________________________________________________*
*4. Output from multiple database tables -------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

*Logic
      "Display the output using 2 database tables, say - scarr (header) and sflight(item)
      "Write separate queries to fetch data from header and item tables.
      "Use 'FOR ALL ENTRIES IN' to fetch data from item table.

      TYPES : BEGIN OF lty_scarr,
                carrid   TYPE s_carr_id,
                carrname TYPE s_carrname,
                currcode TYPE s_currcode,
              END OF lty_scarr.

      DATA : lt_scarr  TYPE TABLE OF lty_scarr,
             lwa_scarr TYPE lty_scarr.

      TYPES : BEGIN OF lty_sflight,
                carrid  TYPE s_carr_id,
                connid  TYPE s_conn_id,
                fldate  TYPE s_date,
                seatmax TYPE s_seatsmax,
              END OF lty_sflight.

      DATA : lt_sflight  TYPE TABLE OF lty_sflight,
             lwa_sflight TYPE lty_sflight.

      TYPES : BEGIN OF lty_final,
                carrid   TYPE s_carr_id,
                carrname TYPE s_carrname,
                currcode TYPE s_currcode,
                connid   TYPE s_conn_id,
                fldate   TYPE s_date,
                seatmax  TYPE s_seatsmax,
              END OF lty_final.

      DATA : lt_final  TYPE TABLE OF lty_final,
             lwa_final TYPE lty_final.

      DATA : lv_carr_id TYPE s_carr_id.
      SELECT-OPTIONS : s_carr FOR lv_carr_id.
      DATA : lv_flag TYPE boolean.

*NOTE:
      "always fetch data from header table first as without header there's no item for a record. (if nothing from header table than no record from item table)

      SELECT carrid, carrname, currcode
        FROM scarr
        INTO TABLE @lt_scarr
        WHERE carrid IN @s_carr.

        IF  lt_scarr IS NOT INITIAL.             "as if there's a valid record in scarr for the s_carr than the internal table will not be initial (not empty)
          SELECT carrid, connid, fldate, seatmax
            FROM sflight
            INTO TABLE @lt_sflight
            FOR ALL ENTRIES IN lt_scarr
            WHERE carrid = lt_scarr-carrid.

          ENDIF.

*or

*IF  sy-subrc = 0.
*  SELECT carrid, connid, fldate, seatsmax
*    FROM sflight
*    INTO TABLE @lt_sflight
**    UP TO 100 ROWS
*    FOR ALL ENTRIES IN @lt_scarr
*    WHERE carrid = @lt_scarr-carrid.
*
*ENDIF.

*NOTE:
          "here we'll have to compulsory go for nested loop as for 1 record in header table there are multiple records in item table.

          LOOP AT lt_scarr INTO lwa_scarr.
            LOOP AT lt_sflight INTO lwa_sflight WHERE carrid = lwa_scarr-carrid.
              lwa_final-carrid = lwa_scarr-carrid.
              lwa_final-carrname = lwa_scarr-carrname.
              lwa_final-currcode = lwa_scarr-currcode.
              lwa_final-connid = lwa_sflight-connid.
              lwa_final-fldate = lwa_sflight-fldate.
              lwa_final-seatmax = lwa_sflight-seatmax.
              APPEND lwa_final TO lt_final.
              CLEAR : lwa_final.
            ENDLOOP.

          ENDLOOP.

*REQURIREMENT:
          "if we want a logic that displays the header columns even if the corresponding items are not present in the item table.

          LOOP AT lt_scarr INTO lwa_scarr.
            LOOP AT lt_sflight INTO lwa_sflight WHERE carrid = lwa_scarr-carrid.
              lwa_final-carrid = lwa_scarr-carrid.
              lwa_final-carrname = lwa_scarr-carrname.
              lwa_final-currcode = lwa_scarr-currcode.
              lwa_final-connid = lwa_sflight-connid.
              lwa_final-fldate = lwa_sflight-fldate.
              lwa_final-seatmax = lwa_sflight-seatmax.
              APPEND lwa_final TO lt_final.
              CLEAR : lwa_final.
              lv_flag = 'X'.
            ENDLOOP.
            IF lv_flag = ' '.
              lwa_final-carrid = lwa_scarr-carrid.
              lwa_final-carrname = lwa_scarr-carrname.
              lwa_final-currcode = lwa_scarr-currcode.
              APPEND : lwa_final TO lt_final.
              CLEAR : lwa_final.
            ENDIF.
            CLEAR : lv_flag.
          ENDLOOP.

          LOOP AT lt_final INTO lwa_final.
            WRITE : / lwa_final-carrid, lwa_final-carrname, lwa_final-connid, lwa_final-currcode, lwa_final-fldate, lwa_final-seatmax.

          ENDLOOP.

*_________________________________________________________________________________________________________________*
*5. JOINS (INNER / OUTER) ----------------------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

          TYPES : BEGIN OF lty_final,
                    carrid   TYPE s_carr_id,
                    carrname TYPE s_carrname,
                    currcode TYPE s_currcode,
                    connid   TYPE s_conn_id,
                    fldate   TYPE s_date,
                    seatmax  TYPE s_seatsmax,
                  END OF lty_final.

          DATA : lt_final  TYPE TABLE OF lty_final,
                 lwa_final TYPE lty_final.

          DATA : lv_carrid TYPE s_carr_id.
          SELECT-OPTIONS : s_carr FOR lv_carrid.

*5.1. INNER JOINS ----------------------------------------------------------------------------------*

*NOTE :
          " it returns the matching records between the tables.


          SELECT sc~carrid, sc~carrname, sc~currcode, sf~connid, sf~fldate, sf~seatsmax
            FROM scarr AS sc INNER JOIN sflight AS sf
*  FROM scarr AS sc JOIN sflight AS sf         "if we just write JOIN by default it will consider it as INNER JOIN
            ON sc~carrid = sf~carrid
            INTO TABLE @lt_final
            WHERE sc~carrid IN @s_carr.


*5.2. OUTER JOINS - LEFT OUTER JOINS ---------------------------------------------------------------*

*NOTE :
            " it returns the matching as well as non-matching records between the tables


            SELECT sc~carrid, sc~carrname, sc~currcode, sf~connid, sf~fldate, sf~seatsmax
              FROM scarr AS sc LEFT OUTER JOIN sflight AS sf
*  FROM scarr AS sc LEFT JOIN sflight AS sf        " we can write LEFT OUTER JOIN / LEFT JOIN
              ON sc~carrid = sf~carrid
              INTO TABLE  @lt_final
              WHERE sc~carrid IN @s_carr.


*_________________________________________________________________________________________________________________*
*x. OUTPUT -------------------------------------------------------------------------------------------------------*
*_________________________________________________________________________________________________________________*
*-----------------------------------------------------------------------------------------------------------------*

              LOOP AT lt_final INTO lwa_final.
                WRITE : / lwa_final-carrid, lwa_final-carrname, lwa_final-connid, lwa_final-currcode, lwa_final-fldate, lwa_final-seatmax.

              ENDLOOP.
