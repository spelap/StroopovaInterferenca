<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Random"%>
<%@page import="razredi.Vprasanje"%>
<%@page import="java.sql.Connection"%>
<%@page import="povezava.Povezava"%>
<%@page import="razredi.Uporabnik"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Vaja</title>
<link type="text/css" rel="stylesheet" href="stil.css" />

<%

int id=0;
	if(request.getParameter("eksperiment")!=null){
		id=Integer.parseInt(request.getParameter("eksperiment"));
	}

Povezava po=new Povezava();
int id_izvedba=0;
if (request.getParameter("zacni")!=null) {
	String starost=request.getParameter("starost");
	int s=Integer.parseInt(starost);
	Uporabnik upo =new Uporabnik(request.getParameter("sifra"),request.getParameter("spol"),s);
	try{
		po.insert(upo);
		id_izvedba=po.insert(upo, id);
	}catch(Exception e){
		out.println(e.getMessage());
	}
}
	//POLNEMO POLJE DRAZLJAJEV
		int n=30;
		Vprasanje polje[]=new Vprasanje[n];
		for(int i=0;i<n/3;i++)
	polje[i]=new Vprasanje("KONSISTENTNI");
		for(int i=n/3;i<2*n/3;i++)
	polje[i]=new Vprasanje("NEKONSISTENTNI");
		for(int i=2*n/3;i<n;i++)
	polje[i]=new Vprasanje("NEVTRALNI");

		 int index;
		 Vprasanje temp;
		    Random random = new Random();
		    for (int i = polje.length - 1; i > 0; i--)
		    {
		        index = random.nextInt(i + 1);
		        temp = polje[index];
		        polje[index] = polje[i];
		        polje[i] = temp;
		    }
%>


<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script>
	var zacetek;
	var konec;
	var razlika;
	var stevec = 0;
	var steviloVprasanj = 10;
	var arraycasov = [];
	var arrayizpisov = [];
	var zapisuj = false;
	var prikazidrazljaj = true;
	var prikaziodziv=true;
	var izpis = 0;
	var cas = 2000;
	var barva;

	///časovni interval
	function callback() {
		setTimeout(callback, cas);
		Prikaz();
	}

	var picipici = setTimeout(callback, cas);

	function generirajBarvo() {
		var barve = ['#FF0000' , '#006600' , '#660066' , '#FF0000' , '#FF0000' , '#003399' , '#003399' , '#660066' , '#003399' , '#006600'];
		barva = barve[stevec];
		return barva;
	}
	function generirajBesedo() {
		var besede = ['VIJOLIČNA' , 'MODRA' , 'VIJOLIČNA' , 'KOREF' , 'RALCUT' , 'KAGID' , 'ZELENA' , 'VIJOLIČNA' , 'VIJOLIČNA' , 'LOPEDS'];
		var beseda = besede[stevec];
		return beseda;
	}
		
	function generirajDrazljaj() {
		var drazljaj = document.getElementById("drazljaj");
		drazljaj.innerHTML = generirajBesedo();
		drazljaj.style.color = generirajBarvo();
	}

	function beleziPritisk(e) {
		var unicode = e.keyCode ? e.keyCode : e.charCode

		switch (unicode) {
		case 49:
			izpis = '#FF0000';
			break;
		case 50:
			izpis = '#003399';
			break;
		case 51:
			izpis = '#006600';
			break;
		case 52:
			izpis = '#660066';
			break;
		default:
			izpis = 0;
		}
		var element = document.getElementById("izpis");
		element.innerHTML = izpis;

	}

	function Prikaz() {

		if ($("#pricetek").css("display") == "block") {
			$(".gumbi").css("display", "block");
			$("#pricetek").css("display", "none");
			generirajDrazljaj();
			$("#drazljaj").css("display", "block");
			zapisuj = true;
			zacetek = new Date().getTime();
			var element = document.getElementById("zcas");
			element.innerHTML = zacetek;
			stevec = stevec + 1;
			return;
		}

		if ($("#drazljaj").css("display") == "block") {
			$("#drazljaj").css("display", "none");
			$("#belina").css("display", "block");
			$("#napaka").css("visibility", "visible");
			prikaziodziv=false;
			if (zapisuj == true) {
				arraycasov.push(0);
				arrayizpisov.push(0);
				zapisuj = false;
			}
			return;
		}
		if ($("#belina").css("display") == "block") {
			prikaziodziv=true;
			if (stevec >= steviloVprasanj) {
				postIt();
			} else {
				$("#belina").css("display", "none");
				generirajDrazljaj();
				$("#drazljaj").css("display", "block");
				$("#napaka").css("visibility", "hidden");
				$("#pravilno").css("visibility", "hidden");
				zapisuj = true;
				zacetek = new Date().getTime();
				var element = document.getElementById("zcas");
				element.innerHTML = zacetek;
				stevec = stevec + 1;	
			}
			return;
		}
	}

	function postIt() {
		//zdruzi polje
		var casi = arraycasov.join();
		var izpisi = arrayizpisov.join();
		//kreira formo
		form = document.createElement('form');
		form.setAttribute('method', 'POST');
		form.setAttribute('action', 'vmesnaStran.jsp?eksperiment=<%=id%>&id_izvedba=<%=id_izvedba%>');

		//naredi dva inputa
		myvar = document.createElement('input');
		myvar.setAttribute('name', 'casi');
		myvar.setAttribute('type', 'hidden');
		myvar.setAttribute('value', casi);
		myvar2 = document.createElement('input');
		myvar2.setAttribute('name', 'izpisi');
		myvar2.setAttribute('type', 'hidden');
		myvar2.setAttribute('value', izpisi);
		form.appendChild(myvar);
		form.appendChild(myvar2);
		document.body.appendChild(form);

		form.submit();
	}

	//Funkcija poklice funkcijo da za vsakih 2000 milisekund ce ze ni bla prej prtisnjena tipka

	function pritisnjenatipka() {

		//izmeri koncni cas
		konec = new Date().getTime();
		var element = document.getElementById("kcas");
		element.innerHTML = konec;
		//izracuna razliko
		element = document.getElementById("razlika");
		element.innerHTML = konec - zacetek;
		razlika = element;
		if (zapisuj == true) {
			arraycasov.push(razlika.innerHTML);
			arrayizpisov.push(izpis);
			zapisuj = false;
		}
		//prikaz beline
		$("#drazljaj").css("display", "none");
		$("#belina").css("display", "block");
		
		
		if(izpis==barva&&prikaziodziv==true)
			$("#pravilno").css("visibility", "visible");
		else if (prikaziodziv==true)
			$("#napaka").css("visibility", "visible");
		prikaziodziv=false;
	}
</script>
</head>

<body onkeyup="pritisnjenatipka()"
	onkeydown="beleziPritisk(event); this.select();">

	<div class="wrapper">
		<div id="pricetek">PRIČETEK VAJE</div>
		<div id="napaka" style="background-color:">NAPAČEN ODGOVOR!</div>
		<div id="pravilno" style="background-color:">PRAVILEN ODGOVOR!</div>
		<div class="main">
		<div class="zadrazljaj">
			<div id="drazljaj">DRAŽLJAJ</div>
		</div>
		<div id="belina"></div>

		<form>
			<div class="gumbi">
				<button class="gumb" type="button" name="rdeca">1 - RDEČA</button>
				<button class="gumb" type="button" name="modra">2 - MODRA</button>
				<button class="gumb" type="button" name="zelena">3 - ZELENA</button>
				<button class="gumb" type="button" name="vijolicna">4 - VIJOLIČNA</button>
			</div>
		</form>
		</div>
		</div>
			<div class="pomoc">
		<table>
			<tr>
				<td>IZPIS</td>
				<td id="izpis">0</td>
			</tr>
			<tr>
				<td>ZACETNI CAS</td>
				<td id="zcas">0</td>
			</tr>
			<tr>
				<td>KONCNI CAS</td>
				<td id="kcas">0</td>
			</tr>
			<tr>
				<td>RAZLIKA</td>
				<td id="razlika">0</td>
			</tr>
		</table>
	</div>
</body>
</html>