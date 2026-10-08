with source as (
    select * from {{ ref('transactions') }}
), 

typed as (
    select
        transaction_id::varchar as transaction_id,
        client_id::varchar as client_id,
        asset_ticker::varchar as asset_ticker,
        operation::varchar as operation,
        quantity::decimal(18, 4) as quantity,
        unit_price::decimal(18, 4) as unit_price,
        transaction_date::date as transaction_date
    from source
)

select * 
from typed
where trim(client_id) <> ''
    and quantity > 0
    and operation in ('BUY', 'SELL')