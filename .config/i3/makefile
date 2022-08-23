CC = clang
ARCH = x86-64
EMU = 64
CFLAGS = -Wall -m$(EMU) -march=$(ARCH)
DEBUGCFLAGS = -O0 -g
RELCFLAGS = -O3
C_LD = lld
EXECNAME = volumeNotif

all: release

volumeNotif.o: volumeNotif.c 
	$(CC) $(CFLAGS) volumeNotif.c -c -o volumeNotif.o
 
debug: CFLAGS += $(DEBUGCFLAGS)
debug: volumeNotif.o
	$(CC) $(CFLAGS) -fuse-ld=$(C_LD) volumeNotif.o -o $(EXECNAME)

release: CFLAGS += $(RELCFLAGS)
release: volumeNotif.o
	$(CC) $(CFLAGS) -fuse-ld=$(C_LD) volumeNotif.o -o $(EXECNAME)
	strip volumeNotif

clean:
	rm *.o volumeNotif

.PHONY: clean all debug release
