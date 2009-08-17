<?php
require 'services/SDRServices.php';
$services = new SDRServices;
session_start();

if ($_REQUEST['method'] == 'addComment') {
    
	$name=$_SESSION['user']['username'];
	$email=$_SESSION['user']['email'];
	$comment=$_REQUEST['comment'];
	$date = date("d/m/Y h:i");

	$lowercase = strtolower($email);
	$image = md5( $lowercase );

    $result = $services->addComment($_SESSION['user']['id'],$comment,$_REQUEST['speciesId']);
    
    if ($result) {
        ?>
    	
    	<div class="column span-16 first racesComment">				
			<div class="column span-3 first image">
				<img src="img/user.jpg"/>	
			</div>
			<div class="column span-12 last detailsUser">
				<div class="nameUser"><a class="nameRace" href="#"><?php echo $name;?>,</a> <?php echo $date;?> </div>
				<p class="textRace"><?php echo $comment; ?></p>
			</div>
		</div> 

    	  
        <?php
    } else {
        ?>
    	<div class="column span-16 first racesComment">				
			Sorry, has been an error.
		</div>  
    	  
        <?php       
    }    
}

if ($_REQUEST['method'] == 'login') {

    try {
        $user= $services->login($_REQUEST['email'],$_REQUEST['password']);
        echo($user['username']);
    } catch(Exception $e) {
        echo('invalid');
    }
     die();
   
}

if ($_REQUEST['method'] == 'logout') {
    $services->logout();
}


?>