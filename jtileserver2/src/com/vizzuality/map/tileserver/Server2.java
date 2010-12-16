package com.vizzuality.map.tileserver;

import java.awt.Color;
import java.awt.Transparency;
import java.awt.image.BufferedImage;
import java.awt.image.WritableRaster;
import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.SocketAddress;
import java.util.List;

import org.simpleframework.http.Request;
import org.simpleframework.http.Response;
import org.simpleframework.http.core.Container;
import org.simpleframework.transport.connect.Connection;
import org.simpleframework.transport.connect.SocketConnection;

public class Server2 implements Container {
	Manager manager = new Manager();
	PNGWriter pngWriter = new PNGWriter();
	
	public static void main(String[] args) {
		Container container = new Server2();
		try {
			Connection connection = new SocketConnection(container);
			SocketAddress address = new InetSocketAddress(Integer.parseInt(args[0]));
			connection.connect(address);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	   public void handle(Request request, Response response) {
		   try {
			   int x = Integer.parseInt(request.getParameter("x"));
			   int y = Integer.parseInt(request.getParameter("y"));
			   int z = Integer.parseInt(request.getParameter("z"));
			   
			   response.set("Content-Type", "image/png");
			   
			   int[] rasterData = new int[256*256];
			   manager.get(x,y,z, rasterData);
				BufferedImage bufferedImage = new BufferedImage(256, 256, Transparency.TRANSLUCENT);
				WritableRaster raster = bufferedImage.getWritableTile(0,0);
				raster.setDataElements(0, 0, 256,256, rasterData);
				PngEncoderB encoder = new PngEncoderB(bufferedImage, true, 0, 9);
				byte[] png = encoder.pngEncode();
			   
			   response.set("Content-Length", png.length);
			   OutputStream responseBody = response.getOutputStream();
			   responseBody.write(png);
			   responseBody.close();
		   } catch (IOException e) {
			   e.printStackTrace();
		   }
	   }
	   
		// because Colors are cached internally in Java, we save MUCH time creating them first
		// and stopping their garbage collection (300msec to create a color on macbook pro)
		protected static final Color[] colors = {
			new Color(0xFF, 0x66, 0x66),
			new Color(0x00, 0x00, 0x00),
			new Color(0x1A, 0x1A, 0x1A),
			new Color(0x55, 0x22, 0x22),
			new Color(0xAA, 0x44, 0x44),
			new Color(0xCC, 0x55, 0x55)
		};
	 
		// the colors that are actually used (internally, Java will pick up a cached color from the 
		// above cache)
		protected static final int[] colorsAsInt = {
			0xFFFF6666,
			0xFF000000,
			0xFF1A1A1A,
			0xFF552222,
			0xFFAA4444,
			0xFFCC5555		
		};
	   
}
