package util;
import java.awt.Transparency;
import java.awt.image.BufferedImage;
import java.awt.image.WritableRaster;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.util.regex.Pattern;

/**
 * Takes some input text files and renders some PNGS
 * @author tim
 */
public class RenderTiles {
        protected static Pattern tab = Pattern.compile("\t");
        
        protected static final int tileSize = 256;
        
        /**
         * @param args InFile OutFile
         */
        public static void main(String[] args) {
            if (args.length!= 1) {
                    System.out.println("Usage: RenderTiles indirectory");
            }
            for (int z=0; z<=8; z++) {
            	render(args[0], z);
            }
        }
                
        public static void render(String path, int zoom) {
                BufferedReader br = null;
                int zoomLookAhead=6;
                try {
                		//int zoom = 1;
                        br = new BufferedReader(new FileReader(path + "/z" + zoom + ".txt"));
                        
                        int pixelsPerCell = tileSize / (2<<(zoomLookAhead-1));
                        int[] rasterData = new int[tileSize*tileSize];
                        
                        
                        String line = br.readLine();
                        
                        // watch for the tile change
                        int gx = 0;
                        int gy = 0;
                        boolean first = true;
                        while (line != null) {
                        	
                        	
                        	
                            String[] atoms = tab.split(line); 
                            // x,y,year
                            int x = Integer.parseInt(atoms[2]);
                            int y = Integer.parseInt(atoms[3]);
                            
                            // tile change
                            boolean change=false;
                            if (gx!=Integer.parseInt(atoms[0])) {
                            	change=true;
                            }
                            if (gy!=Integer.parseInt(atoms[1])) {
                            	change=true;
                            }
                            
                            //System.out.println(gx + ":" + gy);
                            
                            // new tile, write the last
                            if (change && !first) {
                            	
	                            BufferedImage bufferedImage = new BufferedImage(tileSize, tileSize, Transparency.TRANSLUCENT);
	                            WritableRaster raster = bufferedImage.getWritableTile(0,0);
	                            raster.setDataElements(0, 0, tileSize,tileSize, rasterData);
	                            PngEncoderB encoder = new PngEncoderB(bufferedImage, true, 0, 9);
	                            byte[] png = encoder.pngEncode();
	                            
	                            File f = new File(path + "/tiles/" + zoom + "/" + gx + "/");
	                            if (!f.exists())
	                            	f.mkdirs();
	                            FileOutputStream out = new FileOutputStream(path+ "/tiles/" + zoom + "/" + gx + "/" + gy + ".png");
	                            System.out.println("Writing: " + path + "/tiles/" + zoom + "/" + gx + "/" + gy + ".png");
	                            out.write(png);
	                            out.flush();
	                            rasterData = new int[tileSize*tileSize];
	                            gx=Integer.parseInt(atoms[0]);
	                            gy=Integer.parseInt(atoms[1]);
                            }
                            
                            first=false;
                            
                            
                            // year is kinda offset to a 0-255 representation already
                            int year = Integer.parseInt(atoms[4]);
                            
                            
                            // get the pixel offset for the X,Y in this tile
                            int offsetX = getTileOffset(x, zoomLookAhead, pixelsPerCell);
                            int offsetY = getTileOffset(y, zoomLookAhead, pixelsPerCell);
                            
                            int cellStart = (offsetY*tileSize)+(offsetX);
                            
                            // for the number of rows in the cell
                            for (int i=0; i<pixelsPerCell; i++) {
                                    //System.out.println("  drawing row");
                                    // draw the cells
                                    for (int j=cellStart; j<cellStart+pixelsPerCell; j++) {
                                            //System.out.println("    drawing column j[" + j + "]");
                                            rasterData[j] = year;
                                            int col = (255<<24)|(year<<16)|(year<<8)|year;  
                                            rasterData[j] =  col;
                                    }
                                    cellStart+=tileSize;
                            }   
                            line = br.readLine();
                        }
                        
                        // write the last
                        BufferedImage bufferedImage = new BufferedImage(tileSize, tileSize, Transparency.TRANSLUCENT);
                        WritableRaster raster = bufferedImage.getWritableTile(0,0);
                        raster.setDataElements(0, 0, tileSize,tileSize, rasterData);
                        PngEncoderB encoder = new PngEncoderB(bufferedImage, true, 0, 9);
                        byte[] png = encoder.pngEncode();
                        
                        File f = new File(path + "/tiles/" + zoom + "/" + gx + "/");
                        if (!f.exists())
                        	f.mkdirs();
                        System.out.println("Writing: " + path + "/tiles/" + zoom + "/" + gx + "/" + gy + ".png");
                        FileOutputStream out = new FileOutputStream(path + "/tiles/" + zoom + "/" + gx + "/" + gy + ".png");                        
                        out.write(png);
                        out.flush();
                        first=false;
                        
                        
                } catch (Exception e) {
                        e.printStackTrace();
                }
        }
        
        
        // works out the pixel offset for the top left corner of the cell
        // within the tile being rendered
        protected static int getTileOffset(int x, int zoomLookAhead, int pixelsPerCell) {
                //System.out.println("2<<" +(zoomLookAhead-1) + "=" +  (2<<zoomLookAhead-1));
                int cellIdInTile = x % (2<<zoomLookAhead-1);
                //System.out.println("cellIdInTile: " + cellIdInTile);
                return cellIdInTile * pixelsPerCell;
        }        
}