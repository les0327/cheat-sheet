create table if not exists users  (
	id         INTEGER primary key,
	name       VARCHAR(50) not null,
	created_on timestamp not null
);

insert into users (id, name, created_on)
values
	(1, 'Name 1', '2012-01-01'),
	(2, 'Name 2', '2012-01-02'),
	(3, 'Name 3', '2012-01-03'),
	(4, 'Name 4', '2012-01-04'),
	(5, 'Name 5', '2012-02-01'),
	(6, 'Name 6', '2013-02-02'),
	(7, 'Name 7', '2013-02-03'),
	(8, 'Name 8', '2013-02-04'),
	(9, 'Name 9', '2014-03-01');