CC=g++
CFLAGS=-g -Wall -D_DEBUG -std=c++11 -rdynamic
LDFLAGS=-g -rdynamic -Wl,-rpath=$$ORIGIN/

LIBS=libtinyjs.so

SOURCES= \
TinyJS.cpp \
TinyJS_Functions.cpp \
TinyJS_MathFunctions.cpp \
TinyJS_SyntaxTree.cpp

OBJECTS=$(SOURCES:.cpp=.o)

all: run_tests Script run_profiler libtinyjs

run_tests: run_tests.o $(OBJECTS) libtinyjs
	$(CC) $(LDFLAGS) run_tests.o $(OBJECTS) $(LIBS) -o $@ -ldl

Script: Script.o $(OBJECTS) libtinyjs
	$(CC) $(LDFLAGS) Script.o $(OBJECTS) $(LIBS) -o $@ -ldl

run_profiler: run_profiler.o $(OBJECTS) libtinyjs
	$(CC) $(LDFLAGS) run_profiler.o $(OBJECTS) $(LIBS) -o $@ -ldl

libtinyjs:
	$(CC) $(CFLAGS) -shared -o libtinyjs.so -fPIC $(SOURCES) -ldl

.cpp.o:
	$(CC) -c $(CFLAGS) $< -o $@ -ldl

clean:
	rm -f run_tests Script run_profiler run_tests.o run_profiler.o Script.o $(OBJECTS) $(LIBS)
