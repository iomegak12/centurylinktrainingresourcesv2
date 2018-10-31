-- Job Database

-- Create MSK @ Database
-- Create a Credential for Server Lookup
-- Create a Credential for Job Execution
-- Create Server Group
-- Create / Add Members in the Group
-- Define a Job
-- Define a Job Step
-- Execute the Job
-- Monitor the Job (Portal/SSMS)

CREATE MASTER KEY ENCRYPTION BY PASSWORD='Prestige123';

CREATE DATABASE SCOPED CREDENTIAL myjobcred WITH IDENTITY = 'iomegaadmin',
SECRET = 'Prestige123';
GO

CREATE DATABASE SCOPED CREDENTIAL mymastercred WITH IDENTITY = 'iomegaadmin',
SECRET = 'Prestige123';
GO

EXEC jobs.sp_add_target_group 'ServerGroup1'

EXEC jobs.sp_add_target_group_member
'ServerGroup1',
@target_type = 'SqlServer',
@refresh_credential_name='mymastercred', --credential required to refresh the databases in server
@server_name='iomegasqlserverv2.database.windows.net'

EXEC jobs.sp_add_target_group_member
'ServerGroup1',
@target_type = 'SqlServer',
@refresh_credential_name='mymastercred', --credential required to refresh the databases in server
@server_name='iomegasqlserverv3.database.windows.net'

EXEC [jobs].sp_add_target_group_member
@target_group_name = N'ServerGroup1',
@membership_type = N'Exclude',
@target_type = N'SqlDatabase',
@server_name = N'iomegasqlserverv2.database.windows.net',
@database_name =N'iomegajobdatabase'
GO

SELECT * FROM jobs.target_groups WHERE target_group_name='ServerGroup1';
SELECT * FROM jobs.target_group_members WHERE target_group_name='ServerGroup1';

EXEC jobs.sp_add_job @job_name='CreateTableTest', 
	@description='Create Table Test'

EXEC jobs.sp_add_jobstep @job_name='CreateTableTest',
@command=N'IF NOT EXISTS (SELECT * FROM sys.tables
WHERE object_id = object_id(''Test''))
CREATE TABLE [dbo].[Test]([TestId] [int] NOT NULL);',
@credential_name='myjobcred',
@target_group_name='ServerGroup1'

SELECT * FROM jobs.jobs
select * from jobs.jobsteps

EXEC jobs.sp_start_job 'CreateTableTest'

SELECT * FROM jobs.job_executions
WHERE job_name = 'CreateTableTest' and step_id IS NULL
ORDER BY start_time DESC

SELECT * FROM jobs.job_executions
WHERE job_name = 'CreateTableTest'
ORDER BY start_time DESC