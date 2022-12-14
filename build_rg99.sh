#!/bin/sh

BDAT=$(date +"%Y%m%d-%H%M%S")
echo '#define BUILDDATE "'$BDAT'"' >./gambatte_sdl/builddate.h

echo "cd libgambatte && scons"
(cd libgambatte && scons -Q target=rg99) || exit
echo "cd gambatte_sdl && scons"
(cd gambatte_sdl && scons -Q target=rg99)
mv gambatte_sdl/gambatte_sdl gambatte_sdl/gambatte-dms.rg99

echo "cd gambatte_sdl && scons -c"
(cd gambatte_sdl && scons -c target=rg99)
echo "cd libgambatte && scons -c"
(cd libgambatte && scons -c target=rg99)
echo "rm -f *gambatte*/config.log"
rm -f *gambatte*/config.log
echo "rm -rf *gambatte*/.scon*"
rm -rf *gambatte*/.scon*
find . -type f -iname \*.o -delete
find . -type f -iname gambatte_sdl -delete

rm -f gambatte-dms-rg99-r572u4-$BDAT.opk
mksquashfs ./dist/rg99/default.rg99.desktop ./gambatte_sdl/gambatte-dms.rg99 ./dist/gambatte_dms.png ./dist/manual.txt gambatte-dms-rg99-r572u4-$BDAT.opk -all-root -no-xattrs -noappend -no-exports

find . -type f -iname gambatte-dms.rg99 -delete
