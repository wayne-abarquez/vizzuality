package com.vizzuality.map.tileserver;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.SocketAddress;
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

public class Server4 implements Container {
	CompletionService mapCompletionService;
	
	public Server4(CompletionService mapCompletionService) {
		this.mapCompletionService = mapCompletionService;
	}

	public static void main(String[] args) {
		ThreadPoolExecutor mapExecutorService = (ThreadPoolExecutor)Executors.newFixedThreadPool(100);
		CompletionService mapCompletionService = new ExecutorCompletionService(mapExecutorService);
		
		Container container = new Server4(mapCompletionService);
		try {
			Connection connection = new SocketConnection(container);
			SocketAddress address = new InetSocketAddress(Integer.parseInt(args[0]));
			connection.connect(address);
		} catch (NumberFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
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
	    	  System.out.println("Task running");
	    	  response.set("Content-Type", "text/plain");
	    	  response.set("Content-Length", "1");
	    	  try {
				OutputStream os = response.getOutputStream();
				  os.write("B".getBytes());
				  os.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			return null;
		}
	   } 

	   public void handle(Request request, Response response) {
		   System.out.println("Handling");
	      Task task = new Task(request, response);
	      mapCompletionService.submit(task);
	   }
}
