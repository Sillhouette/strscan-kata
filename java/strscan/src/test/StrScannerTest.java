package test;

import static org.junit.Assert.assertEquals;

import org.junit.Test;
import org.junit.runner.RunWith;
import de.bechte.junit.runners.context.*;
import src.StrScanner;

@RunWith(HierarchicalContextRunner.class)
public class StrScannerTest {
	@Test
	public void isInitializedWithAString() {
		String string = "abc def";
		String expected = string;
		
		StrScanner scanner = new StrScanner(string);
		String actual = scanner.getString();
				
		assertEquals(expected, actual);
	}
	
	public class Eof {
		@Test
		public void returnsFalseIfNotAtEndOfString() {
			String string = "abc def";
			boolean expected = false;
			
			StrScanner scanner = new StrScanner(string);
			boolean actual = scanner.eof();
					
			assertEquals(expected, actual);
		}
		
		@Test
		public void returnsTrueIfAtEndOfString() {
			String string = "";
			boolean expected = true;
			
			StrScanner scanner = new StrScanner(string);
			boolean actual = scanner.eof();
					
			assertEquals(expected, actual);
		}
	}
	
	public class Scan {
		@Test
		public void returnsMatchIfFound() {
			String string = "abc";
			String regex = "abc";
			
			String expected = "abc";
			
			StrScanner scanner = new StrScanner(string);
			String actual = scanner.scan(regex);
					
			assertEquals(expected, actual);
		}
		
		@Test
		public void returnsNextMatch() {
			String string = "abc def";
			String regex = "abc";
			
			String expected = "abc";
			
			StrScanner scanner = new StrScanner(string);
			String actual = scanner.scan(regex);
					
			assertEquals(expected, actual);
		}
		
		@Test
		public void returnsNullIfMatchIsntFirst() {
			String string = "abc def";
			String regex = "\\s+";
			
			String expected = null;
			
			StrScanner scanner = new StrScanner(string);
			String actual = scanner.scan(regex);
					
			assertEquals(expected, actual);
		}
		
		@Test
		public void removesMatchFromString() {
			String string = "abc def";
			String regex = "\\w+";
			
			String expected = " def";
			
			StrScanner scanner = new StrScanner(string);
			scanner.scan(regex);
			String actual = scanner.getString();
					
			assertEquals(expected, actual);
		}
	}
}
