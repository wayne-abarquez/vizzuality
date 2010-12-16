package com.vizzuality.map.tileserver;

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
			   
			   List<TileCluster> data = manager.get(x,y,z);
			   byte[] png = pngWriter.generate(data);
			   response.set("Content-Length", png.length);
			   OutputStream responseBody = response.getOutputStream();
			   responseBody.write(png);
			   responseBody.close();
		   } catch (IOException e) {
			   e.printStackTrace();
		   }
	   }
}
