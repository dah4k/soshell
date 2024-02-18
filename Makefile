# Copyright 2024 dah4k
# SPDX-License-Identifier: MIT-0

PROGRAM := hello_world
LIBSONAME := libsoshell.so

all: $(PROGRAM) $(LIBSONAME)

test: $(PROGRAM)
	./$<

testsh: $(PROGRAM) $(LIBSONAME)
	LD_PRELOAD=./$(LIBSONAME) ./$(PROGRAM)

%: %.c
	$(CC) -o $@ $< -Wall -W -pedantic -O2

%.so: %.c
	$(CC) -o $@ $< -Wall -W -pedantic -O2 -fPIC -shared

clean:
	rm -f $(PROGRAM) $(LIBSONAME)

.PHONY: all test testsh clean
