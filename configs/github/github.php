<?php
$secret = "<password>";
$path = "/var/path/to/repo/";
$cmd = "cd {$path} && git fetch --all && git reset --hard origin/master";

$signature = $_SERVER['HTTP_X_HUB_SIGNATURE'];
$post_data = file_get_contents('php://input');

if ($signature) {
		$hash = "sha1=".hash_hmac('sha1', $post_data, $secret);

		if (strcmp($signature, $hash) == 0) {
				echo shell_exec($cmd)."\n";
				exit();
		}
		else {
			echo "Permission Denied\n";
		}
}
else {
		http_response_code(404);
}
?>
