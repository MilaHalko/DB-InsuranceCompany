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

The final result is presented in [ER-diagram file](https://github.com/MilaHalko/DB-InsuranceCompany/blob/main/InsuranceCompanyER.jpg) :fire::fire::fire:

#
## Laboratory work #2
In this phase were enough just to create DB main components via MSSQL, which is based on previously made in laboratory #1 ER-diagram. Also, scripts were developed to create tables as:

  1) Philia
  2) Agent
  3) InsContract
  4) InsType
  5) Salary
  
During development, it was decided to add constraints to check dates(!> current date), money(>=0); foreign and primary keys; one trigger for automatical counting and transferring salary data from InsContract to Salary as well. 
  
The [creating tables script](https://github.com/MilaHalko/DB-InsuranceCompany/blob/main/Tables.sql) is available :sparkles::sparkles::sparkles:

Secondly, the ultimate phase was inserting generated data into all created tables. In this case, the online service [Mockaroo](https://www.mockaroo.com/) is so helpful and aided me in data generation. Final data is available in different formats. I used sql generated code and csv variants as well. 

Check SQL [inserting script](https://github.com/MilaHalko/DB-InsuranceCompany/blob/main/Insert.sql) :green_heart::green_heart::green_heart:

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
It is important to mention that nested requests were used. I tried to use more than 2 tables during coding. I hope I succeded, so you can check [built-in funcs script](https://github.com/MilaHalko/DB-InsuranceCompany/blob/main/lab3.sql) :bug::bug::bug:

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

Try to check [built-in middle funcs scripts](https://github.com/MilaHalko/DB-InsuranceCompany/blob/main/lab4_funcs.sql) :zap::zap::zap:

#
## Laboratory work #5
:memo: ..In process.. :memo:
