package app;
import java.util.regex.*;  

public class StrScanner {
	private String string;
	
	public StrScanner(String string) {
		setString(string);
	}
	
    public boolean eos() {
      return getString().isEmpty();
    }
    
    public String scan(String regex) {
    	String toBeMatched = getString();
    	Pattern p = Pattern.compile(regex);
    	Matcher m = p.matcher(toBeMatched);
    	
    	    	
    	if (m.find()) {
        	String match = m.group(0);
        	if (toBeMatched.startsWith(match)) {
        		int matchLength = match.length();
        		setString(toBeMatched.substring(matchLength));
        		return match;
        	}
    	}
    	return null;
    }

	public String getString() {
		return string;
	}

	private void setString(String string) {
		this.string = string;
	}
  }