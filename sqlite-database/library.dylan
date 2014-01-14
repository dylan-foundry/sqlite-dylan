module: dylan-user

define library sqlite-database
  use common-dylan;
  use c-ffi;
  use sqlite;

  use sql,
    import: {sql};

  export sqlite-database;
end library;

define module sqlite-database
  use common-dylan;
  use c-ffi, import: { null-pointer };
  use finalization;
  use sqlite;
  use sql, import: all, export: all;

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
