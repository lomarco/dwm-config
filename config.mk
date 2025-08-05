# dwm version
VERSION = 6.5

# paths
PREFIX = /usr/local
MANPREFIX = ${PREFIX}/share/man
BUILD_DIR = ./build
TARGET = dwm

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

# Xinerama, comment if you don't want it
XINERAMALIBS  = -lXinerama
XINERAMAFLAGS = -DXINERAMA

# freetype
FREETYPELIBS = -lfontconfig -lXft
FREETYPEINC = /usr/include/freetype2

# includes and libs
INCS = -I${X11INC} -I${FREETYPEINC}
LIBS = -L${X11LIB} -lX11 ${XINERAMALIBS} ${FREETYPELIBS}

# flags
CPPFLAGS = -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_XOPEN_SOURCE=700L -DVERSION=\"${VERSION}\" ${XINERAMAFLAGS}
STRICT_WARNINGS	= -Wall -Wextra -Wshadow -Wformat=2 -Wconversion \
									-Wnull-dereference -Wstack-protector -Wdouble-promotion
DEBUG_CFLAGS   := -g3 -DDEBUG -O0 -fno-omit-frame-pointer
RELEASE_CFLAGS := -O3 -flto -DNDEBUG

CFLAGS = -std=c99 -pedantic -Wno-deprecated-declarations ${INCS} ${CPPFLAGS}
LDFLAGS = ${LIBS}

ifeq ($(DEBUG), 1)
	CFLAGS += $(DEBUG_CFLAGS)
else
	CFLAGS += $(RELEASE_CFLAGS)
endif
ifeq ($(WARNS), 1)
	CFLAGS += $(STRICT_WARNINGS)
endif

# compiler and linker
CC = gcc
