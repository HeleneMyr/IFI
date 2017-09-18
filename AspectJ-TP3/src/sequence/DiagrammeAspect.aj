package sequence;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public aspect DiagrammeAspect {

	private static final int NB_SPACES = 20;
	private static final String RIGHT_ARROW = ">";
	private static final String LEFT_ARROW = "<";
	private static final String NEXT_LINE = "\n";
	private static final String DASH = "-";
	private static final String SPACE = " ";
	private static final String MAIN = "Main";
	private static final String CLASSNAME_FRAGMENT_RIGHT = " |  ";
	private static final String CLASSNAME_FRAGMENT_LEFT = "  | ";
	private static final String CLASSNAME_FRAMING_L = "  +";
	private static final String CLASSNAME_FRAMING_R = "+  ";
	private static final String PIPE = "|";
	private static final String EMPTY_STRING = "";
	private static final String DOT = ".";
	
	private List<String> classes = new ArrayList<>();

	pointcut diagramme() : call(* impl..*.*(..));

	Object around(): diagramme() {
		List<String> className = new ArrayList<>();
		String src = thisJoinPoint.getThis() != null ? thisJoinPoint.getClass().getSimpleName() : MAIN;
		String action = thisJoinPoint.getSignature().getName();
		String dest = thisJoinPoint.getTarget() != null ? thisJoinPoint.getTarget().getClass().getName() : MAIN;
		if (!classes.contains(src)) {
			className.add(src);
		}
		if (!classes.contains(dest)) {
			className.add(dest);
		}
		if (!className.isEmpty())
			System.out.println(printNameClass(className));
		System.out.println(printAction(classes.indexOf(src), classes.indexOf(dest), action));
		Object ret = proceed();

		System.out.println(
				printAction(classes.indexOf(dest), classes.indexOf(src), ret != null ? ret.toString() : EMPTY_STRING));

		return true;
	}

	public String printNameClass(List<String> names) {
		StringBuilder str = new StringBuilder(EMPTY_STRING);
		if (names.isEmpty()) {
			return str.toString();
		}
		String spacesBefore = duplicateCaracteres(SPACE, NB_SPACES / 2);
		String spaces = duplicateCaracteres(spacesBefore.concat(PIPE).concat(spacesBefore), this.classes.size());
		
		StringBuilder entete = new StringBuilder(spaces);
		StringBuilder trace = new StringBuilder(spaces);
		
		for (String n : names) {
			entete.append(CLASSNAME_FRAMING_L);
			entete.append(duplicateCaracteres(DASH, NB_SPACES - (CLASSNAME_FRAMING_L.length() + CLASSNAME_FRAMING_R.length())));
			entete.append(CLASSNAME_FRAMING_R);
		
			int ecart = CLASSNAME_FRAGMENT_LEFT.length() + CLASSNAME_FRAGMENT_RIGHT.length();
			int length = n.length() > (NB_SPACES - ecart) ? (NB_SPACES - ecart) : n.length();
			this.classes.add(n);
			String s = length == (NB_SPACES - ecart) ? EMPTY_STRING : duplicateCaracteres(SPACE, NB_SPACES - ecart - length);
			n = (n.length() > (NB_SPACES - ecart)) ? n.substring(0, (NB_SPACES - ecart - 1)).concat(DOT) : n;
			trace.append(CLASSNAME_FRAGMENT_LEFT);
			trace.append(n);
			trace.append(s);
			trace.append(CLASSNAME_FRAGMENT_RIGHT);
		}
		
		str.append(entete);
		str.append(NEXT_LINE);
		str.append(trace);
		str.append(NEXT_LINE);
		str.append(entete);
		return str.toString();
	}

	public String printAction(int idxSrc, int idxDest, String action) {
		StringBuilder str = new StringBuilder(EMPTY_STRING);
		StringBuilder spaces = new StringBuilder(duplicateCaracteres(SPACE, NB_SPACES / 2));
		int idxStart = Math.min(idxSrc, idxDest);
		int idxEnd = Math.max(idxSrc, idxDest);

		for (int i = 0; i < idxStart; i++) {
			spaces.append(PIPE);
			spaces.append(duplicateCaracteres(SPACE, NB_SPACES));
		}
		if (action != EMPTY_STRING) {
			int length = action.length() > (NB_SPACES - 1) ? (NB_SPACES - 1) : action.length();
			String s = (NB_SPACES - 1) - length == 0 ? EMPTY_STRING : duplicateCaracteres(SPACE, (NB_SPACES - 1) - length);
			str.append(spaces);
			str.append(PIPE);
			str.append(SPACE);
			str.append(action);
			str.append(s);
			str.append(PIPE);
			for (int i = idxStart + 2; i < this.classes.size(); i++) {
				str.append(duplicateCaracteres(SPACE, NB_SPACES));
				if (i <= this.classes.size() - 1) {
					str.append(PIPE);
				}
			}
			str.append(NEXT_LINE);
		}
		str.append(spaces);
		// if (idxSrc == idxDest) {
		// str += "--------";
		// String end = "";
		// for (int i = idxEnd; i<this.classes.size()-1; i++) {
		// end += PIPE + SPACES_20;
		// if (i == this.classes.size() - 2) {
		// end += PIPE;
		// }
		// }
		// str += " |" + end;
		// str += " |" + end;
		// str += "--------" + end;
		// } else {
		for (int i = idxStart; i < idxEnd; i++) {
			String tirets = duplicateCaracteres(DASH, NB_SPACES);
			if (i == idxStart && idxSrc > idxDest) {
				tirets = LEFT_ARROW.concat(duplicateCaracteres(DASH, NB_SPACES - 1));
			}
			if (i == idxEnd - 1 && idxDest > idxSrc) {
				tirets = duplicateCaracteres(DASH, NB_SPACES - 1).concat(RIGHT_ARROW);
			}

			str.append(PIPE);
			str.append(tirets);
			if (i == this.classes.size() - 2) {
				str.append(PIPE);
			}
		}
		for (int i = idxEnd; i < this.classes.size() - 1; i++) {
			str.append(PIPE);
			str.append(duplicateCaracteres(SPACE, NB_SPACES));
			if (i == this.classes.size() - 2) {
				str.append(PIPE);
			}
		}
		// }
		return str.toString();
	}

	public String duplicateCaracteres(String str, int nb) {
		return String.join(EMPTY_STRING, Collections.nCopies(nb, str));
	}
}
