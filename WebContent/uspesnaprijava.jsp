<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Uspešna prijava</title>
<link type="text/css" rel="stylesheet" href="stroop.css" />
<script type="text/javascript">
window.onload = function() {
    var countdownElement = document.getElementById('countdown'),
        seconds = 3,
        second = 0,
        interval;


    interval = setInterval(function() {
        countdownElement.firstChild.data = 'Preusmeritev v ' + (seconds - second) + ' ....';
        if (second >= seconds) {
            clearInterval(interval);
            window.location = "entrypage.jsp";
        }

        second++;
    }, 1000);
}
</script>
</head>
<body>
	<div class="objemi">
		<div class="main">
			<div class="uspenaprijava">
				<h1>Prijava je uspešna!</h1>
				<h3>
					Prijavljeni kot
					<%=request.getRemoteUser()%></h3>
				<div id="countdown">Preusmeritev v 3 ....</div>
			</div>
		</div>
	</div>
</body>
</html>