package nastavi;

public class Registracija {
	private long id;
	private String ime;
	private String priimek;
	private String email;
	private String geslo;
	private String uporabnik;
	
	public Registracija(String ime, String priimek, String email, String geslo) {
		this.ime = ime;
		this.priimek = priimek;
		this.email = email;
		this.geslo = geslo;
		this.uporabnik="uporabnik";
	}
	
	public String getUporabnik() {
		return uporabnik;
	}

	public void setUporabnik(String uporabnik) {
		this.uporabnik = uporabnik;
	}

	public String getIme() {
		return ime;
	}
	public void setIme(String ime) {
		this.ime = ime;
	}
	public String getPriimek() {
		return priimek;
	}
	public void setPriimek(String priimek) {
		this.priimek = priimek;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getGeslo() {
		return geslo;
	}
	public void setGeslo(String geslo) {
		this.geslo = geslo;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	
}
