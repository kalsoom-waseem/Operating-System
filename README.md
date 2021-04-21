# Operating-System 
 Kalsoom Waseem
 291243
 BSCS-9B
 The website link is https://kalsoom-waseem.github.io/
 
 
 
 
![osss](https://user-images.githubusercontent.com/62180999/115550356-30718300-a2c3-11eb-9bc2-316bb99505c2.jpeg)
 

# DOCKER 
# what is docker ? 
docker is a tool designed to make it easier to create, deploy , and run application by using conatainer.

# Container: 
container allow to package up an application with all of the parts it needs, such as libraries and other dependencies, and deploy it as one package. By doing so, the we can rest assured that the application will run on any other Linux machine regardless of any customized settings that machine might have that could differ from the machine used for writing and testing the code. Its a bit like a virtual machine. But rather than creating a whole virtual operating system, Docker allows application to use the same Linis kernel as the system they are running on.

# Software installed using Docker 
i also installed certain softwares using docker.

- Softwares
gcc-cross-x86_64-elf ( A pre-made image which will hold all compilation tools we need)
nasm (For compilation of the assembly code)
Grub(To build our final .iso file )
# What is Grub ? 
GRUB implements a specification called Multiboot, which is a set of conventions for how a kernel should get loaded into memory. By following the Multiboot specification, we can let GRUB load our kernel.

The way that we do this is through a ‘header’. We’ll put some information in a format that multiboot specifies right at the start of our kernel. GRUB will read this information, and follow it to do the right thing.

# Docker Image 
Docker image is like a snapshot of a linux machine with any extra software andfiles installed onto it.

After building a docker image i used a command

code

docker run –rm -it -v %cd%:/root/env myos-buildenv
Before running this command make sure that docker daemon is running. Otherwise it will show error.

# Issue Faced 
snap of an error faced

This is the error that specifies that the docker daemon is not running.

After its proper running im inside a virtual machine with access to all the tools and softwares that i need to build the operating system.


# QEMU 
# Why used ? 
Qemu is used to emulate the image or operating system built by the docker and certain privileged.Its like a hosted virtual machine monitor. It emulates the machine’s processor through dynamic binary translation and provides a set of different hardware and device models for the machine, enabling it to run a variety of guest operating systems.

To Emulate the os in the QEMU the command is

code

qemu-system-x86_64 -cdrom dist/x86_64/kernel.iso
# Header.asm File 
This file has the code for bootloader to locate the operating system in whatever way it is appropriate for the specific computer.

# Magic number (dd 0xe85250d6) 
dd 0xe85250d6 ; magic number

“dd” stand for define double word.

“0xe85250d6” This is a hexadecimal arbitrary number. It does not mean anything. The very first thing that the multiboot specification requires is that we have the magic number dd 0xe85250d6 right at the start.

# dd 0 
This is used to define that we are in the protected mood later we will change this number to 1 which means that now we are using long mood. infact proected mood and the real mood are used to define weather we are operating a 32 or 64 bit processor respectively.

# header_end - header_start 
This statment used to define header length.

# Check Sum 
Here we will do some calculation. Infact the idea is that it lets us and the GRUB double check that everything is accurate.

# Ending Tag 
dw 0
dw 0
dd 8
# Main.asm File 
This file will be the entry point into the system and we are writing the necessary assembly code that we need to print on the screen for our purpose.

In this we first set the system to 32-bit and later converted it to 64-bit.

# Linker.ld File 
we create this file to link both the header file and the main.asm file We’ve now got our kernel in the kernel.bin file. Next, we’re going to make an ISO out of it, so that we can load it up in QEMU

# MakeFile 
Typing all of these commands out every time we want to build the project is tiring and error-prone. It’s nice to be able to have a single command that builds our entire project. To do this, we’ll use make. Make is a classic bit of software that’s used for this purpose. At its core, make is fairly simple. We just need to make a Makefile . In this we define the values with some rules and whenever we need to build the os we just build this MakeFile. It will work fast.

In this file we created to variables to store data of two different type of files. These files are .asm files and .o files i.e, oblect files.

After this we build the object file from the source files. We only recompile when the data of source file has been changed.

At the end we generate our iso file using grub-mkrescue and put our output in the kernal.iso file.

After all this we first build the image then emulated it with QEMU and printed the word “OK” that we wrote in the assembly file.



After this we converted the OS to 64-bit.

# Process to convert into 64-Bit 
From now we will shift to c language and write our code in the c language. To write in c language we need to implement stack. In implementing this we will reserve some memory so that when the boot-loader loads our kernel. We first all implemented this stack in assembly. Before we move to c code we fisrt implemented long mode (64-bit mode) and changed our kernel to 64-bit.

After that we initilize many subroutines to check different parameters. First we all we check that our multoboot2 loader is loaded successfully. Similarly we created function to check for cpuid which gives various cpu information. Which further help to check wether our system is compatible for 64-bit mode or not.Here we use the previous implemented stack to check that weather the system is compatible or not. After this we implemented a new concept called pagging.

# Paging 
All our data in memory is stored at different addresses. However rather than working directly with the physical addresses in ram we work with virtual addresses.Which provides a very useful layer of indirection.physical addresses and virtual addresses. A physical address is the actual, real value of a location in the physical RAM in the machine. A virtual address is an address anywhere inside of our 64-bit address space: the full range. To bridge between the two address spaces, we can map a given virtual address to a particular physical address. Which can be done with the help of this paging concept.So to enter into long mode i.e., 64-bit mode we need to impliment this process of paging.
In the simplest form paging allows us to map virtual addresses to physical addresses. we do this by creating page tble defining all the mappings which the system then looks at whenever we read or write to memory.

A single page is a chunk of 4KB of memory. When we a mapping memory we map a full page of virtual memory to physical memory at a time.There are four level of page table.These are called L1,L2,L3 and L4. Each table can hold 512 entries. Each virtual address take 48bits of 64bits available. The other bits are actually unused.

# Global Descripter Table 
Although we have implemented long mode in paging but we are not in 64-bit mode. We are still in 32-bit compatible sub mode. To finally finish 64-bit mode we need to implement that is called global descripter table. Although we are using paging the global descripter table has less work but it is still required to enter into 64-bit mode.

Our Global descripter table has three entries.

# Zero Entry
Code Segment
Data Segment
Zero Entry 
- code
{ section .rodata

gdt64:

dq 0}

We have a new section: .rodata. This stands for ‘read only data’ and since we are not going to modify our Global descriper table, having it be read-only is a good idea.Next, we have a label: gdt64. We will use this label later to tell the hardware where our Global descriper table is located. Finally, dq 0. This is define quad-word in other words a 64-bit value. Given that it’s a zero entry.

# Code Segment. 
- code 
.code: equ $ - gdt64
dq (1<<44) | (1<<47) | (1<<41) | (1<<43) | (1<<53)
1«44 means ‘left shift one 44 places’, which sets the 44th bit and so on for all other instruction.

( set 44 ‘TO set descriptor type’)
( set 47 ‘present’ this is set if the entry is valid)
( set 41 ‘read/write command’ If this is code segment then it is readable.)
( set 43 ‘Executable’ set to 1 for code segment)
( set 53 for 64-bit GDT this should be 1).
# Print.h File 
After implementing the above all code we are now going to define our c file. Here we will define our own methods for printing data or other values.like here we defined the function to clear the screen, print_src() (to print value) and print_char() etc. We also defined a function to change the foreground and background color. Here we also defined an ENUM to give a specific value to a color.

# Updates in the Makefile: 
We again updated the Makefile and edited the Makefile to read the c and kernal files. Before this it was only compiling and linking the .asm file.

After all this we have succcessfully converted our 32 bit operating system to 64-bit OS. And now we are ready to print the output
 
 
