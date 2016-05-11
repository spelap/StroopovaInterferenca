package razredi;

import java.util.*;


public class Vprasanje  {
	private String tip;
	private boolean pravilnost;
	private long cas;
	private int barva;
	//String SlovenskoImeBarve;
	private String mojabarva;
	String vnesenabarva;
	private String tekst;
	private ArrayList<String> besede;
	private Random rand =new Random();
	private String []randbesede={"KLAGO", "DLERAN", "TEJIF", "RALCUT", "BADIM", "KOREF", "SANTEQ",
			"JUMUD", "BRILUK", "SULIG", "KAGID", "RKISA", "LOPEDS"};
	
	private String sifra;
	private String starost;
	private String spol;

	public String getSifra() {
		return sifra;
	}

	public void setSifra(String sifra) {
		this.sifra = sifra;
	}

	public String getStarost() {
		return starost;
	}

	public void setStarost(String starost) {
		this.starost = starost;
	}

	public String getSpol() {
		return spol;
	}

	public void setSpol(String spol) {
		this.spol = spol;
	}

	public Vprasanje(){
		this.tip="konsistenten";
		this.pravilnost=true;
		this.cas=200;
		this.mojabarva="zelena";
		this.tekst="beseda";
	}
	
	public Vprasanje(String tip, boolean pravilnost, long cas, String mojabarva, String tekst){
		this.tip=tip;
		this.pravilnost=pravilnost;
		this.cas=cas;
		this.mojabarva=mojabarva;
		this.tekst=tekst;
	}
	
	public Vprasanje(String tip){
		this.tip=tip;
		switch (tip) {
		case "KONSISTENTNI":
			barva=rand.nextInt(4);
			tekstIzBarve();
			break;
		case "NEKONSISTENTNI":
			barva=rand.nextInt(4);
			tekstrand();
			break;
		case "NEVTRALNI":
			barva=rand.nextInt(4);
			nevtralneBesede();
			break;
		case "NEVTRALNI_DODATNE_BESEDE":
			barva=rand.nextInt(4);
			tekst=besede.get(rand.nextInt(5));
			break;
		default:
			System.out.println("niste vnesli pravilnega stringa");
			break;
		}
		mojaBarvaIzBarve();
		
	}
	
	public void mojaBarvaIzBarve(){
		switch (barva) {
		case 0:
			mojabarva="#FF0000";
			break;
		case 1:
			mojabarva="#006600";
			break;
		case 2:
			mojabarva="#003399";
			break;
		case 3:
			mojabarva="#660066";
			break;

		default:
			break;
		}
	}
	
	
	public void tekstIzBarve(){
		switch (barva) {
		case 0:
			tekst="RDEÈA";

			break;
		case 1:
			tekst="ZELENA";
			break;
		case 2:
			tekst="MODRA";
			break;
		case 3:
			tekst="VIJOLIÈNA";

			break;

		default:
			break;
		}
	}
	public String tekstIzBarveReturn(){
		switch (barva) {
		case 0:
			
			return"RDEÈA";
		case 1:
			return"ZELENA";
		case 2:
			return "MODRA";
		case 3:
			
			return"VIJOLIÈNA";

		default:
			return"NAPAKA";		}
	}
	
	public void tekstrand(){
		//nastavim izklucujoco stevilko za barve, da ni po random izbrana slucajno enaka,
		//naprimer da se ne zgodi modra zapisana z modro
		int izkljucujoca=rand.nextInt(4);
		while(barva==izkljucujoca){
			izkljucujoca=rand.nextInt(4);
		}
		switch (izkljucujoca) {
		case 0:
			tekst="RDEÈA";
			break;
		case 1:
			tekst="ZELENA";
			break;
		case 2:
			tekst="MODRA";
			break;
		case 3:
			tekst="VIJOLIÈNA";
			break;

		default:
			break;
		}
	}
	public void nevtralneBesede(){
		tekst=randbesede[rand.nextInt(randbesede.length)];
	}
	
	public void ShuffleArray(int[] array)
	{
	    int index, temp;
	    Random random = new Random();
	    for (int i = array.length - 1; i > 0; i--)
	    {
	        index = random.nextInt(i + 1);
	        temp = array[index];
	        array[index] = array[i];
	        array[i] = temp;
	    }
	}
	
	
	@Override
	public String toString() {
		return  tip+"   " + cas+"   " + mojabarva+"   " + vnesenabarva+"   "	+ tekst+"   "+pravilnost;
	}
	public String getTip() {
		return tip;
	}
	public void setTip(String tip) {
		this.tip = tip;
	}
	public boolean isPravilnost() {
		return pravilnost;
	}
	public void setPravilnost(boolean pravilnost) {
		this.pravilnost = pravilnost;
	}
	public long getCas() {
		return cas;
	}
	public void setCas(long cas) {
		this.cas = cas;
	}
	public int getBarva() {
		return barva;
	}
	public void setBarva(int barva) {
		this.barva = barva;
	}
	public String getMojabarva() {
		return mojabarva;
	}
	public void setMojabarva(String mojabarva) {
		this.mojabarva = mojabarva;
	}
	public String getTekst() {
		return tekst;
	}
	public void setTekst(String tekst) {
		this.tekst = tekst;
	}
	public Random getRand() {
		return rand;
	}
	public void setRand(Random rand) {
		this.rand = rand;
	}
	public String[] getRandbesede() {
		return randbesede;
	}
	public void setRandbesede(String[] randbesede) {
		this.randbesede = randbesede;
	}

	public String getVnesenabarva() {
		return vnesenabarva;
	}
	public void setVnesenabarva(String vnesenabarva) {
		this.vnesenabarva = vnesenabarva;
	}
	
}
