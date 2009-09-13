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

	function smarty_function_getDow($params, &$smarty) {
	    $day_number = $params['day_number'];
	    switch ($day_number) {
		    case '1':
		        $text = "Lunes";
		        break;
		    case '2':
		        $text = "Martes";
		        break;
		    case '3':
		        $text = "Miercoles";
		        break;
		    case '4':
		        $text = "Jueves";
		        break;
		    case '5':
		        $text = "Viernes";
		        break;
		    case '6':
		        $text = "Sabado";
		        break;
		    case '7':
		        $text = "Domingo";
		        break;
		}
	    return $text;
	}

	/* Comentario adicional by Javier, amo Smarty */

?>
