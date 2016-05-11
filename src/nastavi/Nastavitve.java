package nastavi;

public class Nastavitve {
	@Override
	public String toString() {
		return "Nastavitve [id=" + id + ", ime=" + ime + ", uvodniPozdrav="
				+ uvodniPozdrav + ", navodilo=" + navodilo + ", zahvala="
				+ zahvala + ", ponovitve=" + ponovitve + ", beseda1=" + beseda1
				+ ", beseda2=" + beseda2 + ", beseda3=" + beseda3
				+ ", beseda4=" + beseda4 + ", beseda5=" + beseda5 + "]";
	}
	private int id;
	private String ime;
	private String uvodniPozdrav;
	private String navodilo;
	private String zahvala;
	private String ponovitve;
	private String beseda1;
	private String beseda2;
	private String beseda3;
	private String beseda4;
	private String beseda5;
	
	public Nastavitve(String ime, String zahvala) {
		this. ime = ime;
		this.zahvala = zahvala;
	}
	
	public Nastavitve(String ime, String uvodniPozdrav, String navodilo,String ponovitve) {
		this. ime = ime;
		this.uvodniPozdrav = uvodniPozdrav;
		this.navodilo = navodilo;
		this.ponovitve = ponovitve;
	}
	
	public Nastavitve(String ime, String uvodniPozdrav, String navodilo, String zahvala, String ponovitve, String beseda1, String beseda2, String beseda3, String beseda4, String beseda5) {
		this.ime = ime;
		this.uvodniPozdrav = uvodniPozdrav;
		this.navodilo = navodilo;
		this.zahvala = zahvala;
		this.ponovitve = ponovitve;
		this.beseda1 = beseda1;
		this.beseda2 = beseda2;
		this.beseda3 = beseda3;
		this.beseda4 = beseda4;
		this.beseda5 = beseda5;
	}
	public Nastavitve(int id,String ime, String uvodniPozdrav, String navodilo, String zahvala, String ponovitve, String beseda1, String beseda2, String beseda3, String beseda4, String beseda5) {
		this.ime = ime;
		this.uvodniPozdrav = uvodniPozdrav;
		this.navodilo = navodilo;
		this.zahvala = zahvala;
		this.ponovitve = ponovitve;
		this.beseda1 = beseda1;
		this.beseda2 = beseda2;
		this.beseda3 = beseda3;
		this.beseda4 = beseda4;
		this.beseda5 = beseda5;
	}
	public Nastavitve(int id,String ime, String uvodniPozdrav, String navodilo, String zahvala, String ponovitve) {
		this.id=id;
		this.ime = ime;
		this.uvodniPozdrav = uvodniPozdrav;
		this.navodilo = navodilo;
		this.zahvala = zahvala;
		this.ponovitve = ponovitve;
	}
	public Nastavitve(int id, String ime,String ponovitve, String beseda1, String beseda2, String beseda3, String beseda4, String beseda5) {
		this.id=id;
		this.ime = ime;
		this.ponovitve = ponovitve;
		this.beseda1 = beseda1;
		this.beseda2 = beseda2;
		this.beseda3 = beseda3;
		this.beseda4 = beseda4;
		this.beseda5 = beseda5;
	}
	
	public String getUvodniPozdrav() {
		return uvodniPozdrav;
	}
	public void setUvodniPozdrav(String uvodniPozdrav) {
		this.uvodniPozdrav = uvodniPozdrav;
	}
	public String getNavodilo() {
		return navodilo;
	}
	public void setNavodilo(String navodilo) {
		this.navodilo = navodilo;
	}
	public String getZahvala() {
		return zahvala;
	}
	public void setZahvala(String zahvala) {
		this.zahvala = zahvala;
	}
	public String getPonovitve() {
		return ponovitve;
	}
	public void setPonovitve(String ponovitve) {
		this.ponovitve = ponovitve;
	}
	public String getBeseda1() {
		return beseda1;
	}
	public void setBeseda1(String beseda1) {
		this.beseda1 = beseda1;
	}
	public String getBeseda2() {
		return beseda2;
	}
	public void setBeseda2(String beseda2) {
		this.beseda2 = beseda2;
	}
	public String getBeseda3() {
		return beseda3;
	}
	public void setBeseda3(String beseda3) {
		this.beseda3 = beseda3;
	}
	public String getBeseda4() {
		return beseda4;
	}
	public void setBeseda4(String beseda4) {
		this.beseda4 = beseda4;
	}
	public String getBeseda5() {
		return beseda5;
	}
	public void setBeseda5(String beseda5) {
		this.beseda5 = beseda5;
	}
	public String getIme() {
		return ime;
	}
	public void setIme(String ime) {
		this.ime = ime;
	}
	public int getId(){
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
}
