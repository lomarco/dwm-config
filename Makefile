include config.mk

SRC = drw.c util.c dwm.c
OBJ = $(patsubst %.c,$(BUILD_DIR)/%.o,$(SRC))

all: $(BUILD_DIR)/$(TARGET) 

$(BUILD_DIR):
	mkdir -p $@

$(BUILD_DIR)/%.o: %.c config.h config.mk | $(BUILD_DIR)
	$(CC) -c $(CFLAGS) $< -o $@

config.h:
	cp -f config.def.h $@

$(BUILD_DIR)/$(TARGET): config.h $(OBJ) | $(BUILD_DIR)
	$(CC) -o $@ $(OBJ) $(LDFLAGS)

clean:
	rm -rf $(BUILD_DIR)

dist: clean
	mkdir -p dwm-${VERSION}
	cp -f LICENSE Makefile README config.def.h config.mk dwm.1 drw.h util.h $(SRC) dwm.png transient.c dwm-${VERSION}
	tar -czf dwm-${VERSION}.tar.gz dwm-${VERSION}
	rm -rf dwm-${VERSION}

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f $(BUILD_DIR)/dwm ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/dwm
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	sed "s/VERSION/${VERSION}/g" < dwm.1 > ${DESTDIR}${MANPREFIX}/man1/dwm.1
	chmod 644 ${DESTDIR}${MANPREFIX}/man1/dwm.1

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/dwm ${DESTDIR}${MANPREFIX}/man1/dwm.1

.PHONY: all clean dist install uninstall
