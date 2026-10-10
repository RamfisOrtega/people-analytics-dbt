-- No checks on departments yet, so every row is valid.
select *
from {{ ref('stg_departments') }}
