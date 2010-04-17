<?php

$conn = pg_pconnect ("host=localhost dbname=gastopublico user=postgres password=");

$sql="DELETE FROM organismo";
$result=pg_query($conn, $sql); 
$row = 0;
if (($handle = fopen("organismos.csv", "r")) !== FALSE) {
    while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
        $num = count($data);
        $row++;
        //print_r($data);
        for ($c=0; $c < $num; $c++) {
            //echo $data[$c] . "<br />\n";
            $data[$c] =pg_escape_string($data[$c]);
        }        
        
        $sql="INSERT INTO organismo(org_contratante,nombre_admin,nombre_organo_contratacion,cif,idioma,contra_permalink,via,cp,poblacion,pais,tlf,fax,email) VALUES('{$data[0]}','{$data[1]}','{$data[2]}','{$data[3]}','{$data[4]}','{$data[7]}','{$data[8]}','{$data[9]}','{$data[10]}','{$data[11]}','{$data[12]}','{$data[13]}','{$data[14]}')";
        
        $result=pg_query($conn, $sql);  
        echo(".");
        
    }
    fclose($handle);
}
?>