<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="povezava.Povezava"%>
<%@page import="java.util.*"%>
<%@page import="razredi.Vprasanje"%>
<%@page import="nastavi.Nastavitve"%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
int stevecPravilnihKonsistentnih = 0;
int stevecPravilnihNevtralnih = 0;
int stevecPravilnikNekonsistentnih=0;
int skupniCasNevtralni=0;
int skupniCasNekonsistentni=0;
int skupniCasKonsistentni=0;
%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link type="text/css" rel="stylesheet" href="stroop.css" />
<title>Stroopova interferenca</title>


<script type="text/javascript" src="https://www.google.com/jsapi"></script>



</head>
<%
	String id_eksperiment = null;
	String id_izvedbe = null;
	String ime = null;
	String zahvala = null;
	int id_e = 0;
	int id_i = 0;

	if (request.getParameter("eksperiment") != null
			&& request.getParameter("id_izvedba") != null) {
		id_eksperiment = request.getParameter("eksperiment");
		id_izvedbe = request.getParameter("id_izvedba");

		Povezava po = new Povezava();
		id_e = Integer.parseInt(id_eksperiment);
		id_i = Integer.parseInt(id_izvedbe);
		try {
			Nastavitve n = po.selectNast(id_e);
			ime = n.getIme();
			zahvala = n.getZahvala();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
%>

<body>
	<div class="header">
		<h1>STROOPOV EKSPERIMENT</h1>
		<p id="imeeksperimenta"><%=ime%></p>
	</div>
	<hr />
	<div class="konec">
		<div class="zahvalica">
			<h2>ZAHVALA</h2>
			<p><%=zahvala%></p>
			<h2>REZULTATI EKSPERIMENTA</h2>
		</div>
		<div id="piechart_3d" style="width: 600px; height: 500px;"></div>
		<div id="barchart_values" style="width: 400px; height: 300px;"></div>
	
	
		<div class="rezultati">
			
			<%
				Povezava p = new Povezava();
				String barve = request.getParameter("izpisi");
				String casi = request.getParameter("casi");
				//out.println(barve);
				p.arraylist_barv(barve, id_i);
				p.arraylist_casov(casi, id_i);
			%>
			<br />
			<%
				int id = 1;
				List<Vprasanje> a = p.selectVprasanjaIzvedba(id_i);
			%>
			<table id="tabela">
				<tr>
					<td>TIP DRAŽJAJA</td>
					<td>ČAS</td>
					<td>BARVA DRAŽLJAJA</td>
					<td>IZBRANA BARVA</td>
					<td>BESEDILO DRAŽLJAJA</td>
					<td>PRAVILNOST</td>
				</tr>
				<%
					for (Vprasanje vprasanje : a) {
				%>
				<tr>
					<td><%=vprasanje.getTip()%></td>
					<td><%=vprasanje.getCas()%></td>
					<td><%=vprasanje.getMojabarva()%></td>
					<td><%=vprasanje.getVnesenabarva()%></td>
					<td><%=vprasanje.getTekst()%></td>
					<td><%=vprasanje.isPravilnost()%></td>
					<%	if(vprasanje.getTip().equals("KONSISTENTNI"))
							skupniCasKonsistentni+=vprasanje.getCas();
						if(vprasanje.getTip().equals("NEKONSISTENTNI"))
							skupniCasNekonsistentni+=vprasanje.getCas();
						if(vprasanje.getTip().equals("NEVTRALNI"))
							skupniCasNevtralni+=vprasanje.getCas();
						
						if (vprasanje.isPravilnost() == true) {
								switch (vprasanje.getTip()) {
								case "KONSISTENTNI":
									stevecPravilnihKonsistentnih++;
									break;
								case "NEKONSISTENTNI":
									stevecPravilnikNekonsistentnih++;
									break;
								case "NEVTRALNI":
									stevecPravilnihNevtralnih++;
									break;
								default:
									break;
								}
							}
					%>
				</tr>
				<%
					}
				%>

			</table>
		</div>
		<script type="text/javascript">
	google.load("visualization", "1", {
		packages : [ "corechart" ]
	});
	google.setOnLoadCallback(drawChart);
	function drawChart() {
		var data = google.visualization
				.arrayToDataTable([
						[ 'Vrsta dražljaja', 'Število pravilnih odgovorov' ],
						[ 'Nekonsistentni dražljaji',
<%=stevecPravilnikNekonsistentnih%>
	],
						[ 'Nevtralni dražljaji',
<%=stevecPravilnihNevtralnih%>
	],
						[ 'Konsistentni dražljaji',
<%=stevecPravilnihKonsistentnih%>
	]
	]);

		var options = {
			title : 'Pravilnost vaših odgovorov',
			is3D : true,
		};

		var chart = new google.visualization.PieChart(document
				.getElementById('piechart_3d'));
		chart.draw(data, options);
	}
</script>
<script type="text/javascript">
    google.load("visualization", "1", {packages:["corechart"]});
    google.setOnLoadCallback(drawChart);
    function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ["Vrsta dražljaja", "Skupni čas v ms", { role: "style" } ],
        ["Nevtralni", <%=skupniCasNevtralni%>, "#b87333"],
        ["Konsistentni", <%=skupniCasKonsistentni%>, "silver"],
        ["Nekonstistentni", <%=skupniCasNekonsistentni%>, "gold"],
      ]);

      var view = new google.visualization.DataView(data);
      view.setColumns([0, 1,
                       { calc: "stringify",
                         sourceColumn: 1,
                         type: "string",
                         role: "annotation" },
                       2]);

      var options = {
        title: "Skupni čas porabljen za reševanje različnih tipov dražljajev",
        width: 600,
        height: 400,
        bar: {groupWidth: "95%"},
        legend: { position: "none" },
      };
      var chart = new google.visualization.BarChart(document.getElementById("barchart_values"));
      chart.draw(view, options);
  }
  </script>
  
		<form method="POST" action="entrypage.jsp">
			<div class="domaca">
				<input type="submit" id="domaca" name="domov"
					value="KONČAJ EKSPERIMENT">
			</div>
		</form>
	</div>
</body>
</html>