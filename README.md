PL/pgSQL procedure for constructing and executing DDL from a concise DSL
    
### e.g.

    accounts:name@text,balance@double precision
    payments:from>accounts,to>accounts,amount@double precision,date@timestamptz

    create table accounts(
        id uuid primary key default gen_random_uuid(),
        name text,
        balance double precision
    );
    
    create table payments(
        id uuid primary key default gen_random_uuid(), 
        from uuid references accounts, 
        to uuid references accounts, 
        amount double precision, 
        date timestamptz
    );
