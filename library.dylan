module: dylan-user

define library sqlite
  use common-dylan;
  use c-ffi;
  use io;

  use sql, 
    import: {sql};

  export sqlite;
end library;

define module sqlite
  use common-dylan, exclude: { format-to-string };
  use format-out;
  use c-ffi;
  use sql, import: all, export: all;
  use finalization;

  export sqlite3-libversion-number, sqlite3-libversion,
         sqlite3-sourceid;

  export sqlite3-threadsafe;

  export sqlite3-close;

  export sqlite3-interrupt;

  export sqlite3-open,
    sqlite3-open-v2;

  export sqlite3-errcode,
    sqlite3-extended-errcode,
    sqlite3-errmsg;

  export sqlite3-prepare,
    sqlite3-sql,
    sqlite3-stmt-readonly,
    sqlite3-stmt-busy,
    sqlite3-bind-blob,
    sqlite3-bind-double,
    sqlite3-bind-int,
    sqlite3-bind-int64,
    sqlite3-bind-null,
    sqlite3-bind-text,
    sqlite3-bind-value,
    sqlite3-bind-zeroblob,
    sqlite3-bind-parameter-count,
    sqlite3-bind-parameter-name,
    sqlite3-bind-parameter-index,
    sqlite3-clear-bindings,
    sqlite3-column-count,
    sqlite3-column-name,
    sqlite3-column-decltype,
    sqlite3-column-blob,
    sqlite3-column-bytes,
    sqlite3-column-double,
    sqlite3-column-int,
    sqlite3-column-int64,
    sqlite3-column-text,
    sqlite3-column-type,
    sqlite3-column-value,
    sqlite3-step,
    sqlite3-data-count,
    sqlite3-finalize,
    sqlite3-reset;

  export
    $SQLITE-OK,
    $SQLITE-ERROR,
    $SQLITE-INTERNAL,
    $SQLITE-PERM,
    $SQLITE-ABORT,
    $SQLITE-BUSY,
    $SQLITE-LOCKED,
    $SQLITE-NOMEM,
    $SQLITE-READONLY,
    $SQLITE-INTERRUPT,
    $SQLITE-IOERR,
    $SQLITE-CORRUPT,
    $SQLITE-NOTFOUND,
    $SQLITE-FULL,
    $SQLITE-CANTOPEN,
    $SQLITE-PROTOCOL,
    $SQLITE-EMPTY,
    $SQLITE-SCHEMA,
    $SQLITE-TOOBIG,
    $SQLITE-CONSTRAINT,
    $SQLITE-MISMATCH,
    $SQLITE-MISUSE,
    $SQLITE-NOLFS,
    $SQLITE-AUTH,
    $SQLITE-FORMAT,
    $SQLITE-RANGE,
    $SQLITE-NOTADB,
    $SQLITE-ROW,
    $SQLITE-DONE,
    $SQLITE-OPEN-READONLY,
    $SQLITE-OPEN-READWRITE,
    $SQLITE-OPEN-CREATE,
    $SQLITE-OPEN-URI,
    $SQLITE-OPEN-NOMUTEX,
    $SQLITE-OPEN-FULLMUTEX,
    $SQLITE-OPEN-SHAREDCACHE,
    $SQLITE-OPEN-PRIVATECACHE,
    $SQLITE-NULL-STRING;

  export
    $NULL-SQLITE-HANDLE;

  create
    <sqlite-dbms>,
    <sqlite-connection>,
    <sqlite-database>,
    <sqlite-user>,
    <sqlite-sql-statement>,
    <sqlite-result-set>,
    <sqlite-forward-only-result-set>,
    <sqlite-scrollable-result-set>,
    connection-handle,
    path-name;
end module;
