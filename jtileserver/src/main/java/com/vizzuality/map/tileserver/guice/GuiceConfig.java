package com.vizzuality.map.tileserver.guice;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import com.google.inject.Guice;
import com.google.inject.Injector;
import com.google.inject.Provides;
import com.google.inject.Scopes;
import com.google.inject.Singleton;
import com.google.inject.servlet.GuiceServletContextListener;
import com.google.inject.servlet.ServletModule;
import com.sun.jersey.guice.spi.container.servlet.GuiceContainer;
import com.vizzuality.map.tileserver.TileResource;
import com.vizzuality.map.tileserver.service.TileManager;
import com.vizzuality.map.tileserver.service.impl.TileManagerImpl;
import com.vizzuality.map.tileserver.util.JSONWriter;
import com.vizzuality.map.tileserver.util.PNGWriter;

public class GuiceConfig extends GuiceServletContextListener {

	@Override
	protected Injector getInjector() {
		return Guice.createInjector(new ServletModule() {

			@Override
			protected void configureServlets() {
				bind(TileResource.class);
				bind(JSONWriter.class).in(Scopes.SINGLETON);
				bind(PNGWriter.class).in(Scopes.SINGLETON);
				bind(TileManager.class).to(
						TileManagerImpl.class).in(Scopes.SINGLETON);
				serve("/*").with(GuiceContainer.class);
			}

			@Provides
			@Singleton
			public SqlSessionFactory provideSqlSessionFactory() throws IOException {
				// setup the iBatis ORM
				// this might not be the optimal way of doing this, but basically the session factory is
				// injected into each manager (basemanager) and the config is read once only here
				Reader reader = Resources
						.getResourceAsReader("ibatis-config.xml");
				return new SqlSessionFactoryBuilder().build(reader);
			}

		});
	}
}
