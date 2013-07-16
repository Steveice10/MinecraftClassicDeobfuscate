#!/bin/bash

if [ -e input/minecraft-server.jar ] ; then
    echo "----- Deobfuscating Server -----"
    echo "Running JarJar on minecraft-server.jar"
    java -jar runtime/jarjar-1.1.jar process configs/server.rules input/minecraft-server.jar output/minecraft-server.jar > /dev/null
    echo "Running RetroGuard on minecraft-server.jar"
    java -jar runtime/retroguard.jar output/minecraft-server.jar output/minecraft-serverrg.jar configs/server.rgs output/retro.log > /dev/null
    rm output/minecraft-server.jar
    rm output/retro.log
    mv output/minecraft-serverrg.jar output/minecraft-server.jar
else
    echo "Skipping Server deobfuscating due to lack of jar."
fi

if [ -e output/minecraft-server.jar ] ; then
    echo "----- Decompiling Server -----"
    if [ -e output/server ] ; then
        rm -r output/server
    fi
    mkdir output/server
    mkdir output/server/src
    java -jar runtime/fernflower.jar -dgs=1 -das=0 -ren=0 output/minecraft-server.jar output/server/src > /dev/null
    unzip output/server/src/minecraft-server.jar -d output/server/src > /dev/null
    rm output/server/src/minecraft-server.jar
    rm output/minecraft-server.jar
    if [ -e output/server/src/null ] ; then
        rm output/server/src/null
    fi
    if [ -e output/server/src/META-INF ] ; then
        rm -r output/server/src/META-INF
    fi
    echo "Patching sources"
    cd output/server/src
    patch -p1 -i ../../../patches/cleanup-server.patch > /dev/null
    cd ..
else
    echo "Skipping Server decompiling due to lack of jar."
fi
