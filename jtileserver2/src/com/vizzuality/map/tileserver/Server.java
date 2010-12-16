/**
 * 
 */
package com.vizzuality.map.tileserver;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.URI;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.regex.Pattern;

import com.sun.net.httpserver.Headers;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;

/**
 * @author tim
 *
 */
public class Server implements HttpHandler {
	static Pattern queryParser = Pattern.compile("_");
	Manager manager = new Manager();
	PNGWriter pngWriter = new PNGWriter();
	
	public Server() {
		System.out.println("Server created");
	}
	
	public static void main(String[] args) {
		try {
			InetSocketAddress addr = new InetSocketAddress(Integer.parseInt(args[0]));
			HttpServer server = HttpServer.create(addr, 5);
			
			server.createContext("/tile", new Server());
			
			ExecutorService e = Executors.newCachedThreadPool();
			server.setExecutor(e);
			server.start();
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void handle(HttpExchange exchange) throws IOException {
		System.out.println("Received");
		
		exchange.getRequestMethod();
		long ts = System.currentTimeMillis();
		URI req = exchange.getRequestURI();
		String[] params = queryParser.split(req.getRawQuery());
		String x = params[0].replace("x=", "");
		String y = params[1].replace("y=", "");
		String z = params[2].replace("z=", "");
		//ts = ts("Params read in", ts);
		
		exchange.getRequestHeaders();
		exchange.getRequestBody().close();
		
		Headers responseHeaders = exchange.getResponseHeaders();
        responseHeaders.set("Content-Type", "image/png");
		//responseHeaders.set("Content-Type", "text/plain");
		
		
		List<TileCluster> data = manager.get(Integer.parseInt(x), Integer.parseInt(y), Integer.parseInt(z));
		//ts = ts("Data set up in", ts);
		//List<TileCluster> data = new LinkedList<TileCluster>();
		
		try {
			byte[] png = pngWriter.generate(data);
			exchange.sendResponseHeaders(200, png.length);
			OutputStream responseBody = exchange.getResponseBody();
			responseBody.write(png);
			responseBody.close();
		} catch (RuntimeException e) {
			e.printStackTrace();
		}
		ts = ts("PNG written in", ts);
        //injector.getBinding(arg0)
        
//        Headers requestHeaders = exchange.getRequestHeaders();
//        Set<String> keySet = requestHeaders.keySet();
//        Iterator<String> iter = keySet.iterator();
//        while (iter.hasNext()) {
//          String key = iter.next();
//          List<String> values = requestHeaders.get(key);
//          String s = key + " = " + values.toString() + "\n";
//          responseBody.write(s.getBytes());
//        }
		exchange.close();
	}
	
	public long ts(String message, long last) {
		System.out.println(message + ": " + (System.currentTimeMillis() - last));
		return System.currentTimeMillis();
	}
	
}
