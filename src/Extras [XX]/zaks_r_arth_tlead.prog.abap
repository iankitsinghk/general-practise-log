*&---------------------------------------------------------------------*
*& Report zaks_r_arth_tlead
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zaks_r_arth_tlead.

select from vbak as a inner join kna1 as b
on a~kunnr = b~kunnr
fields a~vkorg, a~kunnr, b~name1, b~land1,
case b~land1
    when 'US' then 'United States'
    when 'DE' then 'Denmark'
    when 'IN' then 'India'
    else 'Others'
    end as country,
    count( * ) as sales_order_count,
    Sum( a~netwr ) as source_total,
    a~waerk,
    sum(
    currency_conversion( amount = a~netwr,
    source_currency = a~waerk,
    target_currency = 'INR',
    exchange_rate_date = @sy-datum ) ) as total,
    'INR' as target_currency,
    case
        when sum(
            currency_conversion( amount = a~netwr,
            source_currency  = a~waerk,
            target_currency = 'INR',
            exchange_rate_date = @sy-datum ) ) > 100000 then 'Prime Customer'
        else 'Non Prime Customer'
        End as Category,
        case
            when sum( currency_conversion(
            amount = a~netwr,
            source_currency = a~waerk,
            target_currency = 'INR',
            exchange_rate_date = @sy-datum ) ) eq 0 then 0

            else division( sum( currency_conversion(
            amount = a~netwr,
            source_currency = a~waerk,
            target_currency = 'INR',
            exchange_rate_date = @sy-datum ) ), count( * ), 2 )

end as total_ps
group by a~kunnr, b~name1, b~land1, a~vkorg, a~waerk
order by a~kunnr, a~vkorg
into table @data(it_cust_class).

if it_cust_class[] is not initial.
try.
    cl_salv_table=>factory( importing r_salv_table = data(lo_data)
                            changing t_table = it_cust_class ).

  catch cx_salv_msg.
  endtry.

  try.
        data(lo_function) = lo_data->get_functions( ).
        lo_function->set_all( abap_true ).
        data(lo_colms) = lo_data->get_columns( ).
        data(lo_colm_s_t) = lo_colms->get_column( 'SOURCE_TOTAL' ).
        lo_colm_s_t->set_long_text( 'Total (Uncovered)' ).
        data(lo_colm_t) = lo_colms->get_column( 'TOTAL' ).
        lo_colm_t->set_long_text( 'Total (INR)' ).
        data(lo_colm_c) = lo_colms->get_column( 'COUNTRY' ).
        lo_colm_c->set_long_text( 'Nationality' ).
        data(lo_colm_sc) = lo_colms->get_column( 'SALES_ORDER_COUNT' ).
        lo_colm_sc->set_long_text( 'Sales Order Count' ).
        data(lo_colm_s_cu) = lo_colms->get_column( 'WAERK' ).
        lo_colm_s_cu->set_long_text( 'Source Currency' ).
        data(lo_colm_ca) = lo_colms->get_column( 'CATEGORY' ).
        lo_colm_ca->set_long_text( 'Category' ).
        data(lo_colm_t_ps) = lo_colms->get_column( 'TOTAL_PS' ).
        lo_colm_t_ps->set_long_text( 'Total_Per_SO(INR)' ).
        lo_data->display( ).
        catch cx_salv_not_found.

        endtry.
        endif.
