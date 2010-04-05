# process the density tiles
#java -Xmx256m -classpath /Users/tim/dev/workspace/GMBA/webapp/WEB-INF/classes com.vizzuality.gmba.process.tiles.DensityPrepare /Users/tim/dev/gmba/tim_lat_lng_cnt.txt /tmp/density.txt 0 1 13 2
#sort /tmp/density.txt -o /tmp/density_sorted.txt
#java -Xmx256m -classpath /Users/tim/dev/workspace/GMBA/webapp/WEB-INF/classes com.vizzuality.gmba.process.tiles.DensityRender /tmp/density_sorted.txt /tmp/density
# process the environment data tiles
# java -Xmx256m -classpath /Users/tim/dev/workspace/GMBA/webapp/WEB-INF/classes com.vizzuality.gmba.process.tiles.RasterPrepare /Users/tim/dev/gmba/env.txt /tmp env 7 1 2 3 4 9
echo "Sorting Z0"
sort /tmp/env_z0.txt -o /tmp/env_z0_sorted.txt
echo "Sorting Z1"
sort /tmp/env_z1.txt -o /tmp/env_z1_sorted.txt 
echo "Sorting Z2"
sort /tmp/env_z2.txt -o /tmp/env_z2_sorted.txt
echo "Sorting Z3"
sort /tmp/env_z3.txt -o /tmp/env_z3_sorted.txt
echo "Sorting Z4"
sort /tmp/env_z4.txt -o /tmp/env_z4_sorted.txt
echo "Sorting Z5"
sort /tmp/env_z5.txt -o /tmp/env_z5_sorted.txt
echo "Sorting Z6"
sort /tmp/env_z6.txt -o /tmp/env_z6_sorted.txt
echo "Sorting Z7"
sort /tmp/env_z7.txt -o /tmp/env_z7_sorted.txt
java -Xmx256m -classpath /Users/tim/dev/workspace/GMBA/webapp/WEB-INF/classes com.vizzuality.gmba.process.tiles.RasterRender /tmp env _sorted.txt /tmp/env 7 7889 3397


