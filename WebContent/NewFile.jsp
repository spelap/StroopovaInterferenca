<%@page import="razredi.Glavko"%>
<%@page import="javax.servlet.jsp.tagext.TryCatchFinally"%>
<%@page import="jdk.internal.org.objectweb.asm.tree.TryCatchBlockNode"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="razredi.Vprasanje"%>
<%@page import="java.sql.Connection"%>
<%@page import="povezava.Povezava"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
out.print(request.getParameter("casi"));

String s;

	s="12345,22222222,433,312,276,286,1088,1567,977657656,2222221";
	String barve="TESTIRANJE1,TESTIRANJE2,#003399,#003399,#FF0000,#003399,#003399,#660066,#003399,#TESTIRANJE";
	
	//barve=request.getParameter("izpisi");
	//s=request.getParameter("casi");
	Povezava p=new Povezava();
	
		//p.arraylist_barv(barve);
		//p.arraylist_casov(s);
	
%> <br/> <%
out.print(request.getParameter("izpisi"));



%>
<a href="/ss" accesskey="1" title="dsgdg">excel</a>
</body>
</html>