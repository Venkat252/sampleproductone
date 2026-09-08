# Databricks Concepts

Databricks is a cloud data and AI platform built around Apache Spark. It provides
one workspace for data engineering, analytics, machine learning, and governance.

## 1. Lakehouse architecture

The **lakehouse** combines:

- The low-cost, flexible storage of a data lake.
- The reliability, performance, and governance of a data warehouse.

Data is usually stored in cloud object storage such as Amazon S3, Azure Data Lake
Storage, or Google Cloud Storage. Databricks adds compute, table management,
security, and collaborative development on top of that storage.

## 2. Workspace

A Databricks **workspace** is the collaborative environment where teams manage:

- Notebooks and source code.
- Compute resources.
- Jobs and pipelines.
- SQL queries and dashboards.
- Catalogs, schemas, tables, and permissions.

Workspaces are commonly separated by environment, such as development, testing,
and production.

## 3. Notebooks

Notebooks contain executable code and documentation. They can use languages such
as Python, SQL, Scala, and R.

Important notebook features include:

- **Cells**: Independent executable blocks.
- **Magic commands**: For example, `%sql`, `%python`, and `%run`.
- **Widgets/parameters**: Inputs used to make notebooks reusable.
- **Notebook workflows**: Calling one notebook from another.

Use notebooks for exploration, prototyping, and small-to-medium production tasks.
Move reusable production logic into source-controlled modules when appropriate.

## 4. Apache Spark

Spark is the distributed processing engine used by Databricks.

Core ideas:

- A **driver** coordinates the application.
- **Worker nodes** execute tasks.
- A **cluster** provides the driver and workers.
- A **DataFrame** is a distributed table-like collection.
- A **transformation** builds a query plan lazily.
- An **action** executes the plan and produces a result.

Examples of transformations are `select`, `filter`, and `join`. Examples of
actions are `count`, `collect`, and `write`.

Avoid `collect()` on large datasets because it moves all results to the driver.

## 5. Compute options

Databricks provides different compute types for different workloads:

- **All-purpose compute**: Interactive development and exploration.
- **Job compute**: Temporary compute created for scheduled workloads.
- **SQL warehouses**: Optimized compute for SQL queries, dashboards, and BI tools.
- **Serverless compute**: Databricks-managed compute that reduces infrastructure
  management where supported.

Choose the smallest suitable compute, enable autoscaling when useful, and
terminate idle interactive resources.

## 6. Delta Lake

**Delta Lake** is the default transactional storage layer for Databricks. A
Delta table stores data files together with a transaction log.

Key capabilities:

- **ACID transactions** for reliable concurrent reads and writes.
- **Schema enforcement** to reject incompatible data.
- **Schema evolution** when explicitly enabled.
- **Time travel** to query or restore an earlier table version.
- **`MERGE`** for upserts and change data capture.
- **`OPTIMIZE`** for file compaction.
- **`VACUUM`** for removing old unneeded files.

Example:

```sql
MERGE INTO target t
USING updates u
ON t.customer_id = u.customer_id
WHEN MATCHED THEN UPDATE SET *
WHEN NOT MATCHED THEN INSERT *;
```

Do not run `VACUUM` with an unsafe retention period unless the operational
consequences are understood, because old files may be needed for time travel or
long-running readers.

## 7. Medallion architecture

The medallion pattern organizes data into layers:

1. **Bronze**: Raw, append-oriented source data with minimal transformation.
2. **Silver**: Cleaned, standardized, deduplicated, and conformed data.
3. **Gold**: Business-ready aggregates, dimensional models, and metrics.

This pattern improves traceability and lets each layer have a clear quality
contract.

## 8. Ingestion and pipelines

Common ingestion approaches include:

- Batch reads from files or databases.
- Structured Streaming for continuously arriving data.
- Auto Loader for incrementally discovering new cloud files.
- Change data capture from operational systems.

Pipelines should be designed to be restartable and idempotent. Store checkpoints
for streaming workloads and preserve the source metadata needed for replay and
debugging.

## 9. Jobs and orchestration

A Databricks **job** orchestrates one or more tasks. Tasks can run notebooks,
Python files, SQL, pipelines, or other supported workload types.

Useful job concepts:

- Schedules and triggers.
- Task dependencies.
- Parameters.
- Retries and timeout limits.
- Repair runs.
- Alerts and run history.

Production jobs should have explicit dependencies, bounded retries, useful
logging, and separate configuration from code.

## 10. Unity Catalog

**Unity Catalog** is Databricks' centralized governance layer.

Its namespace is commonly:

```text
catalog.schema.object
```

For example:

```text
analytics.sales.daily_orders
```

Unity Catalog manages:

- Catalogs, schemas, tables, views, volumes, and functions.
- Access control and ownership.
- Data discovery and lineage.
- External locations and storage credentials.
- Managed and external tables.

Grant the least privilege necessary. Prefer groups and service principals over
individual production permissions.

## 11. Managed and external tables

- **Managed table**: Databricks manages both metadata and the table's storage
  lifecycle.
- **External table**: The data location is managed outside the table lifecycle.

Use external tables when storage ownership or lifecycle must remain independent
of Databricks. Use managed tables when Databricks should manage the data lifecycle.

## 12. Performance concepts

Common performance techniques include:

- Select only the columns required.
- Filter early and use selective predicates.
- Avoid unnecessary shuffles and wide joins.
- Broadcast small dimension tables when appropriate.
- Compact excessive small files.
- Use partitioning or clustering based on actual query patterns.
- Inspect the Spark query plan and SQL query profile.

Partitioning is not automatically beneficial. Too many partitions create small
files and metadata overhead; too few partitions can make reads and writes
inefficient.

## 13. Security and reliability

Production implementations should include:

- Secret scopes or an approved secret-management integration.
- Service principals for automated jobs.
- Unity Catalog permissions.
- Network and storage controls.
- Audit logs.
- Data quality checks.
- Retry-safe and idempotent writes.
- Monitoring for freshness, volume, and failed records.

Never hard-code passwords, tokens, or connection strings in notebooks.

## 14. Machine learning and AI

Databricks supports the machine-learning lifecycle, including:

- Experiment tracking with MLflow.
- Feature engineering and feature reuse.
- Model registration and versioning.
- Model serving.
- Monitoring and governance.

Keep training data, features, models, prompts, and evaluation results governed
and reproducible.

## 15. A practical learning order

Study the concepts in this order:

1. SQL and relational data modeling.
2. Python and DataFrames.
3. Spark execution and transformations/actions.
4. Delta Lake tables and `MERGE`.
5. Bronze, Silver, and Gold pipelines.
6. Streaming and Auto Loader.
7. Jobs and workflow orchestration.
8. Unity Catalog and security.
9. Performance tuning and monitoring.
10. MLflow and machine-learning workflows.

## 16. Mini project

Build a pipeline that:

1. Ingests JSON or CSV files into a Bronze Delta table.
2. Cleans and deduplicates records into Silver.
3. Creates a Gold aggregate for reporting.
4. Schedules the pipeline as a job.
5. Applies Unity Catalog permissions.
6. Adds data quality checks and a failure alert.

This project exercises the main Databricks concepts in one realistic workflow.
