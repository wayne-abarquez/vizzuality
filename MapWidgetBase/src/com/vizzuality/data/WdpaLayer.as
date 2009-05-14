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
				all:					"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_all_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				national:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_national_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				international:			"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_international_marine/MapServer/tile/|Z|/|Y|/|X|.png",
		//		marine_international:	"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_international_all/MapServer/tile/|Z|/|Y|/|X|.png",
		//		marine_national:		"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_international_all/MapServer/tile/|Z|/|Y|/|X|.png",
				iucn_Ia:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_national_Ia_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				iucn_Ib:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_national_Ib_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				iucn_II:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_national_II_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				iucn_III:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_national_III_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				iucn_IV:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_national_IV_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				iucn_V:					"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_national_V_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				iucn_VI:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_national_VI_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				iucn_unknown:			"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_national_Unknown_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				con_heritage:			"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_international_WHC_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				con_ramsar:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_international_RAMSAR_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				con_unesco:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_international_MAB_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				con_other:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_international_Others_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				mangrove:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/mangrove/MapServer/tile/|Z|/|Y|/|X|.png",
				coral:					"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/coral/MapServer/tile/|Z|/|Y|/|X|.png",
				seagrass:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/seagrass/MapServer/tile/|Z|/|Y|/|X|.png",
				cold_walter_coral:		"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/cold_water_coral/MapServer/tile/|Z|/|Y|/|X|.png",
				pa_border:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_international_all/MapServer/tile/|Z|/|Y|/|X|.png",
				country_per_areas:		"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/country_per_areas_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				country_per_coverage:	"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/country_per_coverage_marine/MapServer/tile/|Z|/|Y|/|X|.png"
			};
		public static const DYNAMIC_LAYERS:Object = {
				all:					"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_all_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				national:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_national_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				international:			"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_international_marine/MapServer/tile/|Z|/|Y|/|X|.png",
		//		marine_international:	"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_international_all/MapServer/tile/|Z|/|Y|/|X|.png",
		//		marine_national:		"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_international_all/MapServer/tile/|Z|/|Y|/|X|.png",
				iucn_Ia:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_national_Ia_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				iucn_Ib:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_national_Ib_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				iucn_II:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_national_II_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				iucn_III:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_national_III_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				iucn_IV:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_national_IV_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				iucn_V:					"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_national_V_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				iucn_VI:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_national_VI_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				iucn_unknown:			"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_national_Unknown_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				con_heritage:			"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_international_WHC_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				con_ramsar:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_international_RAMSAR_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				con_unesco:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_international_MAB_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				con_other:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_international_Others_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				mangrove:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/mangrove/MapServer/tile/|Z|/|Y|/|X|.png",
				coral:					"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/coral/MapServer/tile/|Z|/|Y|/|X|.png",
				seagrass:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/seagrass/MapServer/tile/|Z|/|Y|/|X|.png",
				cold_walter_coral:		"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/cold_water_coral/MapServer/tile/|Z|/|Y|/|X|.png",
				pa_border:				"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/wdpa_international_all/MapServer/tile/|Z|/|Y|/|X|.png",
				country_per_areas:		"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/country_per_areas_marine/MapServer/tile/|Z|/|Y|/|X|.png",
				country_per_coverage:	"http://maps.unep-wcmc.org/ArcGIS/rest/services/WDPAv2_0/country_per_coverage_marine/MapServer/tile/|Z|/|Y|/|X|.png"
			};			
	}
}