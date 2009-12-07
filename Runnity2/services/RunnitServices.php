<?php
require_once($_SERVER['DOCUMENT_ROOT'] ."/runnit-config.php");
require_once($_SERVER['DOCUMENT_ROOT'] ."/libs/language/phpmailer.lang-es.php");
require_once($_SERVER['DOCUMENT_ROOT'] ."/libs/class.phpmailer.php");
require_once($_SERVER['DOCUMENT_ROOT'] ."/libs/class.smtp.php");
require_once($_SERVER['DOCUMENT_ROOT'] ."/libs/Smarty.class.php");
require_once($_SERVER['DOCUMENT_ROOT'] ."/libs/Twitter.class.php");

class RunnitServices {
	
	function __construct() {
	    $this->conn = pg_pconnect ("host=".DB_HOST." dbname=".DB_NAME." user=".DB_USER." password=".DB_PASSWORD);
	
		$this->emailPassword=EMAILPASSWORD;
		$this->basePath=ABSPATH;
	}
	
	private function getMailService() {
	    $mail = new PHPMailer();
		$mail->IsSMTP();
		$mail->SMTPAuth = true;
		$mail->SMTPSecure = "ssl";
		$mail->Host = "smtp.gmail.com";
		$mail->Port = 465;
		$mail->Username = "alertas@runnity.com";
		$mail->Password = $this->emailPassword;
		return $mail;
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
 			$sql="UPDATE users SET previous_login=last_login, last_login=now() WHERE id=".$res['id'];
			pg_query($this->conn, $sql);
    	    return $res;           
        }
	}
	
	//ajaxController
	public function logout() {
	    session_destroy();
	}	
	
	//carrera.php
	public function getComments($on_id,$table) {
	    $table=pg_escape_string($table);
	    
	    $sql="SELECT c.id,commenttext,c.created_when,username,u.id as user_id from comments as c INNER JOIN users as u ON c.user_fk=u.id  WHERE on_id=$on_id AND on_table='$table' ORDER BY c.created_when ASC";	    

	    //Check if the user has avatars or not
	    $result = pg_fetch_all(pg_query($this->conn, $sql));

	    if($result) {
    	    foreach ($result as &$comment) {
                $comment['commenttext'] = ereg_replace("[[:alpha:]]+://[^<>[:space:]]+[[:alnum:]/]", "<a href=\"\\0\">\\0</a>", $comment['commenttext']);  
                $comment['commenttext'] = preg_replace("/(http:\/\/|(www\.))(([^\s<]{4,68})[^\s<]*)/", '<a href="http://$2$3" rel="nofollow">$2$4</a>', $comment['commenttext']);
            }	        
    	}	    
	    /*
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
	    */
	    
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
	public function isEmailFree($email) {
	    $email=pg_escape_string($email);
	    $sql="SELECT id from users WHERE email='$email'";
	    $result=pg_query($this->conn, $sql);
	    if(pg_num_rows($result)>0) {
	        return false;
	    }
	       
	    return true;
	}	
	
	//ajaxController
	public function registerUser($username,$completename,$email,$password,$birthdayDay,$birthdayMonth,$birthdayYear,$localidad,$lat,$lon,$radio) {
	    $username=pg_escape_string($username);
	    $completename=pg_escape_string($completename);
	    $email=pg_escape_string($email);
	    $password=pg_escape_string($password);
	    $localidad=pg_escape_string($localidad);
	    
	    if(strlen($username)<5) {
	        throw new Exception('El nombre de usuario debe ser mayor de 5 caracteres.',101);
	    }
	    
	    if(strlen($password)<5) {
	        throw new Exception('El password debe ser mayor de 5 caracteres.',102);
	    }
	    if(strlen($email)<5) {
	        throw new Exception('Tu email es incorrecto.',103);
	    }	 
	    
	    if(!is_numeric($birthdayDay) || !is_numeric($birthdayMonth) || !is_numeric($birthdayYear)) {
	        throw new Exception('Fecha de nacimiento incorrecta.',106);
	    }
	    
	    if(!is_numeric($lat) || !is_numeric($lon)) {
	        throw new Exception('Coordenadas incorrectas.',106);
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
	    
	    $birthday="$birthdayYear-$birthdayMonth-$birthdayDay";
	    
	    if($radio!=null and is_numeric($radio)) {
	        $radius_interest=$radio;
	    } else {
	        $radius_interest='null';
	    }
	    
	    
	    $sql="INSERT INTO users(username,pass,completename,email,birthday,locality,location_point,radius_interest) VALUES('$username','$password','$completename','$email','$birthday','$localidad',GeomFromText('POINT($lon $lat)',4326),$radius_interest)";
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
	
		//Send confirmation emailsear

        $mail = $this->getMailService();

        $smarty = new Smarty; 
        $smarty->assign('name', $completename);
        $smarty->assign('username', $username);
        $email_message = utf8_decode($smarty->fetch(ABSPATH.'templates/email_registro.tpl'));

		$mail->From = "alertas@runnity.com";
		$mail->FromName = "Registro Runnity";
		$mail->Subject = "Bienvenido a Runnity.com ".$username;
		$mail->AltBody = $noHtml;
		$mail->MsgHTML($email_message);
		$mail->AddAddress($email, $completename);
		$mail->IsHTML(true);	
		
		if(!$mail->Send()) {
			throw new Exception('Problema al enviar el email:'.$mail->ErrorInfo,110);
		}			
		
   		//Tweet!!!
		$tweet = new Twitter(TWITTER_USER, TWITTER_PASS);
		$tweetMessage="Tenemos un nuevo usuario! Mira su perfil en www.runnity.com/user/".ereg_replace(" ","%20",$username);
        $success = $tweet->update($tweetMessage);
		if (!$success) {
			error_log("TWITTER PROBLEM: ".$tweet->error);
		}		
		
		
        $_SESSION['logged']=true;
        $_SESSION['user']['id']=$user['id'];
        $_SESSION['user']['username']=$username;
        $_SESSION['user']['completename']=$completename;
        $_SESSION['user']['email']=$email;
        $_SESSION['user']['locality']=$localidad;
        $_SESSION['user']['birthdayDay']=$birthdayDay;    
        $_SESSION['user']['birthdayMonth']=$birthdayMonth;    
        $_SESSION['user']['birthdayYear']=$birthdayYear;		
		
	
	    return $user;
	}
	
	//ajaxController
	public function updateUser($username,$completename,$email,$password,$birthdayDay,$birthdayMonth,$birthdayYear,$locality,$lat,$lon,$radio,$is_men) {
	    if (!$_SESSION['logged'] or $_SESSION['user']['username']!=$username) {
	        throw new Exception("user not logged in");
	    }
	    
	    $username=pg_escape_string($username);
	    $completename=pg_escape_string($completename);
	    $email=pg_escape_string($email);
	    $password=pg_escape_string($password);
	    $locality=pg_escape_string($locality);
	    
	    $birthday="$birthdayYear-$birthdayMonth-$birthdayDay";	    
	    
	    
        $sql = "SELECT id FROM users WHERE username='$username'";        
        $result = pg_query($this->conn, $sql);
        if(pg_num_rows($result)<1) {
            throw new Exception("username does not exist");
        } else {
            $res=pg_fetch_assoc($result);
            $userId=$res['id'];      
        }	 
        
        
        $sql = "SELECT id,email FROM users WHERE username<>'$username' AND email='$email'";        
        $result = pg_query($this->conn, $sql);
        if(pg_num_rows($result)>0) {
            throw new Exception("tried to change email to an already registered email");
        } 
	    

	    $sql="UPDATE users SET completename='$completename', email='$email', birthday='$birthday', location_point = GeomFromText('POINT($lon $lat)',4326)";
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
		
		if($is_men) {
			$sql.=",is_men=true"; 
		} else {
			$sql.=",is_men=false"; 
		}
	     
	    $sql.=" WHERE username='$username'";
        $result= pg_query($this->conn, $sql);
        
        $_SESSION['logged']=true;
        $_SESSION['user']['id']=$userId;
        $_SESSION['user']['username']=$username;
        $_SESSION['user']['completename']=$completename;
        $_SESSION['user']['email']=$email;
        $_SESSION['user']['locality']=$locality;
        $_SESSION['user']['radius_interest']=$radio;    
        $_SESSION['user']['birthdayDay']=$birthdayDay;    
        $_SESSION['user']['birthdayMonth']=$birthdayMonth;    
        $_SESSION['user']['birthdayYear']=$birthdayYear;  
		$_SESSION['user']['lat']=$lat;   
		$_SESSION['user']['lon']=$lon;     
        return null;
	    
	     
    }

	/*public function getRunsForBBox($north,$south,$east,$west) {
		$sql="select r.id,r.name,event_date,event_location,distance_text, (select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id from run as r left join province as p on r.province_fk=p.id where r.event_date > now() and start_point && ST_SetSRID(ST_MakeBox2D(ST_Point($west, $south), ST_Point($east ,$north)),4326)";
	} */
	
	
	public function removeUser($id) {
	    $sql="DELETE FROM users WHERE id=$id";
	    $result= pg_query($this->conn, $sql);
	    $sql="DELETE FROM users_groups WHERE users_fk=$id";
	    $result= pg_query($this->conn, $sql);
	    $sql="DELETE FROM users_records WHERE user_fk=$id";
	    $result= pg_query($this->conn, $sql);
	    $sql="DELETE FROM users_relations WHERE users_fk=$id";
	    $result= pg_query($this->conn, $sql);
	    $sql="DELETE FROM users_run WHERE users_fk=$id";
	    $result= pg_query($this->conn, $sql);
	    $sql="DELETE FROM picture WHERE user_fk=$id";
	    $result= pg_query($this->conn, $sql);
	    $sql="DELETE FROM comments WHERE user_fk=$id";
	    $result= pg_query($this->conn, $sql);
	    
	    $this->logout();
	    return true;
	}
	
	//usuario_publico.php
	public function getUserInfo($username) {
	    
	    $result=array();
	    $username=pg_escape_string($username);
	    $sql="select id,completename,username,email,created_when,birthday from users where username='$username'";
        $result['datos'] = pg_fetch_assoc(pg_query($this->conn, $sql));
        if(!$result['datos']) {
            return false;
        }
	    

	    $result['carreras']=$this->getUserRuns($result['datos']['id']);
	    $result['amigos']=$this->getUserFriends($result['datos']['id']);
	    $result['grupos']=$this->getUserGroups($result['datos']['id']);
	     $result['records']=$this->getUserRecords($result['datos']['id']);
	    
	    //update visits stats
	    $sql="UPDATE users SET visits_profile=visits_profile+1 WHERE username='$username'";
	    pg_query($this->conn, $sql);
	    
	    return $result;
	    
	}
	
	//usuario.php
	public function getUserPrivateData($username) {
	    if (!$_SESSION['logged']) {
	        throw new Exception("user not logged in");
	    }		
	
	    $result=array();
	    $username=pg_escape_string($username);
	    $sql="select u.id,completename,username,email,created_when,visits_profile,birthday,pass,locality,radius_interest,is_men,x(location_point) as lon, y(location_point) as lat,(select count(com.id) from users as usr inner join comments as com on com.on_id=usr.id and on_table='user' where usr.id=u.id and com.created_when > usr.previous_login) as num_messages,(select count(ur.id) from users_run as ur inner join run as r on ur.run_fk=r.id WHERE users_fk=u.id and r.event_date < now()) as num_races_runned from users as u where username='$username'";
        $result['datos'] = pg_fetch_assoc(pg_query($this->conn, $sql));
        if(!$result['datos']) {
            return false;
        }
	    

	    $result['carreras']=$this->getUserRuns($result['datos']['id']);
	    $result['records']=$this->getUserRecords($result['datos']['id']);
	    $result['amigos']=$this->getUserFriends($result['datos']['id']);
	    $result['grupos']=$this->getUserGroups($result['datos']['id']);	    
	    
	    return $result;
	    
	}
	
	public function getUserRaces($id) {
	    $sql="select r.id,r.name,x(start_point) as lng,y(start_point) as lat,r.event_date 
	        from users_run as ur inner join users as u on ur.users_fk=u.id inner join run as r on ur.run_fk=r.id 
	        where u.id=$id";
	    return pg_fetch_all(pg_query($this->conn, $sql));
	}
	
	public function getUserRecords($id) {
	    $sql="select distance_name,time_taken, 1 as ranking from users_records as ur inner join record_distance as rd on ur.record_distance_fk=rd.id WHERE ur.user_fk=$id";
	    return pg_fetch_all(pg_query($this->conn, $sql));
	    
	}
	
	public function getAllRecordsForUser($id) {
	    $sql="select rd.id, distance_name,time_taken from record_distance as rd left join users_records as ur on rd.id=ur.record_distance_fk and ur.user_fk=$id order by distance ASC";
	    return pg_fetch_all(pg_query($this->conn, $sql));
	    
	}
	
	public function getUserFriends($id) {
	    $sql="select f.id,f.username from users_relations as ur inner join users as f on ur.friend_fk=f.id where ur.users_fk=$id";
	    return pg_fetch_all(pg_query($this->conn, $sql));
	}
	
	public function isUserAlreadyFriend($id) {
	    if (!isset($_SESSION['logged']) or !$_SESSION['logged']) {
	        throw new Exception("user not logged in");
	    }
	    $sql="select id from users_relations where users_fk=".$_SESSION['user']['id']." AND friend_fk=$id";
	    $result=pg_query($this->conn, $sql);
	    if(pg_num_rows($result)>0) {
	        return true;
	    }	       
	    return false;	    
	}
	
	public function getUserGroups($id) {
	    $sql="select g.id,g.name from users_groups as ug inner join groups as g on ug.group_fk=g.id where ug.users_fk=$id";
	    return pg_fetch_all(pg_query($this->conn, $sql));
	}	
	
	public function getGroupUsers($id) {
	    $sql="select u.id,u.username from users_groups as ug inner join users as u on ug.users_fk=u.id where ug.group_fk=$id";
	    return pg_fetch_all(pg_query($this->conn, $sql));
	}	
	
	public function setUserToFriend($friendId) {
	    if (!$_SESSION['logged']) {
	        throw new Exception("user not logged in");
	    }	    
	    $sql="INSERT INTO users_relations(users_fk,friend_fk) VALUES(".$_SESSION['user']['id'].",$friendId)";
	    $result= pg_query($this->conn, $sql);
	    
	    $sql="select username,email from users where id=".$friendId;
	    $res=pg_fetch_assoc(pg_query($this->conn, $sql));
	    
	    $followingFriendName=$res['username'];
	    $followingFriendEmail=$res['email'];
	    
	    //Send message to user to let him know that someone has made him friend
        $mail = $this->getMailService();
		$mail->From = "alertas@runnity.com";
		$mail->FromName = "Alertas Runnity";
		$mail->Subject = "Runnity: ".$_SESSION['user']['username']." te esta siguiendo!";	

        
        $smarty = new Smarty; 
        $smarty->assign('followerName', $_SESSION['user']['username']);
        $smarty->assign('followingFriendName', $followingFriendName);
        

        $email_message = utf8_decode($smarty->fetch(ABSPATH.'templates/email_amigo_recien_creado.tpl'));
        $noHtml="";

		$mail->MsgHTML($email_message);
		$mail->AddAddress($followingFriendEmail, $followingFriendName);
		$mail->IsHTML(true);		
		$mail->AltBody = "";


		if(!$mail->Send()) {
		    error_log("ALERTAS: Email to $followingFriendName no pudo enviarse");
		}	    
	    
	    return null;
	}
	
	public function setUserToGroup($groupId) {
	    if (!$_SESSION['logged']) {
	        throw new Exception("user not logged in");
	    }	    
	    $sql="INSERT INTO users_groups(users_fk,group_fk) VALUES(".$_SESSION['user']['id'].",$groupId)";
	    $result= pg_query($this->conn, $sql);
	    return null;
	}	
	
	public function unSetUserToGroup($groupId) {
	    if (!$_SESSION['logged']) {
	        throw new Exception("user not logged in");
	    }	    
	    $sql="DELETE FROM users_groups WHERE users_fk = ".$_SESSION['user']['id']." AND group_fk =$groupId)";
	    $result= pg_query($this->conn, $sql);
	    return null;
	}	
	
	public function unSetUserToFriend($friendId) {
	    if (!$_SESSION['logged']) {
	        throw new Exception("user not logged in");
	    }	    
	    $sql="DELETE FROM users_relations WHERE users_fk = ".$_SESSION['user']['id']." AND friend_fk =$friendId)";
	    $result= pg_query($this->conn, $sql);
	    return null;
	}	
	
	public function createGroup($name,$userId) {
	    if (!$_SESSION['logged']) {
	        throw new Exception("user not logged in");
	    }
	    $name=pg_escape_string($name);
	    $sql="select id from groups where name ilike '%$name%'";
	    if(pg_num_rows($result)>0) {
	        return false;
	    }
	    
	    	    
	}
	
	//Home
	public function getLastActivity() {
		$sql="SELECT r1.id as run1_id,r1.name as run1_name,a.run1_description, 
			  r2.id as run2_id,r2.name as run2_name,a.run2_description,
			  r3.id as run3_id,r3.name as run3_name,a.run3_description,
			  (select count(id) from users_run where run_fk=r1.id) as run1_num_users,
			  (select count(id) from users_run where run_fk=r2.id) as run2_num_users,
			  (select count(id) from users_run where run_fk=r3.id) as run3_num_users,
			  r1.flickr_img_id as flickr_img_id_1,r2.flickr_img_id as flickr_img_id_2,r3.flickr_img_id as flickr_img_id_3
			  FROM activity as a 
 			  INNER JOIN run as r1 ON a.run1_fk=r1.id 
 			  INNER JOIN run as r2 ON a.run2_fk=r2.id
   			  INNER JOIN run as r3 ON a.run3_fk=r3.id";
		return pg_fetch_all(pg_query($this->conn, $sql));  
	}		
	
	//runnitHomeMap	    
	public function getAllRuns($days=0,$runType=0) {
	    
		$sql="select x(start_point) as lon, y(start_point) as lat,r.id,r.name,event_date,event_location,distance_text, p.name as province_name,r.province_fk as province_id,run_type from run as r left join province as p on r.province_fk=p.id where published=true and start_point is not null";
		
		if ($days!=0) {
		    $sql.=" AND event_date <= (now()::date +".$days .") AND event_date > now()::date";
		}

		if ($runType!=0) {
		    $sql.=" AND run_type =".$runType;
		}		
		
		
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
        

        $activity_description="Un nuevo comentario";
        $user_from = $_SESSION['user']['username'];

        if($table=="run") {
            $sql="UPDATE activity SET run3_fk = run2_fk, run3_description=run2_description,run2_fk = run1_fk, run2_description=run1_description, run1_fk=$id, run1_description='".$activity_description."'";
            $result= pg_query($this->conn, $sql);   
            
            $user_from_id = $_SESSION['user']['id'];
            $sql="select distinct username,completename,u.id,email from comments as c inner join users as u on c.user_fk=u.id where on_id=$id and u.id not in ($user_from_id)";
			$result=pg_fetch_all(pg_query($this->conn, $sql));			
			if ($result){
				for($i = 0; $i < sizeof($result); ++$i){
	    			error_log($result[$i]['email']);  			
		    		$noHtml="Runnity.com\n\n
					$user_from ha comentado una carrera que has comentado:\n\n Si quieres puedes ver el mensaje en: /run/$id";
				
					//Send confirmation emailsear
			
			        $mail = $this->getMailService();
			
			        $smarty = new Smarty; 
			        $smarty->assign('username', $result[$i]['username']);
			        $smarty->assign('user_from', $user_from);
			        $smarty->assign('comment', $comment);
			        $smarty->assign('table', $table);
			        $smarty->assign('idRun', $id);
			        
			        $email_message = utf8_decode($smarty->fetch(ABSPATH.'templates/email_carrera_comment.tpl'));
			
					$mail->From = "alertas@runnity.com";
					$mail->FromName = "Runnity";
					$mail->Subject = "Tienes un mensaje nuevo en una carrera que has comentado ".$result[$i]['username'];
					$mail->AltBody = $noHtml;
					$mail->MsgHTML($email_message);
					$mail->AddAddress($result[$i]['email'], $result[$i]['completename']);
					$mail->IsHTML(true);	
					
					if(!$mail->Send()) {
						throw new Exception('Problema al enviar el email:'.$mail->ErrorInfo,110);
					}
				}
			}
            
            
            
            
                     
        }
        
        //Notify the user if a comment has been sent to him
        if($table=="user") {
			
			$sql="SELECT distinct u.email,u.completename,u.username FROM users as u INNER JOIN comments as c ON u.id=c.on_Id where c.on_id=$id and c.user_fk=$userId";
			$result=pg_query($this->conn, $sql);
			$mailUser=pg_fetch_result($result,0);       	
			$completeName=pg_fetch_result($result,1);
			$userName=pg_fetch_result($result,2);
			
			//mensaje en HTML
			$noHtml="Runnity.com\n\n
			$user_from te ha dejado un mensaje:\n\n
			'$comment'
			
			Si quieres puedes ver el mensaje en tu perfil: /user/$userName";
		
			//Send confirmation emailsear
	
	        $mail = $this->getMailService();
	
	        $smarty = new Smarty; 
	        $smarty->assign('name', $completeName);
	        $smarty->assign('username', $userName);
	        $smarty->assign('user_from', $user_from);
	        $smarty->assign('comment', $comment);
	        
	        $email_message = utf8_decode($smarty->fetch(ABSPATH.'templates/email_mensaje.tpl'));
	
			$mail->From = "alertas@runnity.com";
			$mail->FromName = "Runnity";
			$mail->Subject = "Tienes un mensaje nuevo ".$userName;
			$mail->AltBody = $noHtml;
			$mail->MsgHTML($email_message);
			$mail->AddAddress($mailUser, $completeName);
			$mail->IsHTML(true);	
			
			if(!$mail->Send()) {
				throw new Exception('Problema al enviar el email:'.$mail->ErrorInfo,110);
			}			

        }
        
        //Notify the user if a comment has been sent to him
        if($table=="picture") {
            
            $sql="select u.id as userid,username,completename,p.id,email from picture as p inner join users as u on p.user_fk=u.id  where p.id=$id";
			$result=pg_query($this->conn, $sql); 
			$user_Up=pg_fetch_assoc($result);
			
			$noHtml="Runnity.com\n\n
			$user_from ha comentado una foto tuya:\n\n Si quieres puedes ver el mensaje en: /picture/$id/$table";
		
			//Send confirmation emailsear
	
	        $mail = $this->getMailService();
	
	        $smarty = new Smarty; 
	        $smarty->assign('username', $user_Up['username']);
	        $smarty->assign('user_from', $user_from);
	        $smarty->assign('comment', $comment);
	        $smarty->assign('table', $table);
	        $smarty->assign('idFoto', $id);
	        
	        $email_message = utf8_decode($smarty->fetch(ABSPATH.'templates/email_foto.tpl'));
	
			$mail->From = "alertas@runnity.com";
			$mail->FromName = "Runnity";
			$mail->Subject = "Tienes un mensaje nuevo en una foto ".$user_Up['username'];
			$mail->AltBody = $noHtml;
			$mail->MsgHTML($email_message);
			$mail->AddAddress($user_Up['email'], $user_Up['completename']);
			$mail->IsHTML(true);	
			
			if(!$mail->Send()) {
				throw new Exception('Problema al enviar el email:'.$mail->ErrorInfo,110);
			}		
			
			$user_up_id=$user_Up['userid'];
            $user_from_id = $_SESSION['user']['id'];
			
			$sql="select distinct username,completename,u.id,email from comments as c inner join users as u on c.user_fk=u.id where on_id=$id and u.id not in ($user_from_id,$user_up_id)";
			$result=pg_fetch_all(pg_query($this->conn, $sql));			
			if ($result){
				for($i = 0; $i < sizeof($result); ++$i){
	    			error_log($result[$i]['email']);  			
		    		$noHtml="Runnity.com\n\n
					$user_from ha comentado una foto que has comentado:\n\n Si quieres puedes ver el mensaje en: /picture/$id/$table";
				
					//Send confirmation emailsear
			
			        $mail = $this->getMailService();
			
			        $smarty = new Smarty; 
			        $smarty->assign('username', $result[$i]['username']);
			        $smarty->assign('user_from', $user_from);
			        $smarty->assign('comment', $comment);
			        $smarty->assign('table', $table);
			        $smarty->assign('idFoto', $id);
			        
			        $email_message = utf8_decode($smarty->fetch(ABSPATH.'templates/email_foto_comment.tpl'));
			
					$mail->From = "alertas@runnity.com";
					$mail->FromName = "Runnity";
					$mail->Subject = "Tienes un mensaje nuevo en una foto que has comentado ".$result[$i]['username'];
					$mail->AltBody = $noHtml;
					$mail->MsgHTML($email_message);
					$mail->AddAddress($result[$i]['email'], $result[$i]['completename']);
					$mail->IsHTML(true);	
					
					if(!$mail->Send()) {
						throw new Exception('Problema al enviar el email:'.$mail->ErrorInfo,110);
					}
				}
			}
        }
        
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
    	    $sql="select u.id as user_id,username, r.name as run_name, r.id as run_id, (select count(id) from users_run where run_fk=r.id) as num_participants from users_run as ur inner join users as u on ur.users_fk=u.id inner join run as r on ur.run_fk=r.id order by ur.id DESC";	        
	    } else {
	        $sql="select u.id as user_id,username, r.name as run_name, r.id as run_id, (select count(id) from users_run where run_fk=r.id) as num_participants from users_run as ur inner join users as u on ur.users_fk=u.id inner join run as r on ur.run_fk=r.id where ur.run_fk= $runId order by ur.id DESC";
	    }
	    //Check if the user has avatars or not
	    $result = pg_fetch_all(pg_query($this->conn, $sql));

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
	    $sql="select r.id,r.name,event_date,event_location,distance_text, (select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id,run_type from (run as r inner join users_run as ur on r.id=ur.run_fk) left join province as p on r.province_fk=p.id where ur.users_fk=$id AND r.event_date > now() order by event_date ASC";
        $result = pg_query($this->conn, $sql);  
        return pg_fetch_all(pg_query($this->conn, $sql));
	}	
	
	//searchresults
		public function searchRuns($q,$tipoCarrera,$tipoBusqueda,$fechaInicio,$fechaFin,$offset) { 
	    $q=pg_escape_string($q);
        if(!$offset) {
            $offset=0;
        }
        
	    $sql="select r.id,r.name,event_date,event_location,flickr_img_id,distance_text,(SELECT COUNT(id) FROM picture where on_id=r.id) as num_pictures,(SELECT COUNT(id) FROM comments where on_id=r.id) as num_comments,(select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id,run_type,date_trunc('day',event_date) as event_day";
		$sql.=",CASE WHEN EXTRACT(DOW FROM event_date)=0 THEN 7 ELSE EXTRACT(DOW FROM event_date) END as day_in_week";

        if(isset($_SESSION['logged']) and $_SESSION['logged']) {
            $sql.=",(select case when count(id)>0 then true else false end from users_run as ur where ur.run_fk=r.id and ur.users_fk=".$_SESSION['user']['id'].") as inscrito";
        } else {
            $sql.=",false as inscrito";
        }   
	    
	    $sql.=" from run as r left join province as p on r.province_fk=p.id where published=true ";
	    
	    if($fechaInicio!="") {
	   		$sql.=" and r.event_date >= '$fechaInicio'";	    
	    }		        

	    if($fechaFin!="") {
	   		$sql.=" and r.event_date <= '$fechaFin'";	    
	    }
	    
	    if($tipoBusqueda=="Proximas") {
	   		$sql.=" and r.event_date > now()";	    
	    }	
	    
		        


	    $terms=explode(" ",$q);

        $termsToAvoid=array("El","el","LA","La","la","Los","los","Las","las","En","en","De","de","y","o","i");
	    if(count($terms)>0 and $q!="") {
	        $sql.=" AND (";
    	    foreach($terms as $term) {
    	        if (!in_array($term, $termsToAvoid)) {
    	            $sql.=" to_ascii(convert_to(r.name, 'latin1'), 'latin1') ilike to_ascii(convert_to('%$term%', 'latin1'), 'latin1') or to_ascii(convert_to(event_location, 'latin1'), 'latin1') ilike to_ascii(convert_to('%$term%', 'latin1'), 'latin1') or to_ascii(convert_to(p.name, 'latin1'), 'latin1') ilike to_ascii(convert_to('%$term%', 'latin1'), 'latin1') or p.cautonoma_noaccents ilike to_ascii(convert_to('%$term%', 'latin1'), 'latin1') AND";
    	        }
    	    }	 
    	    $sql=substr($sql,0,-3);
    	    $sql.=")";       
	    } 
	    
	    $RunTypeSearch="";
	    //tipo de carrera
	    switch ($tipoCarrera) {
		    case 'Todas': 
	    		$RunTypeSearch=0;
	    		break;
	    	case 'Mediofondo': 
	    		$RunTypeSearch=1;
	    		break;
	    	case 'Fondo': 
	    		$RunTypeSearch=2;
	    		break;
	    	case 'Marathon/Ultrafondo': 
	    		$RunTypeSearch=3;
	    		break;
	    	case 'Cross/Campo': 
	    		$RunTypeSearch=4;
	    		break;
	    	case 'Combinadas': 
	    		$RunTypeSearch=5;
	    		break;
		}
		
		if ($RunTypeSearch!=0){
			$sql.=" AND run_type = $RunTypeSearch";
		}
	    
	    $sqlForCount="SELECT COUNT(id) as num_results FROM ($sql) as s";
	    
	    $sql.=" order by event_date ASC limit 10 offset $offset";
        
        //echo($sql);
        
        $results=array();
        $results['data'] = pg_fetch_all(pg_query($this->conn, $sql));
        
        if($results['data']) {
            $resultCount=pg_query($this->conn, $sqlForCount);
    	    $resultCount=pg_fetch_assoc($resultCount);
            $results['count'] =(int)$resultCount['num_results'];            
        } else {
            $results['count'] =0;  
			return $results;
        }

        //Iterate over the array to check if the runs have images on the server or not and provide a random one
	    foreach ($results['data'] as &$run) {
	        $targetPicture=$this->basePath."media/run/".$run['id']."_small.jpg";
            if (file_exists($targetPicture)) {
                $run['thumbnail'] = $run['id']."_small.jpg";
            } else {
                //no image for the run, select random
                $run['thumbnail'] = "generic/".rand(1,4)."_small.jpg";
            }
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
	
		$sql.=" order by event_date ASC limit 3";
	    
	    $result = pg_fetch_all(pg_query($this->conn, $sql));
	    
	    return $result;   
	}
	
	//index
	public function getNextImportantRuns($lat=0,$lon=0,$distance_km=150) {	
	$sql="select r.id,r.name,event_date,event_location,distance_text, (select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id,run_type,flickr_img_id";
	
	if(isset($_SESSION['logged']) and $_SESSION['logged']) {
	    $sql.=",(select case when count(id)>0 then true else false end from users_run as ur where ur.run_fk=r.id and ur.users_fk=".$_SESSION['user']['id'].") as inscrito";
	}
	
	$sql.=" from run as r left join province as p on r.province_fk=p.id where r.event_date > now() and published=true and (track_geom is not null or is_displayed_in_home=true)";
	

		if($lat!=0 && $lon!=0) {
			$sql.=" AND distance_sphere(PointFromText('POINT($lon $lat)', 4326),start_point) <($distance_km*1000)";
		}
	
		$sql.=" order by event_date ASC limit 3";
	    
	    $result = pg_fetch_all(pg_query($this->conn, $sql));
	    
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
    	        

            	$activity_description="Alta de carrera";

                $sql="UPDATE activity SET run3_fk = run2_fk, run3_description=run2_description,run2_fk = run1_fk, run2_description=run1_description, run1_fk=$id, run1_description='".$activity_description."'";
                $result= pg_query($this->conn, $sql);

                            
    	        
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
    	    
    	    if($published=='true') {
            	$activity_description="Alta de carrera";

                $sql="UPDATE activity SET run3_fk = run2_fk, run3_description=run2_description,run2_fk = run1_fk, run2_description=run1_description, run1_fk=$newId, run1_description='".$activity_description."'";
                $result= pg_query($this->conn, $sql);       

           		//Tweet!!!
				$tweet = new Twitter(TWITTER_USER, TWITTER_PASS);
        		$tweetMessage=substr($name." (".$event_location.") http://runnity.com/run/".$id."/tw",0,140);
    	        $success = $tweet->update($tweetMessage);
				if (!$success) {
					error_log("TWITTER PROBLEM: ".$tweet->error);
				}
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
        	    
        	    //Update the activity table
                
                //1)Look if the run was already published
                $sql="SELECT published from run WHERE id=$id";
                $res=pg_fetch_assoc(pg_query($this->conn, $sql));
                if($res['published']=="t") {
                    $activity_description="Datos actualizados";
                } else {
                    if ($published=='true') {
                        $activity_description="Alta de carrera";
                   		//Tweet!!!
        				$tweet = new Twitter(TWITTER_USER, TWITTER_PASS);
        				$tweetMessage=substr($name." (".$event_location.") http://runnity.com/run/".$id."/tw",0,140);
            	        $success = $tweet->update($tweetMessage);
        				if (!$success) {
        					error_log("TWITTER PROBLEM: ".$tweet->error);
        				}                        
                        
                        
                    }
                }
                $sql="UPDATE activity SET run3_fk = run2_fk, run3_description=run2_description,run2_fk = run1_fk, run2_description=run1_description, run1_fk=$id, run1_description='".$activity_description."'";
                $result= pg_query($this->conn, $sql);

                            
        	        	    
                
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
    
    public function getUserPositions($id) {
        
        $sql="select rd.distance_name,rd.id,time_taken,
            (select count(ur2.id) +1 as position from users_records as ur2 where time_taken< ur.time_taken AND record_distance_fk=rd.id) as position
            from users_records as ur inner join record_distance as rd on ur.record_distance_fk=rd.id where user_fk=$id order by rd.id";
            
        return pg_fetch_all(pg_query($this->conn, $sql));  
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
        $sql="select id ,name,event_location,distance_meters,event_date,category,awards,description,inscription_price,inscription_location,inscription_email,inscription_website,distance_text,y(start_point) as start_point_lat, x(start_point) as start_point_lon, y(end_point) as end_point_lat, x(end_point) as end_point_lon,province_fk,is_displayed_in_home,created_when,run_type,published,tlf_informacion,flickr_url from run where event_date > now()::date ORDER BY id DESC"; 
		if($limit!=0) {
			$sql.=" LIMIT $limit";
		}

		return pg_fetch_all(pg_query($this->conn, $sql));    
    }
    
    public function getAllRunsSitemap() {
        $sql="select id,name from run WHERE published=true";
        return pg_fetch_all(pg_query($this->conn, $sql));
    }    
    
    public function getAllUsersSitemap() {
        $sql="select id,username from users";
        return pg_fetch_all(pg_query($this->conn, $sql));
    } 
    
    public function getAllImagesSitemap() {
        $sql="select id from picture WHERE on_table='run'";
        return pg_fetch_all(pg_query($this->conn, $sql));
    }       

	public function getRunListSmall() {
		$sql="select id,name,date_part('day',event_date) as dia,date_part('month',event_date) as mes,date_part('year',event_date) as anyo  from run where event_date > now() and published=true";
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
        
        $sql.=" from run as r where r.event_date > now() and published=true and r.id <> $id ";
		$sql.=" and distance_sphere(r.start_point,(select start_point from run where id=$id)) <(40000)";
		$sql.=" order by event_date";
		
		$result=array();
		$result['around'] = pg_fetch_all(pg_query($this->conn, $sql));
		
		
		$sql="select y(start_point) as lat, x(start_point) as lon from run where id=$id";
		$result['coords'] = pg_fetch_assoc(pg_query($this->conn, $sql));
		
		return $result;
    }

    //carrera
    public function getRunsSimilarDistance($id,$distance,$lat,$lon,$distance_km=150) {
	    $sql="select r.id,r.name,event_date,event_location,distance_text,run_type, (select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id";

        if(isset($_SESSION['logged']) and $_SESSION['logged']) {
            $sql.=",(select case when count(id)>0 then true else false end from users_run as ur where ur.run_fk=r.id and ur.users_fk=".$_SESSION['user']['id'].") as inscrito";
        } else {
            $sql.=",false as inscrito";
        }
        
        $sql.=" from run as r left join province as p on r.province_fk=p.id where r.event_date > now() and r.id <> $id ";
		$sql.=" and distance_meters<= $distance+2000 and distance_meters>= $distance-2000 and published=true";
		
		if($lat!=0 && $lon!=0) {
			$sql.=" AND distance_sphere(PointFromText('POINT($lon $lat)', 4326),start_point) <($distance_km*1000)";
		}
		
		$sql.=" order by event_date ASC limit 3";
		//error_log($sql);		
		return pg_fetch_all(pg_query($this->conn, $sql));      
    }

    //carrera
    public function getRunsInSimilarDates($id,$lat,$lon,$distance_km=150) {
	    $sql="select r.id,r.name,event_date,event_location,distance_text,run_type, (select count(id) from users_run where run_fk=r.id) as num_users, p.name as province_name,r.province_fk as province_id";

        if(isset($_SESSION['logged']) and $_SESSION['logged']) {
            $sql.=",(select case when count(id)>0 then true else false end from users_run as ur where ur.run_fk=r.id and ur.users_fk=".$_SESSION['user']['id'].") as inscrito";
        } else {
            $sql.=",false as inscrito";
        }
        
        $sql.=" from run as r left join province as p on r.province_fk=p.id where published=true and r.id <> $id  ";
		$sql.=" and (event_date > (select (event_date::date-3) from run where id=$id) and event_date < (select (event_date::date+3) from run where id=$id))";
		if($lat!=0 && $lon!=0) {
			$sql.=" AND distance_sphere(PointFromText('POINT($lon $lat)', 4326),start_point) <($distance_km*1000)";
		}
		$sql.=" order by event_date ASC limit 3";
		

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
        $mail = $this->getMailService();	

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
	public function sendEmailToPublish($nombre,$email,$data,$date) {
        $mail = $this->getMailService();	

		$mail->From = $email;
		$mail->FromName = $mensaje;
		$mail->Subject = "Mensaje desde la web";
		$mail->MsgHTML("Carrera enviada desde la web con nombre $nombre por ($email)<br><br>$data con fecha $date");
		$mail->AddAddress("contacto@runnity.com", "Web runnity.com");
		$mail->IsHTML(true);	
		
		if(!$mail->Send()) {
			throw new Exception('Problema al enviar el email:'.$mail->ErrorInfo,110);
		}		
		return null;
	}
	
	public function sendAlerts() {
        $sql=<<<SQL
            SELECT r.id as run_id,u.id as user_id,u.username,u.completename,u.email, event_location,r.name as run_name,event_date,distance_text,p.name as province_name,run_type, rt.name as run_type_name,
            CASE EXTRACT(DOW FROM event_date) 
            WHEN 0 THEN 'Domingo'
            WHEN 1 THEN 'Lunes'
            WHEN 2 THEN 'Martes'
            WHEN 3 THEN 'Miercoles'
            WHEN 4 THEN 'Jueves'
            WHEN 5 THEN 'Viernes'
            WHEN 6 THEN 'Sábado'
            ELSE 'otro' END as day_in_week

            from run as r left join province as p on r.province_fk=p.id left join run_type as rt on r.run_type=rt.id,users as u 
            WHERE r.event_date > now()::date AND r.event_date < now()::date+14 AND published=true AND u.radius_interest is not null AND distance_sphere(u.location_point,r.start_point) <(radius_interest*1000)
            order by u.id,r.event_date ASC          
SQL;
        $result= pg_query($this->conn, $sql);
        
        $smarty = new Smarty; 

        $userRunsBlock=array();
        $currentUserId=0;
        $currentUserEmail="";
        $currentUserName="";
        $currentCompleteName="";
        
        $today = getdate();
        
        $today = getdate(time());
        $in14days = getdate(time() + (14 * 24 * 60 * 60));
        
        $timeRange=$today['mday']."/".$today['mon']."/".$today['year']." AL ".$in14days['mday']."/".$in14days['mon']."/".$in14days['year']."";
        while ($row = pg_fetch_assoc($result)) {        
            if($currentUserId!=$row['user_id']) {
                if($currentUserId!=0) {
                    //Send email here using $userRunsBlock
                    
                    
                    $mail = $this->getMailService();
            		$mail->From = "alertas@runnity.com";
            		$mail->FromName = "Alertas Runnity";
            		$mail->Subject = "Runnity: Carreras en los siguientes 14 dias (".count($userRunsBlock).")";	


                    
                    $smarty->assign('name', $currentCompleteName);
                    $smarty->assign('user_id', $currentUserId);
                    $smarty->assign('user_name', $currentUserName);
                    $smarty->assign('carreras', $userRunsBlock);
                    $smarty->assign('timeRange', $timeRange);
                    
    
                    $email_message = utf8_decode($smarty->fetch(ABSPATH.'templates/email_alertas.tpl'));
                    $noHtml="";

            		$mail->MsgHTML($email_message);
            		$mail->AddAddress($currentUserEmail, $currentUserName);
            		$mail->IsHTML(true);		
            		$mail->AltBody = "";


            		if(!$mail->Send()) {
            		    error_log("ALERTAS: Email to $email no pudo enviarse");
            		}
            		                    
                }
                
                $userRunsBlock=array();
                $currentUserId = $row['user_id'];
                $currentUserEmail=$row['email'];
                $currentUserName=$row['username'];
                $currentCompleteName=$row['completename'];                
            }    
            $userRunsBlock[]=$row;
        }
        
        $mail = $this->getMailService();
		$mail->From = "alertas@runnity.com";
		$mail->FromName = "Alertas Runnity";
		$mail->Subject = "Runnity: Carreras en los siguientes 14 dias (".count($userRunsBlock).")";	


        $smarty->assign('username', $currentUserName);
        $smarty->assign('name', $currentCompleteName);
        $smarty->assign('user_id', $currentUserId);
        $smarty->assign('user_name', $currentUserName);
        $smarty->assign('carreras', $userRunsBlock);
        $smarty->assign('timeRange', $timeRange);
        

        $email_message = utf8_decode($smarty->fetch(ABSPATH.'templates/email_alertas.tpl'));
        $noHtml="";

		$mail->MsgHTML($email_message);
		$mail->AddAddress($currentUserEmail, $currentUserName);
		$mail->IsHTML(true);		
		$mail->AltBody = "";


		if(!$mail->Send()) {
		    error_log("ALERTAS: Email to $email no pudo enviarse");
		}        
        
   
	}
	
	
	
	//ajaxController
	/*
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
    	    $request_response = utf8_encode(file_get_contents($request_url));
    	    
    	    if(!$xml = simplexml_load_string($request_response)) {
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
            
            
            
            return ($lat.",".$lon);	   
            
            
                 
	    }
	}
	*/
	
	
	//ajaxController
	public function sendPasswordToEmail($email) {
		$name=pg_escape_string($email);
		
		$sql="select pass,username,completename from users where email='$email'";
		$result = pg_query($this->conn, $sql);  
        $user = pg_fetch_assoc($result);
		if(!$user) {
			return false;
		}

        $smarty = new Smarty; 
        $smarty->assign('name', $user['completename']);
        $smarty->assign('password', $user['pass']);
        $smarty->assign('username', $user['username']);      
        $smarty->assign('email', $email);     
        $email_message = utf8_decode($smarty->fetch(ABSPATH.'templates/email_password.tpl'));
        $noHtml="Tu password es Runnity es: ".$user['pass'];

        $mail = $this->getMailService();
		$mail->From = $email;
		$mail->FromName = $mensaje;
		$mail->Subject = "Tu password en Runnity.com";	
		
		$mail->MsgHTML($email_message);
		$mail->AddAddress($email, $user['completename']);
		$mail->IsHTML(true);		
		$mail->AltBody = $noHtml;
		
		
		if(!$mail->Send()) {
			throw new Exception('Problema al enviar el email:'.$mail->ErrorInfo,110);
		}		
		return true;		
	}
	
	
	public function geolocateAddress($address) {
	    define("MAPS_HOST", "maps.google.com");
	    $base_url = "http://" . MAPS_HOST . "/maps/geo?output=xml" . "&key=" . GMAPS_KEY;
	    $request_url = $base_url . "&q=" . urlencode($address) .",Spain";
	    $rsp = utf8_encode(file_get_contents($request_url));
	    $xml = simplexml_load_string($rsp);
	    //return $xml;
	    if (!$xml) {
	        throw new Exception('Problema al geolocalizar la direccion',220);
	    }
	    $status = $xml->Response->Status->code;
	    if (strcmp($status, "200") == 0) {
            $coordinates = $xml->Response->Placemark->Point->coordinates;
            $coordinatesSplit = split(",", $coordinates);
            $lat = (float)$coordinatesSplit[1];
            $lng = (float)$coordinatesSplit[0];
        } else {
            throw new Exception('Problema al geolocalizar la direccion',220);
        }
	    
	    return array($lat,$lng);
	}
	
	
	
	//searchusers
		public function searchUsers($q,$offset) { 
	    $q=pg_escape_string($q);
        if(!$offset) {
            $offset=0;
        }
        
        $sql="select u.id,u.username,u.completename,u.birthday,(SELECT COUNT(id) FROM picture where user_fk=u.id) as num_pictures from users u";

	    $terms=explode(" ",$q);

        $termsToAvoid=array("El","el","LA","La","la","Los","los","Las","las","En","en","De","de","y","o","i");
	    if(count($terms)>0 and $q!="") {
	        $sql.=" where (";
    	    foreach($terms as $term) {
    	        if (!in_array($term, $termsToAvoid)) {
    	            $sql.=" to_ascii(convert_to(u.username, 'latin1'), 'latin1') ilike to_ascii(convert_to('%$term%', 'latin1'), 'latin1') or to_ascii(convert_to(u.completename, 'latin1'), 'latin1') ilike to_ascii(convert_to('%$term%', 'latin1'), 'latin1') AND";
    	        }
    	    }	 
    	    $sql=substr($sql,0,-3);
    	    $sql.=")";       
	    } 
	    
	    $sqlForCount="SELECT COUNT(id) as num_results FROM ($sql) as s";
	    
	    $sql.=" order by u.completename ASC limit 10 offset $offset";
        
        //echo($sql);
        
        $results=array();
        $results['data'] = pg_fetch_all(pg_query($this->conn, $sql));
        
        if($results['data']) {
            $resultCount=pg_query($this->conn, $sqlForCount);
    	    $resultCount=pg_fetch_assoc($resultCount);
            $results['count'] =(int)$resultCount['num_results'];            
        } else {
            $results['count'] =0;  
			return $results;
        }

        //Iterate over the array to check if the runs have images on the server or not and provide a random one
	    foreach ($results['data'] as &$user) {
	        $targetPicture=$this->basePath."media/avatar/".$user['id']."_s.jpg";
            if (file_exists($targetPicture)) {
                $user['avatar'] = $user['id']."_s.jpg";
            } else {
                //no image for the run, select random
                $user['avatar'] = "0.jpg";
            }
        }

        return $results;  
	}
	

}

?>
