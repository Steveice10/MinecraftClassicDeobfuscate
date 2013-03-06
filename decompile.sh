#!/bin/bash
if [ -e input/minecraft.jar ] ; then
    echo "----- Deobfuscating Minecraft -----"
    echo "Running JarJar on minecraft.jar"
    java -jar runtime/jarjar-1.1.jar process configs/jarjardecomp.rules input/minecraft.jar output/minecraft.jar > /dev/null
    echo "Running RetroGuard on minecraft.jar"
    java -jar runtime/retroguard.jar output/minecraft.jar output/minecraftrg.jar configs/retroguard.rgs output/retro.log > /dev/null
    rm output/minecraft.jar
    rm output/retro.log
    mv output/minecraftrg.jar output/minecraft.jar
else
    echo "Skipping Minecraft deobfuscating due to lack of jar."
fi

if [ -e input/wom.jar ] ; then
    echo "----- Deobfuscating WOM -----"
    echo "Running JarJar on wom.jar"
    java -jar runtime/jarjar-1.1.jar process configs/jarjardecomp.rules input/wom.jar output/wom.jar > /dev/null
    echo "Running RetroGuard on wom.jar"
    java -jar runtime/retroguard.jar output/wom.jar output/womrg.jar configs/retroguard.rgs output/retro.log > /dev/null
    rm output/wom.jar
    rm output/retro.log
    mv output/womrg.jar output/wom.jar
else
    echo "Skipping WOM deobfuscating due to lack of jar."
fi

if [ -e output/minecraft.jar ] ; then
    echo "----- Decompiling Minecraft -----"
    if [ -e output/src ] ; then
        rm -r output/src
    fi
    mkdir output/src
    java -jar runtime/fernflower.jar -dgs=1 -das=0 -ren=0 output/minecraft.jar output/src > /dev/null
    unzip output/src/minecraft.jar -d output/src > /dev/null
    rm output/src/minecraft.jar
    if [ -e output/src/null ] ; then
        rm output/src/null
    fi
    rm -r output/src/META-INF
    echo "Patching sources"
    cd output/src
    patch -p1 -i ../../patches/cleanup-mc.patch > /dev/null
    cd ..
else
    echo "Skipping Minecraft decompiling due to lack of jar."
fi

if [ -e output/wom.jar ] ; then
    echo "----- Decompiling WOM -----"
    if [ -e output/src ] ; then
        rm -r output/womsrc
    fi
    mkdir output/womsrc
    java -jar runtime/fernflower.jar -dgs=1 -das=0 -ren=0 output/wom.jar output/womsrc > /dev/null
    unzip output/womsrc/wom.jar -d output/womsrc > /dev/null
    rm output/womsrc/wom.jar
    if [ -e output/src/null ] ; then
        rm output/src/null
    fi
    rm -r output/src/META-INF
    echo "Patching sources"
    cd output/womsrc
    #patch -p1 -i ../../patches/cleanup-wom.patch > /dev/null
    cd ..
    echo "WOM patch not created yet."
else
    echo "Skipping WOM decompiling due to lack of jar."
fi

