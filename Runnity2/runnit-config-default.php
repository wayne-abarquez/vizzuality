<?php
if($_SERVER["SERVER_NAME"]=="runnity.es" or $_SERVER["SERVER_NAME"]== "runnity.net") {
        $newloc="http://runnity.com".$_SERVER["REQUEST_URI"];
        header( "Location: $newloc") ;
}

require('combinejs.php');
require('combinecss.php');

/** 
 * The base configurations of Runnit.
**/

/** The name of the database for Runnity */
define('DB_NAME', 'db');

/** PostgreSQL database username */
define('DB_USER', 'dbuser');

/** PostgreSQL database password */
define('DB_PASSWORD', 'pass');

/** PostgreSQL hostname */
define('DB_HOST', 'localhost');

define('ABSPATH','/path/to/www/');
define('EMAILPASSWORD','emailpass');

define('TWITTER_USER','runnity');
define('TWITTER_PASS','vizzualejo');

define('HOST','localhost');

switch ($_SERVER["SERVER_NAME"]){
	case (HOST=="localhost"):
		define('GMAPS_KEY','ABQIAAAAtDJGVn6RztUmxjnX5hMzjRT2yXp_ZAY8_ufC3CFXhHIE1NvwkxSPLBWm1r4y_v-I6fII4c2FT0yK6w');    //localhost
		break;
	case (HOST=="runnity.com"):
		define('GMAPS_KEY','ABQIAAAAtDJGVn6RztUmxjnX5hMzjRTy9E-TgLeuCHEEJunrcdV8Bjp5lBTu2Rw7F-koeV8TrxpLHZPXoYd2BA');   //runnity.com
		break;
	case (HOST=="runnity.es"):
		define('GMAPS_KEY','ABQIAAAAtDJGVn6RztUmxjnX5hMzjRQK12cEqCNB3jyFRUdZAxcDvhADJRQn0mHTp4RIKJVv2RqDsWp8h9RPvA');   //runnity.es
		break;
	case (HOST=="runnity.net"):
		define('GMAPS_KEY','ABQIAAAAtDJGVn6RztUmxjnX5hMzjRS5lFIZ4lX1ZuOUC3gMG9aTZZnVExRO7Xbt-wEBLhd43QE_x_w9pE80BQ');	//runnity.net
		break;
	case (HOST=="tumblr.com"):
			define('GMAPS_KEY','ABQIAAAAtDJGVn6RztUmxjnX5hMzjRSC87GBmgHWnSTrc5OmAg2oGs6xtRQYpdLrpOe5203GCF0SmZKxbhOKWw');	//tumblr
			break;		
	case (HOST=="67.23.47.172"):
		define('GMAPS_KEY','ABQIAAAAtDJGVn6RztUmxjnX5hMzjRTGDsp2z8MalcroimtHohqExHETcBS4NC7BdwWef8UXYbVt7VWSNZ9bOQ');   //server
		break;
}

?>