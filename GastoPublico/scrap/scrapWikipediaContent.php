<?php
include('simple_html_dom.php');
define("MAPS_HOST", "maps.google.com");
define("KEY", "abcdefg");
$conn = pg_pconnect ("host=localhost dbname=gastopublico user=postgres password=");
$base_url = "http://" . MAPS_HOST . "/maps/geo?output=xml" . "&key=" . KEY;

require_once(dirname(__FILE__) . '/google.php');
require_once(dirname(__FILE__) . '/class_WikiParser.php');

$sql="SELECT id,wikipedia_url,poblacion FROM organismo WHERE org_contratante='Administración Local'";
$res= pg_fetch_all(pg_query($conn, $sql));

foreach($res as $org) {
    

    $r = google_top(normalize($org['poblacion']). " wikipedia");
    echo(normalize($org['poblacion']). " wikipedia");
    $wikipediaUrl = $r->hits[0]->unescapedUrl;
    print_r($r);
	$html = file_get_dom($wikipediaUrl);
    foreach($html->find('table') as $table) {
        print_r($table);
    }
    
    
    die();
    
    /*
    $contents = file_get_contents($wikipediaUrl."?action=raw");



	$parser = &new WikiParser();
	$output = $parser->parse($contents,$title);
    
    print_r($output);
    die();


    $url = "http://www.wikipedia.org";
    $titles = array("First_article","Second_article");
    $wiki = &new WikiRetriever();
    if (!$wiki->retrieve($url,$titles)) {
    die("Error: $wiki->error");
    } else {
    var_dump($wiki->pages);
    }
    

/*
	$html = file_get_dom($wikipediaUrl);
    foreach($html->find('tr.mergedtoprow') as $tr) {
        print_r($tr->plaintext);
        
    }
*/    
    
    
    $sql="UPDATE organismo SET wikipedia_url='".pg_escape_string($wikipediaUrl)."' WHERE id=".$org['id'];
    $result=pg_query($conn, $sql); 
    echo(".");
    
    

}

function normalize ($string) {
    $table = array(
        'Š'=>'S', 'š'=>'s', 'Đ'=>'Dj', 'đ'=>'dj', 'Ž'=>'Z', 'ž'=>'z', 'Č'=>'C', 'č'=>'c', 'Ć'=>'C', 'ć'=>'c',
        'À'=>'A', 'Á'=>'A', 'Â'=>'A', 'Ã'=>'A', 'Ä'=>'A', 'Å'=>'A', 'Æ'=>'A', 'Ç'=>'C', 'È'=>'E', 'É'=>'E',
        'Ê'=>'E', 'Ë'=>'E', 'Ì'=>'I', 'Í'=>'I', 'Î'=>'I', 'Ï'=>'I', 'Ñ'=>'N', 'Ò'=>'O', 'Ó'=>'O', 'Ô'=>'O',
        'Õ'=>'O', 'Ö'=>'O', 'Ø'=>'O', 'Ù'=>'U', 'Ú'=>'U', 'Û'=>'U', 'Ü'=>'U', 'Ý'=>'Y', 'Þ'=>'B', 'ß'=>'Ss',
        'à'=>'a', 'á'=>'a', 'â'=>'a', 'ã'=>'a', 'ä'=>'a', 'å'=>'a', 'æ'=>'a', 'ç'=>'c', 'è'=>'e', 'é'=>'e',
        'ê'=>'e', 'ë'=>'e', 'ì'=>'i', 'í'=>'i', 'î'=>'i', 'ï'=>'i', 'ð'=>'o', 'ñ'=>'n', 'ò'=>'o', 'ó'=>'o',
        'ô'=>'o', 'õ'=>'o', 'ö'=>'o', 'ø'=>'o', 'ù'=>'u', 'ú'=>'u', 'û'=>'u', 'ý'=>'y', 'ý'=>'y', 'þ'=>'b',
        'ÿ'=>'y', 'Ŕ'=>'R', 'ŕ'=>'r',
    );
    
    return strtr($string, $table);
}



?>