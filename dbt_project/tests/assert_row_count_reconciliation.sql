-- A dbt test passes when it returns 0 rows.
-- Rule: raw rows = valid rows + quarantined rows, for every table. No row is lost.

with counts as (
    select
        'raw_employees' as source_table,
        (select count(*) from {{ ref('raw_employees') }}) as raw_rows,
        (select count(*) from {{ ref('stg_employees_valid') }}) as valid_rows,
        (select count(distinct record_id) from {{ ref('quarantine_records') }}
          where source_table = 'raw_employees') as quarantined_rows

    union all

    select
        'raw_job_assignments',
        (select count(*) from {{ ref('raw_job_assignments') }}),
        (select count(*) from {{ ref('stg_job_assignments_valid') }}),
        (select count(distinct record_id) from {{ ref('quarantine_records') }}
          where source_table = 'raw_job_assignments')

    union all

    select
        'raw_departments',
        (select count(*) from {{ ref('raw_departments') }}),
        (select count(*) from {{ ref('stg_departments_valid') }}),
        (select count(distinct record_id) from {{ ref('quarantine_records') }}
          where source_table = 'raw_departments')
)

select *
from counts
where raw_rows <> valid_rows + quarantined_rows
