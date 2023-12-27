target=test_stats
src=stats.d main.d 
flags=-O -D

build:
	dmd $(src) $(flags) -of=$(target)

run: build
	./$(target)

clean:
	rm *.o $(target)