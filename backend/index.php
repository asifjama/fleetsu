<?php
/**
 * Step 1: Require the Slim Framework using Composer's autoloader
 *
 * If you are not using Composer, you need to load Slim Framework with your own
 * PSR-4 autoloader.
 */
require 'vendor/autoload.php';

$settings 	= 	require_once '/settings.php'; 

$app 		= 	new \Slim\App($settings);

$container 	= 	$app->getContainer();

// Database connection
$container['db'] = function ($c) {
    $settings = $c->get('settings')['db'];
    $pdo = new PDO("mysql:host=" . $settings['host'] . ";dbname=" . $settings['dbname'],
        $settings['user'], $settings['pass']);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    return $pdo;
};

$app->get('/', function ($request, $response, $args) {
    $response->write("Welcome to Slim!");	
    return $response;
});

// post device data
$app->post('/devices', function ($request, $response, $args) {
	$db = $this->db;
	$input = $request->getParsedBody();
	$sql = "INSERT INTO device_report (device_id, device_name, last_report_on, device_status) VALUES (:d_id, :d_name, :last_report, :d_status)";
	$sth = $this->db->prepare($sql);
	$now 	= $input['last_report'];	
	$status = getDeviceLastReport($input['device_id'], $db);
	$sth->bindParam("d_id", $input['device_id']);
	$sth->bindParam("d_name", $input['device_name']);	
	$sth->bindParam("last_report", $now);
	$sth->bindParam("d_status", $status);	
	$sth->execute();
	$input['id'] = $this->db->lastInsertId();
	return $this->response->withJson($input);
});

// get device report
$app->get('/devices', function ($request, $response, $args) {
    $query = $this->db->prepare("SELECT * FROM `device_report` ORDER by id DESC");	
	$query->execute();
	$result = $query->fetchAll();
	$response = [];  
	if(!empty($result))
	{
		$check_device = [];
		foreach($result as $k => $v)
		{
			$d_id				=	$v['device_id'];
			if(!in_array($d_id, $check_device))
			{
				$check_device[]	=	$d_id;
				$response[] 	= 	$v;
			}
		}		
	}
	return $this->response->withJson($response);
});

// get device report
$app->get('/device-details/[{device_id}]', function ($request, $response, $args) {
    $query = $this->db->prepare("SELECT * FROM `device_report` WHERE device_id=:d_id ORDER by id DESC");
	$query->bindParam("d_id", $args['device_id']);	
	$query->execute();
	$result = $query->fetchAll();	
	return $this->response->withJson($result);
});

// get device last report data
function getDeviceLastReport($device_id, $db)
{
	$status = "OFFLINE";
	$sql = "SELECT TIMESTAMPDIFF(HOUR, last_report_on, NOW()) As hours FROM device_report WHERE device_id=:device_id ORDER BY id DESC";
	$sth = $db->prepare($sql);
	$sth->bindParam("device_id", $device_id);
	$sth->execute();
	$result = $sth->fetch(); 
	if($result['hours'] <= 24 && !empty($result))
		$status = "OK";
	
	return $status;
}

$app->run();