package test;

import static org.junit.Assert.assertEquals;

import org.junit.Test;
import src.StrScanner;
public class AcceptanceTest {
	  @Test
	  public void acceptanceTest() {
		String string = "This is an example string";
		StrScanner scanner = new StrScanner(string);
		String pattern1 = "\\w+";
		String pattern2 = "\\s+";

		assertEquals(scanner.scan(pattern1), "This");
		assertEquals(scanner.scan(pattern1), null);
		assertEquals(scanner.scan(pattern2), " ");
		assertEquals(scanner.scan(pattern2), null);
		assertEquals(scanner.scan(pattern1), "is");
		assertEquals(scanner.eof(), false);

		assertEquals(scanner.scan(pattern2), " ");
		assertEquals(scanner.scan(pattern1), "an");
		assertEquals(scanner.scan(pattern2), " ");
		assertEquals(scanner.scan(pattern1), "example");
		assertEquals(scanner.scan(pattern2), " ");
		assertEquals(scanner.scan(pattern1), "string");
		assertEquals(true, scanner.eof());

		assertEquals(scanner.scan(pattern1), null);
		assertEquals(scanner.scan(pattern2), null);
	  }

}
