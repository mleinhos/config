CC = gcc
#`pkg-config --cflags glib-2.0`
CFLAGS = -g -std=c99 
LDFLAGS = 

server: server.o
	$(CC) $(LDFLAGS) -o $@ $^ 

%.o : %.c
	$(CC) $(CFLAGS) -c -o $@ $^ 

clean:
	rm -f *.o server
