<?php

class RunnitServices {
	
	function __construct() {
		$this->dbHandle = new PDO('pgsql:host=67.23.44.117 port=5432 dbname=runnit user=runnit password=runnit555');
		//$this->dbHandle = new PDO('pgsql:host=localhost port=5432 dbname=postgres user=postgres password=postgres');
		
	}
    
    public function login($email,$pass) {

        // create page view database table
        $sql = "SELECT * FROM users WHERE (email='$email' AND pass='$pass') OR (username='$email' AND pass='$pass')";        
        $result = $this->dbHandle->query($sql)->fetch(PDO::FETCH_ASSOC);    

        if (strlen($result['username'])<1) {
            $_SESSION['logged']=false;
            throw new Exception("user not logged in");
        } else {
            $_SESSION['logged']=true;
            $_SESSION['user']=$result;
    	    return $result;            
        }
	}
	
	public function getComments($on_id,$table) {
	    $sql="SELECT c.id,commenttext,c.created_when,username from comments as c INNER JOIN users as u ON c.user_fk=u.id  WHERE on_id=:id AND on_table=:table";
        $stmt = $this->dbHandle->prepare($sql);
        $stmt->bindParam(':id', $on_id);
        $stmt->bindParam(':table', $table);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);	    
	}
	
	public function getSpeciesData($speciesId) {
	    
	}
	
	public function isUsernameFree($username) {
	    $sql="SELECT id from users WHERE username=:username";
		$stmt = $this->dbHandle->prepare($sql);
	    $stmt->bindParam(':username', $username);	     
	    $stmt->execute();
	    if (count($stmt->fetchAll()) > 0) {
	        return false;
	    }	    
	    return true;
	}
	
	public function registerUser($username,$completename,$email,$password) {
	    
	    if(strlen($username)<5) {
	        throw new Exception('Username with not enough characters',101);
	    }
	    if(strlen($password)<5) {
	        throw new Exception('Password with not enough characters',102);
	    }
	    if(strlen($email)<5) {
	        throw new Exception('Email with not enough characters',103);
	    }	 
	    
	    //Check if username or password are in the DB
	    $sql="SELECT id from users WHERE username=:username";
		$stmt = $this->dbHandle->prepare($sql);
	    $stmt->bindParam(':username', $username);	     
	    $stmt->execute();
	    if (count($stmt->fetchAll()) > 0) {
	        throw new Exception('Username already registered',104);
	    }	     
	    
	    //Check if username or password are in the DB
	    $sql="SELECT id from users WHERE email=:email";
		$stmt = $this->dbHandle->prepare($sql);
	    $stmt->bindParam(':email', $email);	     
	    $stmt->execute();
	    if (count($stmt->fetchAll()) > 0) {
	        throw new Exception('Email already registered',105);
	    }	   
	    
	    $sql="INSERT INTO users(username,pass,completename,email) VALUES(:username,:password,:completename,:email)";
		$stmt = $this->dbHandle->prepare($sql);
        $stmt->bindParam(':email', $email);	     
	    $stmt->bindParam(':username', $username);	     
	    $stmt->bindParam(':password', $password);	     
	    $stmt->bindParam(':completename', $completename);	        	    
	    $stmt->execute();	       
	    
	    //get last ID
	    $sql = "SELECT currval('users_id_seq') AS last_value";
	    $resultId = $this->dbHandle->query($sql)->fetch(PDO::FETCH_ASSOC); 
	    
	    
	    $user=array();
	    $user['id']=$resultId['last_value'];
	    $user['username']=$username;
	    $user['completename']=$projectname;
	    $user['email']=$email;
	    return $user;
	}
	
	
	public function logout() {
	    session_destroy();
	}	    
	
	public function addComment($userId,$comment,$id,$table) {
	    try {
	        $sql="INSERT INTO comments(user_fk,commenttext,on_table,on_id) VALUES(:user_fk,:comment,:table,:id)";
    		$stmt = $this->dbHandle->prepare($sql);    
    	    $stmt->bindParam(':user_fk', $userId);	     
    	    $stmt->bindParam(':comment', $comment);	        
    	    $stmt->bindParam(':id', $id);	     
    	    $stmt->bindParam(':table', $table);	     	    
    	    $stmt->execute();
    	    return true;
	    } catch(Exception $e) {
	        return false;
	    }

	    
	}
	
	public function getMostPopularSpecies($limit) {
	    $sql="select num_views,nub_concept_id, scientific_name,id from species_view_stats as svs inner join scientific_name as s on svs.species_fk=s.id order by num_views DESC limit :limit";
		$stmt = $this->dbHandle->prepare($sql);
		$stmt->bindParam(':limit', $limit);	  
	    $stmt->execute(); 
		return $stmt->fetchAll(PDO::FETCH_ASSOC);	    
	    
	    
	}
	
	public function getSpeciesDetailsByNameId($speciesId) {
	    $sql="SELECT d.id,code, resourcename,resource_fk as resource_id, (select count(id) from distribution_unit where distribution_fk=d.id) as num_units from distribution as d inner join resource as r on d.resource_fk=r.id where d.name_fk=:speciesId and d.resource_fk=2";
		$stmt = $this->dbHandle->prepare($sql);
	    $stmt->bindParam(':speciesId', $speciesId); 
	    $stmt->execute();
		$res= $stmt->fetchAll(PDO::FETCH_ASSOC);
		$sources=array();	    
		foreach($res as $data) {	    
			$source=array();
			$source = $data;
			//Add the distribution units
			$sql2="select distinct s.id as id, tag,color from distribution_unit as du inner join status_tags as s on du.status_tags_fk=s.id where distribution_fk=:distributionId";			
			$stmt2 = $this->dbHandle->prepare($sql2);
		    $stmt2->bindParam(':distributionId', $data['id']); 
		    $stmt2->execute();
			$res2= $stmt2->fetchAll(PDO::FETCH_ASSOC);		
			$source['legend'] = $res2;
			$sources[]=$source;					    
		}
		
		return $sources;	    
	}
	
	public function createNewRun($name,$event_location,$distance_meters,$distance_text,$event_date,
	    $category,$awards,$description,$inscription_price,$inscription_location,
	    $inscription_email,$inscription_website,$start_point_lat,$start_point_lon,$end_point_lat,$end_point_lon) {
            try {
	        $sql="INSERT INTO run(name,event_location,distance_meters,distance_text,event_date,category,awards,".
	            "description, inscription_price,inscription_location,inscription_email,inscription_website,start_point,end_point".
	            ") VALUES(:name,:event_location,:distance_meters,:distance_text,:event_date,".
                ":category,:awards,:description,:inscription_price,:inscription_location,".
                ":inscription_email,:inscription_website, GeomFromText('POINT($start_point_lon $start_point_lat)',4326), GeomFromText('POINT($end_point_lon $end_point_lat)',4326))";
    		$stmt = $this->dbHandle->prepare($sql);
            $stmt->bindParam(':name', $name);	     
     	    $stmt->bindParam(':event_location', $event_location);	   
     	    $stmt->bindParam(':distance_meters', $distance_meters, PDO::PARAM_INT);	   
     	    $stmt->bindParam(':distance_text', $distance_text);	   
     	    $stmt->bindParam(':event_date', $event_date, PDO::PARAM_STR);	   
     	    $stmt->bindParam(':category', $category);	   
     	    $stmt->bindParam(':awards', $awards);
     	    $stmt->bindParam(':description', $description);
     	    $stmt->bindParam(':inscription_price', $inscription_price);
     	    $stmt->bindParam(':inscription_location', $inscription_location);
     	    $stmt->bindParam(':inscription_email', $inscription_email); 
     	    $stmt->bindParam(':inscription_website', $inscription_website);
    	    $stmt->execute();
    	    
	    
	        //get last ID
    	    $sql = "SELECT currval('run_id_seq') AS last_value";
    	    $resultId = $this->dbHandle->query($sql)->fetch(PDO::FETCH_ASSOC);
    	    
    	    $newId= (int)$resultId['last_value'];
    	    
    	    if (is_int($newId)) {
    	        return $newId;
    	    } else {
    	        return false;
    	    }
 	    
	        } catch(PDOException $e)
            {
                return $stmt->getMessage();
            }
	    }
	    
    	public function updateRun($id,$name,$event_location,$distance_meters,$distance_text,$event_date,
    	    $category,$awards,$description,$inscription_price,$inscription_location,
    	    $inscription_email,$inscription_website,$start_point_lat,$start_point_lon,$end_point_lat,$end_point_lon) {

                try {
        	        $sql="UPDATE run SET name=:name,event_location=:event_location,distance_meters=:distance_meters,distance_text=:distance_text,event_date=:event_date,category=:category,awards=:awards,".
        	            "description=:description, inscription_price=:inscription_price,inscription_location=:inscription_location,inscription_email=:inscription_email,inscription_website=:inscription_website,start_point=GeomFromText('POINT($start_point_lon $start_point_lat)',4326), end_point=GeomFromText('POINT($end_point_lon $end_point_lat)',4326)".
        	            " WHERE id=:idrun";
            		$stmt = $this->dbHandle->prepare($sql);
            		$stmt->bindParam(':idrun', $id, PDO::PARAM_INT);
                    $stmt->bindParam(':name', $name);	     
             	    $stmt->bindParam(':event_location', $event_location);	   
             	    $stmt->bindParam(':distance_meters', $distance_meters, PDO::PARAM_INT);	   
             	    $stmt->bindParam(':distance_text', $distance_text);	   
             	    $stmt->bindParam(':event_date', $event_date, PDO::PARAM_STR);	   
             	    $stmt->bindParam(':category', $category);	   
             	    $stmt->bindParam(':awards', $awards);	   
             	    $stmt->bindParam(':description', $description);	   
             	    $stmt->bindParam(':inscription_price', $inscription_price);	   
             	    $stmt->bindParam(':inscription_location', $inscription_location);	   
             	    $stmt->bindParam(':inscription_email', $inscription_email);	    
             	    $stmt->bindParam(':inscription_website', $inscription_website);	    
            	    $stmt->execute();
                    return true;
        	    } catch(Exception $e) {
        	        return false;
        	    }
    	    }	    
    	    
    public function removeRun($id) {
        try {
            $sql="DELETE FROM run WHERE id=:id";
    		$stmt = $this->dbHandle->prepare($sql);
    		$stmt->bindParam(':id', $id);
    		$stmt->execute();        
	    } catch(Exception $e) {
	        return false;
	    }    	
    }	    
    
    public function getRunsList() {
        $sql="select * from run ORDER BY id DESC";
		$stmt = $this->dbHandle->prepare($sql);
	    $stmt->execute(); 
		return $stmt->fetchAll(PDO::FETCH_ASSOC);        
    }
	
	public function searchForName($name,$limit=10,$offset=0) {
		//$time_start = microtime_float();
		/* $conn = pg_pconnect("host=ec2-174-129-85-138.compute-1.amazonaws.com port=5432 dbname=sdr user=postgres password=atlas",PGSQL_CONNECT_FORCE_NEW);
		$result = pg_query_params($conn, "select ns.*, n.scientific_name ".
			"from name_summary as ns inner join scientific_name as n on ns.name_fk=n.id ".
			"where n.scientific_name like $1  order by n.scientific_name limit $2 offset $3",array($name.'%',$limit,$offset));
		
		return pg_fetch_all($result); */

		
		
	    $stmt = $this->dbHandle->prepare("select ns.*, n.scientific_name ".
			"from name_summary as ns inner join scientific_name as n on ns.name_fk=n.id ".
			"where n.scientific_name like :param  order by n.scientific_name limit 10 offset 0");
	    //$name = $name . "%";
	    $stmt->bindParam(':param', $name, PDO::PARAM_STR,255); 
		//$stmt->bindParam(':limit', $limit2, PDO::PARAM_INT); 
		//$stmt->bindParam(':offset', $offset2, PDO::PARAM_INT); 
		
		//return($stmt->getSQL(array(':param' => $name.'%')) );
		
	    $stmt->execute(array(':param' => $name.'%'));
	    
	    
	    return $stmt->fetchAll(PDO::FETCH_ASSOC);		
	}
	
	
	/*public function getAllItems() {
	    if (!$_SESSION['logged']) {
	        throw new Exception("user not logged in");
	    }
	    $sth = $this->dbHandle->prepare("SELECT * FROM item");
        $sth->execute();
        
        return $sth->fetchAll(PDO::FETCH_ASSOC);
	}
	
	public function getItemDetail($id) {
	    $sth = $this->dbHandle->prepare("SELECT * FROM item where id=$id");
        $sth->execute();
        
        return $sth->fetch(PDO::FETCH_ASSOC);
	}
	
	public function getItemList($maxItems) {
	    $sth = $this->dbHandle->prepare("SELECT * FROM item limit $maxItems");
        $sth->execute();
        
        return $sth->fetchAll(PDO::FETCH_ASSOC);
	}	*/	

}






?>
