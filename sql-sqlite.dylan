module: sqlite
author: robert@robertroland.org
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND

define constant $NULL-SQLITE-HANDLE = null-pointer(<sqlite3*>);
define constant <connection-handle> = <sqlite3*>;

define concrete class <sqlite-user> (<user>)
end class;

define method make-dbms-specific(type == <user>, dbms :: <sqlite-dbms>, #rest more-args)
  => (user :: <sqlite-user>)
  apply(make, <sqlite-user>, more-args);
end method;

define concrete class <sqlite-dbms> (<dbms>)
  constant slot %dbms-name :: <string> = "SQLite3";
  slot %dbms-version :: false-or(<string>) = #f;
end class;

define method dbms-name(dbms :: <sqlite-dbms>, #key connection :: <connection>) => (name :: <string>)
  dbms.%dbms-name;
end method;

define method dbms-version(dbms :: <sqlite-dbms>, #key connection :: <connection>) => (version :: <string>)
  let version = sqlite3-libversion();

  dbms.%dbms-version := version;
end method;

define concrete class <sqlite-database> (<database>)
  slot path-name :: <string>,
    required-init-keyword: path-name:;
end class;

define method make-dbms-specific (type == <database>, dbms :: <sqlite-dbms>, #rest more-args)
  => (database :: <sqlite-database>)

  apply(make, <sqlite-database>, more-args);
end method;

define concrete class <sqlite-connection> (<connection>)
  slot connection-handle :: <connection-handle> = $NULL-SQLITE-HANDLE,
    init-keyword: connection-handle:;
end class;

define method connect(database :: <sqlite-database>,
    user :: <user>,
    #key path-name :: <string> = "",
    dbms :: <sqlite-dbms> = default-dbms())
  => (connection :: <sqlite-connection>)

  let (result, sqlite3-db-handle) = sqlite3-open(path-name);
  assert(result == $SQLITE-OK, "database open failed: %d", result);

  let connection = make(<sqlite-connection>,
    connection-handle: sqlite3-db-handle,
    dbms: dbms);

  if (dbms.%dbms-name = #f)
    dbms-name(dbms, connection: connection);
  end if;

  if (dbms.%dbms-version = #f)
    dbms-version(dbms, connection: connection);
  end if;

  connection;
end method;

define method disconnect(connection :: <sqlite-connection>,
    #key terminate-statements :: <boolean>)
  => ()
  assert(connection.connection-handle ~= $NULL-SQLITE-HANDLE, "Not connected!");

  sqlite3-close(connection.connection-handle);

  connection.connection-handle := $NULL-SQLITE-HANDLE;
end method;