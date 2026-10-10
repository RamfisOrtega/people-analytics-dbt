# people-analytics-dbt

**Workforce data that doesn't lie.**

<!-- CI badge goes here in Stage 4 (repo: RamfisOrtega/people-analytics-dbt) -->

> All data in this project is synthetic (made up). No real people or companies.

## Goals

This project shows how to turn messy HR data into numbers you can trust.

- **Effective-dated records.** Every job change has a start date and an end date.
- **SCD Type 2 employee dimension.** It keeps the full history of each employee, one row per version.
- **Point-in-time headcount.** How many people worked here on any given date?
- **Monthly attrition.** How many people left each month, and was it voluntary or not?
- **Data quality with quarantine.** Bad rows are not deleted. They go to a quarantine table with a reason code.
- **PII handling.** Names and emails are kept out of the reporting tables.

Where it runs:

- **DuckDB (default).** Local, free, no account needed. CI uses this.
- **Snowflake (optional).** The same dbt models, set up through environment variables. Documented, not tested in CI.

## The problem

_TODO (Stage 4)._

## Architecture

How data flows, left to right:

```mermaid
flowchart LR
    subgraph SRC["1 · Source"]
        CSV["Synthetic CSV files<br/>+ planted bad rows"]
    end

    subgraph SEEDS["2 · Raw seeds (CSV)"]
        RD["raw_departments"]
        RE["raw_employees"]
        RJ["raw_job_assignments"]
    end

    subgraph STG["3 · Staging"]
        SE["stg_employees<br/>email → email_hash"]
        SJ["stg_job_assignments"]
        SD["stg_departments"]
    end

    subgraph DQ["4 · Quality"]
        CHK["int_record_checks<br/>one row per problem"]
        Q["quarantine_records<br/>reason codes"]
        V["stg_*_valid<br/>clean rows only"]
    end

    subgraph PII["Restricted schema"]
        P["pii_employee_contact<br/>names + emails"]
    end

    subgraph MARTS["5 · Marts (no PII)"]
        DE["dim_employee<br/>SCD Type 2"]
        DD["dim_department"]
        DT["dim_date"]
        FH["fct_headcount_monthly"]
        FA["fct_attrition_monthly"]
    end

    CSV --> RD & RE & RJ
    RD --> SD
    RE --> SE
    RJ --> SJ
    RE -. names, emails .-> P
    SE & SJ & SD --> CHK
    CHK -- has a problem --> Q
    CHK -- no problem --> V
    V --> DE & DD
    DT --> FH & FA
    DE --> FH & FA
    DD --> FH
```

How to read it:

- **Solid arrows** show the main data flow.
- **The dotted arrow** shows where personal data goes: only to the restricted schema.
- **Every raw row ends up in one place:** either in a `stg_*_valid` model or in `quarantine_records`. Never lost.

Where the same dbt project runs:

```mermaid
flowchart LR
    DBT["dbt project<br/>same SQL models"] --> DUCK["DuckDB<br/>default · local · CI"]
    DBT -. optional .-> SF["Snowflake<br/>env vars · not in CI"]
```

## Quickstart

_TODO (Stage 4): 5 commands, PowerShell and bash._

## Data model

_TODO (Stage 4)._

## Data-quality design

_TODO (Stage 4): reason codes and the reconciliation rule._

## Metric definitions

### Headcount (point in time)

_TODO (Stage 4)._

### Attrition

_TODO (Stage 4)._

## PII handling

_TODO (Stage 4)._

## How to run the tests

_TODO (Stage 4)._

## Run on Snowflake (optional, not tested in CI)

_TODO (Stage 4)._

## Design decisions and trade-offs

_TODO (Stage 4)._

## Limitations and next steps

_TODO (Stage 4)._

## Synthetic data note

_TODO (Stage 4)._

## License

MIT. See [LICENSE](LICENSE).
