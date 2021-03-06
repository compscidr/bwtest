<?php
parse_str(implode('&', array_slice($argv, 1)), $_GET);

$string = file_get_contents("download.json");
$dbps = getBPSFromJSON($string);

$string = file_get_contents("upload.json");
$ubps = getBPSFromJSON($string);

$ping = 0;
if(isset($_GET["ping"])) {
  $ping = $_GET["ping"];
}

echo "UP: ".$ubps."bps DOWN: ".$dbps."bps PING: ".$ping."ms\n";

$ini_array = parse_ini_file("config.txt");

reportResults($ini_array["LOCAL_NAME"], $ini_array["DATA_SERVER"], $ubps, $dbps, $ping);

function getBPSFromJSON($string) {
  $json_a = json_decode($string, true);
  $intervals = $json_a["intervals"];
  $interval = $intervals[0];
  $sum = $interval["sum"];
  $bps = $sum["bits_per_second"];
  return $bps;
}

function reportResults($name, $server, $up, $down, $rtt) {
  $name = urlencode($name);
  $url = "http://$server/bw/report.php?name=$name&upload=$up&download=$down&rtt=$rtt";
  echo "Sending update to: $url";
  $ch = curl_init($url);
  curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1); 
  $result = curl_exec($ch);
}
?>
