module: sqlite
author: robert@robertroland.org
License:      See License.txt in this distribution for details.
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND

define concrete class <sqlite-user> (<user>)
end class;

define method make-dbms-specific (type == <user>, dbms :: <sqlite-dbms>, #rest more-args)
 => (user :: <sqlite-user>)
  apply(make, <sqlite-user>, more-args);
end method;
