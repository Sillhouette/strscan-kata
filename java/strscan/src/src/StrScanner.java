package src;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StrScanner {
	private String string;
	
	public StrScanner(String string) {
		setString(string);
	}

	public String scan(String regex) {
		String toBeMatched = getString();
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(toBeMatched);
		
		boolean matchFound = !!m.find();

		if(matchFound) {
			String match = m.group(0);
			return startsWithMatch(match) ? setNewString(match) : null;
		}
		return null;
	}
	
	private boolean startsWithMatch(String match) {
		return getString().startsWith(match);
	}
	
	private String setNewString(String match) {
		int matchLength = match.length();
		String newString = getString().substring(matchLength);
		setString(newString);
		
		return match;
	}

	public boolean eof() {
		return getString().isEmpty();
	}

	public String getString() {
		return string;
	}

	private void setString(String string) {
		this.string = string;
	}

}
