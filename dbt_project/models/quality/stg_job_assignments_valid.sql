-- Only job assignments that are NOT in quarantine.
select *
from {{ ref('stg_job_assignments') }}
where record_id not in (
    select record_id
    from {{ ref('quarantine_records') }}
    where source_table = 'raw_job_assignments'
)
