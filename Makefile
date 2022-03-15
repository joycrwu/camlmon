.PHONY: test check

build:
	dune build

utop:
	OCAMLRUNPARAM=b dune utop src

test:
	OCAMLRUNPARAM=b dune exec test/main.exe

play:
	OCAMLRUNPARAM=b dune exec bin/main.exe

check:
	@bash check.sh

finalcheck:
	@bash check.sh final

zip:
	rm -f game.zip
	zip -r game.zip . -x@exclude.lst

clean:
	dune clean
	rm -f game.zip

doc:
	dune build @doc

cloc: clean
	cloc --by-file --include-lang=OCaml .
