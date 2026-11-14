ERLFMT_SOURCE_STYLE = --indent-size=4 --print-width=100

.PHONY: compile
compile:
	rebar3 compile

.PHONY: test
test:
	rebar3 ct

.PHONY: release
release:
	rebar3 as release escriptize

.PHONY: clean
clean:
	rm -rf _build
	rebar3 clean

.PHONY: fmt
fmt: release
	_build/release/bin/erlfmt -w $(ERLFMT_SOURCE_STYLE)

.PHONY: checkfmt
checkfmt: release
	_build/release/bin/erlfmt -c $(ERLFMT_SOURCE_STYLE) --exclude-files="src/erlfmt_parse.erl"

.PHONY: check
check: clean
	make compile
	make test
	rebar3 dialyzer
	make checkfmt
