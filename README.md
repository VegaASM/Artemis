# Artemis

Created by Vega

Version: 0.0-r059

Status: Compiles. Untested. Most likely will just fault.

---

**What is Artemis?**

Artemis is a bare-bones PowerPC 32-bit Instruction Simulator completely written in ARM64 Assembly. Some properties of the Wii-Broadway PPC chip have been implemented into Artemis, such as Broadway's Graphics Instructions (Paired Singles), and 8 more BAT Registers.

**Why write this in ARM64 Assembly?**

After learning ARM64, I wanted to complete a decent size project using the language.

**What do I need to do before running Artemis?**

You'll need a boot.bin file placed in the Artemis/boot folder. Boot.bin contains the PPC instructions that will be executed at the Reset Vector with its source residing in the Artemis/boot-source/bootbin.S file. The boot sequence will begin after a simulated hard reset meaning only the IP bit will be high in the Machine State Register. This means execution begins at simulated physical address of 0xFFF00100. Boot.bin cannot exceed more than 0x40 bytes in size.

The Repo includes a boot.bin file already present in the Artemis/boot folder. Its PPC instructions are this...

* li r3, 0x3400
* mtsrr0 r3
* li r4, 0x0
* mtsrr1 r4
* rfi

After these instructions have executed, the simulated PPC processor will be at memory address 0x00003400 with all bits low in the Machine State Register.

You will also need a boot.dol file placed in the Artemis/dol folder. This is your main PPC executable file. If you are using the default boot.bin, remember that the boot.dol starts execution at address 0x00003400. For more info about the DOL format, read this-->> https://wiibrew.org/wiki/DOL

A template source of a boot.dol is located in the Artemis/dol-source folder. There are plans in the future to add direct booting of the boot.dol or a ppc.elf file.

**I have boot.bin & boot.dol ready. How do I run Artemis?**

You need to compile it from Source. View the COMPILING.txt for instructions on how to compile and launch Artemis. After compilation, launch Artemis. Please **NOTE** that this current Repo revision will most likely just Fault (no testing/debug has been performed)! Once Artemis launches, you can either Step (s) or Exit (e).

The Artemis/www/artemis.txt file contain the Program Counters's (PC) instruction, PC+4 instruction, and all the register contents. The Artemis/www/memory.txt file will contain the contents of all of the simulated physical memory. The basic idea is you open both files in separate tabs of your web browser. After you step, you refresh artemis.txt (and memory.txt if a store was completed), and view the updated contents.

It is a pain, but this is bare-bones. There may be plans in the future to add in php files, so you can host a localserver and the refreshing will be done automatically.

**Is there any other notes to be aware of?**

Currently, Artemis can only execute basic instructions and execute in physical memory. Cache is partially configured but has not yet been implemented. Regarding address translation, IBAT's in theory work, but DBAT's and Page Tables do not. Effects from items such as HIDx SPR settings are not implemented yet. Anything FPSCR related hasn't been implemented yet.

Valid simulated physical memory addresses are the following ranges
* 0x00000000 thru 0x017FFFFF
* 0x10000000 thru 0x13FFFFFF
* 0xFFF00100 thru 0xFFF0013F

**What are the major goals for Artemis?**

To eventually be able to accurately simulate every Wii-Broadway register, and instruction as close as possible to real Hardware. However, this may require Artemis to be upgraded to a PPC "Clock/Instruction-Pipeline Simulator". I'm not sure if I want to take this route as it would be quite the task. Artemis may end up as just a generic PPC 32-bit Instruction Simulator with Cache+Translation abilities, including features that represent some properties of Broadway. Please **NOTE** that this is not meant to ever replace Dolphin-Emu or be a Wii Console emulator.
