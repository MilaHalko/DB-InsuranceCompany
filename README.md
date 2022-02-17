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
## Laboratory #1
The goal: schematic representation DB as blocks and their relationships. The final choice of representation: ER-diagram. As an insurance company is composed of components, the final decision was to break it down into main blocks:
  1) Philia
  2) Insurance agent
  3) Insurance contract
  4) Insurance type
  5) Agent's salary

The final result is presented in [jpg file](https://github.com/MilaHalko/DB-InsuranceCompany/blob/main/InsuranceCompanyER.jpg) :fire::fire::fire:

#
## Laboratory #2
In this phase were enough just to create DB main components via MSSQL, which is based on previously made in laboratory #1 ER-diagram. Also, scripts were developed to create tables as:

  1) Philia
  2) Agent
  3) InsContract
  4) InsType
  5) Salary
  
  During development, it was decided to add constraints to check dates(!> current date), money(>=0); foreign and primary keys; one trigger for automatical counting and transferring salary data from InsContract to Salary as well. 
  
  The final result is available [here](https://github.com/MilaHalko/DB-InsuranceCompany/blob/main/Tables.sql) :sparkles::sparkles::sparkles:

  Secondly, the ultimate phase was inserting generated data into all created tables. In this case, the online service [Mockaroo](https://www.mockaroo.com/) is so helpful and aided me in data generation. Final data is available in different formats. I used sql generated code and csv variants as well. 
  
  Check SQL [inserting script](https://github.com/MilaHalko/DB-InsuranceCompany/blob/main/Insert.sql) :green_heart::green_heart::green_heart:

  #
  ## Laboratory #3
 As this project is also about program features learning, cause I'm a student. This part demonstrate variaty of MSSQL built-in functions. Following are this funcs:
  - Comparison: > < <= >= !=
  - Logical operators: AND OR NOT
  - Combinations of logical operators
  - SIMPLE: SELECT / AS / WHERE / ORDER BY / DESC
  - String: TRIM / LIKE / templates ('%_')
  - BETWEEN / IN / EXISTS
  - Converting types: CONVERT / CAST
  - Aggregate: MAX() /
  - Joins: CROSS / LEFT / RIGHT / INNER
  - UNION

It is important to mention that nested requests were used. I tried to use more than 2 tables during coding. 

I hope I succeded, so you can check it  [here](https://github.com/MilaHalko/DB-InsuranceCompany/blob/main/lab3.sql) :bug::bug::bug:
