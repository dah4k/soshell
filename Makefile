# Copyright 2024 dah4k
# SPDX-License-Identifier: MIT-0

PROGRAM := hello_world
LIBSONAME := libsoshell.so
IMAGES := centos6 photon5

all: $(PROGRAM) $(LIBSONAME)

test: $(PROGRAM)
	./$<

testsh: $(PROGRAM) $(LIBSONAME)
	LD_PRELOAD=./$(LIBSONAME) ./$(PROGRAM)

images: $(IMAGES)

$(IMAGES):
	docker build --file Dockerfile.$@ --tag soshell-$@ .

test-%: %
	docker run --interactive --tty --rm soshell-$<

testsh-%: %
	docker run --interactive --tty --rm --env LD_PRELOAD=/lib64/libsoshell.so soshell-$<

%: %.c
	$(CC) -o $@ $< -Wall -W -pedantic -O2 -std=c99

%.so: %.c
	$(CC) -o $@ $< -Wall -W -pedantic -O2 -fPIC -shared -std=c99

clean:
	rm -f $(PROGRAM) $(LIBSONAME)

.PHONY: all test testsh images $(IMAGES) clean
