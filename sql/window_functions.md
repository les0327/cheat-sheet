# Window functions

A window function performs a calculation across a set of table rows that are somehow related to the current row. This is comparable to the type of calculation that can be done with an aggregate function. But unlike regular aggregate functions, use of a window function does not cause rows to become grouped into a single output row — the rows retain their separate identities  

## row_number()

```sql
select 
	id, 
	name, 
	created_on, 
	row_number() over (order by created_on) 
from users;
```

## partition by
```sql
select 
	id, 
	name, 
	created_on,
	date_part('year', created_on )::varchar as year,
	row_number() over (partition by date_part('year', created_on ) order by created_on) as row_number_partitioned_by_year,
	date_part('month', created_on )::varchar as month,
	count(*) over (partition by date_part('month', created_on )) as user_count_by_month
from users;
```

### [Back to README](../README.md)