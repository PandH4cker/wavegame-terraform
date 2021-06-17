<html>
<body>
<h1>Susbscription management (available soon)</h1>
<h2>Check connections</h2>
<form method="post">
  <input type="text" name="ip" placeholder="EC2 IP : 10.20.11.xxx" />
  <button type="submit" name="EC2" value="EC2">Check connection with EC2</button>
  <button type="submit" name="RDS_1" value="RDS_1">Check connection with RDS 1</button>
  <button type="submit" name="RDS_2" value="RDS_2">Check connection with RDS 2</button>
  <button type="submit" name="S3" value="S3">Check connection with S3</button>
</form>
<?php
include 'variables.php';

if(isset($_POST['EC2'])) {
  if($_POST['ip']) {
          test_command("ping -c 1 {$_POST['ip']}");
  } else {
    print "<p>Enter IP address to ping</p>";
  }
}
if(isset($_POST['RDS_1'])) {
  test_mysql($sql_host_1,$sql_user,$sql_pwd);
}
if(isset($_POST['RDS_2'])) {
  test_mssql($sql_host_2,$sql_user,$sql_pwd);
}
if(isset($_POST['S3'])) {
  test_command("aws s3 ls {$bucket_uri}");
}

function test_command($command){
  echo "<p>Command: {$command}</p>";
  exec("{$command}", $output, $retval);
  foreach($output as $line) {
         echo "<p>{$line}</p>";
  }
}
function test_mysql($sql_host,$sql_user,$sql_pwd){
  echo "<p>Test MySQL connection with RDS 1 at {$sql_host}: </p>";

  $connection=mysqli_connect($sql_host,$sql_user,$sql_pwd);
  if(mysqli_connect_errno()) {
          echo "Failed to connect";          
  } else {
          echo "Connection success";
  }
  mysql_close($connection);
}
function test_mssql($sql_host,$sql_user,$sql_pwd){
  echo "<p>Test MSSQL connection with RDS 2 at {$sql_host}: </p>";
  $serverName = explode(":", $sql_host)[0];
  $connectionOptions = array(
      "Uid" => $sql_user,
      "PWD" => $sql_pwd
  );
  $connection = sqlsrv_connect($serverName, $connectionOptions);
  if($connection) { 
    echo "Connection success";
  } else {
    print "Failed to connect";
  }
  sqlsrv_close($connection);
}
?>
</body>
</html>