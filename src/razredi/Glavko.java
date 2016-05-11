package razredi;



import java.util.Random;

import povezava.Povezava;

public class Glavko {
	public static void main(String[] args) throws Exception {
		System.out.println();
		int n=30;
		Vprasanje polje[]=new Vprasanje[n];
		for(int i=0;i<n/3;i++)
			polje[i]=new Vprasanje("KONSISTENTNI");
		for(int i=n/3;i<2*n/3;i++)
			polje[i]=new Vprasanje("NEKONSISTENTNI");
		for(int i=2*n/3;i<n;i++)
			polje[i]=new Vprasanje("NEVTRALNI");
		
		 int index;
		 Vprasanje temp;
		    Random random = new Random();
		    for (int i = polje.length - 1; i > 0; i--)
		    {
		        index = random.nextInt(i + 1);
		        temp = polje[index];
		        polje[index] = polje[i];
		        polje[i] = temp;
		    }
		
		for (Vprasanje vprasanje : polje) {
			//System.out.println(vprasanje);
		}
		Povezava p=new Povezava();
		p.aliSoDodatneBesede(1);
	}
	
	
}
