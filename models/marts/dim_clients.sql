with ranked as (
    select 
        client_id,
        name,
        city,
        state,
        created_at,
        row_number() over (
            partition by client_id
            order by 
                case when trim(city) <> '' then 1 else 0 end desc,
                created_at,
                name
        ) as rn
    from {{ ref('stg_clients') }}
)

select
    client_id,
    name,
    city,
    state,
    created_at
from ranked
where rn = 1