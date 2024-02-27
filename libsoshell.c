// Copyright 2024 dah4k
// SPDX-License-Identifier: GPL-2.0-only

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#ifndef unsetenv
extern int unsetenv(const char *);
#endif

void __attribute__((constructor)) my_ctor(void) {
    // Critical to break LD_PRELOAD infinite loop
    if (unsetenv("LD_PRELOAD") == -1) {
        perror("unsetenv");
    }
    // Execute busybox-static in current working directory
    if (execl("busybox-static", "sh", NULL) == -1) {
        perror("execl");
    }
}
