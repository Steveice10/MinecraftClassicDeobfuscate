#!/bin/bash
if [ -d output/src ] ; then
    echo "----- Recompiling Minecraft -----"
    if [ -e bin/minecraft ] ; then
        rm -r bin/minecraft
    fi
    mkdir bin
    mkdir bin/minecraft
    echo "Not implemented"
else
    echo "Skipping Minecraft recompiling due to lack of source."
fi

if [ -d output/womsrc ] ; then
    echo "----- Recompiling WOM -----"
    if [ -e bin/wom ] ; then
        rm -r bin/wom
    fi
    mkdir bin
    mkdir bin/wom
    echo "Not implemented"
else
    echo "Skipping WOM recompiling due to lack of source."
fi

if [ -e input/wom.jar ] ; then
    echo "----- Reobfuscating Minecraft -----"
    if [ -e reobf/minecraft.jar ] ; then
        rm reobf/minecraft.jar
    fi
    mkdir reobf
    echo "Not implemented"
else
    echo "Skipping Minecraft reobfuscating due to lack of source."
fi

if [ -e input/wom.jar ] ; then
    echo "----- Reobfuscating WOM -----"
    if [ -e reobf/wom.jar ] ; then
        rm reobf/wom.jar
    fi
    mkdir reobf
    echo "Not implemented"
else
    echo "Skipping WOM reobfuscating due to lack of source."
fi

