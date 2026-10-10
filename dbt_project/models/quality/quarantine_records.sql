-- Pproblem row/s, with its reason
select
    source_table,
    record_id,
    reason_code,
    reason_detail
from {{ ref('int_record_checks') }}
