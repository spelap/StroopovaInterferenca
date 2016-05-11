Infrastruktura, ki jo na� program uporablja: Apache Tomcat 8.0, MySql.
NAVODILA ZA POGON PROGRAMA:
Program zahteva server Apache Tomcat 8.0, saj na starej�ih razli�icah nekatere funkcionalnosti ne delujejo. Pravtako je potrebno prilagoditi nekatere datoteke, ki pripadajo serverju (server.xml in tomcat-users.xml). V srever.xml potrebno pod <Realm className="org.apache.catalina.realm.LockOutRealm"> dodati 
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
V direktorij na�ega serverja (Apache Tomcat 8.0) moramo v mapo /lib kopirati gonilnik, ki smo ga �e prej namestili v mapi WEB-INF/lib/. V direktoriju serverja poi��emo tudi mapo /conf, kamor kopiramo datoteko srever.xml.

Koraki namestitve:
1.Datoteko war je potrebno kopirati v stre�nik (Apache Tomcat 8.0).
2.V njej je Dynamic Web Project stroopov.
3.Ko ga po�enete se odpre odpre entypage.jsp

Poskrbeti moramo, da imamo vzpostavljeno povezavo z mySQL bazo, ki se nahaja na stre�niku.
Ob zagonu projekta se odpre uvodna stran, kjer lahko uporabnik izbere med funkcijami(izbere eksperiment, ki ga �eli re�iti, �e pa je uporabnik �tudent, se lahko registrira in prijavi, ter tako ustvari svoj eksperiment, ki ga lahko tudi izbri�e. Omogo�en je tudi izvoz rezultatov re�evanja eksperimenta v Microsoft Office Excel).
Za prijavo v aplikacijo lahko uporabite email admin@gmail.com in geslo admin, ali pa se registrirate in si tam dolo�ite svoje uporabni�ko ime in geslo. Za samo re�evanje vaje oz. eksperimenta se ni potrebno prijavljati, ampak si lahko uporabnik izmisli poljubno �ifro.