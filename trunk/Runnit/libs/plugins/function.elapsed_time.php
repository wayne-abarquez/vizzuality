<?php 
/* 
* Smarty plugin 
* ------------------------------------------------------------- 
* Type: function 
* Name: elapsed_time 
* Author:	 Goran Pilipovic fka bluesman 
* Purpose: print time pased since specific time 
* Example:	 {elapsed_time timestamp=$ts} 
* ------------------------------------------------------------- 
*/ 
function smarty_function_elapsed_time ($params, &$smarty) 
{ 
extract($params); 
if (empty($timestamp)) 
{ 
return ''; 
} 
if (empty($names)) 
{ 
$names = "day, hour, minute, few seconds"; 
} 

$n = explode (",",$names); 
if (count($n) < 4) 
{ 
$n = array ("day", "hour", "minute", "few seconds"); 
} 

$difference = time() - intval($timestamp); 

$days = floor($difference / (60 * 60 * 24)); 
$hours = floor($difference / (60 * 60)); 
$minutes = floor($difference / 60); 

$s = ""; 
$val = 0; 
if ($minutes > 0) 
{ 
$val = $minutes; 
$s = $n[2]; 
if ($hours > 0) 
{ 
$val = $hours; 
$s = $n[1]; 
if ($days > 0) 
{ 
$val = $days; 
$s = $n[0]; 
if ($days > 30) 
{ 
$val = "more than a month"; 
$s = $n[0]; 
} 
} 
} 
} 
else 
{ 
return $n[3]; 
} 

$rest = $val % 10; 
if ($s == $n[0]) 
{ 
$s = "day"; 
if ($rest > 1)	 { $s .= "s"; } 
} 

elseif ($s == $n[1])	
{ 
$s = "hour"; 
if ($rest > 1)	 { $s .= "s"; } 
} 

elseif ($s == $n[2]) 
{ 
$s = "minute"; 
if ($rest > 1)	 { $s .= "s"; } 
} 

if (!empty($assign)) 
{ 
$smarty->assign($assign, $difference); 
} 

return "{$val} {$s} ago"; 
} 