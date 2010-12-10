package com.vizzuality.map.tileserver;

import java.util.Collection;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;


import com.google.inject.Inject;
import com.google.inject.servlet.RequestScoped;
import com.vizzuality.map.tileserver.model.TileCluster;
import com.vizzuality.map.tileserver.service.TileManager;

@Path("/tile")
@RequestScoped
public class TileResource {
	@QueryParam("tileX") int tileX;
	@QueryParam("tileY") int tileY;
	@QueryParam("zoom") int zoom;

	@Inject
	TileManager tileManager;
	
	// TODO, perhaps we want a .json extension?
	// not sure how to implement so use /json for now
	@GET
	@Path("/json")
    @Produces({MediaType.APPLICATION_JSON})
    public Collection<TileCluster> get() {
		return tileManager.get(tileX, tileY, zoom);
    }
	
	@GET
    @Produces({"image/png"})
    public Collection<TileCluster> getImage() {
		return tileManager.get(tileX, tileY, zoom);
    }
}
