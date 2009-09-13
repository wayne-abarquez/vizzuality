<?php
/*
 * Smarty plugin
 * ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ-
 * File:     function.getMonth.php
 * Type:     function
 * Name:     getMonth
 * Purpose:  get month text
 * ÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑÑ-
 */

	function smarty_function_getMonth($params, &$smarty) {
	    $month = $params['month'];
	    switch ($month) {
		    case '01':
		        $text = "ENE";
		        break;
		    case '02':
		        $text = "FEB";
		        break;
		    case '03':
		        $text = "MAR";
		        break;
		    case '04':
		        $text = "ABR";
		        break;
		    case '05':
		        $text = "MAY";
		        break;
		    case '06':
		        $text = "JUN";
		        break;
		    case '07':
		        $text = "JUL";
		        break;
		    case '08':
		        $text = "AGO";
		        break;
		    case '09':
		        $text = "SEP";
		        break;
		    case '10':
		        $text = "OCT";
		        break;
		    case '11':
		        $text = "NOV";
		        break;
		    case '12':
		        $text = "DIC";
		        break;
		}
	    return $text;
	}

	/* Comentario adicional by Jam, odio Smarty */

?>
