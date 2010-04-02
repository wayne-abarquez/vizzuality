package com.vizzuality.gmba.process.raster;

public class Delme {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		int color =(int)( 3397 * 255 / 3397);
		System.out.println(color);
		System.out.println(color << 8);
		color = 0xFF00FF | (color << 8);
		System.out.println(color);
		
		color = 0xFFFFFF;
		System.out.println(color);
		
		
		
		System.out.println(1 << 9);
		int b=0;
		for (int j=0; j<9; j++) {
			b+=0xf;
		}	
		System.out.println(b);
		


	}

}
