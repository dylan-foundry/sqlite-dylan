module: sqlite-database
author: robert@robertroland.org
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND

define constant $NULL-SQLITE-HANDLE = null-pointer(<sqlite3*>);
define constant <connection-handle> = <sqlite3*>;

define concrete class <sqlite-connection> (<connection>)
  slot connection-handle :: <connection-handle> = $NULL-SQLITE-HANDLE,
    init-keyword: connection-handle:;
end class;

define method connect (database :: <sqlite-database>,
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

  finalize-when-unreachable(connection);

  connection;
end method;

define method disconnect (connection :: <sqlite-connection>,
                          #key terminate-statements :: <boolean>)
 => ()
  assert(connection.connection-handle ~= $NULL-SQLITE-HANDLE, "Not connected!");

  sqlite3-close(connection.connection-handle);

  connection.connection-handle := $NULL-SQLITE-HANDLE;
end method;

define method finalize (connection :: <sqlite-connection>)
 => ()
  let conn-handle = connection.connection-handle;
  if (conn-handle ~= $NULL-SQLITE-HANDLE)
    sqlite3-close(conn-handle);
  end if;

  next-method();
end method;
