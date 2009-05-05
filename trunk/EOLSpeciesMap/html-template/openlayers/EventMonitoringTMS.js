/**
 * @requires OpenLayers/Layer/TMS.js
 */

/**
 * Class: iBiodiversity.Layer.EventMonitoringTMS
 *
 * Overrides the addTileMonitoringHooks 
 * 
 * Inherits from:
 *  - <OpenLayers.Layer.TMS>
 */

EventMonitoringTMS = OpenLayers.Class(OpenLayers.Layer.TMS, {
	
	tiles: [],
    
    /**
     * Constructor: EventMonitoringTMS
     * 
     * Parameters:
     * name - {String}
     * url - {String}
     * options - {Object} Hashtable of extra options to tag onto the layer
     */
    initialize: function(name, url, options) {
        var newArguments = [];
        newArguments.push(name, url, options);
        OpenLayers.Layer.TMS.prototype.initialize.apply(this, newArguments);
    },    

    /** 
     * Method: addTileMonitoringHooks
     * This function takes a tile as input and adds the appropriate hooks to 
     *     the tile so that the layer can keep track of the loading tiles.
     * 
     * Parameters: 
     * tile - {<OpenLayers.Tile>}
     */
    addTileMonitoringHooks: function(tile) {
        OpenLayers.Layer.TMS.prototype.addTileMonitoringHooks.apply(this, [tile]);
        this.tiles.push(tile);
    },


    CLASS_NAME: "EventMonitoringTMS"
});
