MELANGE=melange

all: build

.PHONY: build test

sqlite.dylan: sqlite.intr
	$(MELANGE) -Tc-ffi sqlite.intr sqlite.dylan

build: sqlite.dylan
	dylan-compiler -build sqlite

test: sqlite.dylan
	dylan-compiler -build sqlite-test-suite-app
	_build/bin/sqlite-test-suite-app

clean:
	rm -f sqlite.dylan
	rm -rf _build/bin/sqlite*
	rm -rf _build/lib/*sqlite*
	rm -rf _build/build/sqlite*
