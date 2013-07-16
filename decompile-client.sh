#!/bin/bash
if [ -e input/minecraft.jar ] ; then
    echo "----- Deobfuscating Client -----"
    echo "Running JarJar on minecraft.jar"
    java -jar runtime/jarjar-1.1.jar process configs/client.rules input/minecraft.jar output/minecraft.jar > /dev/null
    echo "Running RetroGuard on minecraft.jar"
    java -jar runtime/retroguard.jar output/minecraft.jar output/minecraftrg.jar configs/client.rgs output/retro.log > /dev/null
    rm output/minecraft.jar
    rm output/retro.log
    mv output/minecraftrg.jar output/minecraft.jar
else
    echo "Skipping Client deobfuscating due to lack of jar."
fi

if [ -e output/minecraft.jar ] ; then
    echo "----- Decompiling Client -----"
    if [ -e output/client ] ; then
        rm -r output/client
    fi
    mkdir output/client
    mkdir output/client/src
    java -jar runtime/fernflower.jar -dgs=1 -das=0 -ren=0 output/minecraft.jar output/client/src > /dev/null
    unzip output/client/src/minecraft.jar -d output/client/src > /dev/null
    rm output/client/src/minecraft.jar
    rm output/minecraft.jar
    if [ -e output/client/src/null ] ; then
        rm output/client/src/null
    fi
    rm -r output/client/src/META-INF
    echo "Patching sources"
    cd output/client/src
    patch -p1 -i ../../../patches/cleanup-client.patch > /dev/null
    cd ..
else
    echo "Skipping Client decompiling due to lack of jar."
fi
