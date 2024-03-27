# Artemis

Created by Vega

**What is Artemis?**

Artemis is a bare-bones PowerPC 32-bit Instruction Simulator completely written in ARM64 Assembly.

**Why write this in ARM64 Assembly?**

After learning ARM64, I wanted to complete a decent size project using the language.

**What do I need to do before running Artemis?**

You will need a boot.dol file placed in the Artemis/dol folder. For more info about the DOL format, read this-->> https://wiibrew.org/wiki/DOL

If you instead have a PPC-32 compliant ELF file, you can use an ELF to DOL converter. More info -->> https://www.wiibrew.org/wiki/ELF_to_DOL_Converter

**I have boot.dol ready. How do I run Artemis?**

You need to compile it from Source. View the COMPILING.txt for instructions on how to compile and launch Artemis. After compilation, launch Artemis. Please **NOTE** that this current Repo revision will most likely just Fault (no testing/debug has been performed)! Once Artemis launches, follow the on-screen instructions.

**Is there any other notes to be aware of?**

Valid simulated memory addresses are the following ranges
* 0x00000000 thru 0x017FFFFF
* 0x10000000 thru 0x13FFFFFF

Be sure the instructions in your boot.dol adhere to these ranges. When stepping, the www/artemis.txt file will contain all the Register Information plus the current instruction string, and subsequent instruction string. The www/memory.txt file will contain all the Memory contents.

**What are the major goals for Artemis?**

To eventually be able to accurately simulate every Wii-Broadway register, and instruction. Please **NOTE** that this is not meant to ever replace Dolphin or be a Wii Console simulator.

-----

Version: 0.0-r025

Status: Compiles. Untested. Most likely will just fault.

Artemis can *ONLY* do the following at the moment...
* Execute a handful of basic instructions
* Execute in physical memory
