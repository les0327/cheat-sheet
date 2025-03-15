# Pessimistic locking

### Pros

* Use locks (shared/exclusive) to prevent changes to a record. (Good for data consistency)
* Simple, straightforward and predictable approach, that allows only 1 process to update record at a given time.
* More suitable for high contention environments. Allows to minimize number of conflicts.   

### Cons

* May cause performance bottleneck, as other read/writes of this record are blocked when lock is up. (reduces level of concurrency in the system)
* May cause deadlocks if different transaction locks same resources in different order.


## Pessimistic locking in Spring Boot / JPA

### Lock modes

* `PESSIMISTIC_READ`:
    Obtains shared lock, that allows concurrent reads, but blocks writes for locked records.
* `PESSIMISTIC_WRITE `:  
    Obtains exclusive lock, that prevents any reads/writes for locked records.
* `PESSIMISTIC_FORCE_INCREMENT`:  
    Same as `PESSIMISTIC_WRITE`, but also increments version attribute.

### Lock scopes

* `NORMAL`:  
    Locks only entity.
    Also lock ancestors in `JOINED` inheritance.
* `EXTENDED`:  
    Additionally locks entity`s relationships. (extends lock on @OneToOne, @ElementCollection, @JoinTable ....)

### Notes

* Timeout can be used to throw an exception if lock can not be acquired in certain amount of time. 

### [Back to README](../README.md)