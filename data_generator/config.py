from datetime import date
from pathlib import Path

SEED = 42
NUM_EMPLOYEES = 300

START_DATE = date(2022, 1, 1)
END_DATE = date(2026, 9, 30)    # nothing happens after this date

ATTRITION_RATE = 0.12           # 12% leave per year
DEFECT_RATE = 0.03              # 3% of rows broken on purpose

DEPARTMENTS = ["Engineering", "Sales", "Marketing", "Finance",
               "People", "Operations", "Support", "Product"]

LOCATIONS = ["NTH", "STH", "CTR"]
EMAIL_DOMAIN = "example.com"

ROOT = Path(__file__).parent.parent
OUTPUT_DIR = ROOT / "dbt_project" / "seeds"
DEFECT_LOG = ROOT / "data_generator" / "injected_defects.json"
