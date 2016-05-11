Infrastruktura, ki jo naš program uporablja: Apache Tomcat 8.0, MySql.
NAVODILA ZA POGON PROGRAMA:
Program zahteva server Apache Tomcat 8.0, saj na starejših razlièicah nekatere funkcionalnosti ne delujejo. Pravtako je potrebno prilagoditi nekatere datoteke, ki pripadajo serverju (server.xml in tomcat-users.xml). V srever.xml potrebno pod <Realm className="org.apache.catalina.realm.LockOutRealm"> dodati 
	<Realm className="org.apache.catalina.realm.JDBCRealm"
      		driverName="com.mysql.jdbc.Driver"
   			connectionURL="jdbc:mysql://164.8.251.196:3306/p12015stroop"
   			connectionName="p12015stroop" 
   			connectionPassword="gp12015stroop"
      		userTable="student" 
      		userNameCol="email" 
      		userCredCol="geslo"
   			userRoleTable="user_roles" 
   			roleNameCol="role_name"
   			/>
V direktorij našega serverja (Apache Tomcat 8.0) moramo v mapo /lib kopirati gonilnik, ki smo ga že prej namestili v mapi WEB-INF/lib/. V direktoriju serverja poišèemo tudi mapo /conf, kamor kopiramo datoteko srever.xml.

Koraki namestitve:
1.Datoteko war je potrebno kopirati v strežnik (Apache Tomcat 8.0).
2.V njej je Dynamic Web Project stroopov.
3.Ko ga poženete se odpre odpre entypage.jsp

Poskrbeti moramo, da imamo vzpostavljeno povezavo z mySQL bazo, ki se nahaja na strežniku.
Ob zagonu projekta se odpre uvodna stran, kjer lahko uporabnik izbere med funkcijami(izbere eksperiment, ki ga želi rešiti, èe pa je uporabnik študent, se lahko registrira in prijavi, ter tako ustvari svoj eksperiment, ki ga lahko tudi izbriše. Omogoèen je tudi izvoz rezultatov reševanja eksperimenta v Microsoft Office Excel).
Za prijavo v aplikacijo lahko uporabite email admin@gmail.com in geslo admin, ali pa se registrirate in si tam doloèite svoje uporabniško ime in geslo. Za samo reševanje vaje oz. eksperimenta se ni potrebno prijavljati, ampak si lahko uporabnik izmisli poljubno šifro.