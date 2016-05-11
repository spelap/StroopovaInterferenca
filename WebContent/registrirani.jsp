<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="nastavi.Registracija"%>
<%@page import="povezava.Povezava"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.security.*"%>
<%@page import="java.net.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Stroopova interferenca</title>
<link type="text/css" rel="stylesheet" href="stroop.css" />
</head>

<body>
	<%
	request.setCharacterEncoding("UTF-8");
	
			String sIme=null;
			String sPriimek=null;
			String sEmail=null;
			String sGeslo=null;
		
			try {
			for (Cookie c : request.getCookies()) {
				if (c.getName().equals("cIme")) sIme=c.getValue();
				if (c.getName().equals("cPriimek")) sPriimek=c.getValue();
				if (c.getName().equals("cEmail")) sEmail=c.getValue();
				if (c.getName().equals("cGeslo")) sGeslo=c.getValue();
			}
			}catch (Exception e) {};
	%>

	<%
		List<Registracija> reg = null;
		if(session.getAttribute("registracija")!=null) {
			reg =(List<Registracija>)session.getAttribute("registracija");
		} else {
			reg =new ArrayList<Registracija>();
			session.setAttribute("registracija", reg);
		}
	%>

	<%//kodiranje
		if (request.getParameter("potrdi")!=null) {
			String geslo=request.getParameter("prvo");
	        String kodiranoGeslo = null;
	        try {
	            MessageDigest md = MessageDigest.getInstance("MD5");
	            md.update(geslo.getBytes());
	            byte[] bytes = md.digest();
	            StringBuilder sb = new StringBuilder();
	            for(int i=0; i< bytes.length ;i++)
	            {
	                sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
	            }
	            kodiranoGeslo = sb.toString();
	        }
	        catch (NoSuchAlgorithmException e){
	            e.printStackTrace();
	        }
			Registracija registrirani =new Registracija(request.getParameter("ime"),request.getParameter("priimek"),request.getParameter("email"),kodiranoGeslo);
			reg.add(registrirani);
			try{
				Povezava po=new Povezava();
				po.insert(registrirani);
			}catch(Exception e){
				System.out.println(e.getMessage());
			}
		}
	
		if (request.getParameter("izbrisi")!=null) {
			long id=Long.parseLong(request.getParameter("izbrisi"));
			int index=-1;
			for (int i=0;i<reg.size();i++) {
				if (reg.get(i).getId() == id) index=i;
			}
			if (index>=0)reg.remove(index);
	}
		%>		

<body>
	<div class="headerContent">
		<div class="topHeader"><a href="entrypage.jsp">NAZAJ NA ZAČETNO STRAN</a></div>
		<div class="header">
			<h1>REGISTRIRANI UPORABNIKI</h1>
		</div>
	</div>
	<hr/>
	<div class="maincontent">
		<div class="main">
		</div>
		<h3 class="uvod"><center>Registracija je bila uspešna!Tvoje uporabniško ime je <b><%=request.getParameter("email")%></b> in geslo <b><%=request.getParameter("prvo")%>.</b></center></h3>
	</div>

	<div class="footer">
		<p>©DENIS VODIŠEK, FLORIJAN KLEZIN, ŠPELA PEČNIK, MIHA KEBE©</p>
	</div>
<%
	response.addCookie(new Cookie("cIme",URLEncoder.encode(request.getParameter("ime"),"UTF-8")));
	response.addCookie(new Cookie("cPriimek",URLEncoder.encode(request.getParameter("priimek"),"UTF-8")));
	response.addCookie(new Cookie("cEmail",request.getParameter("email")));
	response.addCookie(new Cookie("cGeslo",request.getParameter("geslo")));
%>


</body>
</html>