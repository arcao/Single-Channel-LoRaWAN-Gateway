# Single Channel LoRaWAN Gateway

CC=g++
CFLAGS=-c -Wall
LIBS=-lwiringPi

all: single_channel_lorawan_gateway

single_channel_lorawan_gateway: base64.o main.o
	$(CC) main.o base64.o $(LIBS) -o single_channel_lorawan_gateway

main.o: main.cpp
	$(CC) $(CFLAGS) main.cpp

base64.o: base64.c
	$(CC) $(CFLAGS) base64.c

clean:
	rm *.o single_channel_lorawan_gateway

install:
	mkdir -p $(DESTDIR)$(prefix)/lib/systemd/system
	install -m 0755 single_channel_lorawan_gateway $(DESTDIR)$(prefix)/sbin
	install -m 0755 systemd/lorawan-spgw.service $(DESTDIR)$(prefix)/lib/systemd/system
  systemctl daemon-reload
  systemctl enable lorawan-spgw