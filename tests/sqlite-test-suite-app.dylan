module: sqlite-test-suite-app

define suite all-sqlite-test-suites ()
  suite sqlite-test-suite;
  suite sqlite-database-test-suite;
end;

run-test-application(all-sqlite-test-suites);
