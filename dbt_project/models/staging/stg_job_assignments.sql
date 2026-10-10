select
    trim(assignment_id) || '|' || trim(employee_id) as record_id,
    trim(assignment_id) as assignment_id,
    trim(employee_id)   as employee_id,
    trim(department_id) as department_id,
    job_level,
    trim(manager_id)    as manager_id,
    trim(location_code) as location_code,
    start_date,
    end_date
from {{ ref('raw_job_assignments') }}
