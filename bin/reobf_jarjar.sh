#!/bin/bash
echo "Running JarJar on minecraft.jar"
java -jar jarjar-1.1.jar process ../output/reversejarjar.rules ../output/minecraft.jar ../output/minecraft_reobf.jar
