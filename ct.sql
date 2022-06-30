create or replace procedure rocinante.ct(token text) as $$
    declare
        table_name text := split_part(token, ':', 1);
        fields   text[] := regexp_split_to_array(split_part(token, ':', 2), ',');
        query      text := 'create table ' || quote_ident(table_name) || '(' || 'id uuid primary key default gen_random_uuid(), ';

    begin
        for i in (array_lower(fields, 1)) .. (array_upper(fields, 1)) loop
            if regexp_match(fields[i], '>') is not null then -- field IS foreign key
                query := query || quote_ident(split_part(fields[i], '>', 1)) || ' uuid references ' || split_part(fields[i], '>', 2);
            else -- field NOT foreign key
                query := query || quote_ident(split_part(fields[i], '@', 1)) || ' ' || split_part(fields[i], '@', 2);
            end if;

            if i <> array_upper(fields, 1) then
                query := query || ', ';
            end if;
        end loop;

        query := query || ');';

        raise notice '%', query;

        execute query;
    end;
$$ language plpgsql;
