<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="nastavi.Nastavitve"%>
<%@page import="povezava.Povezava"%>
<%@page import="java.net.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Stroopova interferenca</title>
<link type="text/css" rel="stylesheet" href="stroop.css" />
<script type="text/javascript" src="/code_examples/passtest.js"></script>
</head>

<body>
	<%
	request.setCharacterEncoding("UTF-8");
	boolean skozi=true;
		String sIme=null;
			String sPozdrav=null;
			String sNavodilo=null;
			String sZahvala=null;
			String sPonovitve=null;
			String sBeseda1=null;
			String sBeseda2=null;
			String sBeseda3=null;
			String sBeseda4=null;
			String sBeseda5=null;
			//pregled piškotkov
			try {
		for (Cookie c : request.getCookies()) {
			if (c.getName().equals("cIme"))sIme=c.getValue();
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
	
	Povezava po=new Povezava();
	String s=null;
	%>
<body>
	<%
	List<Nastavitve> n=po.selectV(); 
	Nastavitve na=null;
	boolean odlocitev=true;
	if(n.size()>0){
		for(int i=0; i<n.size(); i++){
		na=n.get(i);
			if(request.getParameter("gumbpotrdi")!=null){ 
				if ((request.getParameter("ime").equals(na.getIme())) && (request.getParameter("uvodnipozdrav").equals(na.getUvodniPozdrav()))&&(request.getParameter("navodilo").equals(na.getNavodilo()))&&(request.getParameter("zahvala").equals(na.getZahvala()))&& (request.getParameter("ponovitve").equals(na.getPonovitve()))&& (request.getParameter("beseda1").equals(na.getBeseda1()))&& (request.getParameter("beseda2").equals(na.getBeseda2()))&& (request.getParameter("beseda3").equals(na.getBeseda3()))&& (request.getParameter("beseda4").equals(na.getBeseda4()))&& (request.getParameter("beseda5").equals(na.getBeseda5()))) {
					%><script>alert("Ne morete vnesti dveh enakih eksperimentov!")</script><%
					odlocitev=false;
					break;
				}
			}
		}
	}
	else{
		if(request.getParameter("gumbpotrdi")!=null){ 
			odlocitev=false;
			Nastavitve admin =new Nastavitve(request.getParameter("ime"),request.getParameter("uvodnipozdrav"),request.getParameter("navodilo"),request.getParameter("zahvala"),
					request.getParameter("ponovitve"),request.getParameter("beseda1"),request.getParameter("beseda2"),request.getParameter("beseda3"),
					request.getParameter("beseda4"),request.getParameter("beseda5"));
			try{
				if(request.getRemoteUser()!=null) {
				s=request.getRemoteUser();
				po.insert(admin, s);
				}
			}catch(Exception e){
				out.println(e.getMessage());
			}
		}
	}
	
	if(odlocitev){
		Nastavitve admin =new Nastavitve(request.getParameter("ime"),request.getParameter("uvodnipozdrav"),request.getParameter("navodilo"),request.getParameter("zahvala"),
				request.getParameter("ponovitve"),request.getParameter("beseda1"),request.getParameter("beseda2"),request.getParameter("beseda3"),
				request.getParameter("beseda4"),request.getParameter("beseda5"));
		try{
			if(request.getRemoteUser()!=null) {
			s=request.getRemoteUser();
			po.insert(admin, s);
			}
		}catch(Exception e){
			out.println(e.getMessage());
		}
	}
	
		if (request.getParameter("izbrisi")!=null) {
			int id=Integer.parseInt(request.getParameter("izbrisi"));
			if(request.getRemoteUser()!=null) {
				s=request.getRemoteUser();
				int sporocilo=po.delete(id,s);
				if(sporocilo==1){
					%><script>alert("Študent lahko izbriše samo eksperimente, ki jih je sam ustvaril!");</script><%
				}
			}else{
				%><script>alert("Za brisanje eksperimentov morate biti prijavljeni! Študent lahko izbriše samo eksperimente, ki jih je sam ustvaril!");</script><%
			}
		}
%>	
	<div class="headerContent">
		<div class="topHeader"><a href="entrypage.jsp">NAZAJ NA ZAČETNO STRAN</a>
		<div class="registracija">
		<% if(request.getRemoteUser()!=null) { %>
		<div class="odjava">
		<p>PRIJAVLJENI KOT:  |<b><%=request.getRemoteUser()%></b>| <a href="entrypage.jsp?odjava">ODJAVA</a></p>
		</div>
		<% } %>
		</div>
		</div>
		<div class="header">
			<h1>OBSTOJEČI TESTI</h1>
		</div>
	</div>
	<hr/>
	<div class="maincontent">
		<div class="main">
		
			<table id="tabela">
				<tr>
					<td>IME</td>
					<td>ŠTEVILO PONOVITEV</td>
					<td>BESEDA 1</td>
					<td>BESEDA 2</td>
					<td>BESEDA 3</td>
					<td>BESEDA 4</td>
					<td>BESEDA 5</td>
					<td>IZBRIŠI</td>
					<td>REŠI TEST</td>
					<td>ŠT. REŠENIH</td>
					<td>POVLECI</td>
				</tr>
				<%
					for (Nastavitve a: po.select()){
				%>
				<tr>
					<td><%=a.getIme()%></td>
					<td><%=a.getPonovitve()%></td>
					<td><%=a.getBeseda1()%></td>
					<td><%=a.getBeseda2()%></td>
					<td><%=a.getBeseda3()%></td>
					<td><%=a.getBeseda4()%></td>
					<td><%=a.getBeseda5()%></td>
					<td><a href="testic.jsp?izbrisi=<%=a.getId()%>" onclick="return confirm('Si prepričan? Izbrisane bodo tudi vse rešitve tega eksperimenta.');">IZBRIŠI</a></td>
					<td><a href="uporabnikLog.jsp?eksperiment=<%=a.getId()%>">REŠI</a></td>
					<td><i><%=po.stResenih(a.getId()) %></i></td>
					<td><a href="eksperiment.xls?a=<%=a.getId()%>">DOWNLOAD</a></td>
					
				</tr>
				<%
					}
				%>

			</table>
		</div>
	</div>

<%try{
	if(request.getParameter("ime")!=null){
		response.addCookie(new Cookie("cIme",URLEncoder.encode(request.getParameter("ime"),"UTF-8")));
		response.addCookie(new Cookie("cPozdrav",URLEncoder.encode(request.getParameter("uvodnipozdrav"),"UTF-8")));
		response.addCookie(new Cookie("cNavodilo",URLEncoder.encode(request.getParameter("navodilo"),"UTF-8")));
		response.addCookie(new Cookie("cZahvala",URLEncoder.encode(request.getParameter("zahvala"),"UTF-8")));
		response.addCookie(new Cookie("cPonovitve",request.getParameter("ponovitve")));
		response.addCookie(new Cookie("cBeseda1",URLEncoder.encode(request.getParameter("beseda1"),"UTF-8")));
		response.addCookie(new Cookie("cBeseda2",URLEncoder.encode(request.getParameter("beseda2"),"UTF-8")));
		response.addCookie(new Cookie("cBeseda3",URLEncoder.encode(request.getParameter("beseda3"),"UTF-8")));
		response.addCookie(new Cookie("cBeseda4",URLEncoder.encode(request.getParameter("beseda4"),"UTF-8")));
		response.addCookie(new Cookie("cBeseda5",URLEncoder.encode(request.getParameter("beseda5"),"UTF-8")));
	}
	}catch(Exception e){};
%>


</body>
</html>