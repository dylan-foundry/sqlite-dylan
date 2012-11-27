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

clean-dylan:

clean: clean-dylan
