package com.vizzuality.gmba.process.raster;

import java.io.File;
import java.io.IOException;
import java.util.regex.Pattern;


public class ElevationReduce extends RasterReduce {
	// 24 requires -Xmx256m
	protected static final int tileSize = 256;
	protected static final Pattern tab = Pattern.compile("\t");
	
	public static void main(String[] args) throws IOException {
		run(new File("/tmp/env_z0_Sorted.txt"), 0);
		run(new File("/tmp/env_z1_Sorted.txt"), 1);
		run(new File("/tmp/env_z2_Sorted.txt"), 2);
		run(new File("/tmp/env_z3_Sorted.txt"), 3);
		run(new File("/tmp/env_z4_Sorted.txt"), 4);
		run(new File("/tmp/env_z5_Sorted.txt"), 5);
		run(new File("/tmp/env_z6_Sorted.txt"), 6);
		run(new File("/tmp/env_z7_Sorted.txt"), 7);
//		run(new File("/tmp/env_z8_Sorted.txt"), 8);
//		run(new File("/tmp/env_z9_Sorted.txt"), 9);
		System.exit(0);
	}

	protected static void assignColours(int[] pixels) {
		for (int i=0; i<pixels.length; i++) {
			if (pixels[i]<=100) {
				pixels[i]=0;
			} else if (pixels[i]<=300) {
				pixels[i] = 0x11FF0000; 
			} else if (pixels[i]<=600) {
				pixels[i] = 0x22FF0000; 
			} else if (pixels[i]<=900) {
				pixels[i] = 0x33FF0000; 
			} else if (pixels[i]<=1300) {
				pixels[i] = 0x44FF0000; 
			} else if (pixels[i]<=1800) {
				pixels[i] = 0x55FF0000; 
			} else if (pixels[i]<=2400) {
				pixels[i] = 0x66FF0000; 
			} else if (pixels[i]<=2800) {
				pixels[i] = 0x77FF0000; 
			} else if (pixels[i]<=3200) {
				pixels[i] = 0x88FF0000; 
			} else if (pixels[i]<=3600) {
				pixels[i] = 0x99FF0000; 
			} else if (pixels[i]<=4000) {
				pixels[i] = 0xAAFF0000; 
			} else if (pixels[i]<=4400) {
				pixels[i] = 0xBBFF0000; 
			} else if (pixels[i]<=4800) {
				pixels[i] = 0xCCFF0000; 
			} else if (pixels[i]<=5200) {
				pixels[i] = 0xDDFF0000; 
			} else if (pixels[i]<=5600) {
				pixels[i] = 0xEEFF0000; 
			} else if (pixels[i]>=5600) {
				pixels[i] = 0xFFFF0000; 
			}
		}
	}	
}
