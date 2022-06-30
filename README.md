PL/pgSQL procedure for creating and executing DDL - assumes many defaults

Concise DSL

    accounts:name@text,balance@double precision
    payments:from>accounts,to>accounts,amount@double precision,date@timestamptz
