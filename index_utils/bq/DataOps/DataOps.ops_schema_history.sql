--https://flywaydb.org/documentation/configfiles

CREATE TABLE DataOps.ops_schema_history (
installed_rank  INT64   NOT NULL, --max()+1
version         STRING  NOT NULL, --the x in Vx_ scriptname
description     STRING  NOT NULL, --use as Sprint
type            STRING  NOT NULL, --SQL
script          STRING  NOT NULL, --scriptname.sql
checksum        INT64   NOT NULL,
installed_by    STRING  NOT NULL,
installed_on    STRING  NOT NULL,
execution_time  INT64   NOT NULL,
success         BOOL    NOT NULL
)

--insert into DataOps.ops_schema_history values(1,'1','sprint_4_2','SQL','abc.sql',0,'ops','dtString',0,true)