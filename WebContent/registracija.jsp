<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>	
<%@page import="povezava.Povezava"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Stroopova interferenca</title>
<link type="text/css" rel="stylesheet" href="stroop.css" />
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script>
function checkPass()
{
    var prvo = document.getElementById('prvo');
    var drugo = document.getElementById('drugo');
    var message = document.getElementById('preveri');
    var prav = "#66cc66";
    var narobe = "#ff6666";
    
    if(prvo.value == drugo.value){
    	$('#potrdi').attr("disabled", false);
        drugo.style.backgroundColor = prav;
        message.style.color = prav;
        message.innerHTML = "Gesli se ujemata!";
    }
    else{
    	$('#potrdi').attr("disabled", true);
        drugo.style.backgroundColor = narobe;
        message.style.color = narobe;
        message.innerHTML = "Gesli se ne ujemata!";
    }
}  
function emailCheck() {
	
}	

</script>
</head>

<body>
<%	ArrayList<String> emaili=new ArrayList<String>();
			Povezava po=new Povezava();
			emaili=po.emaili();

			String sIme=null;
			String sPriimek=null;
			String sEmail=null;
			String sGeslo=null;
			//pregled piškotkov
			try {
		for (Cookie c : request.getCookies()) {
			if (c.getName().equals("cIme")) sIme=c.getValue();
			if (c.getName().equals("cPriimek")) sPriimek=c.getValue();
			if (c.getName().equals("cEmail")) sEmail=c.getValue();
			if (c.getName().equals("cGeslo")) sGeslo=c.getValue();
			}
			}catch (Exception e) {};
	%>
	
	<div class="headerContent">
		<div class="topHeader">
			<a href="entrypage.jsp">NAZAJ NA ZAČETNO STRAN</a>
		</div>
		<div class="header">
			<h1>REGISTRACIJA</h1>
		</div>
	</div>
	<hr />
	<div class="maincontent">
		<div class="main">
			<form method="POST" action="registrirani.jsp" name="obrazec" onsubmit="return preveri(this)">
				<table id="prijava">
					<tr>
						<td>Ime:</td>
						<td><input type="text" name="ime"></td>
					</tr>
					<tr>
						<td>Priimek:</td>
						<td><input type="text" name="priimek"></td>
					</tr>
					<tr>
						<td>E-mail:</td>
						<td><input id ="email" type="text" name="email" onkeyup="emailCheck(); return false;"></td>
					</tr>
					<tr>
						<td>Geslo:</td>
						<td><input id="prvo" type="password" name="prvo"></td>
					</tr>
					<tr>
						<td>Potrditev gesla:</td>
						<td><input type="password" name="drugo" id="drugo" onkeyup="checkPass(); return false;"></td>
					</tr>
					<tr>
						<td></td>
						<td><span id="preveri" class="preveri" ></span></td>
					</tr>
				</table>
				
				<input id="potrdi" type="submit" name="potrdi" value="REGISTRACIJA">
				</form>
		</div>
	</div>
	<div class="footer">
		<p>©DENIS VODIŠEK, FLORIJAN KLEZIN, ŠPELA PEČNIK, MIHA KEBE©</p>
	</div>
<script type="text/javascript">

function preveri(obrazec)
{
	obrazec.ime.style.backgroundColor = "white";
	if (obrazec.ime.value == ""){
		alert("Vpišite ime!");
		obrazec.ime.style.backgroundColor = "red";
		return false;
	}
	obrazec.priimek.style.backgroundColor = "white";
	if (obrazec.priimek.value == ""){
		alert("Vpišite priimek!");
		obrazec.priimek.style.backgroundColor = "red";
		return false;
   	}
   obrazec.email.style.backgroundColor = "white";
   if (obrazec.email.value == "") {
		alert("Vpišite e-mail!");
		obrazec.email.style.backgroundColor = "red";
		return false;
	}
   obrazec.prvo.style.backgroundColor = "white";
   if (obrazec.prvo.value == "") {
		alert("Vpišite geslo!");
		obrazec.prvo.style.backgroundColor = "red";
		return false;
	}
   obrazec.drugo.style.backgroundColor = "white";
   if (obrazec.drugo.value == "") {
		alert("Vpišite geslo!");
		obrazec.drugo.style.backgroundColor = "red";
		return false;
	}
   obrazec.ime.style.backgroundColor = "white";
   if (!(obrazec.ime.value.match(/^[A-Za-zšđčćžŠĐČĆŽ\s]*$/))){  
     alert("Vnesli ste napačno ime! Ime lahko vsebuje samo male in velike črke, ter presledek.");
     obrazec.ime.focus();
     obrazec.ime.style.backgroundColor = "red";
     return false;
   }
   obrazec.priimek.style.backgroundColor = "white";
   if (!(obrazec.priimek.value.match(/^[A-Za-zšđčćžŠĐČĆŽ\s]*$/))){  
	     alert("Vnesli ste napačen priimek! Priimek lahko vsebuje samo male in velike črke, ter presledek.");
	     obrazec.priimek.focus();
	     obrazec.priimek.style.backgroundColor = "red";
	     return false;
	}
   
   obrazec.email.style.backgroundColor = "white"; 
   if(obrazec.email.value!=" "){
   <%for(int i=0; i<emaili.size(); i++){%>
	   if(obrazec.email.value=="<%=emaili.get(i)%>"){
		   alert("Ta email je že zaseden! Vnesite drugega.");
		   obrazec.email.style.backgroundColor = "red";
		    return false;
	   }
	  <%}%>
	}
   
 obrazec.email.style.backgroundColor = "white"; 
  if (!(/^[a-zA-Z0-9_\.\-]+@[a-zA-Z]+\.+[a-zA-Z]+$/.test(obrazec.email.value))){  
     alert("Vnesli ste napačen email naslov! Email mora biti oblike naslov@domena.koncnica");
     obrazec.email.style.backgroundColor = "red";
     return false;
   } 
  obrazec.prvo.style.backgroundColor = "white";
  if (!(obrazec.prvo.value.match(/^(?=.*[0-9])([a-zA-Z0-9]{5,})$/))){  
	     alert("Vnesli ste napačno geslo! Geslo lahko vsebuje samo male in velike črke (brez šumnikov) in eno številko in mora biti dolgo najman 5 znakov.");
	     obrazec.prvo.focus();
	     obrazec.prvo.style.backgroundColor = "red";
	     return false;
	}
  obrazec.drugo.style.backgroundColor = "white";
  if (!(obrazec.drugo.value==obrazec.prvo.value)){  
	     alert("Vnesli ste napačno ponovitev geslo! Gesli se morata ujemati.");
	     obrazec.drugo.focus();
	     obrazec.drugo.style.backgroundColor = "red";
	     return false;
	}
	return true;
}
</script>
</body>

</html>