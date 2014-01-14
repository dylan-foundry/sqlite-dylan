module: dylan-user

define library sqlite-database-test-suite
  use common-dylan;
  use sqlite-database;
  use testworks;
  use system;

  export sqlite-database-test-suite;
end library;

define module sqlite-database-test-suite
  use common-dylan;
  use sqlite-database;
  use testworks;
  use file-system;

  export sqlite-database-test-suite;
end module;
