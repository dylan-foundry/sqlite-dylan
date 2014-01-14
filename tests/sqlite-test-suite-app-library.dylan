module: dylan-user

define library sqlite-test-suite-app
  use testworks;
  use sqlite-test-suite;
  use sql-sqlite-test-suite;
end library;

define module sqlite-test-suite-app
  use testworks;
  use sqlite-test-suite;
  use sql-sqlite-test-suite;
end module;
