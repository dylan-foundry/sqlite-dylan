MELANGE=melange

all: build

.PHONY: build test

sqlite/sqlite.dylan: sqlite/sqlite.intr
	$(MELANGE) -Tc-ffi sqlite/sqlite.intr sqlite/sqlite.dylan

build: sqlite/sqlite.dylan
	dylan-compiler -build sqlite

test: sqlite/sqlite.dylan
	dylan-compiler -build sqlite-test-suite-app
	_build/bin/sqlite-test-suite-app

clean:
	rm -rf _build/bin/*sqlite*
	rm -rf _build/lib/*sqlite*
	rm -rf _build/build/*sqlite*
