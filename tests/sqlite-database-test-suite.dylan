module: sqlite-database-test-suite
synopsis: Test suite for the sqlite-database library.

define test dbms-name-test ()
  let dbms-handle = make(<sqlite-dbms>);
  let connection = make(<sqlite-connection>, dbms: dbms-handle);

  check-equal("test the DB name", "SQLite3", dbms-name(dbms-handle, connection: connection));
end test dbms-name-test;

define test dbms-version-test ()
  let dbms-handle = make(<sqlite-dbms>);
  let connection = make(<sqlite-connection>, dbms: dbms-handle);

  check-true("Version should be set", dbms-version(dbms-handle, connection: connection));
end test dbms-version-test;

define test dbms-connect-disconnect-test ()
  let dbms-handle = make(<sqlite-dbms>);
  let user = make(<sqlite-user>, dbms: dbms-handle);
  let database = make(<sqlite-database>, path-name: ":memory:");
  let connection = connect(database, user, path-name: database.path-name, dbms: dbms-handle);

  check-true("should have a valid connection", connection);

  disconnect(connection, terminate-statements: #f);

  check-equal("connection handle should be null", $NULL-SQLITE-HANDLE, connection.connection-handle);
end test dbms-connect-disconnect-test;

define test dbms-sql-statement-test ()
  let dbms-handle = make(<sqlite-dbms>);
  let user = make(<sqlite-user>, dbms: dbms-handle);
  let database = make(<sqlite-database>, path-name: ":memory:");
  let connection = connect(database, user, path-name: database.path-name, dbms: dbms-handle);

  let sql-query = "SELECT :STR, :INT, :FLOAT;";
  let statement = make(<sqlite-sql-statement>, connection: connection, text: sql-query);

  check-true("statement should be a valid instance", statement);

  let parameters = make(<stretchy-vector>);
  add!(parameters, "asdf");
  add!(parameters, 1234);
  add!(parameters, 5678.9);

  let result-set = execute(statement, parameters: parameters);

  check-true("received a valid resultset", result-set);
end test dbms-sql-statement-test;

define suite sqlite-database-test-suite ()
  test dbms-name-test;
  test dbms-version-test;
  test dbms-connect-disconnect-test;
  test dbms-sql-statement-test;
end suite;
