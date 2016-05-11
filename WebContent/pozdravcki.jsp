<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="nastavi.Nastavitve"%>
<%@page import="povezava.Povezava"%>
<%@page import="razredi.Uporabnik"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Stroopova interferenca</title>
<link type="text/css" rel="stylesheet" href="stroop.css" />
<script type="text/javascript" src="/code_examples/passtest.js"></script>
</head>
<%

String ime = null;
String uvodnipozdrav =null;
String navodila = null;
String stPonovitev = null;
String zahvala = null;
Povezava po=new Povezava();
int id=0;
if(request.getParameter("eksperiment")!=null){
	id=Integer.parseInt(request.getParameter("eksperiment"));
	try{
	Nastavitve n=po.selectNast(id);
	ime=n.getIme();
	uvodnipozdrav=n.getUvodniPozdrav();
	navodila=n.getNavodilo();
	stPonovitev=n.getPonovitve();
	zahvala = n.getZahvala();
	}catch(Exception e){
		System.out.println(e.getMessage());
	}
}
String starost=null;
String sifra=null;
String spol=null;
if (request.getParameter("naprej")!=null) {
	starost=request.getParameter("starost");
	sifra=request.getParameter("sifra");
	spol=request.getParameter("spol");
}

%>
<body>
	<div class="header">
		<h1>STROOPOV EKSPERIMENT</h1>
		<p id="imeeksperimenta"><%=ime%></p>
	</div>
	<hr />
	<div class="pozdrav">
		<div class="uvod">
			<h2>UVODNI POZDRAV</h2>
			<p><%=uvodnipozdrav%></p>
		</div>
		<div class="navodilo">
			<h2>NAVODILA</h2>
			<p><%=navodila%></p>
		</div>
		<div class="navodilo">
			<h2>ŠTEVILO PONOVITEV DRAŽJAJA</h2>
			<p><%=stPonovitev%></p>
		</div>
		<form method="POST" action="vaja.jsp?eksperiment=<%=id%>&starost=<%=starost%>&sifra=<%=sifra%>&spol=<%=spol%>">
		<div class="zacni">
			<input type="submit" id="zacni" name="zacni" value="ZAČNI">
		</div>
		</form>
	</div>
</body>
</html>