* Should we have a finalizer on statements to run sqlite3-finalize()?
* Should we have a finalizer on the database to run sqlite3-close()?
* Add many other #define'd constants to the sqlite.intr and library.dylan
  files.
* Documentation.
* Should we wrap sqlite3_exec()?
* Add macro for tests that does a check and on a failure prints the
  textual error as well.
* Support configuration stuff.
* Make existing stuff the low-level interface and provide a slightly
  more sane interface on top that also does error checks and uses
  conditions.
* Don't expose people to the fact that bind parameter indexes are
  1-based while result indexes are 0-based. That is madness.
