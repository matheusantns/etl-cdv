{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key='transaction_id'
    )
}}

with source as (
    select * from {{ ref('int_transactions') }}
)

select
    transaction_id,
    client_id,
    asset_ticker,
    operation,
    quantity,
    unit_price,
    transaction_date,
    client_name,
    client_city,
    client_state,
    {{ signed_quantity('operation', 'quantity') }} as signed_quantity,
    {{ signed_quantity('operation', 'quantity') }} * unit_price as signed_notional
from source
{% if is_incremental() %}
where transaction_date > (select max(transaction_date) from {{ this }})
{% endif %}
