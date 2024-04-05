# Artemis

Created by Vega

Version: 0.0-r031

Status: Compiles. Untested. Most likely will just fault.

---

**What is Artemis?**

Artemis is a bare-bones PowerPC 32-bit Instruction Simulator completely written in ARM64 Assembly. Some properties of the Wii-Broadway PPC chip have been implemented into Artemis.

**Why write this in ARM64 Assembly?**

After learning ARM64, I wanted to complete a decent size project using the language.

**What do I need to do before running Artemis?**

You will need a boot.bin file placed in the Artemis/boot folder. Boot.bin contains the PPC instructions that will be executed at the Reset Vector with its source residing in the Artemis/boot-source/bootbin.S file. The boot sequence will begin after a simulated hard reset meaning only the IP bit will be high in the Machine State Register. This means execution begins at simulated physical address of 0xFFF00100. Boot.bin cannot exceed more than 0x40 bytes in size.

By default, the PPC instructions in boot.bin are this...

* li r3, 0x3400
* mtsrr0 r3
* li r4, 0x0
* mtsrr1 r4
* rfi

After these instructions have executed, the simulated PPC processor will be at 0x3400 with all bits low in the Machine State Register.

You will also need a boot.dol file placed in the Artemis/dol folder. This is your main PPC executable file. If you are using the default boot.bin, remember that the boot.dol beings execution at simulated physical address 0x00003400. For more info about the DOL format, read this-->> https://wiibrew.org/wiki/DOL

A template source of a boot.dol is located in the Artemis/dol-source folder.

**I have boot.bin & boot.dol ready. How do I run Artemis?**

You need to compile it from Source. View the COMPILING.txt for instructions on how to compile and launch Artemis. After compilation, launch Artemis. Please **NOTE** that this current Repo revision will most likely just Fault (no testing/debug has been performed)! Once Artemis launches, follow the on-screen instructions.

**Is there any other notes to be aware of?**

Currently, Artemis can only execute basic instructions and execute in physical memory.

Valid simulated physical memory addresses are the following ranges
* 0x00000000 thru 0x017FFFFF
* 0x10000000 thru 0x13FFFFFF
* IP bit high of vector addresses (i.e 0xFFF0_nnnn)

Be sure the instructions in your boot.dol adhere to these ranges. When stepping, the www/artemis.txt file will contain all the Register Information plus the current instruction string, and subsequent instruction string. The www/memory.txt file will contain all the Memory contents.

**What are the major goals for Artemis?**

To eventually be able to accurately simulate every Wii-Broadway register, and instruction. Please **NOTE** that this is not meant to ever replace Dolphin or be a Wii Console emulator.
