create table Employee
(
	empNumber char(8), 
	firstName varchar(25), 
	lastName varchar(25), 
	ssn char(9), 
	address varchar(50),
	state char(2), 
	zip char(5), 
	jobCode char(4), 
	dateOfBirth date, 
	certification bit, 
	salary money,
	constraint PK_EmpNumber primary key (empNumber),
	constraint EMP_STATECHECK check (state='CA' or state='FL')
)
go

create table Job
(
	jobCode char(4), 
	jobdesc varchar(50),
	constraint PK_JobCode primary key (jobCode),
	constraint JOB_JOBCODE check (jobCode='CAST' OR jobCode='ENGI' OR jobCode='INSP' or jobCode='PMGR')
)
go
alter table Employee
add constraint FK_JOB foreign key (jobCode) references Job(jobCode);
go

insert into Job
(jobCode,jobdesc)
values
('CAST','Cast Member'),
('ENGI','Engineer'),
('INSP','Inspector'),
('PMGR','Project Manager')
go

insert into Employee 
(empNumber,firstName,lastName,ssn,address,state,zip,jobCode,dateOfBirth,certification,salary)
values
('12345678','Jon','Smith','123456789','111 Miami Ave', 'FL', '33313','CAST','1988-01-01','1','25000'),
('23456789','Mike','Jones','112345678','111 Kendall Ave','FL','33186','ENGI','1988-03-01','1','80000'),
('11234567','James','Scott','223456789','123 Oakland Ave','CA','12345','PMGR','1985-02-02','2','90000')
go

create view vw_CertifiedEngineers
as
(
	select empNumber, firstName, lastName, jobdesc
	from Employee left join Job
	on Employee.jobCode = Job.jobCode
	where jobdesc='Engineer' and certification='1'
)
go

create view vw_ReadyToRetire
as
(
	select empNumber,firstName,lastName
	from Employee
	where dateofBirth < '1956-01-01'
)
go

create view vw_EmployeeAvgSalary
as
(
	select jobCode, Avg(salary) as AvgSalary
	from Employee 
	group by jobCode 
)
go

create index IDX_LastName
on Employee(lastName);
go

create index IDX_ssn
on Employee(ssn);
go
