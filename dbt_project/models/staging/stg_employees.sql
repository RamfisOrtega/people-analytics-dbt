select
    trim(employee_id)                as employee_id,
    {{ hash_pii('work_email') }}     as email_hash,
    hire_date,
    termination_date,
    lower(trim(termination_type))    as termination_type
from {{ ref('raw_employees') }}
