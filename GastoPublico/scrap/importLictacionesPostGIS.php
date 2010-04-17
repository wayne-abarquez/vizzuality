<?php

$conn = pg_pconnect ("host=localhost dbname=gastopublico user=postgres password=");



$sql="DELETE FROM licitacion";
$result=pg_query($conn, $sql); 
$row = 0;
if (($handle = fopen("licitaciones.csv", "r")) !== FALSE) {
    while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
        $num = count($data);
        $row++;
        //print_r($data);
        $importe=$data[5];
        for ($c=0; $c < $num; $c++) {
            //echo $data[$c] . "<br />\n";
            $data[$c] ="'".pg_escape_string($data[$c])."'";
            if($data[$c]=="''") {
                $data[$c]="null";
            }
        }        
        
        //expediente,titulo_contrato,tipo_contrato,subtipo_contrato,estado,importe_ofertado,organo_contratacion,fecha_presentacion,fecha_adjudicacionprov,fecha_adjudicaciondef,organismo,nombre_adjudicatario,cif_adjudicatario,partido_politico,importe__adjudicado,url_organismo,url_contrataciondelestado,responsable_organismo,logo_organismo,tipo_administracion
        
        
        $sql="INSERT INTO licitacion(expediente,titulo,clase2,clase1,estado,importe,organismo,fecha1,fecha2,fecha3) VALUES({$data[0]},{$data[1]},{$data[2]},{$data[3]},{$data[4]},$importe,{$data[6]},{$data[7]},{$data[8]},{$data[9]})";
        
        $result=pg_query($conn, $sql);  
        echo(".");
        
    }
    fclose($handle);
}
?>