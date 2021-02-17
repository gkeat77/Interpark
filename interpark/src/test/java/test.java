import java.util.StringTokenizer;

public class test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		String d = "11/25/2020";
		
		 d = d.substring(6,10)+ d.substring(0,2)+ d.substring(3,5);
		System.out.println(String.format( d));
	}

}
