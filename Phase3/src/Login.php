<?php
    require_once('init.php');

    $username = $password = $name_err = $match_err = $login_err = "";
    if($_SERVER["REQUEST_METHOD"] == "POST")
    {
        if(empty($_POST['username']))
        {
            $name_err = "* Username is required";
        }
        if(register_post_keys('username'))
        {
            register_post_keys('password');
            if($db->login($username, $password))
            {
                $_SESSION['username'] = $username;
                if($_SESSION['isstaff'] == false) {
                    if($_SESSION['hasprofile'] == false) {
                        redirect('Profile.php');
                    }
                    else {
                        redirect('userHomePage.php');
                    }
                }
                if($_SESSION['isstaff'] == true)
                    redirect('staffHomePage.php');
            }
            else {
                $login_err = "Login unsuccessful";
            }
        }
    }
?>


<!DOCTYPE HTML>

<html>
    <head>
        <title>Library Manage System</title>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta name="description" content="" />
        <meta name="keywords" content="" />
        <!--[if lte IE 8]><script src="css/ie/html5shiv.js"></script><![endif]-->
        <script src="js/jquery.min.js"></script>
        <script src="js/jquery.scrollex.min.js"></script>
        <script src="js/jquery.scrolly.min.js"></script>
        <script src="js/skel.min.js"></script>
        <script src="js/init.js"></script>
        <noscript>
            <link rel="stylesheet" href="css/skel.css" />
            <link rel="stylesheet" href="css/style.css" />
            <link rel="stylesheet" href="css/style-xlarge.css" />
        </noscript>
    </head>
    <style>
    .error {color: #FF0000;}
    </style>
    <body>

        <!-- Header -->
            <section id="header">
                <header class="major">
                    <h1>User Login</h1>
                    <p>Let's make reading more fun! <3</p>
                </header>
                <div class="container">
                    <form method="post" action='' id="form">
                        <div class="row uniform">
                            <div class="6u 12u$(xsmall)"><input type="text" name="username" id="fname" placeholder="Username" /><span class="error"><?php echo $name_err . $login_err;?></span></div>
                            <div class="6u$ 12u$(xsmall)"><input type="password" name="password" id="lname" placeholder="Password" /></div>
                            
                            <div class="12u$">
                                <ul class="actions">
                                    <li><input type="submit" value="Login" class="special" /></span></li>
                                </ul>
                            </div>
                        </div>
                    </form>
                </div>
            </section>
        
        <!-- Footer -->
            <section id="footer" class="main special">
            <span class="image fit primary"><img src="images/pic01.jpg" alt="" /></span>
                <footer>
                </footer>
            </section>
    </body>
</html>