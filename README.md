# Artemis

What is Artemis?

Artemis is a bare-bones PowerPC 32-bit Instruction Simulator completely written in ARM64 Assembly.

Why write this in ARM64 Assembly?

After learning ARM64, I wanted to complete a decent size project using the language.

What do I need to do before running Artemis?

You will also need a boot.dol file placed in the Artemis/dol folder. For more info about the DOL format, read this-->> https://wiibrew.org/wiki/DOL

I have boot.dol ready. How do I run Artemis?

You need to compile it from Source. View the COMPILING_and_DEBUG.txt for instructions. After compiling, move the main executable to the Repo Root directory, make it executable, and launch it...

chmod +x ./main
./main

Follow the on-screen instructions. Artemis/www contains the two files you can look at (refresh) after every instruction simulation.

-----

Version: n/a at this time

Status: Compiles, doesn't really work

Artemis can *ONLY* do the following at the moment...
- Execute a handful of integer instructions
- Execute in physical memory
