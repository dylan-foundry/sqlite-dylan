module: sql-sqlite-test-suite
synopsis: Test suite for the sql-sqlite library.

define suite sql-sqlite-test-suite ()
  test dbms-name-test;
  test dbms-version-test;
  test dbms-connect-disconnect-test;
end suite;

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