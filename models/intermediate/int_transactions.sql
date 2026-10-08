with transactions as (
    select * from {{ ref('stg_transactions') }}
),

clients as (
    select * from {{ ref('dim_clients') }}
)

select
    t.transaction_id,
    t.client_id,
    t.asset_ticker,
    t.operation,
    t.quantity,
    t.unit_price,
    t.transaction_date,
    c.name as client_name,
    c.city as client_city,
    c.state as client_state,
from transactions t
inner join clients c
    on t.client_id = c.client_id