export NASM=/usr/local/Cellar/nasm/2.13.01/bin/nasm

mkdir build
mkdir build/engine

# engine files
$NASM -o build/engine/clock.o -f macho ../engine/clock.asm -I../macros/

# test files
$NASM -o build/test.o -f macho test.asm -I../macros/

# link
ld -o build/test build/test.o build/engine/clock.o -macosx_version_min 10.7 -lc /usr/lib/crt1.o
./build/test