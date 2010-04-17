<?php

require_once($_SERVER['DOCUMENT_ROOT'] ."/config.php");
class GastoPublico {
	
	function __construct() {
	    $this->conn = pg_pconnect ("host=".DB_HOST." dbname=".DB_NAME." user=".DB_USER." password=".DB_PASSWORD);
	
		$this->emailPassword=EMAILPASSWORD;
		$this->basePath=ABSPATH;
	}

    function getGeneralStats() {
        $sql="select rd.id, distance_name,time_taken from record_distance as rd left join users_records as ur on rd.id=ur.record_distance_fk and ur.user_fk=$id order by distance ASC";
	    return pg_fetch_all(pg_query($this->conn, $sql));
    }


    function getFeaturedLicitaciones() {
        $sql="select l.id as licitacion_id, o.id as organismo_id,titulo,importe,fecha1,fecha2,fecha3,votes_up,votes_down,num_comentarios,o.nombre_admin,o.org_contratante FROM licitacion as l inner join organismo as o on l.organismo_fk= o.id ORDER BY importe DESC LIMIT 3";
	    return pg_fetch_all(pg_query($this->conn, $sql));        
    }
    
    function getFeaturedOrganismos() {
        $sql="select count(l.id) as num_licitaciones, o.id as organismo_id, o.nombre_admin,o.org_contratante FROM licitacion as l inner join organismo as o on l.organismo_fk= o.id group by o.id,o.nombre_admin,o.org_contratante ORDER BY count(l.id) DESC LIMIT 5";
        return pg_fetch_all(pg_query($this->conn, $sql));   
    }
    
    function getOrganismoData($id) {
        $sql="select * from organismo WHERE id=".$id;
        return pg_fetch_assoc(pg_query($this->conn, $sql));  
    }
    
    
    function licitacionesByOrganism($id,$offset) {
        
        $sql="select l.id as licitacion_id, o.id as organismo_id,titulo,importe,fecha1,fecha2,fecha3,votes_up,votes_down,num_comentarios,o.nombre_admin,o.org_contratante FROM licitacion as l inner join organismo as o on l.organismo_fk= o.id WHERE o.id=".$id ." LIMIT 6 OFFSET ".$offset;
	    return pg_fetch_all(pg_query($this->conn, $sql));        
    }    
    
}
?>