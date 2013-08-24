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

