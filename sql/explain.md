# Explain

Keep in mind that the statement is actually executed when the ANALYZE option is used.

## Examples

```sql
explain analyze select * from users;

---

Seq Scan on users  (cost=0.00..15.10 rows=510 width=130) (actual time=0.007..0.008 rows=9 loops=1)
Planning Time: 0.028 ms
Execution Time: 0.014 ms
```


```sql
explain analyze select * from users where name = 'Name 3' or name = 'Name 5';

---

Seq Scan on users  (cost=0.00..17.65 rows=5 width=130) (actual time=0.010..0.011 rows=2 loops=1)
  Filter: (((name)::text = 'Name 3'::text) OR ((name)::text = 'Name 5'::text))
  Rows Removed by Filter: 7
Planning Time: 0.036 ms
Execution Time: 0.020 ms
```

Even if index exists, postgres can decide to use another scan:
```sql
explain analyze select * from users where id = 3;

---

Seq Scan on users  (cost=0.00..1.11 rows=1 width=19) (actual time=0.010..0.011 rows=1 loops=1)
  Filter: (id = 3)
  Rows Removed by Filter: 8
Planning Time: 0.045 ms
Execution Time: 0.019 ms


SET enable_seqscan to off;
explain analyze select * from users where id = 3;
---
Index Scan using users_pkey on users  (cost=0.14..8.15 rows=1 width=19) (actual time=0.011..0.012 rows=1 loops=1)
  Index Cond: (id = 3)
Planning Time: 0.039 ms
Execution Time: 0.021 ms
```

```sql
explain analyze 
select 
	id, 
	name, 
	created_on,
	date_part('year', created_on )::varchar as year,
	row_number() over (partition by date_part('year', created_on ) order by created_on) as row_number_partitioned_by_year,
	date_part('month', created_on )::varchar as month,
	count(*) over (partition by date_part('month', created_on )) as user_count_by_month
from users;

---

WindowAgg  (cost=1.62..1.98 rows=9 width=115) (actual time=0.042..0.046 rows=9 loops=1)
  ->  Sort  (cost=1.62..1.65 rows=9 width=43) (actual time=0.039..0.040 rows=9 loops=1)
        Sort Key: (date_part('year'::text, created_on)), created_on
        Sort Method: quicksort  Memory: 25kB
        ->  WindowAgg  (cost=1.28..1.48 rows=9 width=43) (actual time=0.021..0.025 rows=9 loops=1)
              ->  Sort  (cost=1.28..1.30 rows=9 width=35) (actual time=0.018..0.018 rows=9 loops=1)
                    Sort Key: (date_part('month'::text, created_on))
                    Sort Method: quicksort  Memory: 25kB
                    ->  Seq Scan on users  (cost=0.00..1.14 rows=9 width=35) (actual time=0.011..0.014 rows=9 loops=1)
Planning Time: 0.051 ms
Execution Time: 0.091 ms
```


### [Back to README](../README.md)