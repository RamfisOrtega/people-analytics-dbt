-- One row per problem found. A row with 2 problems shows up twice.

with employees as (
    select * from {{ ref('stg_employees') }}
),

assignments as (
    select * from {{ ref('stg_job_assignments') }}
),

-- Check 1: required fields are empty
missing_employee_fields as (
    select
        'raw_employees'           as source_table,
        employee_id               as record_id,
        'MISSING_REQUIRED_FIELD'  as reason_code,
        'hire_date is empty'      as reason_detail
    from employees
    where hire_date is null
),

missing_assignment_fields as (
    select
        'raw_job_assignments'     as source_table,
        record_id,
        'MISSING_REQUIRED_FIELD'  as reason_code,
        'a required field is empty' as reason_detail
    from assignments
    where employee_id is null
       or department_id is null
       or job_level is null
       or location_code is null
       or start_date is null
),

-- Check 2: job ends before it starts
start_after_end as (
    select
        'raw_job_assignments'     as source_table,
        record_id,
        'START_AFTER_END'         as reason_code,
        'start_date is after end_date' as reason_detail
    from assignments
    where start_date > end_date
),

-- Check 3: manager does not exist
orphan_manager as (
    select
        'raw_job_assignments'     as source_table,
        a.record_id,
        'ORPHAN_MANAGER'          as reason_code,
        'manager ' || a.manager_id || ' does not exist' as reason_detail
    from assignments a
    left join employees e on a.manager_id = e.employee_id
    where a.manager_id is not null
      and e.employee_id is null
),

-- Check 4: same assignment_id used on more than one row
duplicate_assignment_id as (
    select
        'raw_job_assignments'     as source_table,
        record_id,
        'DUPLICATE_ASSIGNMENT_ID' as reason_code,
        'assignment_id ' || assignment_id || ' is used more than once' as reason_detail
    from assignments
    where assignment_id in (
        select assignment_id
        from assignments
        group by assignment_id
        having count(*) > 1
    )
),

-- Check 5: job dates fall outside the employment dates
outside_employment as (
    select
        'raw_job_assignments'     as source_table,
        a.record_id,
        'OUTSIDE_EMPLOYMENT'      as reason_code,
        'job dates fall outside hire and termination dates' as reason_detail
    from assignments a
    join employees e on a.employee_id = e.employee_id
    where a.start_date < e.hire_date
       or (e.termination_date is not null
           and coalesce(a.end_date, date '9999-12-31') > e.termination_date)
),

-- Check 6: two jobs for the same person at the same time
overlapping_assignment as (
    select
        'raw_job_assignments'     as source_table,
        a.record_id,
        'OVERLAPPING_ASSIGNMENT'  as reason_code,
        'overlaps with ' || b.record_id as reason_detail
    from assignments a
    join assignments b
      on a.employee_id = b.employee_id
     and a.record_id <> b.record_id
     and a.start_date <= coalesce(b.end_date, date '9999-12-31')
     and b.start_date <= coalesce(a.end_date, date '9999-12-31')
)




select * from missing_employee_fields
union all
select * from missing_assignment_fields
union all
select * from start_after_end
union all
select * from orphan_manager
union all
select * from duplicate_assignment_id
union all
select * from outside_employment
union all
select * from overlapping_assignment


