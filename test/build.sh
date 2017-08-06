export NASM=/usr/local/Cellar/nasm/2.13.01/bin/nasm

$NASM -o build/test.o -f macho test.asm -I../macros/
ld -o build/test build/test.o -macosx_version_min 10.7 -lc /usr/lib/crt1.o
./build/test