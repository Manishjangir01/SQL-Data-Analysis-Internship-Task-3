# SQL Data Analysis Internship: Task 3

Advanced SQL queries using JOIN, GROUP BY, HAVING and subqueries, applied to a student performance database.

## Database

Three related tables:

| Table | Columns | Purpose |
|-------|---------|---------|
| `Students` | `StudentID`, `Name`, `Age` | Student details |
| `Courses` | `id`, `name` | Course list |
| `Enrollments` | `student_id`, `course_id`, `grade` | Which student took which course, and the grade |

## Queries

1. **Top student per course:** highest grade in each course, found with a subquery on `MAX(grade)`
2. **Pass rate per course:** percentage of students with grade >= 40
3. **Overall topper:** student with the highest average grade across all courses
4. **Students in multiple courses:** `GROUP BY` with `HAVING COUNT(...) > 1`

## Expected output

Running the script on the included sample data (13 students, 3 courses, 18 enrollments):

| Query | Result |
|-------|--------|
| Top student per course | SQL: Simran (95), Python: Simran (93), Data Analytics: Simran (94) |
| Pass rate | SQL: 90.00%, Python: 100.00%, Data Analytics: 100.00% |
| Overall topper | Simran, average 94.00 |
| Multiple courses | Aman (2), Riya (2), Neha (2), Simran (3) |

These match the screenshots in `SQL_Data_Analysis_Output.pdf`.

## How to run

The script creates the tables, inserts the sample data and runs the four queries, so it works on its own. It can be run again at any time because it drops and recreates the tables.

- **Online:** paste `Task_3_SQL_Data_Analysis.sql` into DB Fiddle (MySQL) or SQLite Online and run it.
- **MySQL:** `mysql -u <user> -p <database> < Task_3_SQL_Data_Analysis.sql`
- **SQLite:** `sqlite3 task3.db < Task_3_SQL_Data_Analysis.sql`

## Files

- `Task_3_SQL_Data_Analysis.sql`: schema, sample data and the four queries
- `SQL_Data_Analysis_Output.pdf`: query outputs

## Tools

MySQL, PostgreSQL or SQLite. SQL concepts: joins, aggregation, subqueries, `HAVING`.

## What I learned

- Writing analytical queries that answer business-style questions
- Using a subquery to find the maximum per group
- Grouping by the primary key (not just the name) so two students with the same name are never merged
