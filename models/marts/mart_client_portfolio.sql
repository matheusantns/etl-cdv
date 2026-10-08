with fact as (
    select * from {{ ref('fact_transactions') }}
),

clients as (
    select * from {{ ref('dim_clients') }}
),

netted as (
    select
        f.client_id,
        f.asset_ticker,
        sum({{ signed_quantity('f.operation', 'f.quantity') }}) as net_quantity,
        sum({{ signed_quantity('f.operation', 'f.quantity') }} * f.unit_price) as net_notional
    from fact f
    group by
        f.client_id,
        f.asset_ticker
)

select
    n.client_id || '|' || n.asset_ticker as portfolio_id,
    n.client_id,
    c.name as client_name,
    n.asset_ticker,
    n.net_quantity,
    n.net_notional
from netted n
inner join clients c
    on n.client_id = c.client_id
