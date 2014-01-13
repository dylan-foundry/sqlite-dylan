module: sqlite
author: robert@robertroland.org
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND

define concrete class <sqlite-dbms> (<dbms>)
  constant slot %dbms-name :: <string> = "SQLite3";
  slot %dbms-version :: false-or(<string>) = #f;
end class;

define method dbms-name (dbms :: <sqlite-dbms>, #key connection :: <connection>) => (name :: <string>)
  dbms.%dbms-name;
end method;

define method dbms-version (dbms :: <sqlite-dbms>, #key connection :: <connection>) => (version :: <string>)
  let version = sqlite3-libversion();

  dbms.%dbms-version := version;
end method;
