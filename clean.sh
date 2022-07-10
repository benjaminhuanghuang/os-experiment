   
   
# recursively remove all .exe
find . -name "*.o" -exec rm -rf '{}' \;
find . -name "*.exe" -exec rm -rf '{}' \;
find . -name "*.bin" -exec rm -rf '{}' \;
#
find . -name "*.img" -exec rm -rf '{}' \;
