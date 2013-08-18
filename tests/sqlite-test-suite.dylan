module: sqlite-test-suite
synopsis: Test suite for the sqlite library.

define macro with-sqlite-db
  { with-sqlite-db (?db-handle:variable = ?db-location:expression) ?:body end }
    => {
        let _sqlite3-db = #f;
        block() 
          let (result, _sqlite3-db) = sqlite3-open(?db-location);
          let ?db-handle = _sqlite3-db;
          ?body;
        cleanup
          if (_sqlite3-db)
            sqlite3-close(_sqlite3-db);
          end
        end
       }
end macro with-sqlite-db;

define suite sqlite-test-suite ()
  test openclose-macro-test;
  test openclose-test;
  test statement-test;
  test openclose-v2-test;
end suite;

define test openclose-macro-test ()
  with-sqlite-db(db = ":memory:")
    check-true("database handle should not be #f", db);

    check-equal("errcode should be 0", 0, sqlite3-errcode(db));
  end;
end test openclose-macro-test;

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
  let sql-query = "SELECT :AAAA;";
  with-sqlite-db(sqlite3 = ":memory:") 
    let (prepare-result, statement) = sqlite3-prepare(sqlite3, sql-query);
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
    check-equal("statement is not busy",
                sqlite3-stmt-busy(statement), #f);
    check-equal("statement has correct SQL",
                sqlite3-sql(statement), sql-query);
    check-equal("statement parameter can be bound",
                sqlite3-bind-int(statement, 1, 3), $SQLITE-OK);
    check-equal("statement can be stepped",
                sqlite3-step(statement), $SQLITE-ROW);
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
  end;
end test statement-test;
