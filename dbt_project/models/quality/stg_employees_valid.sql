-- Only employees that are NOT in quarantine.
select *
from {{ ref('stg_employees') }}
where employee_id not in (
    select record_id
    from {{ ref('quarantine_records') }}
    where source_table = 'raw_employees'
)
