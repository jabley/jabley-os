default: run

.PHONY: clean

build:
	mkdir -p build

build/multiboot_header.o: build multiboot_header.asm
	nasm -f elf64 multiboot_header.asm -o build/multiboot_header.o

build/boot.o: build boot.asm
	nasm -f elf64 boot.asm -o build/boot.o

build/kernel.bin: build/multiboot_header.o build/boot.o linker.ld
	ld -n -o build/kernel.bin -T linker.ld build/multiboot_header.o build/boot.o

build/isofiles: build/kernel.bin grub.cfg
	mkdir -p build/isofiles/boot/grub
	cp grub.cfg build/isofiles/boot/grub
	cp build/kernel.bin build/isofiles/boot/

build/os.iso: build/isofiles
	grub-mkrescue -o build/os.iso build/isofiles

run: build/os.iso
	qemu-system-x86_64 -curses -cdrom build/os.iso

clean:
	rm -rf build
