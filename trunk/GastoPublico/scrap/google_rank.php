<?php

require_once(dirname(__FILE__) . '/google.php');

$filename = 'strings.txt';
$myFile = "results.txt";
$fh = fopen($myFile, 'w');

$file_handle = fopen($filename, "r");
$count = 0;
while (!feof($file_handle)) 
{
	$line = fgets($file_handle);
	$parts = explode("\t", trim($line));

	$query = $parts[1];
	
	$r = google_top($query);
	
	//print_r($r);
	
	// analyse
	$counter = array();
	
	
	for ($i = 0; $i < 10; $i++)
	{
		if (isset($r->hits[$i]))
		{
			$h = $r->hits[$i];
			
			//print_r($h);
			if (isset($counter[$h->visibleUrl]))
			{
				$counter[$h->visibleUrl] = min($counter[$h->visibleUrl], $i);
			}
			else
			{
				$counter[$h->visibleUrl] = $i;	
			}
				
		}
	}
	
	print_r($parts[0]."\n");
	
	foreach ($counter as $k => $v)
	{
		$sql= "INSERT INTO gfrank(id, url, rank) VALUES (" . $parts[0] . ",\"" . $k . "\"," . $v . ");\n";
		fwrite($fh, $sql);
	}


}
fclose($file_handle);
fclose($fh);

?>