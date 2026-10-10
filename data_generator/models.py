from dataclasses import dataclass
from datetime import date

@dataclass
class Employee:
    employee_id: str
    first_name: str
    last_name: str
    work_email: str
    hire_date: date | None           # None only when a defect is injected
    termination_date: date | None = None
    termination_type: str | None = None   # "voluntary" / "involuntary"


@dataclass
class Department:
    department_id: str
    department_name: str


@dataclass
class JobAssignment:
    assignment_id: str
    employee_id: str
    department_id: str
    job_level: int
    manager_id: str | None          # None only for the top person
    location_code: str
    start_date: date
    end_date: date | None           # still in this job
