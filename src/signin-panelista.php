<!-- python -m SimpleHTTPServer -->
<!doctype html>

<html lang='en'>
<head>
  	<meta charset='utf-8'>
    <link href='css/styles.css' type='text/css' rel='stylesheet'/>
	<link href='css/signin.css' type='text/css' rel='stylesheet'/>
	<script src='https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js'></script>
    <script src='js/signin.js' type='text/javascript'></script>
  	<title> Focus - Iniciar Sesión</title>
</head>

<body>
    <div id='header'>
    	<div id="container">
    		<img src='img/focus_logo.png'/>
    	</div>
    </div>
    <div id='loginForm'>
    	
    	<form id='formLogin'>
    		<h1> Login </h1>
            <div class='input-wrapper'>
                <label> Email: </label><br/>
		 		<input type='text' name='email' placeholder='Username' id='email' required />
	 		</div>
	 		<br/>	
            <div class='input-wrapper'>
	 		    <label> Password: </label><br/>
		  		<input type='password' name='Password' placeholder='***************' id='password'>
	  		</div>
	  		<div>
            	<button type='submit' id='loginButtonPanelista'>Iniciar Sesión</button>
        	</div>
            <div id='feedback'></div>
		</form>
    </div>
	<footer>
		<p>Copyright © 2016 Focus Consulting Group, SA. de C.V.</p>
	</footer>
</body>
</html>
