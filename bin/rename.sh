#!/bin/bash
echo "Running JarJar on minecraft.jar"
java -jar jarjar-1.1.jar process ../configs/jarjardecomp.rules ../input/minecraft.jar ../output/minecraft.jar
echo "Running RetroGuard on minecraft.jar"
java -jar retroguard.jar ../output/minecraft.jar ../output/minecraftrg.jar ../configs/retroguard.rgs ../output/retro.log
rm ../output/minecraftrg.jar
rm ../output/retro.log
echo "Done!"
if test -a ../input/wom.jar ; then
echo "Running JarJar on wom.jar"
java -jar jarjar-1.1.jar process ../configs/jarjardecomp.rules ../input/wom.jar ../output/wom.jar
#echo "Running RetroGuard on wom.jar"
#java -cp .:retroguard.jar:../output/minecraft.jar:../output/womjj.jar -jar retroguard.jar ../output/womjj.jar ../output/wom.jar ../configs/retroguard.rgs ../output/retro_wom.log
fi
