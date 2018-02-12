# Linux From Scratch - 3

---

# Speakers

----

# Aditya Kamat

* CSE @ BMSCE
* [Linkedin](https://www.linkedin.com/in/aditya-kamat-53646310b/)
* [Github](https://github.com/GiVeMeRoOt)
* Twitter (@kamat_adi)

----

# Kaushik Iyer

* ISE @ BMSCE
* [Linkedin](https://www.linkedin.com/in/kaushik-iyer-8b75a5a3)
* [Github](https://githib.com/KaushikIyer16)

---

## Table of contents:
* Part 1: Developing a basic kernel
* Part 2: Enhancing its features
* Part 3: Good coding practices
* Part 4: Interrupts
* Part 5: Building  using make files
* Part 6: Building a basic shell

---

# Part 1: Developing a basic kernel
Note: Refer to OS1

----

# Refer to OS1

----

## kernel.asm
1. It is the assembly code which defines the properties of the kernel.
2. dd stands for define double in assembly.
3. 1BADB002 is called the magical number which identifies the OS as a multiboot OS by the bootloader.
4. cli is used to clear interrupts.
5. Once the kmain returns, the CPU is supposed to halt.

----

## kernel.c
1. kmain function has to be defined in this program.
2. The char array videomem stores the character first and then its color.
3. Major drawback is that we cannot print a string at once.

----

## link.ld
1. It helps in linking the compiled kernel in c and in assembly.
2. The kernel needs to be loaded from 0x100000. We define it in the first part of the section.
3. The text part is loaded from kernel.asm
4. text: Data that ends in the flash memory<br>
   data: Initialised variables/functionalities<br>
   bss: Uninitialised data

----

## Commands that we used:
* nasm -f elf32 kernel.asm -o kasm.o
* gcc -m32 -c kernel.c -o kc.o
* ld -m elf_i386 -T link.ld -o LFS-OS/boot/kernel.bin kasm.o kc.o
* qemu-system-i386 -kernel LFS-OS/boot/kernel.bin
* grub-mkrescue -o lfs-os.iso LFS-OS/

---

# Part 2: Enhancing its features
Note: Refer to OS2 and OS3

----

# Refer to OS2 and OS3

----

## Let us look at some of the changes made to the files.

----

Add "read a" at the end of the *build.sh* for the screen to wait and display errors.

----

We also have an "include" folder which have the definition and declaration of all the C programs.

----

=> __types.h__: All the datatypes which will be used by our kernel.

----

=> __string.h__: Includes functions related to string manipulation.

----

=> __system.h__: It has functions that read and write into the hardware ports of the system.

----

=> __screen.h__: Consists of functions that interacts with the user when the kernel boots up.

----

=> __kb.h__: Consists a map of the different ascii codes for the keys. Refer to the scancode images in the Documents folder for more details.

----

*** Use "freestanding" argument in gcc to allow the compiler to use only the functions defined in our header files/programs. ***

----

Some important functionalities defined:
* print()
* clearScreen()
* clearLine()
* updateCursor()
* printCh()

---

# Part 3: Good coding practices
Note: Refer to OS4

----

# Refer to OS4

----

1. Have a header file for every C program in the include folder.
2. Declare the functions and variables in the header files and define them in the c programs so that they are not copied multiple times while compiling the kernel.

----

The object folder contains all the compiled versions of the includes which can be linked to the kernel directly.

----

This approach allows us to compile only the necessary files and link them with the kernel.
We are slowly moving from monolithic structure to micro kernel structure.

----

This will also help other developers understand our code and easily make changes. This approach is called encapsulation stratergy. You can just build your modules and forget about them. Compile only whatever has changed.

---

# Part 4: Interrupts
Note: Refer to OS5

----

# Refer to OS5

----

An interrupt is a signal sent by the hardware (mouse, keyboard,etc) to the processor in the form of an exception.
This tells the processor to stop whatever it is doing and execute the solution to the exception.

----

<h2> ___IDT - Interrupts Descriptor Table___ </h2>
<br> <br><h7>
Refer [here](https://en.wikipedia.org/wiki/Interrupt_descriptor_table) for more details.
</h7>

----

Check out util, idt and isr files in include folder for the implementation part.

----

In utils:
* memory_copy: Copies data from source to destination.
* memory_set: Sets the same value in multiple locations of the memory.
* int_to_ascii: Converts an interger to a character string equivalent to its ascii value.

----

In idt:
* We are creating an array which consists of 256 interrupt elements.
* idt_gate_t defines the properties of each element.
* idt_register_t stores the base address of the struct and also the size, so that the idt can be accessed by the processor.

----

In isr:
* We define all the interrupts.
* We define the exception messages for every interrupt.
* asm() in C is used to execute assembly instructions.

---

# Part 5: Building  using make files
Note: Refer to OS6

----

# Refer to OS6

----

One major advantage of using make file over the bash script we used is that the make file only compiles whatever has not been changed and then links it to the kernel dynamically. We had to manually comment out the lines in the bash script.

----

The make script makes the entire process more efficient and automation becomes easier.

----

## Syntax of the makefile

----

Define all the constants in the beginning, which can later be called in the file.

----

__"Target:Dependency"__ <br>
This is the format used to generate cycles of processes to be completed in the same order as desired.

----

__make__ command executes the build target and inturn calls run. <br>
__make clear__ command executes the clear target in the makefile.

---

# Part 6: Building a basic shell
Note: Refer to OS6

----

# Refer to OS6

----

We create a shell program which comprises of multiple functions for the user to interact with the OS.

----

Type "help" to see a list of commands that are supported and play around with them.

----

The "malloc" function in util.c allocated memory in a stack and not a heap since it is defined statically.

----

Check out set_screen_colour() function in screen.c to check find out the method to set background and foreground colour.

----

Add the grub.conf file and try booting into your OS using virtualbox.

---

# Thank you
