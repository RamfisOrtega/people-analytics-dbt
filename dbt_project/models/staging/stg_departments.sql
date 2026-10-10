select
    trim(department_id) as department_id,
    trim(department_name) as department_name
from {{ ref('raw_departments') }}