target=test_stats
src=stats.d main.d tests.d
docs=docs
flags=-O -D -Dd$(docs) -w -of=$(target) -unittest

build:
	dmd $(src) $(flags) 

run: build
	./$(target)

clean:
	rm *.o $(target)