d_compiler=dmd

target_release=targets/stats_release
target_debug=targets/stats_debug

src=src/*.d
tests=tests/*.d
include_paths=-I=src -I=tests

docs=docs

.PHONY: benchmarks man

flags_release=$(include_paths) -O -inline -D -Dd$(docs) -w -of=$(target_release)
flags_debug=$(include_paths) -debug -D -Dd$(docs) -w -of=$(target_debug) -unittest

all: run_debug run_release

build_debug:
	$(d_compiler) $(src) $(tests) $(flags_debug)

build_release:
	$(d_compiler) $(src) $(tests) $(flags_release)
	
run_debug: build_debug 
	./$(target_debug)
	
run_release: build_release 
	./$(target_release)

clean:
	rm $(target_debug) $(target_release)

benchmarks:
	Rscript benchmarks/test.R

man:
	dmd --help | less
