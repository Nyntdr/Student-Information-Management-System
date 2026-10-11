<?php
define("host","localhost");
define("duser","sims_user");
define("dpass","Sims@1234");
define("ddb","SIMS");
$conn=mysqli_connect(host, duser, dpass, ddb);
if(!$conn){
    echo "Unable to connect to the database.";
}
?>