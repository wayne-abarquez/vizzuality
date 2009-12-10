<?php




$conn = mysql_connect("localhost", "root", "root");
mysql_select_db('cormofitos', $conn);

$sql="
DROP TABLE IF EXISTS `cormofitos`.`utmcoords`;
CREATE TABLE  `cormofitos`.`utmcoords` (
  `utm` varchar(7) NOT NULL,
  `coords` varchar(200) default NULL,
  PRIMARY KEY  (`utm`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";

mysql_query($sql, $conn);

$root = simplexml_load_file("http://localhost/allutm10.kml");
//$data = get_object_vars($root);

$utm=array();
foreach ($root->children() as $child) {
	$data = get_object_vars($child);
	foreach($child->Placemark as $place) {
		$placeData = get_object_vars($place);
		$coordsData = get_object_vars($placeData['Polygon']->outerBoundaryIs->LinearRing);
		$sql="INSERT INTO utmcoords(utm,coords) VALUES('".$placeData['name']."','".$coordsData['coordinates']."');";
		mysql_query($sql, $conn);
		echo(".\n");	
	}
	 
	
}


?>