module: sqlite
author: robert@robertroland.org
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND

define concrete class <sqlite-database> (<database>)
  slot path-name :: <string>,
    required-init-keyword: path-name:;
end class;

define method make-dbms-specific (type == <database>, dbms :: <sqlite-dbms>, #rest more-args)
  => (database :: <sqlite-database>)

  apply(make, <sqlite-database>, more-args);
end method;
