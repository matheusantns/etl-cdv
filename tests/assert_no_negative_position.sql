{{ config(severity='warn') }}

select
    portfolio_id,
    client_id,
    asset_ticker,
    net_quantity
from {{ ref('mart_client_portfolio') }}
where net_quantity < 0
