<?php

require_once(dirname(__FILE__) . '/config.inc.php');

/**
 * @brief Return top 12 hits in Google using AJAX API
 *
 * http://code.google.com/apis/ajaxsearch/documentation/#fonje
 *
 */ 
function google_top($query)
{
	global $config;
	
	$obj = new stdclass;
	$obj->hits = array();
	$obj->count = 0;
	
	$q = str_replace(' ', '%20', $query);
	
	$ch = curl_init(); 
	curl_setopt ($ch, CURLOPT_RETURNTRANSFER, 1); 
	curl_setopt ($ch ,CURLOPT_REFERER, 'http://ispecies.org'); 
	if ($config['proxy_name'] != '')
	{
		curl_setopt ($ch, CURLOPT_PROXY, $config['proxy_name'] . ':' . $config['proxy_port']);
	}
	
	
	$start = 1;
	while ($start < 10)
	{
	
		$url = 'http://ajax.googleapis.com/ajax/services/search/web?v=1.0&q=' . $q . '&start=1&language=es';
		curl_setopt($ch, CURLOPT_URL, $url); 
	
		$json=curl_exec ($ch); 
		
		$h = json_decode($json);
		
		//print_r($h);
		
		foreach ($h->responseData->results as $hit)
		{
			array_push ($obj->hits, $hit);
		}
		
		$obj->count = $h->responseData->cursor->estimatedResultCount;
		
		if( curl_errno ($ch) != 0 )
		{
		}
	
		$start += 4;
	}
	
	curl_close ($ch); 
	
	return $obj;
}

?>



