# Operating-System 
 Kalsoom Waseem
 291243
 BSCS-9B
![osss](https://user-images.githubusercontent.com/62180999/115550356-30718300-a2c3-11eb-9bc2-316bb99505c2.jpeg)
 
 
 
 
 Basic tooling and Description
download and install docker and qemu docker will enable us to create a reproducible build environment
first we create a docker image which is the snapshot of linux machine after that we are in linux virtual machine
src folder contains all the source code
header.asm contains  magic number data so that bootloaders understand that we have some opertaing system multi boot2 specification 
main.asm is the entry point into our operating system
linker and grub configurations targets folder
linker file links the operating system together we will start with one megabyte in then multi-boot header and all our cpu instructions
iso file contains a group configuration file and then final produced iso file grub will creaate iso file od our os kernel iso file holds the os
qemu will emulate the os
makefile organizes all the build commands. only files that have been modified gets rebuild
main.asm contains stack stack reserves 16kbytes of memory
it contains assembly code for checking if the cpu supports long mode or not and check multiboot and contains error instructions. for long mode we must set up paging all data and meor is stored at their addresses we work with virtual addresses maped to physical addresses we implement virtual memory in order to enter 64-bit long mode through paging page tables define all the mappings which cpu looks at while reading or writing to memory full page of virtual memory is mapped too phsical memory page tables work with four levels in setup-page-tables . at last we write some custom print function in kernel-main functions
