<?php
    require_once('init.php');

    $err = $search_isbn = $search_title = $search_author = null;
    if($_SERVER["REQUEST_METHOD"] == "POST"){
        if(register_post_keys('search_isbn') || register_post_keys('search_title') || register_post_keys('search_author'))
        {
            register_post_keys('search_title');
            register_post_keys('search_author');
            //if($search_isbn)
                $_SESSION["search_isbn"] = $search_isbn;
            //if($search_title)
                $_SESSION["search_title"] = $search_title;
            //if($search_author)
                $_SESSION["search_author"] = $search_author;
            redirect('RequestHold.php');
        }
        $err = "Please fill at least one field";
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
    </header>
    <div class="container">
        <h1>Search Restaurant</h1>
        <form method="post" action="" id="form">
            <div class="row uniform">
                <div class="6u 12u$(xsmall)"><input type="text" name="search_name" id="fname" placeholder="Name" /></div>
                <div class="6u 12u$(xsmall)">
                <select>
                <option value="volvo">Volvo</option>
                <option value="saab">Saab</option>
                <option value="vw">VW</option>
                <option value="audi" selected>Audi</option>
                </select>
                </div>
                <div class="6u 12u$(xsmall)"><input type="text" name="search_zipcode" id="fname" placeholder="Zip Code" /></div>
                <div class="6u 12u$(xsmall)"><input type="text" name="search_cuisine" id="fname" placeholder="Cuisine" /></div>
                <div class="12u$ 12u$">
                    <ul class="actions">
                        <a href=Profile.html onClick=”javascript :history.back(-1);”>Back</a>
                    </ul>
                    <ul class="actions">
                        <li><input type="submit" value="Search" class="special" /><br><span class="error"><?php echo $err;?></span></li>
                    </ul>
                    <ul class="actions">
                        <a href=index.php onClick=”javascript :history.back(-1);”>Close</a>
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