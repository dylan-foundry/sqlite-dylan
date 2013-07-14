module: sqlite-test-suite
synopsis: Test suite for the sqlite library.

define suite sqlite-test-suite ()
  test openclose-test;
  test statement-test;
  test openclose-v2-test;
end suite;

define test openclose-test ()
  let (result, sqlite3) = sqlite3-open(":memory:");
  check-equal("open returns SQLITE_OK",
              result, $SQLITE-OK);
  check-equal("close returns SQLITE_OK",
              sqlite3-close(sqlite3), $SQLITE-OK);
end test openclose-test;

define test openclose-v2-test ()
  let db-location = concatenate(as(<string>, temp-directory()), "openclose-v2-test.db");
  
  let (result, sqlite3) = sqlite3-open-v2(db-location, 
                                          logior($SQLITE-OPEN-READWRITE, $SQLITE-OPEN-CREATE), 
                                          $SQLITE-NULL-STRING);
  check-equal("open returns SQLITE_OK",
              result, $SQLITE-OK);
  check-equal("close returns SQLITE_OK",
              sqlite3-close(sqlite3), $SQLITE-OK);

  delete-file(db-location);
end test openclose-v2-test;

define test statement-test ()
  let sql = "SELECT :AAAA;";
  let (open-result, sqlite3) = sqlite3-open(":memory:");
  let (prepare-result, statement) = sqlite3-prepare(sqlite3, sql);
  check-equal("prepare returns SQLITE_OK",
              prepare-result, $SQLITE-OK);
  check-equal("statement has 1 bind parameter",
              sqlite3-bind-parameter-count(statement), 1);
  check-equal("statement has correct bind parameter name",
              sqlite3-bind-parameter-name(statement, 1), ":AAAA");
  check-equal("statement has bind parameter in correct position",
              sqlite3-bind-parameter-index(statement, ":AAAA"), 1);
  check-equal("statement returns 1 column",
              sqlite3-column-count(statement), 1);
  check-equal("statement is read-only",
              sqlite3-stmt-readonly(statement), #t);
  // Commented out for now because sqlite3-stmt-busy isn't available
  // on all systems, notably Ubuntu 12.04.  It's new as of 3.7.10.
  // check-equal("statement is not busy",
  //             sqlite3-stmt-busy(statement), #f);
  check-equal("statement has correct SQL",
              sqlite3-sql(statement), sql);
  check-equal("statement parameter can be bound",
              sqlite3-bind-int(statement, 1, 3), $SQLITE-OK);
  check-equal("statement can be stepped",
              sqlite3-step(statement), $SQLITE-ROW);
  // See above comment.
  // check-equal("stepped statement is busy",
  //             sqlite3-stmt-busy(statement), #t);
  check-equal("statement returned correct number of columns.",
              sqlite3-data-count(statement), 1);
  check-equal("statement returned correct data",
              sqlite3-column-int(statement, 0), 3);
  check-equal("statement is done after stepping again",
              sqlite3-step(statement), $SQLITE-DONE);
  check-equal("close returns SQLITE_BUSY (due to unfinalized statements)",
              sqlite3-close(sqlite3), $SQLITE-BUSY);
  check-equal("statement can be finalized",
              sqlite3-finalize(statement), $SQLITE-OK);
  check-equal("close returns SQLITE_OK",
              sqlite3-close(sqlite3), $SQLITE-OK);
end test statement-test;
