module: sqlite-database
author: robert@robertroland.org
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND

define constant $null-statement-handle = null-pointer(<sqlite3-stmt*>);

define concrete class <sqlite-sql-statement> (<sql-statement>)
  slot connection :: <sqlite-connection> = default-connection(),
    init-keyword: connection:;

  slot bindings :: <vector> = make(<vector>);

  slot %statement-handle :: <sqlite3-stmt*> = $null-statement-handle;

  slot %prepared :: <boolean> = #f;
end class;

define method make-dbms-specific (type == <sqlite-sql-statement>, dbms :: <sqlite-dbms>, #rest more-args)
 => (sql-statement :: <sqlite-sql-statement>)
  apply(make, <sqlite-sql-statement>, more-args);
end method make-dbms-specific;

define method initialize (stmt :: <sqlite-sql-statement>, #key)
 => ()
  next-method();

  finalize-when-unreachable(stmt);
end method initialize;

define method finalize (stmt :: <sqlite-sql-statement>)
 => ()
  close-statement(stmt);

  next-method();
end method finalize;

define method statement-column-names (stmt :: <sqlite-sql-statement>)
 => (column-names :: <simple-object-vector>)
  //TODO: assert the statement handle is valid
  let statement-handle = stmt.%statement-handle;

  let column-count = sqlite3-column-count(statement-handle);
  let column-names = make(<simple-object-vector>, size: column-count);
  for (column :: <integer> from 1 to column-count)
    column-names[column - 1] := sqlite3-column-name(statement-handle, column);
  end for;

  column-names
end method statement-column-names;

define method close-statement (stmt :: <sqlite-sql-statement>) => ()
  if (stmt.%prepared)
    let handle = stmt.%statement-handle;
    if (handle ~= $null-statement-handle)
      sqlite3-finalize(handle);
    end if;

    stmt.%prepared := #f
  end;
end method close-statement;

define method execute (stmt :: <sqlite-sql-statement>,
                       #key result-set-policy :: false-or(<result-set-policy>) = $default-result-set-policy,
                            parameters :: <sequence> = #(),
                            liaison :: false-or(<function>))
 => (result-set :: false-or(<result-set>))

  if (stmt.%prepared)
    close-statement(stmt)
  end;

  if (parameters.size > 0)
    bind-parameters(stmt, parameters);
  end if;

  let (prepare-result, statement) = sqlite3-prepare(stmt.connection.connection-handle,
                                                    stmt.text);
  stmt.%prepared := #t;
  stmt.%statement-handle := statement;

  if (prepare-result ~= $SQLITE-OK)
    // sql statement bombed. bomb here.
  end;

  if (result-set-policy)
    let column-count = sqlite3-column-count(statement);

    if (column-count > 0)
      make(<sqlite-result-set>,
           result-set-policy: result-set-policy,
           statement: stmt,
           liaison: liaison);
    else
        make(<empty-result-set>);
    end;
  else
    close-statement(stmt);
  end;
end method execute;

define method bind-parameters (statement :: <sqlite-sql-statement>,
                               parameters :: <sequence>)
 => ()
  for (parameter-number :: <integer> from 0 below parameters.size)
    sqlite3-parameter-binder(statement.%statement-handle,
                             parameter-number,
                             parameters[parameter-number]);
  end for;
end method;
