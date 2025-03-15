# Optimistic locking

### Pros

* Does not lock records. Instead, uses version (modification date, hash, ...) to determinate if record was changed since last read. If so - abort transaction.
* No deadlocks as no locks are used.
* More suitable for application with more reads than writes (fewer chances that record was modified by other transaction). Performs better than pessimistic locking in environments with rare conflicts.   

### Cons

* Not suitable for write-intense application, as it will result in a lot of rollbacks (fewer chances that record was modified by other transaction).
* Requires additional effort to handle retries.


## Optimistic locking in Spring Boot / JPA

### Lock modes

* `OPTIMISTIC` (`READ`):
    Rises isolation level to `repeatable reads` (from default `read commited`).
* `OPTIMISTIC_FORCE_INCREMENT` (`WRITE`):  
    Auto-increments version. Usually used to update version of parent entity whenever a child entity is modified.

### [Back to README](../README.md)