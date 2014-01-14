module: sqlite

define interface
  #include "sqlite3.h",
    equate: {"char *" => <c-string>},
    import: {
      "sqlite3_libversion",
      "sqlite3_sourceid",
      "sqlite3_libversion_number",

      "sqlite3_threadsafe",

      "sqlite3_close",

      "sqlite3_interrupt",

      "sqlite3_open",
      "sqlite3_open_v2",

      "sqlite3_errcode",
      "sqlite3_extended_errcode",
      "sqlite3_errmsg",

      "sqlite3_prepare_v2" => %sqlite3-prepare,
      "sqlite3_sql",
      "sqlite3_stmt_readonly",
      "sqlite3_stmt_busy",
      "sqlite3_bind_blob",
      "sqlite3_bind_double",
      "sqlite3_bind_int",
      "sqlite3_bind_int64",
      "sqlite3_bind_null",
      "sqlite3_bind_text",
      "sqlite3_bind_value",
      "sqlite3_bind_zeroblob",
      "sqlite3_bind_parameter_count",
      "sqlite3_bind_parameter_name",
      "sqlite3_bind_parameter_index",
      "sqlite3_clear_bindings",
      "sqlite3_column_count",
      "sqlite3_column_name",
      "sqlite3_column_decltype",
      "sqlite3_step",
      "sqlite3_data_count",
      "sqlite3_column_blob",
      "sqlite3_column_bytes",
      "sqlite3_column_double",
      "sqlite3_column_int",
      "sqlite3_column_int64",
      "sqlite3_column_text",
      "sqlite3_column_type",
      "sqlite3_column_value",
      "sqlite3_finalize",
      "sqlite3_reset",

      "SQLITE_OK",
      "SQLITE_ERROR",
      "SQLITE_INTERNAL",
      "SQLITE_PERM",
      "SQLITE_ABORT",
      "SQLITE_BUSY",
      "SQLITE_LOCKED",
      "SQLITE_NOMEM",
      "SQLITE_READONLY",
      "SQLITE_INTERRUPT",
      "SQLITE_IOERR",
      "SQLITE_CORRUPT",
      "SQLITE_NOTFOUND",
      "SQLITE_FULL",
      "SQLITE_CANTOPEN",
      "SQLITE_PROTOCOL",
      "SQLITE_EMPTY",
      "SQLITE_SCHEMA",
      "SQLITE_TOOBIG",
      "SQLITE_CONSTRAINT",
      "SQLITE_MISMATCH",
      "SQLITE_MISUSE",
      "SQLITE_NOLFS",
      "SQLITE_AUTH",
      "SQLITE_FORMAT",
      "SQLITE_RANGE",
      "SQLITE_NOTADB",
      "SQLITE_ROW",
      "SQLITE_DONE",
      "SQLITE_OPEN_READONLY",
      "SQLITE_OPEN_READWRITE",
      "SQLITE_OPEN_CREATE",
      "SQLITE_OPEN_URI",
      "SQLITE_OPEN_NOMUTEX",
      "SQLITE_OPEN_FULLMUTEX",
      "SQLITE_OPEN_SHAREDCACHE",
      "SQLITE_OPEN_PRIVATECACHE",
      "SQLITE_STATIC"
    };

    function "sqlite3_threadsafe",
      map-result: <C-boolean>;

    function "sqlite3_open",
      output-argument: 2;

    function "sqlite3_open_v2",
      output-argument: 2;

    function "sqlite3_prepare_v2",
      output-argument: 4,
      output-argument: 5;

    function "sqlite3_stmt_readonly",
      map-result: <C-boolean>;

    function "sqlite3_stmt_busy",
      map-result: <C-boolean>;

end interface;

define constant $SQLITE-NULL-STRING = null-pointer(<c-string>);

define function sqlite3-prepare(db :: <sqlite3*>, sql-query :: <string>)
  => (res :: <integer>, statement :: <sqlite3-stmt*>)
  %sqlite3-prepare(db, sql-query, size(sql-query));
end function;

define generic sqlite3-parameter-binder(stmt :: <sqlite3-stmt*>,
                                       parameter-number :: <integer>,
                                       value :: <object>) => ();

define method sqlite3-parameter-binder(stmt :: <sqlite3-stmt*>,
                                      parameter-number :: <integer>,
                                      value :: <integer>)
  => ()
  sqlite3-bind-int64(stmt, parameter-number, value);
end method;

define C-callable-wrapper sqlite3-text-cb of sqlite3-text-callback
  parameter ptr :: <C-function-pointer>;
end C-callable-wrapper;

define function sqlite3-text-callback(ptr :: <C-function-pointer>) => ()
end function;

define method sqlite3-parameter-binder(stmt :: <sqlite3-stmt*>,
                                      parameter-number :: <integer>,
                                      value :: <string>)
  => ()
  sqlite3-bind-text(stmt, parameter-number, value, size(value), sqlite3-text-cb);
end method;

define method sqlite3-parameter-binder(stmt :: <sqlite3-stmt*>,
                                      parameter-number :: <integer>,
                                      value :: <float>)
  => ()
  sqlite3-bind-double(stmt, parameter-number, as(<double-float>, value));
end method;
