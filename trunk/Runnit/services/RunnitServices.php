<?php
require_once($_SERVER['DOCUMENT_ROOT'] ."/runnit-config.php");
require_once($_SERVER['DOCUMENT_ROOT'] ."/libs/class.phpmailer.php");
require_once($_SERVER['DOCUMENT_ROOT'] ."/libs/class.smtp.php");
require_once($_SERVER['DOCUMENT_ROOT'] ."/libs/Smarty.class.php");

class RunnitServices {
	
	function __construct() {
	    $this->conn = pg_connect ("host=".DB_HOST." dbname=".DB_NAME." user=".DB_USER." password=".DB_PASSWORD);
	
		$this->emailPassword=EMAILPASSWORD;
		$this->basePath=ABSPATH;
	}
    
    //ajaxController,RacedEditor.mxml
    public function login($email,$pass) {

        $email=pg_escape_string($email);
        $pass=pg_escape_string($pass);
        
        // create page view database table
        $sql = "SELECT id,completename,username,pass,email,created_when,x(location_point) as lon,y(location_point) as lat,locality,radius_interest,is_admin FROM users WHERE (email='$email' AND pass='$pass') OR (username='$email' AND pass='$pass')";        
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
	
	//ajaxController
	public function logout() {
	    if (!$_SESSION['logged']) {
	        throw new Exception("user not logged in");
	    }
	    session_destroy();
	}	
	
	//carrera.php
	public function getComments($on_id,$table) {
	    $table=pg_escape_string($table);
	    
	    $sql="SELECT c.id,commenttext,c.created_when,username,u.id as user_id from comments as c INNER JOIN users as u ON c.user_fk=u.id  WHERE on_id=$on_id AND on_table='$table' ORDER BY c.created_when ASC";	    

	    //Check if the user has avatars or not
	    $result = pg_fetch_all(pg_query($this->conn, $sql));
	    
	    //Iterate over the array to check if the runs have images on the server or not and provide a random one
	    if($result) {
    	    foreach ($result as &$comment) {
    	        $targetPicture=$this->basePath."media/avatar/".$comment['user_id'].".jpg";
                if (file_exists($targetPicture)) {
                    $comment['avatar'] = $comment['user_id'].".jpg?".rand();;
                } else {
                    //no image for the run, select random
                    $comment['avatar'] = "0.jpg";
                }
            }	        
	    }	    
	    
	    return $result; 
	     
	}
	
	//ajaxController
	public function isUsernameFree($username) {
	    $username=pg_escape_string($username);
	    $sql="SELECT id from users WHERE username='$username'";
	    $result=pg_query($this->conn, $sql);
	    if(pg_num_rows($result)>0) {
	        return false;
	    }
	       
	    return true;
	}
	
	//ajaxController
	public function registerUser($username,$completename,$email,$password) {
	    $username=pg_escape_string($username);
	    $completename=pg_escape_string($completename);
	    $email=pg_escape_string($email);
	    $password=pg_escape_string($password);
	    
	    if(strlen($username)<5) {
	        throw new Exception('El nombre de usuario debe ser mayor de 5 caracteres.',101);
	    }
	    
	    if(strlen($password)<5) {
	        throw new Exception('El password debe ser mayor de 5 caracteres.',102);
	    }
	    if(strlen($email)<5) {
	        throw new Exception('Tu email es incorrecto.',103);
	    }	 
	    
	    //Check if username or password are in the DB
	    $sql="SELECT id from users WHERE username='$username'";
	    $result=pg_query($this->conn, $sql);
	    if(pg_num_rows($result)>0) {
	        throw new Exception('Ese nombre de usuario ya esta registrado.',104);
	    }	    
	    	     
	    
	    //Check if username or password are in the DB
	    $sql="SELECT id from users WHERE email='$email'";
	    $result=pg_query($this->conn, $sql);
	    if(pg_num_rows($result)>0) {
	        throw new Exception('Email ya registrado.',105);
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
	    $user['completename']=$completename;
	    $user['email']=$email;
	
		//mensaje en HTML
		$noHtml="Bievenido a Runnity.com\n\nTus datos de acceso son:\n\nUsuario:$username\n\nPassword:$password\n\nSi tienes alguna duda mandanos un email.";
	
		//Send confirmation email

		$mail = new PHPMailer();
		$mail->IsSMTP();
		$mail->SMTPAuth = true;
		$mail->SMTPSecure = "ssl";
		$mail->Host = "smtp.gmail.com";
		$mail->Port = 465;
		$mail->Username = "alertas@runnity.com";
		$mail->Password = $this->emailPassword;

        $smarty = new Smarty; 
        $smarty->assign('name', $completename);
        $smarty->assign('username', $username);
        $email_message = utf8_decode($smarty->fetch(ABSPATH.'templates/email_registro.tpl'));

		$mail->From = "alertas@runnity.com";
		$mail->FromName = "Alertas Runnity";
		$mail->Subject = "Bienvenido a Runnity.com ".$username;
		$mail->AltBody = $noHtml;
		$mail->MsgHTML($email_message);
		$mail->AddAddress($email, $completename);
		$mail->IsHTML(true);	
		
		if(!$mail->Send()) {
			throw new Exception('Problema al enviar el email:'.$mail->ErrorInfo,110);
		}			
	
	    return $user;
	}
	
	//ajaxController
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
	    
	    if ($locality) {
			$sql.=",locality='$locality'";  
		} else {
			$sql.=",locality=null";  
		}
	    if ($radio) {
			$sql.=",radius_interest=$radio";  
		} else {
			$sql.=",radius_interest=null";  
		}
	     
	    $sql.=" WHERE username='$username'";
        $result= pg_query($this->conn, $sql);
        
        $_SESSION['logged']=true;
        $_SESSION['user']['username']=$username;
        $_SESSION['user']['completename']=$completename;
        $_SESSION['user']['email']=$email;
        $_SESSION['user']['locality']=$locality;
        $_SESSION['user']['radius_interest']=$radio;    
        
        return null;
	    
	     
    }

	/*public function getRunsForBBox($north,$south,$east,$west) {
		$sql="select r.id,r.name,event_date,event_location,distance_text, (select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id from run as r left join province as p on r.province_fk=p.id where r.event_date > now() and start_point && ST_SetSRID(ST_MakeBox2D(ST_Point($west, $south), ST_Point($east ,$north)),4326)";
	} */
	
	//runnitHomeMap
	public function getAllRuns() {
		$sql="select x(start_point) as lon, y(start_point) as lat,r.id,r.name,event_date,event_location,distance_text, p.name as province_name,r.province_fk as province_id from run as r left join province as p on r.province_fk=p.id where r.event_date > now() and published=true and start_point is not null";
		return pg_fetch_all(pg_query($this->conn, $sql));  
	}		    
	
	//ajaxController
	public function addComment($userId,$comment,$id,$table) {
	    if (!$_SESSION['logged'] or $_SESSION['user']['id']!=$userId) {
	        throw new Exception("user not logged in");
	    }
	    
	    $comment=pg_escape_string($comment);
	    $table=pg_escape_string($table);
	    
	    $sql="INSERT INTO comments(user_fk,commenttext,on_table,on_id) VALUES($userId,'$comment','$table',$id)";
        $result= pg_query($this->conn, $sql);
        return null;
	    
	}
	
	/*public function getAllRunsBBox() {
		$sql="select xmax(extent(start_point)) as east,ymax(extent(start_point)) as north, xmin(extent(start_point)) as west, ymin(extent(start_point)) as south   from run as r where r.event_date > now()";
        $result = pg_query($this->conn, $sql);  
        return pg_fetch_assoc($result);		
	}*/
	
	
	//carrera,index
	public function getLastUsersInscribedToRuns($runId=0) {
	    if($runId==0) {
    	    $sql="select u.id as user_id,username, r.name as run_name, r.id as run_id, (select count(id) from users_run where run_fk=r.id) as num_participants from users_run as ur inner join users as u on ur.users_fk=u.id inner join run as r on ur.run_fk=r.id order by ur.id DESC limit 3";	        
	    } else {
	        $sql="select u.id as user_id,username, r.name as run_name, r.id as run_id, (select count(id) from users_run where run_fk=r.id) as num_participants from users_run as ur inner join users as u on ur.users_fk=u.id inner join run as r on ur.run_fk=r.id where ur.run_fk= $runId order by ur.id DESC limit 3";
	    }
	    //Check if the user has avatars or not
	    $result = pg_fetch_all(pg_query($this->conn, $sql));
	    
	    //Iterate over the array to check if the runs have images on the server or not and provide a random one
	    if($result) {
    	    foreach ($result as &$user) {
    	        $targetPicture=$this->basePath."media/avatar/".$user['user_id'].".jpg";
                if (file_exists($targetPicture)) {
                    $user['avatar'] = $user['user_id'].".jpg?".rand();
                } else {
                    //no image for the run, select random
                    $user['avatar'] = "0.jpg";
                }
            }	        
	    }

	    if ($result==false) {
	    	return "f";
	    } else {
	    	return $result;	
	    }        
	    
	}	
	
	/*public function getHighlightedRun() {
	    $sql="select r.id,r.name,event_date,event_location,distance_text, (select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id from run as r left join province as p on r.province_fk=p.id where r.event_date > now() order by is_displayed_in_home ASC LIMIT 1";
        $result = pg_query($this->conn, $sql);  
        return pg_fetch_assoc($result);
	}*/
	
	//usuario.php
	public function getUserRuns($id) {
	    $sql="select r.id,r.name,event_date,event_location,distance_text, (select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id,run_type from (run as r inner join users_run as ur on r.id=ur.run_fk) left join province as p on r.province_fk=p.id where ur.users_fk=$id AND r.event_date > now()";
        $result = pg_query($this->conn, $sql);  
        return pg_fetch_all(pg_query($this->conn, $sql));
	}	
	
	//searchresults
	public function searchRuns($q,$max,$min,$offset) {
        $q=pg_escape_string($q);
        if(!$offset) {
            $offset=0;
        }
        
	    $sql="select r.id,r.name,event_date,event_location,distance_text, (select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id,run_type,date_trunc('day',event_date) as event_day";
		$sql.=",CASE WHEN EXTRACT(DOW FROM event_date)=0 THEN 7 ELSE EXTRACT(DOW FROM event_date) END  as day_in_week";

        if(isset($_SESSION['logged']) and $_SESSION['logged']) {
            $sql.=",(select case when count(id)>0 then true else false end from users_run as ur where ur.run_fk=r.id and ur.users_fk=".$_SESSION['user']['id'].") as inscrito";
        } else {
            $sql.=",false as inscrito";
        }   
	    
	    $sql.=" from run as r  left join province as p on r.province_fk=p.id where r.event_date > now() and published=true AND (r.name ilike '%$q%' or event_location ilike '%$q%')";
	    if($min>0) {
	        $sql.=" AND distance_meters >= $min";
	    }
	    if($max>0) {
	        $sql.=" AND distance_meters <= $max";	        
	    }
	    
	    $sqlForCount="SELECT COUNT(id) as num_results FROM ($sql) as s";
	    
	    $sql.=" order by event_date ASC limit 20 offset $offset";
        
        $results=array();
        $results['data'] = pg_fetch_all(pg_query($this->conn, $sql));
        
        if($results['data']) {
            $resultCount=pg_query($this->conn, $sqlForCount);
    	    $resultCount=pg_fetch_assoc($resultCount);
            $results['count'] =(int)$resultCount['num_results'];            
        } else {
            $results['count'] =0;  
        }

        
        return $results;  
	}
	
	//searchResults,index
	public function getNextRuns($lat=0,$lon=0,$distance_km=150) {	
	$sql="select r.id,r.name,event_date,event_location,distance_text, (select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id,run_type,flickr_img_id";
	
	if(isset($_SESSION['logged']) and $_SESSION['logged']) {
	    $sql.=",(select case when count(id)>0 then true else false end from users_run as ur where ur.run_fk=r.id and ur.users_fk=".$_SESSION['user']['id'].") as inscrito";
	}
	
	$sql.=" from run as r left join province as p on r.province_fk=p.id where r.event_date > now() and published=true";
	
/*		if($provinceName!="") {
			$sqlProv="SELECT id from province WHERE name like '$provinceName'";
			$resultCount=pg_query($this->conn, $sqlProv);
			$resultCount=pg_fetch_assoc($resultCount);
			if($resultCount) {
				$sql.=" and r.province_fk=".$resultCount['id'];
			}
			
		}
*/

		if($lat!=0 && $lon!=0) {
			$sql.=" AND distance_sphere(PointFromText('POINT($lon $lat)', 4326),start_point) <($distance_km*1000)";
		}
	
		$sql.=" order by event_date ASC limit 6";
	    
	    $result = pg_fetch_all(pg_query($this->conn, $sql));
	    
	    //Iterate over the array to check if the runs have images on the server or not and provide a random one
	    foreach ($result as &$run) {
	        $targetPicture=$this->basePath."media/run/".$run['id']."_small.jpg";
            if (file_exists($targetPicture)) {
                $run['thumbnail'] = $run['id']."_small.jpg";
            } else {
                //no image for the run, select random
                $run['thumbnail'] = "generic/".rand(1,4)."_small.jpg";
            }
        }
	    
	    return $result;   
	}
	
	public function getProvinces() {
	    $sql="select * from province ORDER BY id ASC";
	    return pg_fetch_all(pg_query($this->conn, $sql));	    
	}
	
	
	
	public function createNewRun($name,$event_location,$distance_meters,$distance_text,$event_date,
	    $category,$awards,$description,$inscription_price,$inscription_location,
	    $inscription_email,$inscription_website,$start_point_lat,$start_point_lon,$end_point_lat,$end_point_lon,$province_id,$is_selected,$run_type,$published,$tlf_informacion,$flickr_url) {
            if (!$_SESSION['logged'] or $_SESSION['user']['is_admin']!='t') {
    	        throw new Exception("user not logged in");
    	    }
    	    

			$name=pg_escape_string($name);
			$event_location=pg_escape_string($event_location);
			$distance_text=pg_escape_string($distance_text);
			$category=pg_escape_string($category);
			$awards=pg_escape_string($awards);
			$description=pg_escape_string($description);
			$inscription_price=pg_escape_string($inscription_price);
			$inscription_location=pg_escape_string($inscription_location);
			$inscription_email=pg_escape_string($inscription_email);
			$inscription_website=pg_escape_string($inscription_website);


    	    if($is_selected=='true') {
    	        $is_selected="true";
    	    } else {
    	        $is_selected="false";
    	    }

    	    if($published=='true') {
    	        $published="true";
    	    } else {
    	        $published="false";
    	    }    	    
    	    
    	    $idflick="null";
    	    if($flickr_url!="") {
                //http://www.flickr.com/photos/luis_carrasco/3228648671/
                //extract the id
                $flic_pieces=explode("/",substr($flickr_url,0,-1));
                if(is_numeric(end($flic_pieces))) {
                    $idflick= "'". end($flic_pieces) ."'";
                }
            }
    	    
	        $sql="INSERT INTO run(name,event_location,distance_meters,distance_text,event_date,category,awards,".
	            "description, inscription_price,inscription_location,inscription_email,inscription_website,province_fk,is_displayed_in_home,run_type,published,tlf_informacion,flickr_url,flickr_img_id,start_point,end_point".
	            ") VALUES('$name','$event_location',$distance_meters,'$distance_text','$event_date',".
                "'$category','$awards','$description','$inscription_price','$inscription_location',".
                "'$inscription_email','$inscription_website', $province_id,$is_selected,$run_type,$published,'$tlf_informacion','$flickr_url',$idflick";

                if($start_point_lat) {
                    $sql.=",GeomFromText('POINT($start_point_lon $start_point_lat)',4326)";
                } else {
                    $sql.=",null";
                }
                if($end_point_lat) {
                    $sql.=", GeomFromText('POINT($end_point_lon $end_point_lat)',4326)";
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
    	    
			//Send alerts to users
			$sql="SELECT u.email,u.completename from run as r,users as u WHERE r.id=$newId AND u.radius_interest is not null AND distance_sphere(u.location_point,r.start_point) <(radius_interest*1000)";
			$alerts=pg_fetch_all(pg_query($this->conn, $sql)); 
			if($alerts) {
				//prepare email
				$mail = new PHPMailer();
				$mail->IsSMTP();
				$mail->SMTPAuth = true;
				$mail->SMTPSecure = "ssl";
				$mail->Host = "smtp.gmail.com";
				$mail->Port = 465;
				$mail->Username = "alertas@runnity.com";
				$mail->Password = $this->emailPassword;		

				$mail->From = $email;
				$mail->FromName = $mensaje;
				$mail->Subject = "Nueva carrera: $name ($event_location,$event_date)";
				$mail->MsgHTML("Mensaje enviado desde Runnity.com<br><br>$description");
				$mail->IsHTML(true);	

				foreach($alerts as $al) {
					$mail->AddBCC($al['email'], $al['completename']);
				}	
				$mail->Send();			
			}



    	    if (is_int($newId)) {
    	        return $newId;
    	    } else {
    	        return false;
    	    }
 	    
	    }
	    
    	public function updateRun($id,$name,$event_location,$distance_meters,$distance_text,$event_date,
    	    $category,$awards,$description,$inscription_price,$inscription_location,
    	    $inscription_email,$inscription_website,$start_point_lat,$start_point_lon,$end_point_lat,$end_point_lon, $province_id,$is_selected,$run_type,$published,$tlf_informacion,$flickr_url) {
                if (!$_SESSION['logged'] or $_SESSION['user']['is_admin']!='t') {
        	        throw new Exception("user not logged in");
        	    }

				$name=pg_escape_string($name);
				$event_location=pg_escape_string($event_location);
				$distance_text=pg_escape_string($distance_text);
				$category=pg_escape_string($category);
				$awards=pg_escape_string($awards);
				$description=pg_escape_string($description);
				$inscription_price=pg_escape_string($inscription_price);
				$inscription_location=pg_escape_string($inscription_location);
				$inscription_email=pg_escape_string($inscription_email);
				$inscription_website=pg_escape_string($inscription_website);
				$tlf_informacion=pg_escape_string($tlf_informacion);
				$flickr_url=pg_escape_string($flickr_url);


        	    $idflick="null";
        	    if($flickr_url!="") {
                    //http://www.flickr.com/photos/luis_carrasco/3228648671/
                    //extract the id
                    $flic_pieces=explode("/",substr($flickr_url,0,-1));
                    if(is_numeric(end($flic_pieces))) {
                        $idflick= "'". end($flic_pieces) ."'";
                    }
                }
        	    
        	    if($is_selected=='f') {
        	        $is_selected="false";
        	    } else {
        	        $is_selected="true";
        	    }
        	    
        	    if($published=='true') {
        	        $published="true";
        	    } else {
        	        $published="false";
        	    }        	    
                
        	        $sql="UPDATE run SET name='$name',event_location='$event_location', distance_meters=$distance_meters, distance_text='$distance_text',event_date='$event_date',category='$category',awards='$awards', description='$description', inscription_price='$inscription_price',inscription_location='$inscription_location',inscription_email='$inscription_email',inscription_website='$inscription_website',province_fk=$province_id,is_displayed_in_home=$is_selected,run_type=$run_type,published=$published,tlf_informacion='$tlf_informacion',flickr_url='$flickr_url',flickr_img_id=$idflick";
        	        
        	    if($start_point_lat) {
        	        $sql.=",start_point=GeomFromText('POINT($start_point_lon $start_point_lat)',4326)";
        	    } else {
        	        $sql.=",start_point=null";
        	    }    
        	    if($end_point_lat) {
        	        $sql.=",end_point=GeomFromText('POINT($end_point_lon $end_point_lat)',4326)";
        	    }  
        	    else {
        	        $sql.=",end_point=null";
        	    }      	    
        	        
        	    $sql.=" WHERE id=$id";
            $result= pg_query($this->conn, $sql);
            return null;

    }
    
    public function getTrackGeometry($id) {
        $sql="select x((ST_Dump(track_geom)).geom) as lon, y((ST_Dump(track_geom)).geom) as lat from run where id=$id";
        
        $result=array();
        $result['track']=pg_fetch_all(pg_query($this->conn, $sql));
        
        $sql="select x(start_point) as start_lon,y(start_point) as start_lat,x(end_point) as end_lon,y(end_point) as end_lat,altimetria  from run where id=$id";
	    $res=pg_query($this->conn, $sql);
	    $res2=pg_fetch_assoc($res);
	            
        $result['start']=array();
        $result['start']['lat']=$res2['start_lat'];
        $result['start']['lon']=$res2['start_lon'];
        $result['end']=array();
        $result['end']['lat']=$res2['end_lat'];
        $result['end']['lon']=$res2['end_lon'];      
        
        $result['altimetria']=substr($res2['altimetria'],1,-1);
        
        
        return $result;
    }
    
    
    public function updateRunGeometry($points,$altimetria,$id) {
        $wkt="MULTIPOINT(";
        foreach ($points as &$p) {
            $wkt.="(".$p['lon']." ". $p['lat'] ."),";
        }
        $wkt=substr($wkt,0,-1);
        $wkt.=")";
        
        $altText=implode(",",$altimetria);
        
        $sql="UPDATE run SET track_geom=geomFromText('$wkt',4326), altimetria='{".$altText."}' WHERE id=$id";
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
    
    
    //racesEditor, sitemap
    public function getRunsList($limit=0) {
        $sql="select id ,name,event_location,distance_meters,event_date,category,awards,description,inscription_price,inscription_location,inscription_email,inscription_website,distance_text,y(start_point) as start_point_lat, x(start_point) as start_point_lon, y(end_point) as end_point_lat, x(end_point) as end_point_lon,province_fk,is_displayed_in_home,created_when,run_type,published,tlf_informacion,flickr_url from run ORDER BY id DESC"; 
		if($limit!=0) {
			$sql.=" LIMIT $limit";
		}

		return pg_fetch_all(pg_query($this->conn, $sql));    
    }
    
    //carrera
    public function getRunDetails($id) {
        $sql="select r.id ,r.name,event_location,distance_meters,event_date,category,awards,description,inscription_price,tlf_informacion,inscription_location,inscription_email,inscription_website,distance_text,y(start_point) as start_point_lat, x(start_point) as start_point_lon, y(end_point) as end_point_lat, x(end_point) as end_point_lon,is_displayed_in_home,(select count(users_run.id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id,run_type,flickr_img_id,flickr_url";
        
        if(isset($_SESSION['logged']) and $_SESSION['logged']) {
            $sql.=",(select case when count(id)>0 then true else false end from users_run as ur where ur.run_fk=r.id and ur.users_fk=".$_SESSION['user']['id'].") as inscrito";
        } else {
            $sql.=",false as inscrito";
        }        
        
        $sql.=" from run as r left join province as p on r.province_fk=p.id where r.id=$id";
        $result = pg_query($this->conn, $sql);  
        $run = pg_fetch_assoc($result);
        
        
        $run['big_picture'] = "generic/".rand(1,4)."_big.jpg";
        
        return $run;
    }
    
    //RunAroundMap.as
    public function getRunsCloseToAnotherForMap($id) {
	    $sql="select r.id,r.name,event_date,run_type,event_location,distance_text, y(start_point) as lat, x(start_point) as lon";

        if(isset($_SESSION['logged']) and $_SESSION['logged']) {
            $sql.=",(select case when count(id)>0 then true else false end from users_run as ur where ur.run_fk=r.id and ur.users_fk=".$_SESSION['user']['id'].") as inscrito";
        } else {
            $sql.=",false as inscrito";
        }
        
        $sql.=" from run as r where r.event_date > now() and r.id <> $id ";
		$sql.=" and distance_sphere(r.start_point,(select start_point from run where id=$id)) <(40000)";
		$sql.=" order by event_date";
		
		$result=array();
		$result['around'] = pg_fetch_all(pg_query($this->conn, $sql));
		
		
		$sql="select y(start_point) as lat, x(start_point) as lon from run where id=$id";
		$result['coords'] = pg_fetch_assoc(pg_query($this->conn, $sql));
		
		return $result;
    }

    //carrera
    public function getRunsSimilarType($id) {
	    $sql="select r.id,r.name,event_date,event_location,distance_text,run_type, (select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id";

        if(isset($_SESSION['logged']) and $_SESSION['logged']) {
            $sql.=",(select case when count(id)>0 then true else false end from users_run as ur where ur.run_fk=r.id and ur.users_fk=".$_SESSION['user']['id'].") as inscrito";
        } else {
            $sql.=",false as inscrito";
        }
        
        $sql.=" from run as r left join province as p on r.province_fk=p.id where r.event_date > now() and r.id <> $id ";
		$sql.=" and run_type = (select run_type from run where id=$id)";
		$sql.=" order by event_date ASC limit 4";
		return pg_fetch_all(pg_query($this->conn, $sql));      
    }

    //carrera
    public function getRunsInSimilarDates($id) {
	    $sql="select r.id,r.name,event_date,event_location,distance_text,run_type, (select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id";

        if(isset($_SESSION['logged']) and $_SESSION['logged']) {
            $sql.=",(select case when count(id)>0 then true else false end from users_run as ur where ur.run_fk=r.id and ur.users_fk=".$_SESSION['user']['id'].") as inscrito";
        } else {
            $sql.=",false as inscrito";
        }
        
        $sql.=" from run as r left join province as p on r.province_fk=p.id where r.event_date > now() and r.id <> $id  ";
		$sql.=" and (event_date > (select (event_date::date-7) from run where id=$id) or event_date < (select (event_date::date+7) from run where id=$id))";
		$sql.=" order by event_date ASC limit 4";
		return pg_fetch_all(pg_query($this->conn, $sql));      
    }


    //ajaxController
	public function inscribeUserToRun($userId,$runId) {
		$sql="INSERT INTO users_run(users_fk,run_fk) VALUES ($userId,$runId)";
        $result= pg_query($this->conn, $sql);
        return null;		
	}
	
	//ajaxController
	public function unInscribeUserToRun($userId,$runId) {
		$sql="DELETE FROM users_run WHERE users_fk=$userId AND run_fk=$runId";
        $result= pg_query($this->conn, $sql);
        return null;		
	}

    //ajaxController
	public function sendEmailToAlertas($nombre,$email,$mensaje) {
		$mail = new PHPMailer();
		$mail->IsSMTP();
		$mail->SMTPAuth = true;
		$mail->SMTPSecure = "ssl";
		$mail->Host = "smtp.gmail.com";
		$mail->Port = 465;
		$mail->Username = "alertas@runnity.com";
		$mail->Password = $this->emailPassword;		

		$mail->From = $email;
		$mail->FromName = $mensaje;
		$mail->Subject = "Mensaje desde la web";
		$mail->MsgHTML("Mensaje enviado desde la web por $nombre ($email)<br><br>$mensaje");
		$mail->AddAddress("contacto@runnity.com", "Web runnity.com");
		$mail->IsHTML(true);	
		
		if(!$mail->Send()) {
			throw new Exception('Problema al enviar el email:'.$mail->ErrorInfo,110);
		}		
		return null;
	}
	
	
	
	
	//ajaxController
	public function setAlert($address,$distance) {
        if (!$_SESSION['logged']) {
	        throw new Exception("user not logged in");
	    }	    
	    
	    $address=pg_escape_string($address);
	    $userId=$_SESSION['user']['id'];
	    if($address=="" or !$address) {
	        //remove the possible alerts
	        $sql="UPDATE users SET locality=null, location_point=null, radius_interest=null WHERE id=$userId";
	        $result= pg_query($this->conn, $sql);
	        $sql="DELETE FROM pending_alerts WHERE user_fk=$userId";
	        $result= pg_query($this->conn, $sql);
	        $_SESSION['user']['locality']="";
	        $_SESSION['user']['radius_interest']="";
	        $_SESSION['user']['lat']=null;
	        $_SESSION['user']['lon']=null;	        
	        return true;
	    } else {
    	    $base_url = "http://maps.google.com/maps/geo?output=xml" . "&key=ABQIAAAAtDJGVn6RztUmxjnX5hMzjRTy9E-TgLeuCHEEJunrcdV8Bjp5lBTu2Rw7F-koeV8TrxpLHZPXoYd2BA";
    	    $request_url = $base_url . "&q=" . urlencode($address.",spain");
    	    if(!$xml = simplexml_load_file($request_url)) {
    	        return false;
    	    } 
    	    $status = $xml->Response->Status->code;
    	    if (!(strcmp($status, "200") == 0)) {
    	        return false;
            }
            $coordinates = $xml->Response->Placemark->Point->coordinates;
            $coordinatesSplit = split(",", $coordinates);
            // Format: Longitude, Latitude, Altitude
            $lat = $coordinatesSplit[1];
            $lon = $coordinatesSplit[0];        

    		$sql="UPDATE users SET locality='$address', location_point=PointFromText('POINT($lon $lat)', 4326), radius_interest=$distance WHERE id=$userId";
    		$result= pg_query($this->conn, $sql);

	        $_SESSION['user']['locality']=$address;
	        $_SESSION['user']['lat']=$lat;
	        $_SESSION['user']['lon']=$lon;
	        $_SESSION['user']['radius_interest']=$distance;

	        $sql="DELETE FROM pending_alerts WHERE user_fk=$userId";
	        $result= pg_query($this->conn, $sql);

    		//Estas son las que el hombre no ha sido informado al acabar de apuntarse
    		$sql="INSERT INTO pending_alerts(run_fk,user_fk) SELECT r.id as run_id,u.id as user_id from run as r,users as u WHERE u.id=$userId AND r.created_when <= now()::date-1 AND r.event_date < now()::date+30 AND u.radius_interest is not null AND distance_sphere(u.location_point,r.start_point) <(radius_interest*1000)";
            $result= pg_query($this->conn, $sql);
            
            
            
            return true;	   
            
            
                 
	    }
	}
	
	
	public function prepareAlerts() {
		$sql="INSERT INTO pending_alerts(run_fk,user_fk) SELECT r.id as run_id,u.id as user_id from run as r,users as u WHERE r.created_when > now()::date-1 AND r.event_date < now()::date+30 AND u.radius_interest is not null AND distance_sphere(u.location_point,r.start_point) <(radius_interest*1000)";
        $result= pg_query($this->conn, $sql);
        return null;		
	}
	
	public function sendAlerts() {
		$sql="select u.email,u.id as user_id,r.id,r.name,event_date,event_location,distance_text, p.name as province_name from ((pending_alerts as pa inner join run as r on pa.run_fk=r.id) inner join users as u on pa.user_fk=u.id) left join province as p on r.province_fk=p.id where r.event_date > now() order by user_id,event_date";
		
		//Do something
		
		
		//Remove the pending alerts
		$sql="DELETE FROM pending_alerts";
        $result= pg_query($this->conn, $sql);
        return null;		
	}
	
	//ajaxController
	public function sendPasswordToEmail($email) {
		$name=pg_escape_string($email);
		
		$sql="select pass from users where email='$email'";
		$result = pg_query($this->conn, $sql);  
        $user = pg_fetch_assoc($result);
		if(!$user) {
			return false;
		}

		$mail = new PHPMailer();
		$mail->IsSMTP();
		$mail->SMTPAuth = true;
		$mail->SMTPSecure = "ssl";
		$mail->Host = "smtp.gmail.com";
		$mail->Port = 465;
		$mail->Username = "alertas@runnity.com";
		$mail->Password = $this->emailPassword;		

		$mail->From = $email;
		$mail->FromName = $mensaje;
		$mail->Subject = "Password en Runnity.com";
		$mail->MsgHTML("Tu password es: ".$user['pass']);
		$mail->AddAddress($email, $email);
		$mail->IsHTML(true);	
		
		if(!$mail->Send()) {
			throw new Exception('Problema al enviar el email:'.$mail->ErrorInfo,110);
		}		
		return true;		
	}

}

?>
