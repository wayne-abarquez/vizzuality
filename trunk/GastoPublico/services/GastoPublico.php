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
        $sql="select id,titulo,importe,fecha1,fecha2,fecha3,votes_up,votes_down,num_comentarios FROM licitacion ORDER BY importe DESC LIMIT 3";
	    return pg_fetch_all(pg_query($this->conn, $sql));        
    }
}
?>