module: dylan-user

define library sqlite-test-suite
  use common-dylan;
  use sqlite;
  use testworks;
  use system;

  export sqlite-test-suite;
end library;

define module sqlite-test-suite
  use common-dylan;
  use sqlite;
  use testworks;
  use file-system;

  export sqlite-test-suite;
end module;
