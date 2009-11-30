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

	function smarty_function_getMonth2($params, &$smarty) {
	    $month = $params['month'];
	    switch ($month) {
		    case '01':
		        $text = "Enero";
		        break;
		    case '02':
		        $text = "Febrero";
		        break;
		    case '03':
		        $text = "Marzo";
		        break;
		    case '04':
		        $text = "Abril";
		        break;
		    case '05':
		        $text = "Mayo";
		        break;
		    case '06':
		        $text = "Junio";
		        break;
		    case '07':
		        $text = "Julio";
		        break;
		    case '08':
		        $text = "Agosto";
		        break;
		    case '09':
		        $text = "Septiembre";
		        break;
		    case '10':
		        $text = "Octubre";
		        break;
		    case '11':
		        $text = "Noviembre";
		        break;
		    case '12':
		        $text = "Diciembre";
		        break;
		}
	    return $text;
	}

	/* Comentario adicional by Jam, odio Smarty */

?>
