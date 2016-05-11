package razredi;

public class Eksperiment {
	private String sIme=null;
	private String sPozdrav=null;
	private String sNavodilo=null;
	private String sZahvala=null;
	private String sPonovitve=null;
	private String sBeseda1=null;
	private String sBeseda2=null;
	private String sBeseda3=null;
	private String sBeseda4=null;
	private String sBeseda5=null;
public Eksperiment(){};

public Eksperiment(String sIme, String sPozdrav, String sNavodilo, String sZahvala, String sPonovitve, String sBeseda1, String sBeseda2, String sBeseda3, String sBeseda4, String sBeseda5){
	this.sIme=sIme;
	this.sPozdrav=sPozdrav;
	this.sNavodilo=sNavodilo;
	this.sZahvala=sZahvala;
	this.sPonovitve=sPonovitve;
	this.sBeseda1=sBeseda1;
	this.sBeseda2=sBeseda2;
	this.sBeseda3=sBeseda3;
	this.sBeseda4=sBeseda4;
	this.sBeseda5=sBeseda5;
}

public String getsIme() {
	return sIme;
}

public void setsIme(String sIme) {
	this.sIme = sIme;
}

public String getsPozdrav() {
	return sPozdrav;
}

public void setsPozdrav(String sPozdrav) {
	this.sPozdrav = sPozdrav;
}

public String getsNavodilo() {
	return sNavodilo;
}

public void setsNavodilo(String sNavodilo) {
	this.sNavodilo = sNavodilo;
}

public String getsZahvala() {
	return sZahvala;
}

public void setsZahvala(String sZahvala) {
	this.sZahvala = sZahvala;
}

public String getsPonovitve() {
	return sPonovitve;
}

public void setsPonovitve(String sPonovitve) {
	this.sPonovitve = sPonovitve;
}

public String getsBeseda1() {
	return sBeseda1;
}

public void setsBeseda1(String sBeseda1) {
	this.sBeseda1 = sBeseda1;
}

public String getsBeseda2() {
	return sBeseda2;
}

public void setsBeseda2(String sBeseda2) {
	this.sBeseda2 = sBeseda2;
}

public String getsBeseda3() {
	return sBeseda3;
}

public void setsBeseda3(String sBeseda3) {
	this.sBeseda3 = sBeseda3;
}

public String getsBeseda4() {
	return sBeseda4;
}

public void setsBeseda4(String sBeseda4) {
	this.sBeseda4 = sBeseda4;
}

public String getsBeseda5() {
	return sBeseda5;
}

public void setsBeseda5(String sBeseda5) {
	this.sBeseda5 = sBeseda5;
}

}
