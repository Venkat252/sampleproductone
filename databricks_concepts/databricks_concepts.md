# Databricks Concepts

Databricks is a cloud data and AI platform built around Apache Spark. It provides
one workspace for data engineering, analytics, machine learning, and governance.

## Core concepts

- **Lakehouse**: Combines data lake flexibility with data warehouse reliability.
- **Workspace**: Collaborative environment for notebooks, jobs, compute, and SQL.
- **Apache Spark**: Distributed processing engine used for large-scale data.
- **DataFrames**: Distributed, table-like data structures processed with Spark.
- **Delta Lake**: Storage layer providing ACID transactions, schema enforcement,
  time travel, and reliable updates.
- **Medallion architecture**: Bronze raw data, Silver cleaned data, and Gold
  business-ready data.
- **Jobs**: Scheduled or triggered workflows made of dependent tasks.
- **Unity Catalog**: Centralized governance, permissions, lineage, and discovery.
- **SQL warehouses**: Compute optimized for SQL queries, dashboards, and BI tools.
- **MLflow**: Tools for tracking experiments, registering models, and serving ML.

## Delta Lake example

```sql
MERGE INTO target t
USING updates u
ON t.customer_id = u.customer_id
WHEN MATCHED THEN UPDATE SET *
WHEN NOT MATCHED THEN INSERT *;
```

## Recommended learning order

1. SQL and data modeling.
2. Python and Spark DataFrames.
3. Spark transformations, actions, and joins.
4. Delta Lake tables and `MERGE`.
5. Bronze, Silver, and Gold pipelines.
6. Streaming and Auto Loader.
7. Jobs and workflow orchestration.
8. Unity Catalog and security.
9. Performance tuning and monitoring.
10. MLflow and machine-learning workflows.

## Mini project

Build a pipeline that ingests files into Bronze, cleans them into Silver, creates
Gold aggregates, schedules the workflow as a job, and applies Unity Catalog
permissions and data quality checks.
