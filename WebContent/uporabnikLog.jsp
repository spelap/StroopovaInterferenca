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
<% String id=null;
	if(request.getParameter("eksperiment")!=null){
		id=request.getParameter("eksperiment");
	}
%>
	<div class="headerContent">
		<div class="topHeader">
			<a href="entrypage.jsp">NAZAJ NA ZAČETNO STRAN</a>
	</div>
		<div class="header">
			<h1>PRIJAVA</h1>
		</div>
	</div>
	<hr />
	<div class="maincontent">
		<div class="main">
			<form method="POST" action="pozdravcki.jsp?eksperiment=<%=id%>" name="obrazec" onsubmit="return preveri(this)">
				<table id="prijava">
					<tr>
						<td>Šifra:</td>
						<td><input type="text" name="sifra"></td>
					</tr>
					<tr>
						<td>Spol:</td>
						<td><input type="radio" name="spol" value="moski" checked >Moški<input type="radio" name="spol" value="zenski">Ženski</td>
					</tr>
					<tr>
						<td>Starost:</td>
						<td><input type="text" onkeypress='return event.charCode >= 48 && event.charCode <= 57' name="starost"></input></td>
					</tr>
				</table>
				<input id="naprej" type="submit"  name="naprej" value="POTRDI">
				</form>
		</div>
	</div>

	<div class="footer">
		<p>©DENIS VODIŠEK, FLORIJAN KLEZIN, ŠPELA PEČNIK, MIHA KEBE©</p>
	</div>
	
<script language="JavaScript">
function preveri(obrazec)
{
	if(obrazec.sifra.value==""){	
		alert("Vpiši šifro!");
		return false;
	}
	if(obrazec.spol.value==false){	
		alert("Označi spol!!");
		return false;
	}
	if(obrazec.starost.value==""){	
		alert("Vnesi starost!");
		return false;
	}
	if(obrazec.sifra.value==""){	
		alert("Vpiši šifro!");
		return false;
	}
	if(obrazec.starost.value != ""){	
		var starost = obrazec.starost.value;
		if (!(starost > 12 && starost < 80)) {
			alert("Nepravilna starost!");
			return false;	
		}
	}
	if(!(obrazec.sifra.value.match(/^[A-Za-z0-9]*$/))){	
		alert("Šifra je lahko sestavljena iz malih in velikih črk ter številk (brez presledkov in drugih znakov).");
		return false;
	}
	
	return true;
}
</script>
</body>
</html>