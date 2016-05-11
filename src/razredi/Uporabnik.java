package razredi;

public class Uporabnik {
	private String sifra;
	private String spol;
	private int starost;
	
	public Uporabnik(String sifra, String spol, int starost){
		this.sifra=sifra;
		this.spol=spol;
		this.starost=starost;
	}

	public String getSifra() {
		return sifra;
	}

	public void setSifra(String sifra) {
		this.sifra = sifra;
	}

	public String getSpol() {
		return spol;
	}

	public void setSpol(String spol) {
		this.spol = spol;
	}

	public int getStarost() {
		return starost;
	}

	public void setStarost(int starost) {
		this.starost = starost;
	}
	
}
