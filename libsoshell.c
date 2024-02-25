// Copyright 2024 dah4k
// SPDX-License-Identifier: GPL-2.0-only

#include <stdlib.h>
#include <unistd.h>

#ifndef unsetenv
extern int unsetenv(const char *);
#endif

void __attribute__((constructor)) my_ctor(void) {
    unsetenv("LD_PRELOAD");         // Critical to avoid small Fork Bomb
    execl("/bin/busybox-static", "sh", NULL);
}
