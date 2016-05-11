<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@page import="razredi.Vprasanje"%>
<%@page import="java.sql.Connection"%>
<%@page import="povezava.Povezava"%>
<%@page import="razredi.Uporabnik"%>
<%@page import="nastavi.Nastavitve"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Eksperiment</title>
<link type="text/css" rel="stylesheet" href="stil.css" />

<%
String id_eksperiment=null;
String id_izvedbe=null;
int id_e=0;
int id_i=0;
int n=0;
int steviloVprasanj=0;
ArrayList<String> besede=null; 
Vprasanje polje[]=null;
String ponovitve = null;
Povezava pov=new Povezava();
boolean aliSoDodatneBesede=false;
	if(request.getParameter("eksperiment")!=null&&request.getParameter("id_izvedbe")!=null){
		id_eksperiment=request.getParameter("eksperiment");
		id_izvedbe=request.getParameter("id_izvedbe");
		id_e=Integer.parseInt(id_eksperiment);
		id_i=Integer.parseInt(id_izvedbe);
		try{
		Nastavitve na=pov.selectNast(id_e);
		ponovitve =na.getPonovitve();
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
	}
	//pridobimo 5 dodatnih besed za nevtralni dražljaj iz baze	
		try{
		//System.out.println("novo");
		//System.out.println("ali so besede????  "+pov.aliSoDodatneBesede(id_e));
		if(pov.aliSoDodatneBesede(id_e)){
			aliSoDodatneBesede=true;
			besede=pov.getBesedeArray(id_e);
			//System.out.println(besede.toString());
		}
		}catch(Exception e){
			System.out.println(e.getMessage());
		}
	//POLNEMO POLJE DRAZLJAJEV
		Random rand=new Random();
		n= Integer.parseInt(ponovitve);
		polje=new Vprasanje[n];
		for(int i=0;i<n/3;i++)
	polje[i]=new Vprasanje("KONSISTENTNI");
		for(int i=n/3;i<2*n/3;i++)
	polje[i]=new Vprasanje("NEKONSISTENTNI");
		//če je boolean alisododatnebesede(prej nastavljen) true,se napolnijo drugi teksti
		if(aliSoDodatneBesede){
			for(int i=2*n/3;i<n;i++){
				polje[i]=new Vprasanje("NEVTRALNI");
				polje[i].setTekst(besede.get(rand.nextInt(5)));
			}	
		}

		else
		for(int i=2*n/3;i<n;i++)
	polje[i]=new Vprasanje("NEVTRALNI");
	//premesaj vprasanja
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
		try{    
			int id_iz=Integer.parseInt(id_izvedbe);

			//System.out.println(polje.length);
			for (Vprasanje vprasanje : polje) {
					pov.insert(vprasanje, id_iz);
			}
			///število vprašanj :)
			steviloVprasanj=Integer.parseInt(pov.selectNast(id_e).getPonovitve());
		}catch(Exception e){
			out.println(e.getMessage());
		}
		
%>


<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script>
	var zacetek;
	var konec;
	var razlika;
	var stevec = 0;
	var steviloVprasanj = <%=steviloVprasanj%>;
	var arraycasov = [];
	var arrayizpisov = [];
	var zapisuj = false;
	var prikazidrazljaj = true;
	var izpis = 0;
	var cas = 2000;
	var dovolipost=true;

	
	function callback() {
		if(dovolipost==true){
			setTimeout(callback, cas);
			Prikaz();
		}
		else
			return;
	}
	
	var picipici = setTimeout(callback, cas);

	function generirajBarvo() {
		var barve = [
<%for(int i=0;i<polje.length;i++){
				out.print("'"+polje[i].getMojabarva()+"'");	
				if(polje.length>i+1)
					out.print(" , ");
		}%>
	];
		var barva = barve[stevec];
		return barva;
	}
	function generirajBesedo() {
		var besede = [
<%for(int i=0;i<polje.length;i++){
				out.print("'"+polje[i].getTekst()+"'");	
				if(polje.length>i+1)
					out.print(" , ");
			}%>
	];
		var beseda = besede[stevec];
		return beseda;
	}

	function generirajDrazljaj() {
		var drazljaj = document.getElementById("drazljaj");
		drazljaj.innerHTML = generirajBesedo();
		drazljaj.style.color = generirajBarvo();
	}

	function beleziPritisk(e) {
		var unicode = e.keyCode ? e.keyCode : e.charCode;

		switch (unicode) {
		case 49:
			izpis = 1;
			break;
		case 50:
			izpis = 2;
			break;
		case 51:
			izpis = 3;
			break;
		case 52:
			izpis = 4;
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
			cas=1000;
			$("#pricetek").css("display", "none");
			generirajDrazljaj();
			$("#drazljaj").css("display", "block");
			zapisuj = true;
			zacetek = window.performance.now();
			var element = document.getElementById("zcas");
			element.innerHTML = zacetek;
			stevec = stevec + 1;
			return;
		}

		if ($("#drazljaj").css("display") == "block") {
			cas=2000;
			$("#drazljaj").css("display", "none");
			$("#belina").css("display", "block");
			if (zapisuj == true) {
				arraycasov.push(2000);
				arrayizpisov.push(0);
				zapisuj = false;
			}
			return;
		}
		if ($("#belina").css("display") == "block") {
			cas=1000;
			if (stevec >= steviloVprasanj && dovolipost==true) {
				postIt();
				dovolipost=false
			} else {
				$("#belina").css("display", "none");
				generirajDrazljaj();
				$("#drazljaj").css("display", "block");
				zapisuj = true;
				zacetek = window.performance.now();
				var element = document.getElementById("zcas");
				element.innerHTML = zacetek;
				stevec = stevec + 1;
			}

			return;
		}
	}

	function postIt() {
		
		//zdruzi polje

		var casovi = arraycasov.join();
		var izpisovi = arrayizpisov.join();
		//kreira formo
		var url="konecKviza.jsp?eksperiment=<%=id_eksperiment%>&id_izvedba=<%=id_izvedbe%>";
		var form = document.createElement('form');
		form.setAttribute('method', 'POST');
		form.setAttribute('action', url);
		//naredi dva inputa
		myvar = document.createElement('input');
		myvar.setAttribute('name', 'casi');
		myvar.setAttribute('type', 'hidden');
		myvar.setAttribute('value', casovi);
		
		
		myvar2 = document.createElement('input');
		myvar2.setAttribute('name', 'izpisi');
		myvar2.setAttribute('type', 'hidden');
		myvar2.setAttribute('value', izpisovi);
		form.appendChild(myvar);
		form.appendChild(myvar2);
		document.body.appendChild(form);
		form.submit();		
		
	}

	//Funkcija poklice funkcijo da za vsakih 2000 milisekund ce ze ni bla prej prtisnjena tipka

	function pritisnjenatipka() {
		cas=2000;
		//izmeri koncni cas
		konec = window.performance.now();
		var element = document.getElementById("kcas");
		element.innerHTML = konec;
		//izracuna razliko
		element = document.getElementById("razlika");
		element.innerHTML = Math.round(konec - zacetek);
		razlika = element;
		if (zapisuj == true) {
			arraycasov.push(razlika.innerHTML);
			arrayizpisov.push(izpis);
			zapisuj = false;
		}
		//prikaz beline
		$("#drazljaj").css("display", "none");
		$("#belina").css("display", "block");
		
		
	}
</script>
</head>

<body onkeyup="pritisnjenatipka()"
	onkeydown="beleziPritisk(event); this.select();">

	<div class="wrapper">
		<div id="pricetek">PRIČETEK EKSPERIMENTA</div>
		<div class="main">
		<div class="zadrazljaj">
			<div class="drazljaj" id="drazljaj">DRAŽLJAJ</div>
		</div>
		<div id="napaka">NAPAKA</div>
		<div id="pravilno">PRAVILNO</div>
		<div id="belina"></div>

		<form>
			<div class="gumbi">
				<button class="gumb" type="button" name="rdeca">1 - RDEČA</button>
				<button class="gumb" type="button" name="modra">2 - MODRA</button>
				<button class="gumb" type="button" name="zelena">3 - ZELENA</button>
				<button class="gumb" type="button" name="vijolicna">4-VIJOLIČNA</button>
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