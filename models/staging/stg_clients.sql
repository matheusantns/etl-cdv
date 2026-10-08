with source as ( 
    select * from {{ ref('clients') }}
),

typed as (
    select 
        client_id::varchar as client_id,
        name::varchar as name,
        city::varchar as city,
        state::varchar as state,
        created_at::date as created_at
    from source
)

select * from typed