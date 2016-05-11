package povezava;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.sql.ResultSet;
import java.util.List;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import razredi.Uporabnik;
import nastavi.Nastavitve;
import nastavi.Registracija;
import razredi.Vprasanje;
public class Povezava {
	public String izpis;
	public Exception e;

	public Connection getConnection() {
		try {
			InitialContext ic=new InitialContext();
			DataSource ds = (DataSource)ic.lookup("java:comp/env/jdbc/p12015stroop");

			return ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
			izpis=e.getMessage();
			return null;
		}
	}

	public void insert(Vprasanje v, int i) throws Exception {
		Connection conn=getConnection();
		try {
			PreparedStatement ps=conn.prepareStatement("insert into vprasanje(pravilnost, cas, IZVEDBA_id_izvedba, tip, vnesena_barva, pravilna_barva, beseda) values (?,?,?,?,?,?,?)");
			ps.setBoolean(1, v.isPravilnost());
			ps.setLong(2,    v.getCas());
			ps.setInt(3, 	i);
			ps.setString(4,	v.getTip());
			ps.setString(5, "ni doloceno");
			ps.setString(6, v.tekstIzBarveReturn());
			ps.setString(7, v.getTekst());
			ps.executeUpdate();
		} finally {
			conn.close();
		}
	}

	public void insert(Uporabnik u) throws Exception {
		Connection conn=getConnection();
		try {
			PreparedStatement ps=conn.prepareStatement("insert into uporabnik(sifra, starost, spol) values (?,?,?)");
			ps.setString(1, u.getSifra());
			ps.setInt(2,    u.getStarost());
			ps.setString(3, 	u.getSpol());
			ps.executeUpdate();
		} finally {
			conn.close();
		}

	}

	public int insert(Uporabnik u, int id) throws Exception {
		Connection conn=getConnection();
		int idUporabnika=0;
		PreparedStatement pr=conn.prepareStatement("select id_uporabnik from uporabnik where sifra=?");
		pr.setString(1, u.getSifra());
		ResultSet rs=pr.executeQuery();
		while (rs.next()) {
			idUporabnika=rs.getInt("id_uporabnik");
			break;
		}
		rs.close();

		try {
			PreparedStatement ps=conn.prepareStatement("insert into izvedba(EKSPERIMENT_id_eksperiment, UPORABNIK_id_uporabnik) values (?,?)");
			ps.setInt(1, id);
			ps.setInt(2, idUporabnika);
			ps.executeUpdate();


			int idIzvedbe=0;
			PreparedStatement p3=conn.prepareStatement("select id_izvedba from izvedba where EKSPERIMENT_id_eksperiment=? and UPORABNIK_id_uporabnik=?");
			p3.setInt(1, id);
			p3.setInt(2, idUporabnika);
			ResultSet rt=p3.executeQuery();
			while (rt.next()) {
				idIzvedbe=rt.getInt("id_izvedba");
				break;
			}
			rt.close();
			return idIzvedbe;
		} finally {
			conn.close();
		}
	}




	public void insert(Nastavitve n, String student) throws Exception {
		Connection conn=getConnection();
		try {
			PreparedStatement ps=conn.prepareStatement("insert into eksperiment(ime,uvodni_pozdrav, navodilo, zahvala, st_ponovitev, beseda_1, beseda_2, beseda_3, beseda_4, beseda_5) values (?,?,?,?,?,?,?,?,?,?)");
			ps.setString(1, n.getIme());
			ps.setString(2, n.getUvodniPozdrav());
			ps.setString(3, n.getNavodilo());
			ps.setString(4, n.getZahvala());
			ps.setString(5, n.getPonovitve());
			ps.setString(6, n.getBeseda1());
			ps.setString(7, n.getBeseda2());
			ps.setString(8, n.getBeseda3());
			ps.setString(9, n.getBeseda4());
			ps.setString(10, n.getBeseda5());
			ps.executeUpdate();

			int id=0;
			PreparedStatement pr=conn.prepareStatement("select id_eksperiment from eksperiment where ime=? and uvodni_pozdrav=? and navodilo=? and zahvala=? and st_ponovitev=? and beseda_1=? and beseda_2=? and beseda_3=? and beseda_4=? and beseda_5=?");
			pr.setString(1, n.getIme());
			pr.setString(2, n.getUvodniPozdrav());
			pr.setString(3, n.getNavodilo());
			pr.setString(4, n.getZahvala());
			pr.setString(5, n.getPonovitve());
			pr.setString(6, n.getBeseda1());
			pr.setString(7, n.getBeseda2());
			pr.setString(8, n.getBeseda3());
			pr.setString(9, n.getBeseda4());
			pr.setString(10, n.getBeseda5());
			ResultSet rs=pr.executeQuery();
			while (rs.next()) {
				id=rs.getInt("id_eksperiment");
				break;
			}
			rs.close();

			int idD=0;
			PreparedStatement p2=conn.prepareStatement("select id_student from student where email=?");
			p2.setString(1, student);
			ResultSet r2=p2.executeQuery();
			while (r2.next()) {
				idD=r2.getInt("id_student");
				break;
			}
			r2.close();

			PreparedStatement p1=conn.prepareStatement("insert into izdelava(STUDENT_id_student,EKSPERIMENT_id_eksperiment) values (?,?)");
			p1.setInt(1, idD);
			p1.setInt(2, id);
			p1.executeUpdate();
		} catch(Exception e){
			e.getMessage();}
		finally {
			conn.close();
		}
	}

	public Nastavitve selectNast(int id) throws Exception{
		Nastavitve n=null;
		Connection conn=getConnection();
		try {
			PreparedStatement po=conn.prepareStatement("select * from eksperiment where id_eksperiment=?");
			po.setInt(1, id);
			ResultSet r2=po.executeQuery();
			while (r2.next()) {
				n=new Nastavitve(r2.getInt("id_eksperiment"),r2.getString("ime"),r2.getString("uvodni_pozdrav"),r2.getString("navodilo"),r2.getString("zahvala"),r2.getString("st_ponovitev"));
				break;
			}
			r2.close();
		} finally {
			conn.close();
		}
		return n;
	}


	public List<Nastavitve> select() throws Exception {
		List<Nastavitve> eksperiment=new ArrayList<Nastavitve>();
		Connection conn=getConnection();
		try {
			ResultSet rs=conn.createStatement().executeQuery("select * from eksperiment");
			while (rs.next()) {
				Nastavitve n=new Nastavitve(rs.getInt("id_eksperiment"),rs.getString("ime"),rs.getString("st_ponovitev"),rs.getString("beseda_1"),rs.getString("beseda_2"),rs.getString("beseda_3"),rs.getString("beseda_4"),rs.getString("beseda_5"));
				eksperiment.add(n);
			}
			rs.close();
		} finally {
			conn.close();
		}
		return eksperiment;
	}
	public List<Nastavitve> selectV() throws Exception {
		List<Nastavitve> eksperiment=new ArrayList<Nastavitve>();
		Connection conn=getConnection();
		try {
			ResultSet rs=conn.createStatement().executeQuery("select * from eksperiment");
			while (rs.next()) {
				Nastavitve n=new Nastavitve(rs.getInt("id_eksperiment"),rs.getString("ime"),rs.getString("uvodni_pozdrav"),rs.getString("navodilo"),rs.getString("zahvala"),rs.getString("st_ponovitev"),rs.getString("beseda_1"),rs.getString("beseda_2"),rs.getString("beseda_3"),rs.getString("beseda_4"),rs.getString("beseda_5"));
				eksperiment.add(n);
			}
			rs.close();
		} finally {
			conn.close();
		}
		return eksperiment;
	}

	public List<Vprasanje> selectVprasanja(int id) throws Exception{
		Connection conn=getConnection();
		List <Vprasanje> a= new ArrayList<Vprasanje>();
		try {
			String selecteksperiment="select * from vprasanje,izvedba,eksperiment,uporabnik where IZVEDBA_id_izvedba=id_izvedba and EKSPERIMENT_id_eksperiment=id_eksperiment and UPORABNIK_id_uporabnik=id_uporabnik and id_eksperiment="+id+";";
			ResultSet rs=conn.createStatement().executeQuery(selecteksperiment);
			while(rs.next()){
				Vprasanje v= new Vprasanje();
				v.setMojabarva(rs.getString("pravilna_barva"));
				v.setCas(rs.getInt("cas"));
				v.setTip(rs.getString("tip"));
				v.setVnesenabarva(rs.getString("vnesena_barva"));
				v.setTekst(rs.getString("beseda"));
				v.setSifra(rs.getString("sifra"));
				v.setSpol(rs.getString("spol"));
				v.setStarost(rs.getString("starost"));
				if (v.getMojabarva().equals(v.getVnesenabarva()))
					v.setPravilnost(true);
				else
					v.setPravilnost(false);
				a.add(v);
			}
		} catch (Exception e) {

		}
		finally{
			conn.close();
		}
		return a;
	}

	public List<Vprasanje> selectVprasanjaIzvedba(int id) throws Exception{
		Connection conn=getConnection();
		List <Vprasanje> a= new ArrayList<Vprasanje>();
		try {
			String selecteksperiment=" select * from vprasanje,izvedba where "
					+ "IZVEDBA_id_izvedba=id_izvedba and id_izvedba="+id+";";
			ResultSet rs=conn.createStatement().executeQuery(selecteksperiment);
			while(rs.next()){
				Vprasanje v= new Vprasanje();
				v.setMojabarva(rs.getString("pravilna_barva"));
				v.setCas(rs.getInt("cas"));
				v.setTip(rs.getString("tip"));
				v.setVnesenabarva(rs.getString("vnesena_barva"));
				v.setTekst(rs.getString("beseda"));
				if (v.getMojabarva().equals(v.getVnesenabarva()))
					v.setPravilnost(true);
				else
					v.setPravilnost(false);
				a.add(v);
			}
		} catch (Exception e) {

		}
		finally{
			conn.close();
		}
		return a;
	}

	public void insert(Registracija r) throws Exception {
		Connection conn=getConnection();
		try {
			PreparedStatement ps=conn.prepareStatement("insert into student(geslo,email, ime, priimek ) values (?,?,?,?)");
			ps.setString(1, r.getGeslo());
			ps.setString(2, r.getEmail());
			ps.setString(3, r.getIme());
			ps.setString(4, r.getPriimek());
			ps.executeUpdate();
			PreparedStatement ps1=conn.prepareStatement("insert into user_roles(email, role_name) values (?,?)");
			ps1.setString(1, r.getEmail());
			ps1.setString(2, r.getUporabnik());
			ps1.executeUpdate();
		} finally {
			conn.close();
		}
	}

	public int delete(int id, String s) throws Exception {
		Connection conn=getConnection();
		try {
			int idS=0;
			PreparedStatement p3=conn.prepareStatement("select id_student from student where email=?");
			p3.setString(1,s);
			ResultSet r1=p3.executeQuery();
			while (r1.next()) {
				idS=r1.getInt("id_student");
				break;
			}
			r1.close();

			int idD=0;
			PreparedStatement p2=conn.prepareStatement("select id_student from student,izdelava,eksperiment where id_student=STUDENT_id_student and EKSPERIMENT_id_eksperiment=id_eksperiment and id_eksperiment=?");
			p2.setInt(1, id);
			ResultSet r2=p2.executeQuery();
			while (r2.next()) {
				idD=r2.getInt("id_student");
				break;
			}
			r2.close();

			ArrayList<Integer> idT=new ArrayList<Integer>();
			PreparedStatement p1=conn.prepareStatement("select id_izvedba from izvedba where EKSPERIMENT_id_eksperiment=?");
			p1.setInt(1, id);
			ResultSet r3=p1.executeQuery();
			while (r3.next()) {
				idT.add(r3.getInt("id_izvedba"));
			}
			r3.close();



			if(idS==idD){
				for(int i = 0; i < idT.size(); i++) {
					int idE=idT.get(i);
					PreparedStatement po=conn.prepareStatement("delete from vprasanje where IZVEDBA_id_izvedba=?");
					po.setInt(1, idE);
					po.executeUpdate();
				}

				PreparedStatement pt=conn.prepareStatement("delete from izdelava where EKSPERIMENT_id_eksperiment=?");
				pt.setInt(1, id);
				pt.executeUpdate();

				PreparedStatement p4=conn.prepareStatement("delete from izvedba where EKSPERIMENT_id_eksperiment=?");
				p4.setInt(1, id);
				p4.executeUpdate();

				PreparedStatement ps=conn.prepareStatement("delete from eksperiment where id_eksperiment=?");
				ps.setInt(1, id);
				ps.executeUpdate();
			}
			else{
				return 1;
			}
		} finally {
			conn.close();
		}
		return 0;
	}

	public void arraylist_casov(String casi,int id_izvedba) throws Exception{
		Connection conn=getConnection();
		try {
			ArrayList<String> aList= new ArrayList<String>(Arrays.asList(casi.split(",")));
	
			ArrayList<Integer> numbers = new ArrayList<Integer>();
			for(int i = 0; i < aList.size(); i++) {
				numbers.add(Integer.parseInt(aList.get(i)));   
			}
	
			int idN=0;
			PreparedStatement p2=conn.prepareStatement("select MIN(id_vprasanje) from vprasanje where IZVEDBA_id_izvedba=?");
			p2.setInt(1, id_izvedba);
			ResultSet r2=p2.executeQuery();
			while (r2.next()) {
				idN=r2.getInt("MIN(id_vprasanje)");
				break;
			}
			r2.close();
	
			for (int i=0;i<numbers.size();i++) {
				int cas= numbers.get(i);
				casi_v_bazo(cas, idN,id_izvedba);
				idN++;
			}
		} finally {
			conn.close();
		}
	}
	public void arraylist_barv(String barve,int id_izvedba) throws Exception{
		Connection conn=getConnection();
	try {
			ArrayList<String> aList= new ArrayList<String>(Arrays.asList(barve.split(",")));
	
			int idN=0;
			PreparedStatement p2=conn.prepareStatement("select MIN(id_vprasanje) from vprasanje where IZVEDBA_id_izvedba=?");
			p2.setInt(1, id_izvedba);
			ResultSet r2=p2.executeQuery();
			while (r2.next()) {
				idN=r2.getInt("MIN(id_vprasanje)");
				break;
			}
			r2.close();
	
			for (int i=0;i<aList.size();i++) {
				String barva= aList.get(i);
				String barvatekst;
				switch (barva) {
				case "1":
					barvatekst="RDEÈA";
					break;
				case "2":
					barvatekst="MODRA";
					break;
				case "3":
					barvatekst="ZELENA";
					break;
				case "4":
					barvatekst="VIJOLIÈNA";
					break;
	
				default:
					barvatekst="0";
					break;
				}
				barve_v_bazo(barvatekst, idN,id_izvedba);
				idN++;
			}
	} finally {
		conn.close();
	}
}

	public void barve_v_bazo(String barva,int id,int id_izvedba ) throws Exception {
		Connection conn=getConnection();
		try {

			PreparedStatement ps=conn.prepareStatement("UPDATE Vprasanje SET vnesena_barva=? WHERE id_vprasanje=? AND IZVEDBA_id_izvedba=? ");
			ps.setString(1, barva);
			ps.setInt(2, id);
			ps.setInt(3, id_izvedba);
			ps.executeUpdate();
		} finally {
			conn.close();

		}

	}

	public void casi_v_bazo(int cas,int id,int id_izvedba ) throws Exception {
		Connection conn=getConnection();
		try {

			PreparedStatement ps=conn.prepareStatement("UPDATE Vprasanje SET cas=? WHERE id_vprasanje=? AND IZVEDBA_id_izvedba=? ");
			ps.setInt(1, cas);
			ps.setInt(2, id);
			ps.setInt(3, id_izvedba);

			ps.executeUpdate();
		} finally {
			conn.close();

		}

	}
	public int stResenih(int id) throws Exception {
		int i = 0;
		ArrayList<Integer> idiji = new ArrayList<Integer>();
		Connection conn=getConnection();
		try {
			int idE = 0;
			PreparedStatement p3=conn.prepareStatement("select id_eksperiment from eksperiment where id_eksperiment=?");
			p3.setInt(1,id);
			ResultSet r1=p3.executeQuery();
			while (r1.next()) {
				idE=r1.getInt("id_eksperiment");
				idiji.add(idE);
				break;
			}
			for(int j = 0; j < idiji.size();j++) {
			if(idiji.get(j) == id) {
				i = 0;
				PreparedStatement po=conn.prepareStatement("SELECT eksperiment_id_eksperiment, count(id_izvedba) FROM izvedba , eksperiment where EKSPERIMENT_id_eksperiment = id_eksperiment group by EKSPERIMENT_id_eksperiment");
				ResultSet r2=po.executeQuery();
				while(r2.next()) {
					if(idiji.get(j) == r2.getInt("eksperiment_id_eksperiment")) {
					i = r2.getInt("count(id_izvedba)");
					return i;
				}
				}
			}
			}
			r1.close();

		} finally {
			conn.close();
		}
		return 0; 
	}

	public ArrayList<String> emaili() throws Exception{
		Connection conn=getConnection();
		ArrayList<String> email=new ArrayList<String>();
		try {
			PreparedStatement po=conn.prepareStatement("select email from user_roles");
			ResultSet r2=po.executeQuery();
			while (r2.next()) {
				email.add(r2.getString("email"));
			}
			r2.close();
		} finally {
			conn.close();
		}
		return email;
	}

	public boolean aliSoDodatneBesede(int id_eksperiment) throws Exception{
		String a;
		Connection conn=getConnection();
		try {
			PreparedStatement ps=conn.prepareStatement("SELECT beseda_1 from eksperiment WHERE id_eksperiment=? ");
			ps.setInt(1,id_eksperiment);
			ResultSet r1=ps.executeQuery();
			if(r1.next()){
				a =r1.getString(1);
				if(!a.equals("/")){
					//System.out.println("od tuki"+a+"do tuki");
					//System.out.println(a.length());
					//System.out.println("string je bil");
					return true;
				}
				else 
					return false;
			}
			else 
				return false;
		} finally {
			conn.close();

		}
	}
	public ArrayList<String> getBesedeArray(int id_eksperiment)throws SQLException{
		Connection conn=getConnection();
		ArrayList<String> besede=new ArrayList<String>();
		try {
			for (int i = 0; i < 5; i++) {
				PreparedStatement po=conn.prepareStatement("SELECT beseda_? from eksperiment WHERE id_eksperiment=? ");
				po.setInt(1,i+1);
				po.setInt(2,id_eksperiment);
				ResultSet r2=po.executeQuery();
				if (r2.next()) {
					besede.add(r2.getString(1));
					//System.out.println("beseda Ä¹Ë‡tevilka  "+i+besede.get(i));
				}
				r2.close();
			}
		} finally {
			conn.close();
		}
		return besede;
	}

}
