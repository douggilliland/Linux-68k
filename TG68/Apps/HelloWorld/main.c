/// prints out the UART port

#include "uart.h"
#include "small_printf.h"

int main(int argc, char **argv)
{
	printf("Hello World\n\r");
	printf("Hello number %d\n\r",42);
	printf("Printf with a string: %s\n\r","Yes, a string!");
	return(0);
}

