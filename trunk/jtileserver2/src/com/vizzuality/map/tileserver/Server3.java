package com.vizzuality.map.tileserver;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.SocketAddress;
import java.util.List;
import java.util.concurrent.Callable;
import java.util.concurrent.CompletionService;
import java.util.concurrent.ExecutorCompletionService;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadPoolExecutor;

import org.simpleframework.http.Request;
import org.simpleframework.http.Response;
import org.simpleframework.http.core.Container;
import org.simpleframework.transport.connect.Connection;
import org.simpleframework.transport.connect.SocketConnection;

public class Server3 implements Container {
	CompletionService<Void> mapCompletionService;
	static Manager manager = new Manager();
	static PNGWriter pngWriter = new PNGWriter();

	public Server3(CompletionService<Void> mapCompletionService) {
		this.mapCompletionService = mapCompletionService;
	}
	
	public static void main(String[] args) {
		ThreadPoolExecutor mapExecutorService = (ThreadPoolExecutor)Executors.newFixedThreadPool(25);
		CompletionService<Void> mapCompletionService = new ExecutorCompletionService<Void>(mapExecutorService);
		Container container = new Server3(mapCompletionService);
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
	
	
	public static class Task implements Callable<Void> {
		private final Response response;
		private final Request request;
		public Task(Request request, Response response) {
			this.response = response;
			this.request = request;
		}

		@Override
		public Void call() throws Exception {
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
			return null;  
		}
		
	}
	
	public void handle(Request request, Response response) {
		Callable<Void> t = new Task(request, response);
		mapCompletionService.submit(t);
	}
}
