package com.vizzuality.gmba.process.raster;

import java.io.File;
import java.io.IOException;
import java.util.regex.Pattern;


public class ReliefReduce extends RasterReduce {
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
			//System.out.println(pixels[i]);
			int color =(int)( pixels[i] * (double)0xFF / 3397);
			color = 0xFFFF00FF | (color<<8);
			pixels[i]=color;

		}
	}	
}
