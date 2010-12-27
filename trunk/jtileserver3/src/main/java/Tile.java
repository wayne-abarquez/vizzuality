import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.zip.CRC32;
import java.util.zip.CheckedOutputStream;
import java.util.zip.Deflater;
import java.util.zip.DeflaterOutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * A simple PNG rendering Servlet that uses a manager to get the data 
 * @author tim
 */
public class Tile extends HttpServlet {
	private static final byte[] SIGNATURE = {(byte)137, 80, 78, 71, 13, 10, 26, 10};
    private static final int IHDR = (int)0x49484452;
    private static final int IDAT = (int)0x49444154;
    private static final int IEND = (int)0x49454E44;
    private static final byte COLOR_TRUECOLOR_ALPHA = 6;
    private static final byte COMPRESSION_DEFLATE = 0;
    private static final byte FILTER_NONE = 0;
    private static final byte INTERLACE_NONE = 0;
    
    // manager gets the data from the DB
	static Manager manager = new Manager();
    
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		resp.setStatus(200);
		resp.setHeader("Content-Type", "image/png");
		
		// arrays for the RGB and alpha channels
		byte[] r = new byte[256*256];
		byte[] g = new byte[256*256];
		byte[] b = new byte[256*256];
		byte[] a = new byte[256*256];
		
		//manager.getMock(req.getIntHeader("x"),req.getIntHeader("y"),req.getIntHeader("z"),r,g,b,a);
		
		int x= Integer.parseInt(req.getParameter("x"));
		int y= Integer.parseInt(req.getParameter("y"));
		int z= Integer.parseInt(req.getParameter("z"));
		
		manager.get(x,y,z,r,g,b,a);
		write(resp.getOutputStream(),r,g,b,a);
		resp.getOutputStream().close();
	}
	
    /**
     * Writes the PNG
     */
    public static void write(OutputStream os, byte[] r, byte[] g, byte[] b, byte[] a) throws IOException {
        DataOutputStream dos = new DataOutputStream(os);
        dos.write(SIGNATURE);
 
        Chunk cIHDR = new Chunk(IHDR);
        cIHDR.writeInt(256);
        cIHDR.writeInt(256);
        cIHDR.writeByte(8); // 8 bit per component
        cIHDR.writeByte(COLOR_TRUECOLOR_ALPHA);
        cIHDR.writeByte(COMPRESSION_DEFLATE);
        cIHDR.writeByte(FILTER_NONE);
        cIHDR.writeByte(INTERLACE_NONE);
        cIHDR.writeTo(dos);
 
        Chunk cIDAT = new Chunk(IDAT);
        DeflaterOutputStream dfos = new DeflaterOutputStream(cIDAT, new Deflater(Deflater.BEST_SPEED));
 
        int channels = 4;
        int lineLen = 256 * channels;
        byte[] lineOut = new byte[lineLen];
        
        for(int line=0 ; line<256 ; line++) {
        	for (int p=0;p<256;p++) {
        		// write the RGB+Transparency
        		lineOut[p*4 + 0] = r[(line*256)+p]; // & 0xff; // R
        		lineOut[p*4 + 1] = g[(line*256)+p]; // G
        		lineOut[p*4 + 2] = b[(line*256)+p]; // B
        		lineOut[p*4 + 3] = a[(line*256)+p]; // transparency
        		
//        		int color = data[(line*256)+p];
//        		lineOut[p*4 + 0] = (byte) ((color>>16) & 0xff); // R
//        		lineOut[p*4 + 1] = (byte) ((color>>8) & 0xff); 	// G
//        		lineOut[p*4 + 2] = (byte) (color & 0xff); 		// B
//        		lineOut[p*4 + 3] = (byte) ((color>>24) & 0xff);
        	}
        	
            dfos.write(FILTER_NONE);
            dfos.write(lineOut);
            
        }
        
        dfos.finish();
        try {
            cIDAT.writeTo(dos);
        } catch (IOException ex) {
            ex.printStackTrace();
        }
 
        Chunk cIEND = new Chunk(IEND);
        cIEND.writeTo(dos);
 
        dos.flush();
        dos.close();
    }
 
 
    static class Chunk extends DataOutputStream {
        final CRC32 crc;
        final ByteArrayOutputStream baos;
 
        Chunk(int chunkType) throws IOException {
            this(chunkType, new ByteArrayOutputStream(), new CRC32());
        }
        private Chunk(int chunkType, ByteArrayOutputStream baos,
                      CRC32 crc) throws IOException {
            super(new CheckedOutputStream(baos, crc));
            this.crc = crc;
            this.baos = baos;
 
            writeInt(chunkType);
        }
 
        public void writeTo(DataOutputStream out) throws IOException {
            flush();
            out.writeInt(baos.size() - 4);
            baos.writeTo(out);
            out.writeInt((int)crc.getValue());
        }
    }	
}
