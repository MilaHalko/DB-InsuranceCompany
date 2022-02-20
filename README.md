# Database (MSSQL): Insurance Company
Laboratory works to improve my MSSQL skills. The theme and database name is "InsuranceCompany". 
## The work consists of phases as:
  - Creating DB ER-diagramme
  - Creating 5 tables for InsuranceCompany
  - Data inserting  
  - Practice of using SELECT in many ways
  - Practice of using built-in functions
  - Creating of procedures, functions, triggers, and cursors

#
## Laboratory work #1
The goal: schematic representation DB as blocks and their relationships. The final choice of representation: ER-diagram. As an insurance company is composed of components, the final decision was to break it down into main blocks:
  1) Philia
  2) Insurance agent
  3) Insurance contract
  4) Insurance type
  5) Agent's salary

The final result is presented in [ER-diagram file](https://github.com/MilaHalko/DB-InsuranceCompany/blob/main/LAB1_ER-diagram/InsuranceCompanyER.jpg) :fire::fire::fire:

#
## Laboratory work #2
In this phase were enough just to create DB main components via MSSQL, which is based on previously made in laboratory #1 ER-diagram. Also, scripts were developed to create tables as:

  1) Philia
  2) Agent
  3) InsContract
  4) InsType
  5) Salary
  
During development, it was decided to add constraints to check dates(!> current date), money(>=0); foreign and primary keys; one trigger for automatical counting and transferring salary data from InsContract to Salary as well. 
  
The [creating tables script](https://github.com/MilaHalko/DB-InsuranceCompany/blob/main/LAB2_tables%26insert/Tables.sql) is available :sparkles::sparkles::sparkles:

Secondly, the ultimate phase was inserting generated data into all created tables. In this case, the online service [Mockaroo](https://www.mockaroo.com/) is so helpful and aided me in data generation. Final data is available in different formats. I used sql generated code and csv variants as well. 

Check SQL [inserting script](https://github.com/MilaHalko/DB-InsuranceCompany/blob/main/LAB2_tables%26insert/Insert.sql) :green_heart::green_heart::green_heart:

#
## Laboratory work #3
As this project is also about program features learning, cause I'm a student. This part demonstrate variaty of MSSQL built-in functions. Following are this funcs:
  - Comparison: > < <= >= !=
  - Logical operators: AND OR NOT
  - Combinations of logical operators
  - SIMPLE: SELECT / AS / WHERE / ORDER BY / DESC
  - String: TRIM / LIKE / templates ('%_')
  - BETWEEN / IN / EXISTS
  - Converting types: CONVERT / CAST
  - Joins: CROSS / LEFT / RIGHT / INNER
  - UNION

It is important to mention that nested requests were used. I tried to use more than 2 tables during coding. 

I hope I succeded, so you can check [built-in funcs script](https://github.com/MilaHalko/DB-InsuranceCompany/blob/main/LAB3_simple-funcs/lab3.sql) :bug::bug::bug:

#
## Laboratory work #4
Mostly done, but it is essential to learn how to group, sort datas. The equally important thing too is trying new built-in functions to increase knoledge about SQL functionality. So, this work representate my new experience in creating requests using things like:
  - Aggregate Functions: COUNT / SUM / AVG / MIN / MAX
  - String functions: LOWER / UPPER
  - Date functions: DAY / YEAR / MONTH
  - GROUP BY: simple / with few parametrs / with HAVING
  - VIEW creating: from few tables / from other view / ALTER with joins
  - SP functions: sp_help / sp_helptext / sp_depends

As result we have a spectre of new foundation for further database engineering using SQL.

Try to check [built-in middle funcs script](https://github.com/MilaHalko/DB-InsuranceCompany/blob/main/LAB4_middle-funcs/lab4_funcs.sql) :zap::zap::zap:

#
## Laboratory work #5
So, let's discuss the final step! To make the long story short, I planned to write script to  practice creating things like:
  - [Stored procedures](https://github.com/MilaHalko/DB-InsuranceCompany/tree/main/LAB5_hard-funcs/lab5_storedProc.sql)
  - [Functions](https://github.com/MilaHalko/DB-InsuranceCompany/blob/main/LAB5_hard-funcs/lab5_funcs.sql)
  - [Cursors](https://github.com/MilaHalko/DB-InsuranceCompany/blob/main/LAB5_hard-funcs/lab5_cursor.sql)
  - [Triggers](https://github.com/MilaHalko/DB-InsuranceCompany/blob/main/LAB5_hard-funcs/lab5_triggers.sql)
I created some for updating amounts if some info is inserted, updated or deleted; checking if an agent is a foreigner; cycle for printing all agents with upper surnames and their initials.
But you can check the full script for certain aspect by clicking on the list items above :alien::alien::alien:

#
## Final words
This SQL course was really helpful for me. During the course, I learned how to design a database and then create it using the Microsoft SQL Server environment. Of course the whole result of the work you can check, I will be very happy :tada::tada::tada:
