module: sqlite-test-suite
synopsis: Test suite for the sqlite library.

define suite sqlite-test-suite ()
  test openclose-test;
  test prepare-test;
end suite;

define test openclose-test ()
  let (result, sqlite3) = sqlite3-open(":memory:");
  check-equal("open returns SQLITE_OK", result, $SQLITE-OK);
  check-equal("close returns SQLITE_OK", sqlite3-close(sqlite3), $SQLITE-OK);
end test openclose-test;

define test prepare-test ()
  let sql = "SELECT :AAAA;";
  let (open-result, sqlite3) = sqlite3-open(":memory:");
  let (prepare-result, statement, remaining) = sqlite3-prepare(sqlite3, sql, -1);
  check-equal("prepare returns SQLITE_OK", prepare-result, $SQLITE-OK);
  check-equal("statement has 1 bind parameter",
              sqlite3-bind-parameter-count(statement), 1);
  sqlite3-finalize(statement);
  check-equal("close returns SQLITE_OK", sqlite3-close(sqlite3), $SQLITE-OK);
end test prepare-test;
