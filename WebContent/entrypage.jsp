<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Stroopova interferenca</title>
<link type="text/css" rel="stylesheet" href="stroop.css" />
</head>

	<%
		if(request.getParameter("odjava")!=null) {
			session.invalidate();
			response.sendRedirect("entrypage.jsp");
		}
	%>

<body>
	<div class="zacetna">
	<div class="headerContent">
		<div class="topHeader">
		<div class="registracija">
		<% if(request.getRemoteUser()!=null) { %>
		<div class="odjava">
		<p>PRIJAVLJENI KOT:  |<b><%=request.getRemoteUser()%></b>| <a href="entrypage.jsp?odjava">ODJAVA</a></p>
		</div>
		<%
			} else {
		%>
		 <%if (request.getRemoteUser()==null){ %><a href="uspesnaprijava.jsp">PRIJAVA</a><%} %>
		<span> | |</span>
		<a href="registracija.jsp">REGISTRACIJA</a>
		<%
			}
		%>
	</div>
	</div>
	</div>
		<div class="naslov">
			<h1>STROOPOVA</h1>
			<h1>INTERFERENCA</h1>
			<hr />
		</div>
		<div class="linki">
			<a href="testic.jsp" id="testi">OBSTOJEČI TESTI</a> <a
				href="admin.jsp" id="dodaj">DODAJ EKSPERIMENT</a>
		</div>
	</div>
</body>
</html>