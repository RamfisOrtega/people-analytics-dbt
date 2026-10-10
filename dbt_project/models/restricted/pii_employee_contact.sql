select
    trim(employee_id) as employee_id,
    trim(first_name)  as first_name,
    trim(last_name)   as last_name,
    trim(work_email)  as work_email
from {{ ref('raw_employees') }}
