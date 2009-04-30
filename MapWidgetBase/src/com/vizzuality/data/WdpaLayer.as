package com.vizzuality.data
{
	public final class WdpaLayer
	{
		public static const ALL:String="all";
		public static const NATIONAL:String="national";
		public static const INTERNATIONAL:String="international";
		public static const MARINE_INTERNATIONAL:String="marine_international";
		public static const MARINE_NATIONAL:String="marine_national";
		public static const IUCN_IA:String="iucn_Ia";
		public static const IUCN_IB:String="iucn_Ib";
		public static const IUCN_II:String="iucn_II";
		public static const IUCN_III:String="iucn_III";
		public static const IUCN_IV:String="iucn_IV";
		public static const IUCN_V:String="iucn_V";
		public static const IUCN_VI:String="iucn_VI";
		public static const IUCN_UNKNOWN:String="iucn_unknown";
		public static const CON_HERITAGE:String="con_heritage";
		public static const CON_RAMSAR:String="con_ramsar";
		public static const CON_UNESCO:String="con_unesco";
		public static const CON_OTHER:String="con_other";
		public static const MANGROVE:String="mangrove";
		public static const CORAL:String="coral";
		public static const SEAGRASS:String="seagrass";
		public static const COLD_WALTER_CORAL:String="cold_walter_coral";
		public static const PA_BORDER:String="pa_border";
		public static const COUNTRY_PER_AREAS:String="country_per_areas";
		public static const COUNTRY_PER_COVERAGE:String="country_per_coverage";
		public static const NONE:String="none";
		//public static const COUNTRY_PA_ONLY:String="country_border";
		
		public static const STATIC_LAYERS:Object = {
				all:					"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_all/MapServer/tile/|Z|/|Y|/|X|.png",
				national:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/WDPA_National_All/MapServer/tile/|Z|/|Y|/|X|.png",
				international:			"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/WDPA_International_All/MapServer/tile/|Z|/|Y|/|X|.png",
				marine_international:	"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				marine_national:		"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				iucn_Ia:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				iucn_Ib:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				iucn_II:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				iucn_III:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				iucn_IV:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				iucn_V:					"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				iucn_VI:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				iucn_unknown:			"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				con_heritage:			"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				con_ramsar:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				con_unesco:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				con_other:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				mangrove:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				coral:					"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				seagrass:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				cold_walter_coral:		"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				pa_border:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				country_per_areas:		"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				country_per_coverage:	"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png"
			};
		public static const DYNAMIC_LAYERS:Object = {
				all:					"http://geowebcache|N|.gbif.org/service/gmaps?layers=gbif%3Apolygon&zoom=|Z|&x=|X|&y=|Y|",
				national:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				international:			"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				marine_international:	"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				marine_national:		"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				iucn_Ia:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				iucn_Ib:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				iucn_II:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				iucn_III:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				iucn_IV:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				iucn_V:					"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				iucn_VI:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				iucn_unknown:			"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				con_heritage:			"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				con_ramsar:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				con_unesco:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				con_other:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				mangrove:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				coral:					"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				seagrass:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				cold_walter_coral:		"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				pa_border:				"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				country_per_areas:		"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png",
				country_per_coverage:	"http://dkshzq8b2nyc7.cloudfront.net/|X|_|Y|_|Z|_13839800.png"				
			};			
	}
}