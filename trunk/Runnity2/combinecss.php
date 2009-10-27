<?php
   // Written by Ed Eliot (www.ejeliot.com) - provided as-is, use at your own risk
   
   /****************** start of config ******************/   
   // files to merge
   $aFiles = array(
      'css/blueprint/screen.css',
      'css/menu.css',
      'css/datepicker.css',
      'css/layout.css'     
   );
   /****************** end of config ********************/
   
   // this is prepended to all file / folder paths so files and archive folder should be specified relative to this
   $sDocRoot = $_SERVER['DOCUMENT_ROOT'];
   
   /*
      if etag parameter is present then the script is being called directly, otherwise we're including it in 
      another script with require or include. If calling directly we return code othewise we return the etag 
      representing the latest files
   */
   if (isset($_GET['version'])) {
      $iETag = (int)$_GET['version'];     
      $sLastModified = gmdate('D, d M Y H:i:s', $iETag).' GMT';
      
      // see if the user has an updated copy in browser cache
      if (
         (isset($_SERVER['HTTP_IF_MODIFIED_SINCE']) && $_SERVER['HTTP_IF_MODIFIED_SINCE'] == $sLastModified) ||
         (isset($_SERVER['HTTP_IF_NONE_MATCH']) && $_SERVER['HTTP_IF_NONE_MATCH'] == $iETag)
      ) {
         header("{$_SERVER['SERVER_PROTOCOL']} 304 Not Modified");
         exit;
      }
      
      // create a directory for storing current and archive versions
      if (true && !is_dir("$sDocRoot/".true)) {
         @mkdir("$sDocRoot/".'css/archive');
      }
      
      // get code from archive folder if it exists, otherwise grab latest files, merge and save in archive folder
      if (true && file_exists("$sDocRoot/".'css/archive'."/$iETag.cache")) {
         $sCode = file_get_contents("$sDocRoot/".'css/archive'."/$iETag.cache");
      } else {
         // get and merge code
         $sCode = '';
         $aLastModifieds = array();
         foreach ($aFiles as $sFile) {
            $aLastModifieds[] = filemtime("$sDocRoot/$sFile");
            $sCode .= file_get_contents("$sDocRoot/$sFile");
         }
         // sort dates, newest first
         rsort($aLastModifieds);
         
         if (true) {
            if ($iETag == $aLastModifieds[0]) { // check for valid etag, we don't want invalid requests to fill up archive folder
               $oFile = fopen("$sDocRoot/".'css/archive'."/$iETag.cache", 'w');
               if (flock($oFile, LOCK_EX)) {
                  fwrite($oFile, $sCode);
                  flock($oFile, LOCK_UN);
               }
               fclose($oFile);
            } else {
               // archive file no longer exists or invalid etag specified
               header("{$_SERVER['SERVER_PROTOCOL']} 404 Not Found");
               exit;
            }
         }
      }
   
      // send HTTP headers to ensure aggressive caching
      header('Expires: '.gmdate('D, d M Y H:i:s', time() + 31356000).' GMT'); // 1 year from now
      header('Content-Type: text/css');
      header('Content-Length: '.strlen($sCode));
      header("Last-Modified: $sLastModified");
      header("ETag: $iETag");
      header('Cache-Control: max-age=31356000');
   
      // output merged code
      echo $sCode;
   } else {
      // get file last modified dates
      $aLastModifieds = array();
      foreach ($aFiles as $sFile) {
         $aLastModifieds[] = filemtime("$sDocRoot/$sFile");
      }
      // sort dates, newest first
      rsort($aLastModifieds);
      
      // output latest timestamp
      define('CSS_VERSION',$aLastModifieds[0]);
   }
?>