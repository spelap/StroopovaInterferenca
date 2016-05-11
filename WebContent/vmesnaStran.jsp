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

<%
String id_izvedbe=null;
String id_eksperimenta=null;
if(request.getParameter("id_izvedba")!=null&&request.getParameter("eksperiment")!=null){
	id_izvedbe=request.getParameter("id_izvedba");
	id_eksperimenta=request.getParameter("eksperiment");
}

%>
	<div class="objemi">
		<div class="main">
			<div class="zakljucekvaje">
				<h2>Vaja se je zaključila. S klikom na na gumb ZAČNI
					EKSPERIMENT nadaljujete z eksperimentom.</h2>
				<form method="POST"
					action="eksperiment.jsp?eksperiment=<%=id_eksperimenta%>&id_izvedbe=<%=id_izvedbe%>">
					<div class="pojdieksperiment">
						<input type="submit" id="pojdieksperiment" name="zacni"
							value="ZAČNI EKSPERIMENT">
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>