module: sqlite
author: robert@robertroland.org
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND

define abstract class <sqlite-result-set> (<result-set>)
  slot %sql-statement :: false-or(<sqlite-sql-statement>) = #f,
    init-keyword: sql-statement:;

  constant slot %connection :: false-or(<sqlite-connection>) = #f,
    init-keyword: connection:;

  slot %current-record-number :: <integer> = -1;
  slot %result-set-at-end? :: <boolean> = #f;
end class;

define class <sqlite-forward-only-result-set> (<sqlite-result-set>, <forward-only-result-set>)
end class;

define class <sqlite-scrollable-result-set> (<sqlite-result-set>, <scrollable-result-set>)
  constant slot %record-cache :: <deque> = make(<deque>);
end class;

define method make (type == <sqlite-result-set>,
                    #key result-set-policy :: <result-set-policy>,
                         statement :: false-or(<sqlite-sql-statement>),
                         liaison :: false-or(<function>),
                         generator :: false-or(<function>),
                         connection: conn :: false-or(<sqlite-connection>))
 =>  (result-set :: <result-set>)

  let the-liaison = if (liaison ~= #f)
                      liaison
                    else
                      if (statement ~= #f & statement.coercion-policy ~= $no-coercion)
                        copy-sequence
                      else
                        identity
                      end if
                    end if;

  make(<sqlite-forward-only-result-set>, 
       sql-statement: statement,
       liaison: the-liaison,
       generator: generator,
       rowset-size: 10,
       connection: if (statement ~= #f) statement.connection else connection end if);
end method;
