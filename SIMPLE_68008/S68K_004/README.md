This is an example of a C program that runs on the SIMPLE-68008 card.

You will need a version of gcc built as a cross-compiler for the 68k
platform. I used gcc version 7.5.0.

Build the code using the provided make file. It gets linked at address
$2000. To load it into the S68K_002 monitor you can run the
command "L" and then send the run file to the serial port. On a
Linux desktop system using the first USB serial port, this command
works well:

% ascii-xfr -s -l 100 S68K_004.run > /dev/ttyUSB0 

Or just do "make upload".

You can now run the program from the S68K_002 monitor using R2000. Output should
look like the following:

SIMPLE-68008 CPU
RAM Test Passed
> l
Load S-Record
++++++++++++++++++++++++++++>
> r2000
