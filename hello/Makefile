link: build
	ld hello.o -o hello

build:
	as hello.s -o hello.o

dump:
	objtool -d hello | less
