package app;

import static org.junit.Assert.assertEquals;

import org.junit.Test;


public class StrScannerTest {
  @Test
  public void isInitializedWithString() {
	String string = "abc def";
    StrScanner scanner = new StrScanner(string);
    String expected = string;
    
    String actual = scanner.getString();
    		
    assertEquals(expected, actual);
  }
  
  @Test
  public void eosReturnsFalseWhenNotAtEndOfString() {
		String string = "abc def";
	    StrScanner scanner = new StrScanner(string);
	    Boolean expected = false;
	    
	    Boolean actual = scanner.eos();
	    
	    assertEquals(expected, actual);
  }
  
  @Test
  public void eosReturnsTrueWhenAtEndOfString() {
		String string = "";
	    StrScanner scanner = new StrScanner(string);
	    Boolean expected = true;
	    
	    Boolean actual = scanner.eos();
	    
	    assertEquals(expected, actual);
  }
  
  @Test
  public void scanReceivesARegexAndReturnsFirstMatch() {
		String string = "abc def";
	    StrScanner scanner = new StrScanner(string);
	    String pattern = "\\w+";
	    String expected = "abc";
	    
	    String actual = scanner.scan(pattern);
	    
	    assertEquals(expected, actual);
  }
  
  @Test
  public void scanReceivesARegexAndReturnsNullIfNoFirstMatch() {
		String string = "abc def";
	    StrScanner scanner = new StrScanner(string);
	    String pattern = "\\s+";
	    String expected = null;
	    
	    String actual = scanner.scan(pattern);
	    
	    assertEquals(expected, actual);
  }
  
  @Test
  public void scanRemembersItsPlaceInTheString() {
		String string = "abc def";
	    StrScanner scanner = new StrScanner(string);
	    String pattern1 = "\\w+";
	    String pattern2 = "\\s+";
	    String expected1 = "abc";
	    String expected2 = " ";
	    String expected3 = "def";
	    
	    String actual1 = scanner.scan(pattern1);
	    String actual2 = scanner.scan(pattern2);
	    String actual3 = scanner.scan(pattern1);
	    
	    assertEquals(expected1, actual1);
	    assertEquals(expected2, actual2);
	    assertEquals(expected3, actual3);
  }
  
  @Test
  public void eosReturnsFalseUntilStringEnds() {
		String string = "abc def";
	    StrScanner scanner = new StrScanner(string);
	    String pattern1 = "\\w+";
	    String pattern2 = "\\s+";
	    boolean expected1 = false;
	    boolean expected2 = true;
	    
	    scanner.scan(pattern1);
	    boolean actual1 = scanner.eos();
	    scanner.scan(pattern2);
	    boolean actual2 = scanner.eos();
	    scanner.scan(pattern1);
	    boolean actual3 = scanner.eos();
	    
	    assertEquals(expected1, actual1);
	    assertEquals(expected1, actual2);
	    assertEquals(expected2, actual3);
  }
  
  @Test
  public void doesNotConsumeOriginalString() {
	  String string = "abc def";
	  String pattern = "\\w+";
	  StrScanner scanner = new StrScanner(string);
	  
	  scanner.scan(pattern);
	  
	  assertEquals(string, "abc def");
  }
}