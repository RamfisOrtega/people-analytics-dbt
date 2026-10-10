# Planted bad rows (answer key)

These rows were added to the seed CSVs on purpose.
dbt must send every one of them to `quarantine_records` with the reason code below.

All bad rows belong to employees `E0901`–`E0914` and use assignment IDs starting with `A9`.

| Reason code | Table | Record | What is wrong |
|---|---|---|---|
| OVERLAPPING_ASSIGNMENT | raw_job_assignments | A90001, A90002 | E0901 has 2 open jobs at the same time from 2024-03-01 |
| OVERLAPPING_ASSIGNMENT | raw_job_assignments | A90003, A90004 | E0902: second job starts 2024-06-01, first job ends 2024-12-31 |
| START_AFTER_END | raw_job_assignments | A90005 | starts 2025-06-01, ends 2025-01-01 |
| START_AFTER_END | raw_job_assignments | A90006 | starts 2024-09-15, ends 2024-03-01 |
| OUTSIDE_EMPLOYMENT | raw_job_assignments | A90007 | job starts 2023-11-01, but E0905 was hired 2024-01-15 |
| OUTSIDE_EMPLOYMENT | raw_job_assignments | A90008 | job ends 2024-12-31, but E0906 left 2024-02-29 |
| ORPHAN_MANAGER | raw_job_assignments | A90009 | manager E9999 does not exist |
| ORPHAN_MANAGER | raw_job_assignments | A90010 | manager E9998 does not exist |
| MANAGER_CYCLE | raw_job_assignments | A90011, A90012 | E0909 reports to E0910, and E0910 reports to E0909 |
| DUPLICATE_ASSIGNMENT_ID | raw_job_assignments | A90013 (2 rows) | the same ID is used for E0911 and E0912 |
| MISSING_REQUIRED_FIELD | raw_employees | E0913 | hire_date is empty |
| MISSING_REQUIRED_FIELD | raw_job_assignments | A90014 | department_id is empty |

Totals: 16 bad rows (15 assignments, 1 employee), 7 reason codes.
