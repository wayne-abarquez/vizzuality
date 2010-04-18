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
        $sql="select l.id as licitacion_id, o.grupo_fk as grupo_id,titulo,importe,fecha1,fecha2,fecha3,votes_up,votes_down,num_comentarios,o.nombre_admin,o.org_contratante FROM licitacion as l inner join organismo as o on l.organismo_fk= o.id ORDER BY importe DESC LIMIT 5";
	    return pg_fetch_all(pg_query($this->conn, $sql));        
    }
    
    function getFeaturedOrganismos() {
        $sql="select count(l.id) as num_licitaciones, o.id as organismo_id, o.nombre_admin,o.org_contratante FROM licitacion as l inner join organismo as o on l.organismo_fk= o.id group by o.id,o.nombre_admin,o.org_contratante ORDER BY count(l.id) DESC LIMIT 7";
        return pg_fetch_all(pg_query($this->conn, $sql));   
    }
    
    function getOrganismoData($id) {
        //mirar si es un organismo o un municipio
        $sql="select org_contratante from organismo WHERE grupo_fk=$id LIMIT 1";
        $res=pg_fetch_assoc(pg_query($this->conn, $sql));
        if($res['org_contratante']=="Administración General del Estado") {
            $sql="select grupo_fk as group_id,count(l.id) as num_licitaciones, sum(l.importe) as sum_importe,org_contratante,nombre_admin,'Madrid' as poblacion, 'Madrid' as provincia, web, alcalde, partido_politico,alcalde_voota_link,habitantes from organismo as o inner join licitacion as l on o.id=l.organismo_fk  
            where grupo_fk=$id  group by grupo_fk,org_contratante,nombre_admin,web,alcalde,partido_politico,alcalde_voota_link,habitantes";
        } else{
            $sql="select grupo_fk as group_id,count(l.id) as num_licitaciones, sum(l.importe) as sum_importe,org_contratante,nombre_admin,poblacion, provincia, web, alcalde, partido_politico,alcalde_voota_link,habitantes from organismo as o inner join licitacion as l on o.id=l.organismo_fk  
            where grupo_fk=$id  group by grupo_fk,org_contratante,nombre_admin,poblacion,provincia,web,alcalde,partido_politico,alcalde_voota_link,habitantes";
                     
        }
        return pg_fetch_assoc(pg_query($this->conn, $sql));   
 
    }
    
    
    function licitacionesByOrganism($id,$offset) {   
        $sql="select l.id as licitacion_id, o.id as organismo_id,titulo,importe,fecha1 as fecha, categoria,votes_up,votes_down,num_comentarios,o.nombre_admin,o.org_contratante FROM licitacion as l inner join organismo as o on l.organismo_fk= o.id WHERE o.grupo_fk=".$id ." LIMIT 6 OFFSET ".$offset;
	    return pg_fetch_all(pg_query($this->conn, $sql));        
    }    
    
    function getNearOrganismos($id) {
        $sql="select org_contratante from organismo WHERE grupo_fk=$id LIMIT 1";
        $res=pg_fetch_assoc(pg_query($this->conn, $sql));
        if($res['org_contratante']=="Administración General del Estado") {
            $sql="select grupo_fk as id,nombre_admin from organismo WHERE org_contratante='Administración General del Estado' LIMIT 5";
        } else {
            $sql="select grupo_fk as id,nombre_admin from organismo WHERE org_contratante<>'Administración General del Estado' LIMIT 5";
        }
        return pg_fetch_all(pg_query($this->conn, $sql));
    }
    
    function getLicitacionDetails($id) {
        $sql="select * from licitacion as l inner join organismo as o on l.organismo_fk=o.id where l.id=".$id." LIMIT 1";
        return pg_fetch_assoc(pg_query($this->conn, $sql));
    }
    
    function getOrganismosCloseToLicitacion($id) {
        $sql="select id,nombre_admin from organismo LIMIT 10";
        return pg_fetch_all(pg_query($this->conn, $sql));
    }
    
    function getOtherLicitacionesFromSameOrganismo($id) {
        $sql="select l.id as licitacion_id, o.grupo_fk as grupo_id,titulo,importe,fecha1,fecha2,fecha3,votes_up,votes_down,num_comentarios,o.nombre_admin,o.org_contratante FROM licitacion as l inner join organismo as o on l.organismo_fk= o.id ORDER BY importe DESC LIMIT 2";
        return pg_fetch_all(pg_query($this->conn, $sql));
    }    
    
    function getCommentsByLicitacion($id) {
        $sql="select * from comentario WHERE licitacion_fk=".$id;
        return pg_fetch_all(pg_query($this->conn, $sql));
    }
    
    function postComment($userfk,$name,$email,$comentario,$web,$licitacion_id,$token) {
        $name=pg_escape_string($name);
        $email=pg_escape_string($email);
        $comentario=pg_escape_string($comentario);
        $web=pg_escape_string($web);
        
        $sql="INSERT INTO comentario(user_fk,nombre,email,web,comentario,licitacion_fk) VALUES($userfk,'$name','$email','$web','$comentario',$licitacion_id)";
        $result= pg_query($this->conn, $sql);
        $sql="UPDATE licitacion set num_comentarios=num_comentarios+1 WHERE id=$licitacion_id";
        $result= pg_query($this->conn, $sql);
        return "ok";
    }
    
    function createUser($facebookToken) {
        $facebookToken=pg_escape_string($facebookToken);
        $sql="INSERT INTO users(token) VALUES('$facebookToken')";
        $result= pg_query($this->conn, $sql);
        return  "ok";      
    }
    
    function vote($direction,$licitacion_id) {

        if($direction=="up") {
            $sql="UPDATE licitacion set votes_up=votes_up+1 WHERE id=$licitacion_id";
        } else {
            $sql="UPDATE licitacion set votes_down=votes_down+1 WHERE id=$licitacion_id";
        }
        $result= pg_query($this->conn, $sql);
        return  "ok";       
    }
    
    function getNextOrganismo() {
        $tempOffset=rand(0,10);
        $sql="SELECT grupo_fk,nombre_admin,wikipedia_url,web,partido_politico,provincia,alcalde,alcalde_voota_link,habitantes,escudo,foto FROM organismo WHERE partido_politico is null
                group by grupo_fk,nombre_admin,wikipedia_url,web,partido_politico,provincia,alcalde,alcalde_voota_link,habitantes,escudo,foto  LIMIT 1 OFFSET $tempOffset";
        return pg_fetch_assoc(pg_query($this->conn, $sql));
    }
    
    function saveOrganismo($alcalde,$voota,$wikipedi_url,$web,$partido_poltico,$provincia,$habitantes,$escudo,$foto,$grupoId) {
        if($alcalde=="") {
             $alcalde="null";
        }else {
             $alcalde="'".pg_escape_string($alcalde)."'";
        }
        if($voota=="") {
             $voota="null";
        }else {
             $voota="'".pg_escape_string($voota)."'";
        }
        if($wikipedi_url=="") {
             $wikipedi_url="null";
        }else {
             $wikipedi_url="'".pg_escape_string($wikipedi_url)."'";
        }
        if($web=="") {
             $web="null";
        }else {
             $web="'".pg_escape_string($web)."'";
        }
        if($partido_poltico=="") {
             $partido_poltico="null";
        }else {
             $partido_poltico="'".pg_escape_string($partido_poltico)."'";
        }  
        if($provincia=="") {
             $provincia="null";
        }else {
             $provincia="'".pg_escape_string($provincia)."'";
        }                                     
        if($habitantes=="") {
            $habitantes="null";
        } else {
            $habitantes="'".pg_escape_string($habitantes)."'";
        }
        if($escudo=="") {
             $escudo="null";
        }else {
             $escudo="'".pg_escape_string($escudo)."'";
        }
        if($foto=="") {
             $foto="null";
        }else {
             $foto="'".pg_escape_string($foto)."'";
        }                


        $sql="UPDATE organismo SET 
        alcalde=$alcalde,
        alcalde_voota_link=$voota,
        wikipedia_url=$wikipedi_url,
        web=$web,
        partido_politico=$partido_poltico,
        provincia=$provincia,
        habitantes=$habitantes,
        escudo=$escudo,
        foto=$foto
        WHERE grupo_fk =$grupoId    
        ";
        $result= pg_query($this->conn, $sql);
        return  "ok";        
    }
    
}
?>