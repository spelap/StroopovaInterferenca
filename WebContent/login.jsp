<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Stroopova interferenca</title>
<link type="text/css" rel="stylesheet" href="stroop.css" />
</head>

<body>
	<div class="headerContent">
		<div class="topHeader">
			<a href="entrypage.jsp">NAZAJ NA ZAČETNO STRAN</a>
		
		<div class="registracija">
	<a href="registracija.jsp">REGISTRACIJA</a>
	</div>
	</div>
		<div class="header">
			<h1>PRIJAVA</h1>
		</div>
	</div>
	<hr />
	<div class="maincontent">
		<div class="main">
			<form method="POST" action="j_security_check" name="obrazec" onsubmit="return preveri(this)">
				<table id="prijava">
					<tr>
						<td>E-mail:</td>
						<td><input type="text" name="j_username"></td>
					</tr>
					<tr>
						<td>Geslo:</td>
						<td><input type="password" name="j_password"></td>
					</tr>
				</table>
				<input id="potrdi" type="submit" name="potrdi" value="POTRDI">
				</form>
		</div>
	</div>

	<div class="footer">
		<p>©DENIS VODIŠEK, FLORIJAN KLEZIN, ŠPELA PEČNIK, MIHA KEBE©</p>
	</div>
<script language="JavaScript" src="js/md5.js"></script>
<script language="JavaScript">
function preveri(obrazec)
{
	if(obrazec.j_password.value!=""){	
		var geslo=obrazec.j_password.value;
		var hash = calcMD5(geslo);
		obrazec.j_password.value=hash;
		return true;
	}
	return false;
}
</script>
</body>
</html>