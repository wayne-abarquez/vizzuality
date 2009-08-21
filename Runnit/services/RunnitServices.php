<?php

class RunnitServices {
	
	function __construct() {
	    $this->conn = pg_connect ("host=67.23.44.117 dbname=runnit user=postgres password=postgres");
		
	}
    
    public function login($email,$pass) {

        $email=pg_escape_string($email);
        $pass=pg_escape_string($pass);
        
        // create page view database table
        $sql = "SELECT * FROM users WHERE (email='$email' AND pass='$pass') OR (username='$email' AND pass='$pass')";        
        $result = pg_query($this->conn, $sql);
        if(pg_num_rows($result)<1) {
            $_SESSION['logged']=false;
            throw new Exception("user not logged in");
        } else {
 
            $_SESSION['logged']=true;
            $res=pg_fetch_assoc($result);
            $_SESSION['user']=$res;
    	    return $res;           
        }
	}
	
	public function getComments($on_id,$table) {
	    $table=pg_escape_string($table);
	    
	    $sql="SELECT c.id,commenttext,c.created_when,username from comments as c INNER JOIN users as u ON c.user_fk=u.id  WHERE on_id=$on_id AND on_table='$table'";	    
	    return pg_fetch_all(pg_query($this->conn, $sql)); 
	     
	}
	
	
	public function isUsernameFree($username) {
	    $username=pg_escape_string($username);
	    $sql="SELECT id from users WHERE username='$username'";
	    $result=pg_query($this->conn, $sql);
	    if(pg_num_rows($result)>0) {
	        return false;
	    }
	       
	    return true;
	}
	
	public function registerUser($username,$completename,$email,$password) {
	    $username=pg_escape_string($username);
	    $completename=pg_escape_string($completename);
	    $email=pg_escape_string($email);
	    $password=pg_escape_string($password);
	    
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
	    $sql="SELECT id from users WHERE username='$username'";
	    $result=pg_query($this->conn, $sql);
	    if(pg_num_rows($result)>0) {
	        throw new Exception('Username already registered',104);
	    }	    
	    	     
	    
	    //Check if username or password are in the DB
	    $sql="SELECT id from users WHERE email='$email'";
	    $result=pg_query($this->conn, $sql);
	    if(pg_num_rows($result)>0) {
	        throw new Exception('Email already registered',105);
	    }	     
	    
	    $sql="INSERT INTO users(username,pass,completename,email) VALUES('$username','$password','$completename','$email')";
		$result=pg_query($this->conn, $sql);   
	    
	    //get last ID
	    $sql = "SELECT currval('users_id_seq') AS last_value";
	    $result=pg_query($this->conn, $sql);
	    $res=pg_fetch_assoc($result);
	    
	    
	    $user=array();
	    $user['id']=$res['last_value'];
	    $user['username']=$username;
	    $user['completename']=$projectname;
	    $user['email']=$email;
	    return $user;
	}
	
	public function updateUser($username,$completename,$email,$password,$locality,$radio) {
	    if (!$_SESSION['logged'] or $_SESSION['user']['username']!=$username) {
	        throw new Exception("user not logged in");
	    }
	    
	    $username=pg_escape_string($username);
	    $completename=pg_escape_string($completename);
	    $email=pg_escape_string($email);
	    $password=pg_escape_string($password);
	    $locality=pg_escape_string($locality);
	    

	    $sql="UPDATE users SET completename='$completename', email='$email'";
	    if(strlen($password)>4) {
	        $sql.=",pass='$password'";
	    }
	    
	    
	    $sql.=",locality='$locality'";   
	    $sql.=",radius_interest=$radio";
	    $sql.=" WHERE username='$username'";
        $result= pg_query($this->conn, $sql);
        return null;
	    
	     
    }
	
	public function logout() {
	    if (!$_SESSION['logged']) {
	        throw new Exception("user not logged in");
	    }
	    session_destroy();
	}	    
	
	public function addComment($userId,$comment,$id,$table) {
	    if (!$_SESSION['logged'] or $_SESSION['user']['id']!=$userId) {
	        throw new Exception("user not logged in");
	    }
	    
	    $comment=pg_escape_string($comment);
	    $table=pg_escape_string($table);
	    
	    $sql="INSERT INTO comments(user_fk,commenttext,on_table,on_id) VALUES('$user_fk','$comment','$table','$id')";
        $result= pg_query($this->conn, $sql);
        return null;
	    
	}
	
	
	public function getLastUsersInscribedToRuns() {
	    $sql="select u.id as user_id,username, r.name as run_name, r.id as run_id, (select count(id) from users_run where run_fk=r.id) as num_participants from users_run as ur inner join users as u on ur.users_fk=u.id inner join run as r on ur.run_fk=r.id order by ur.id DESC limit 3";
	    return pg_fetch_all(pg_query($this->conn, $sql));  
	}
	
	public function getHighlightedRun() {
	    $sql="select r.id,r.name,event_date,event_location,distance_text, (select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id from run as r left join province as p on r.province_fk=p.id where r.event_date > now() order by is_displayed_in_home ASC LIMIT 1";
        $result = pg_query($this->conn, $sql);  
        return pg_fetch_assoc($result);
	}
	
	public function searchRuns($q,$max,$min,$offset) {
        $q=pg_escape_string($q);
        if(!$offset) {
            $offset=0;
        }
        
	    $sql="select r.id,r.name,event_date,event_location,distance_text, (select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id from run as r  left join province as p on r.province_fk=p.id where r.event_date > now() AND (name ilike '%$q%' or event_location ilike '%$q%')";
	    if($min>0) {
	        $sql.=" AND distance_meters >= $min";
	    }
	    if($max>0) {
	        $sql.=" AND distance_meters <= $max";	        
	    }
	    
	    $sql.=" order by event_date ASC limit 15 offset $offset";
        
        return pg_fetch_all(pg_query($this->conn, $sql));  
	}
	
	public function getNextRuns() {
	    $sql="select r.id,r.name,event_date,event_location,distance_text, (select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id from run as r left join province as p on r.province_fk=p.id where r.event_date > now() order by event_date ASC limit 4";
	    return pg_fetch_all(pg_query($this->conn, $sql));     
	}
	
	public function getProvinces() {
	    $sql="select * from province ORDER BY id ASC";
	    return pg_fetch_all(pg_query($this->conn, $sql));	    
	}
	
	
	public function createNewRun($name,$event_location,$distance_meters,$distance_text,$event_date,
	    $category,$awards,$description,$inscription_price,$inscription_location,
	    $inscription_email,$inscription_website,$start_point_lat,$start_point_lon,$end_point_lat,$end_point_lon,$province_id,$is_selected) {
            if (!$_SESSION['logged'] or $_SESSION['user']['is_admin']!='t') {
    	        throw new Exception("user not logged in");
    	    }
    	    
    	    if($is_selected=='true') {
    	        $is_selected="true";
    	    } else {
    	        $is_selected="false";
    	    }
    	    
	        $sql="INSERT INTO run(name,event_location,distance_meters,distance_text,event_date,category,awards,".
	            "description, inscription_price,inscription_location,inscription_email,inscription_website,province_fk,is_displayed_in_home,start_point,end_point".
	            ") VALUES('$name','$event_location',$distance_meters,'$distance_text','$event_date',".
                "'$category','$awards','$description','$inscription_price','$inscription_location',".
                "'$inscription_email','$inscription_website', $province_id,$is_selected";
                
                if($start_point_lat) {
                    $sql.=",GeomFromText('POINT($start_point_lon $start_point_lat)',4326)";
                } else {
                    $sql.=",null";
                }
                if($end_point_lat) {
                    $sql.=", GeomFromText('POINT($end_point_lon $end_point_lat)',4326))";
                }else {
                    $sql.=",null";
                }              
                $sql.=")";
            $result= pg_query($this->conn, $sql);

	    
	        //get last ID
    	    $sql = "SELECT currval('run_id_seq') AS last_value";
    	    $result=pg_query($this->conn, $sql);
    	    $res=pg_fetch_assoc($result);    	    
    	    $newId= (int)$res['last_value'];
    	    
    	    if (is_int($newId)) {
    	        return $newId;
    	    } else {
    	        return false;
    	    }
 	    
	    }
	    
    	public function updateRun($id,$name,$event_location,$distance_meters,$distance_text,$event_date,
    	    $category,$awards,$description,$inscription_price,$inscription_location,
    	    $inscription_email,$inscription_website,$start_point_lat,$start_point_lon,$end_point_lat,$end_point_lon, $province_id,$is_selected) {
                if (!$_SESSION['logged'] or $_SESSION['user']['is_admin']!='t') {
        	        throw new Exception("user not logged in");
        	    }
                
        	        $sql="UPDATE run SET name='$name',event_location='$event_location', distance_meters=$distance_meters, distance_text='$distance_text',event_date='$event_date',category='$category',awards='$awards', description='$description', inscription_price='$inscription_price',inscription_location='$inscription_location',inscription_email='$inscription_email',inscription_website='$inscription_website',province_fk=$province_id,is_displayed_in_home=$is_selected";
        	        
        	    if($start_point_lat) {
        	        $sql.=",start_point=GeomFromText('POINT($start_point_lon $start_point_lat)',4326)";
        	    }    
        	    if($end_point_lat) {
        	        $sql.=",end_point=GeomFromText('POINT($end_point_lon $end_point_lat)',4326)";
        	    }        	    
        	        
        	    $sql.=" WHERE id=$id";
            $result= pg_query($this->conn, $sql);
            return null;

    }
    	    
    public function removeRun($id) {
        if (!$_SESSION['logged'] or $_SESSION['user']['is_admin']!='t') {
	        throw new Exception("user not logged in");
	    }
        $sql="DELETE FROM run WHERE id=$id";
        $result= pg_query($this->conn, $sql);
        return null;   	
    }	    
    
    public function getRunsList() {
        $sql="select id ,name,event_location,distance_meters,event_date,category,awards,description,inscription_price,inscription_location,inscription_email,inscription_website,distance_text,y(start_point) as start_point_lat, x(start_point) as start_point_lon, y(end_point) as end_point_lat, x(end_point) as end_point_lon,province_fk,is_displayed_in_home from run ORDER BY id DESC"; 
		return pg_fetch_all(pg_query($this->conn, $sql));    
    }
    
    public function getRunDetails($id) {
        $sql="select r.id ,r.name,event_location,distance_meters,event_date,category,awards,description,inscription_price,inscription_location,inscription_email,inscription_website,distance_text,y(start_point) as start_point_lat, x(start_point) as start_point_lon, y(end_point) as end_point_lat, x(end_point) as end_point_lon,is_displayed_in_home,(select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id from run as r left join province as p on r.province_fk=p.id where r.id=$id";
        $result = pg_query($this->conn, $sql);  
        return pg_fetch_assoc($result);
    }


}

?>
