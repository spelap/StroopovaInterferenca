<%@page import="nastavi.Nastavitve"%>
<%@page import="povezava.Povezava"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script type="text/javascript">
var a = 0;
	$(document).ready(function() {
		$("#gumb").click(function() {
			$("#vnosBesede").toggle(2000);
			a++;
		});
	});

	function preveri(eksperiment) {
		if (eksperiment.ime.value == "") {
			alert("Vpišite ime eksperimenta!");
			return false;
		}

		if (eksperiment.uvodnipozdrav.value == "") {
			alert("Napišite uvodni pozdrav!");
			return false;
		}
		if (eksperiment.navodilo.value == "") {
			alert("Napišite navodilo eksperimenta!");
			return false;
		}
		if (eksperiment.zahvala.value == "") {
			alert("Napišite zahvalo eksperimenta!");
			return false;
		}
		if (!(eksperiment.ime.value.match(/^[A-Za-zšđčćžŠĐČĆŽ\s]*$/))) {
			alert("Vnesli ste napačno ime eksperimenta! Ime lahko vsebuje samo male in velike črke, ter presledek.");
			eksperiment.ime.focus();
			return false;
		}
		if (eksperiment.ime.value.length > 200) {
			alert("Predolgo ime. Vpisati je možno največ 200 znakov. Vi ste vpisali "+eksperiment.ime.value.length+" znakov.");
			return false;
		}
		if (eksperiment.uvodnipozdrav.value.length > 1000) {
			alert("Predolg uvodni pozdrav. Vpisati je možno največ 1000 znakov. Vi ste vpisali "+eksperiment.uvodnipozdrav.value.length+" znakov.");
			return false;
		}
		if (eksperiment.navodilo.value.length > 1000) {
			alert("Predolgo navodilo. Vpisati je možno največ 1000 znakov. Vi ste vpisali "+eksperiment.navodilo.value.length+" znakov.");
			return false;
		}
		if (eksperiment.zahvala.value.length > 1000) {
			alert("Predolga zahvala. Vpisati je možno največ 1000 znakov. Vi ste vpisali "+eksperiment.zahvala.value.length+" znakov.");
			return false;
		}
		if (a%2 != 0) {
			if (eksperiment.beseda1.value == "") {
				alert("Prosimo vnesite vseh 5 besed!");
				return false;
			}
			if (eksperiment.beseda2.value == "") {
				alert("Prosimo vnesite vseh 5 besed!");
				return false;
			}
			if (eksperiment.beseda3.value == "") {
				alert("Prosimo vnesite vseh 5 besed!");
				return false;
			}
			if (eksperiment.beseda4.value == "") {
				alert("Prosimo vnesite vseh 5 besed!");
				return false;
			}
			if (eksperiment.beseda5.value == "") {
				alert("Prosimo vnesite vseh 5 besed!");
				return false;
			}
			if (eksperiment.beseda1.value.length < 5) {
				alert("Besede morajo biti daljše od 5 črk! Prosim popravite 1. besedo");
				return false;
			}
			if (eksperiment.beseda2.value.length < 5) {
				alert("Besede morajo biti daljše od 5 črk! Prosim popravite 2. besedo");
				return false;
			}
			if (eksperiment.beseda3.value.length < 5) {
				alert("Besede morajo biti daljše od 5 črk! Prosim popravite 3. besedo");
				return false;
			}
			if (eksperiment.beseda4.value.length < 5) {
				alert("Besede morajo biti daljše od 5 črk! Prosim popravite 4. besedo");
				return false;
			}
			if (eksperiment.beseda5.value.length < 5) {
				alert("Besede morajo biti daljše od 5 črk! Prosim popravite 5. besedo");
				return false;
			}
			
			if (eksperiment.beseda1.value.length > 50) {
				alert("Besede morajo biti krajše od 50 znakov! Prosim popravite 1. besedo");
				return false;
			}
			if (eksperiment.beseda2.value.length > 50) {
				alert("Besede morajo biti krajše od 50 znakov! Prosim popravite 2. besedo");
				return false;
			}
			if (eksperiment.beseda3.value.length > 50) {
				alert("Besede morajo biti krajše od 50 znakov! Prosim popravite 3. besedo");
				return false;
			}
			if (eksperiment.beseda4.value.length > 50) {
				alert("Besede morajo biti krajše od 50 znakov! Prosim popravite 4. besedo");
				return false;
			}
			if (eksperiment.beseda5.value.length > 50) {
				alert("Besede morajo biti krajše od 50 znakov! Prosim popravite 5. besedo");
				return false;
			}
		}
		if(a%2 == 0) {
			var posevno = "/";
			eksperiment.beseda1.value = posevno;
			eksperiment.beseda2.value = posevno;
			eksperiment.beseda3.value = posevno;
			eksperiment.beseda4.value = posevno;
			eksperiment.beseda5.value = posevno;
		}
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Stroopova interferenca</title>
<link type="text/css" rel="stylesheet" href="stroop.css" />
</head>
<%
	if(request.getParameter("odjava")!=null) {
	session.invalidate();
	response.sendRedirect("entrypage.jsp");
		}
%>
<%
	String sIme = null;
	String sPozdrav=null;
	String sNavodilo=null;
	String sZahvala=null;
	String sPonovitve=null;
	String sBeseda1=null;
	String sBeseda2=null;
	String sBeseda3=null;
	String sBeseda4=null;
	String sBeseda5=null;
	String uporabnik=request.getRemoteUser();
	//pregled piškotkov
	try {
	for (Cookie c : request.getCookies()) {
		if (c.getName().equals("cIme")) sIme=c.getValue();
		if (c.getName().equals("cPozdrav")) sPozdrav=c.getValue();
		if (c.getName().equals("cNavodilo")) sNavodilo=c.getValue();
		if (c.getName().equals("cZahvala")) sZahvala=c.getValue();
		if (c.getName().equals("cPonovitve")) sPonovitve=c.getValue();
		if (c.getName().equals("cBeseda1")) sBeseda1=c.getValue();
		if (c.getName().equals("cBeseda2")) sBeseda2=c.getValue();
		if (c.getName().equals("cBeseda3")) sBeseda3=c.getValue();
		if (c.getName().equals("cBeseda4")) sBeseda4=c.getValue();
		if (c.getName().equals("cBeseda5")) sBeseda5=c.getValue();
		}
	}catch (Exception e) {};
%>

<body>
	<div class="headerContent">
		<div class="topHeader">
			<a href="entrypage.jsp">NAZAJ NA ZAČETNO STRAN</a>
			<div class="odjava">
				<div class="registracija">
					<%
						if(request.getRemoteUser()!=null) {
					%>
					<div class="odjava">
						<p>
							PRIJAVLJENI KOT: |<b><%=request.getRemoteUser()%></b>| <a
								href="entrypage.jsp?odjava">ODJAVA</a>
						</p>
					</div>
					<%
						}
					%>
				</div>
			</div>
		</div>
		<div class="header">
			<h1>NASTAVITVE TESTA</h1>
		</div>
	</div>
	<hr />
	<form action="testic.jsp" method="post" name="eksperiment"
		onsubmit="return preveri(this)">
		<div class="maincontent">
			<div class="main">
				<div class="ime">
					<h3>Ime eksperimenta:</h3>
					<textarea rows="1" cols="80" name="ime"></textarea>
				</div>
				<div class="uvodniPozdrav">
					<h3>Napišite uvodni pozdrav:</h3>
					<textarea rows="6" cols="80" name="uvodnipozdrav"></textarea>
				</div>

				<div class="navodila">
					<h3>Napišite navodila eksperimenta:</h3> 
					<textarea rows="6" cols="80" name="navodilo"></textarea>
				</div>

				<div class="zahvala">
					<h3>Napišite zahvalo:</h3>
					<textarea rows="6" cols="80" name="zahvala"></textarea>
				</div>

				<div class="stPonovitev">
					<h3>Koliko ponovitev dražjajev želite:</h3>
					<select name="ponovitve">
						<option>3</option>
						<option>15</option>
						<option>30</option>
						<option>60</option>
						<option>90</option>
						<option>120</option>
					</select>
				</div>
				<div class="gumby">
					<input id="gumb" type="button" name="VnosBesed"
						value="Vnos svojih besed">
				</div>
				<div id="vnosBesede" class=vnosBesed style="display: none">
					<h3>Vnos poljubnih besed:</h3>
					<input type='text' name='beseda1'> <input type='text'
						name='beseda2'> <input type='text' name='beseda3'>
					<input type='text' name='beseda4'> <input type='text'
						name='beseda5'>
				</div>

				<div class="potrdi">
					<input type="submit" id="potrdi" name="gumbpotrdi" value="POTRDI">
				</div>
			</div>
		</div>
	</form>
	<div id="footer">
		<p>©DENIS VODIŠEK, FLORIJAN KLEZIN, ŠPELA PEČNIK, MIHA KEBE©</p>
	</div>

</body>
</html>