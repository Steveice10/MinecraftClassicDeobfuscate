#!/bin/bash
echo "Running JarJar on minecraft.jar"
java -jar jarjar-1.1.jar process ../configs/jarjardecomp.rules ../input/minecraft.jar ../output/minecraft.jar
echo "Running RetroGuard on minecraft.jar"
java -jar retroguard.jar ../output/minecraft.jar ../output/minecraftrg.jar ../configs/retroguard.rgs ../output/retro.log
rm ../output/minecraft.jar
rm ../output/retro.log
mv ../output/minecraftrg.jar ../output/minecraft.jar
echo "Done!"
if test -a ../input/wom.jar ; then
    echo "Running JarJar on wom.jar"
    java -jar jarjar-1.1.jar process ../configs/jarjardecomp.rules ../input/wom.jar ../output/wom.jar
    echo "Running RetroGuard on wom.jar"
    java -jar retroguard.jar ../output/wom.jar ../output/womrg.jar ../configs/retroguard.rgs ../output/retro.log
    rm ../output/wom.jar
    rm ../output/retro.log
    mv ../output/womrg.jar ../output/wom.jar
fi
