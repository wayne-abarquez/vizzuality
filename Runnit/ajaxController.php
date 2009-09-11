<?php
require 'services/RunnitServices.php';
$services = new RunnitServices;
session_start();

if ($_REQUEST['method'] == 'isUsernameFree') {
    if($services->isUsernameFree($_REQUEST['username'])) {
    	echo("valid");
    } else {
    	echo("notvalid");
    }
    die();
}

if ($_REQUEST['method'] == 'addComment') {
    
	$name=$_SESSION['user']['username'];
	$email=$_SESSION['user']['email'];
	$comment=$_REQUEST['comment'];
	$date = date("d/m/Y h:i");

	$lowercase = strtolower($email);
	$image = md5( $lowercase );

    $result = $services->addComment($_SESSION['user']['id'],$comment,$_REQUEST['id'],$_REQUEST['onTable']);
    
    if ($result==null) {
        ?>

		<div class="column span-16 first racesComment">				
			<div class="column span-3 first image">
				<img src="/avatar.php?id=<?php echo $_SESSION['user']['id']; ?>"/>	
			</div>
			<div class="column span-12 last commentBox">
				<div class="nameUser"><a class="nameRace" href="#"><?php echo $name;?>,</a> ahora mismo.</div>
				<p class="textRace"><?php echo $comment; ?></p>
			</div>
		</div>
    	  
        <?php
    } else {
        ?>
    	<div class="column span-16 first racesComment">				
			Lo siento, ha ocurrido un error.
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
    echo ("ok");
}


if ($_REQUEST['method'] == 'register') {
	$result = $services->registerUser($_REQUEST['username'],$_REQUEST['name'],$_REQUEST['email'],$_REQUEST['password']);
	echo ($result['username']);
}

if ($_REQUEST['method'] == 'inscribeUserToRun') {
	$result = $services->inscribeUserToRun($_REQUEST['userId'],$_REQUEST['runId']);
	echo('OK');
}

if ($_REQUEST['method'] == 'unInscribeUserToRun') {
	$result = $services->unInscribeUserToRun($_REQUEST['userId'],$_REQUEST['runId']);
}

if ($_REQUEST['method'] == 'sendEmailToAlertas') {
	$result = $services->sendEmailToAlertas($_REQUEST['nombre'],$_REQUEST['email'],$_REQUEST['mensaje']);
	echo("OK");
}

if ($_REQUEST['method'] == 'sendPasswordToEmail') {
	$result = $services->sendPasswordToEmail($_REQUEST['email']);
	if($result) {
		echo("OK");
	} else {
		echo("INVALID");
	}
	
}

if ($_REQUEST['method'] == 'setAlert') {
	$result = $services->setAlert($_REQUEST['locality'],$_REQUEST['distance']);
	if(!$result) {
	    echo("INVALID");
	} else {
	    echo($result);
	}	
}


if ($_REQUEST['method'] == 'updateUser') {
	$result = $services->updateUser($_REQUEST['username'],$_REQUEST['name'],$_REQUEST['email'],$_REQUEST['password'],null,null);
	echo ('OK');
}



if ($_REQUEST['method'] == 'uploadPicture') {
	if() {
	    echo("success");
	} else {
	    echo("error");
	}
}



?>