<?php
/*
 * Smarty plugin
 * ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ-
 * File:     function.getMonth2.php
 * Type:     function
 * Name:     getMonth
 * Purpose:  get month text
 * ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ-
 */

	function smarty_function_getParsedTime($params, &$smarty) {
	    $timeNotParsed = $params['time'];
	    $result = $params['result'];
	    
	    $hora=substr($timeNotParsed,0,2);
		$minutos=substr($timeNotParsed,3,2);
		$segundos=substr($timeNotParsed,6,2);
		$centesimas=substr($timeNotParsed,9,2);
		
	    switch ($result) {
		    case 'hora':
		        return $hora;
		    case 'minutos':
				return $minutos;
		    case 'segundos':
				return $segundos;	
		    case 'centesimas':
				return $centesimas;
		}
	    return false;
	}

	/* Comentario adicional by Jam, odio Smarty */

?>
