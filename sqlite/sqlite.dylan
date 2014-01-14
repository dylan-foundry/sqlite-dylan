module: sqlite

define C-pointer-type <c-string> => <C-signed-char>;
define C-struct <sqlite3-stmt>
end;

define C-pointer-type <sqlite3-stmt*> => <sqlite3-stmt>;
define C-function sqlite3-bind-parameter-name
  input parameter arg1_ :: <sqlite3-stmt*>;
  input parameter arg2_ :: <C-signed-int>;
  result res :: <c-string>;
  c-name: "sqlite3_bind_parameter_name";
end;

define C-struct <sqlite3>
end;

define C-pointer-type <sqlite3*> => <sqlite3>;
define C-pointer-type <sqlite3-stmt**> => <sqlite3-stmt*>;
define C-pointer-type <char**> => <c-string>;
define C-function %sqlite3-prepare
  input parameter db_ :: <sqlite3*>;
  input parameter zSql_ :: <c-string>;
  input parameter nByte_ :: <C-signed-int>;
  output parameter ppStmt_ :: <sqlite3-stmt**>;
  output parameter pzTail_ :: <char**>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_prepare_v2";
end;

define C-struct <Mem>
end;

define constant <sqlite3-value> = <Mem>;

define C-pointer-type <sqlite3-value*> => <sqlite3-value>;
define C-function sqlite3-bind-value
  input parameter arg1_ :: <sqlite3-stmt*>;
  input parameter arg2_ :: <C-signed-int>;
  input parameter arg3_ :: <sqlite3-value*>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_bind_value";
end;

define constant $SQLITE-NOTFOUND = 12;

define constant $SQLITE-EMPTY = 16;

define C-function sqlite3-finalize
  input parameter pStmt_ :: <sqlite3-stmt*>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_finalize";
end;

define C-function sqlite3-bind-parameter-index
  input parameter arg1_ :: <sqlite3-stmt*>;
  input parameter zName_ :: <c-string>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_bind_parameter_index";
end;

define C-function sqlite3-bind-int
  input parameter arg1_ :: <sqlite3-stmt*>;
  input parameter arg2_ :: <C-signed-int>;
  input parameter arg3_ :: <C-signed-int>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_bind_int";
end;

define C-function sqlite3-sourceid
  result res :: <c-string>;
  c-name: "sqlite3_sourceid";
end;

define constant $SQLITE-ERROR = 1;

define C-function sqlite3-column-bytes
  input parameter arg1_ :: <sqlite3-stmt*>;
  input parameter iCol_ :: <C-signed-int>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_column_bytes";
end;

define constant <sqlite-int64> = <C-signed-long>;

define constant <sqlite3-int64> = <sqlite-int64>;

define C-function sqlite3-column-int64
  input parameter arg1_ :: <sqlite3-stmt*>;
  input parameter iCol_ :: <C-signed-int>;
  result res :: <sqlite3-int64>;
  c-name: "sqlite3_column_int64";
end;

define C-function sqlite3-column-value
  input parameter arg1_ :: <sqlite3-stmt*>;
  input parameter iCol_ :: <C-signed-int>;
  result res :: <sqlite3-value*>;
  c-name: "sqlite3_column_value";
end;

define constant $SQLITE-MISMATCH = 20;

define C-function sqlite3-extended-errcode
  input parameter db_ :: <sqlite3*>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_extended_errcode";
end;

define constant $SQLITE-NOTADB = 26;

define constant $SQLITE-CANTOPEN = 14;

define constant $SQLITE-AUTH = 23;

define constant $SQLITE-OK = 0;

define C-function sqlite3-stmt-busy
  input parameter arg1_ :: <sqlite3-stmt*>;
  result res :: <C-boolean>;
  c-name: "sqlite3_stmt_busy";
end;

define constant $SQLITE-BUSY = 5;

define constant $SQLITE-READONLY = 8;

define constant $SQLITE-PROTOCOL = 15;

define C-function sqlite3-bind-int64
  input parameter arg1_ :: <sqlite3-stmt*>;
  input parameter arg2_ :: <C-signed-int>;
  input parameter arg3_ :: <sqlite3-int64>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_bind_int64";
end;

define constant $SQLITE-ABORT = 4;

define constant $SQLITE-OPEN-FULLMUTEX = 65536;

define C-function sqlite3-column-name
  input parameter arg1_ :: <sqlite3-stmt*>;
  input parameter N_ :: <C-signed-int>;
  result res :: <c-string>;
  c-name: "sqlite3_column_name";
end;

define C-function sqlite3-column-count
  input parameter pStmt_ :: <sqlite3-stmt*>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_column_count";
end;

define constant <anonymous-66> = <C-function-pointer>;
define C-function sqlite3-bind-text
  input parameter arg1_ :: <sqlite3-stmt*>;
  input parameter arg2_ :: <C-signed-int>;
  input parameter arg3_ :: <c-string>;
  input parameter n_ :: <C-signed-int>;
  input parameter arg5_ :: <anonymous-66>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_bind_text";
end;

define C-function sqlite3-interrupt
  input parameter arg1_ :: <sqlite3*>;
  c-name: "sqlite3_interrupt";
end;

define C-function sqlite3-bind-parameter-count
  input parameter arg1_ :: <sqlite3-stmt*>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_bind_parameter_count";
end;

define C-function sqlite3-column-blob
  input parameter arg1_ :: <sqlite3-stmt*>;
  input parameter iCol_ :: <C-signed-int>;
  result res :: <C-void*>;
  c-name: "sqlite3_column_blob";
end;

define C-function sqlite3-column-int
  input parameter arg1_ :: <sqlite3-stmt*>;
  input parameter iCol_ :: <C-signed-int>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_column_int";
end;

define C-function sqlite3-column-type
  input parameter arg1_ :: <sqlite3-stmt*>;
  input parameter iCol_ :: <C-signed-int>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_column_type";
end;

define C-function sqlite3-errmsg
  input parameter arg1_ :: <sqlite3*>;
  result res :: <c-string>;
  c-name: "sqlite3_errmsg";
end;

define C-function sqlite3-data-count
  input parameter pStmt_ :: <sqlite3-stmt*>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_data_count";
end;

define constant $SQLITE-FULL = 13;

define C-function sqlite3-clear-bindings
  input parameter arg1_ :: <sqlite3-stmt*>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_clear_bindings";
end;

define C-function sqlite3-close
  input parameter arg1_ :: <sqlite3*>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_close";
end;

define constant $SQLITE-DONE = 101;

define constant $SQLITE-INTERNAL = 2;

define constant $SQLITE-OPEN-PRIVATECACHE = 262144;

define constant $SQLITE-CONSTRAINT = 19;

define C-function sqlite3-step
  input parameter arg1_ :: <sqlite3-stmt*>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_step";
end;

define constant $SQLITE-LOCKED = 6;

define C-function sqlite3-bind-zeroblob
  input parameter arg1_ :: <sqlite3-stmt*>;
  input parameter arg2_ :: <C-signed-int>;
  input parameter n_ :: <C-signed-int>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_bind_zeroblob";
end;

define C-function sqlite3-column-decltype
  input parameter arg1_ :: <sqlite3-stmt*>;
  input parameter arg2_ :: <C-signed-int>;
  result res :: <c-string>;
  c-name: "sqlite3_column_decltype";
end;

define C-function sqlite3-bind-null
  input parameter arg1_ :: <sqlite3-stmt*>;
  input parameter arg2_ :: <C-signed-int>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_bind_null";
end;

define C-pointer-type <sqlite3**> => <sqlite3*>;
define C-function sqlite3-open-v2
  input parameter filename_ :: <c-string>;
  output parameter ppDb_ :: <sqlite3**>;
  input parameter flags_ :: <C-signed-int>;
  input parameter zVfs_ :: <c-string>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_open_v2";
end;

define constant $SQLITE-ROW = 100;

define constant $SQLITE-CORRUPT = 11;

define constant $SQLITE-OPEN-CREATE = 4;

define constant $SQLITE-OPEN-URI = 64;

define constant $SQLITE-NOLFS = 22;

define C-function sqlite3-column-double
  input parameter arg1_ :: <sqlite3-stmt*>;
  input parameter iCol_ :: <C-signed-int>;
  result res :: <C-double>;
  c-name: "sqlite3_column_double";
end;

define C-function sqlite3-libversion
  result res :: <c-string>;
  c-name: "sqlite3_libversion";
end;

define C-function sqlite3-threadsafe
  result res :: <C-boolean>;
  c-name: "sqlite3_threadsafe";
end;

define C-function sqlite3-open
  input parameter filename_ :: <c-string>;
  output parameter ppDb_ :: <sqlite3**>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_open";
end;

define constant <anonymous-60> = <C-function-pointer>;
define C-function sqlite3-bind-blob
  input parameter arg1_ :: <sqlite3-stmt*>;
  input parameter arg2_ :: <C-signed-int>;
  input parameter arg3_ :: <C-void*>;
  input parameter n_ :: <C-signed-int>;
  input parameter arg5_ :: <anonymous-60>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_bind_blob";
end;

define constant $SQLITE-IOERR = 10;

define constant $SQLITE-SCHEMA = 17;

define C-function sqlite3-stmt-readonly
  input parameter pStmt_ :: <sqlite3-stmt*>;
  result res :: <C-boolean>;
  c-name: "sqlite3_stmt_readonly";
end;

define constant $SQLITE-OPEN-SHAREDCACHE = 131072;

define constant $SQLITE-TOOBIG = 18;

define constant $SQLITE-FORMAT = 24;

define constant $SQLITE-INTERRUPT = 9;

define C-function sqlite3-errcode
  input parameter db_ :: <sqlite3*>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_errcode";
end;

define constant $SQLITE-PERM = 3;

define constant $SQLITE-RANGE = 25;

define constant $SQLITE-OPEN-NOMUTEX = 32768;

define constant $SQLITE-OPEN-READONLY = 1;

define C-function sqlite3-libversion-number
  result res :: <C-signed-int>;
  c-name: "sqlite3_libversion_number";
end;

define C-function sqlite3-sql
  input parameter pStmt_ :: <sqlite3-stmt*>;
  result res :: <c-string>;
  c-name: "sqlite3_sql";
end;

define C-function sqlite3-bind-double
  input parameter arg1_ :: <sqlite3-stmt*>;
  input parameter arg2_ :: <C-signed-int>;
  input parameter arg3_ :: <C-double>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_bind_double";
end;

define C-pointer-type <unsigned-char*> => <C-unsigned-char>;
define C-function sqlite3-column-text
  input parameter arg1_ :: <sqlite3-stmt*>;
  input parameter iCol_ :: <C-signed-int>;
  result res :: <unsigned-char*>;
  c-name: "sqlite3_column_text";
end;

define constant $SQLITE-OPEN-READWRITE = 2;

define constant $SQLITE-MISUSE = 21;

define constant $SQLITE-NOMEM = 7;

define C-function sqlite3-reset
  input parameter pStmt_ :: <sqlite3-stmt*>;
  result res :: <C-signed-int>;
  c-name: "sqlite3_reset";
end;

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
