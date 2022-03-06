<?php
	session_start();

	// Direct to a new page
	function redirect($new_location)
	{
		header('Location: ' . $new_location);
		exit;
	}

    // Check if post keys are filled
    function register_post_keys() {
        $args = func_get_args();
        return register_keys($_POST, $args);
    }

    function register_keys($array, $keys) {
        if (!not_null_keys($array, $keys)) {
            return false;
        }
        foreach ($keys as $k) {
            $GLOBALS[$k] = $array[$k];
        }
        return true;
    }

    function not_null_keys($array, $keys) {
        foreach ($keys as $k) {
            if ($array[$k] == null) {
                return false;
            }
        }
        return true;
    }

	function test_input($data)
	{
		$data = trim($data);
		$data = stripslashes($data);
		$data = htmlspecialchars($data);
		return $data;
	}

    function logout()
    {
        session_unset();
    }
?>