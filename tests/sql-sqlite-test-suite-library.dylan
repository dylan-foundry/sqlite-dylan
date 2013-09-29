module: dylan-user

define library sql-sqlite-test-suite
  use common-dylan;
  use io;
  use sqlite;
  use testworks;
  use system;

  export sql-sqlite-test-suite;
end library;

define module sql-sqlite-test-suite
  use common-dylan, exclude: { format-to-string };
  use format;
  use format-out;
  use sqlite;
  use testworks;
  use file-system;

  export sql-sqlite-test-suite;
end module;
