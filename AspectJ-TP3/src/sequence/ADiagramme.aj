package sequence;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public aspect ADiagramme {

	private static final int NB_SPACES = 25;
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

	private List<String> classes = new ArrayList<>();

	declare precedence: sequence.AClientOrder, singleton.ASingleton;

	pointcut diagramme() : call(* impl..*.*(..));

	Object around(): diagramme() {
		List<String> className = new ArrayList<>();
		String src = thisJoinPoint.getThis() != null ? thisJoinPoint.getThis().getClass().getSimpleName() : MAIN;
		String action = thisJoinPoint.getSignature().getName();
		String dest = thisJoinPoint.getTarget() != null ? thisJoinPoint.getTarget().getClass().getSimpleName() : MAIN;
		if (!classes.contains(src)) {
			className.add(src);
		}
		if (!classes.contains(dest)) {
			className.add(dest);
		}
		if (!className.isEmpty())
			System.out.println(printNameClass(className));
		System.out.println(printAction(classes.indexOf(src), classes.indexOf(dest), action, false));
		Object ret = proceed();
		System.out.println(printAction(classes.indexOf(dest), classes.indexOf(src),
				ret != null ? ret.toString() : EMPTY_STRING, true));

		return ret;
	}

	public String printNameClass(List<String> names) {
		if (names.isEmpty()) {
			return EMPTY_STRING;
		}
		String spaces = calculateSpacesBetweenCall();
		String entete = createFramingClassName(names.size(), spaces);
		int gap = calculateFramingGap();
		String trace = spaces;
		
		for (String n : names) {
			this.classes.add(n);
			String s = calculateSpacesBetweenNameClassAndPipe(gap, n);
			n = cutClassName(gap, n);
			trace += CLASSNAME_FRAGMENT_LEFT + n + s + CLASSNAME_FRAGMENT_RIGHT;
		}

		return entete + NEXT_LINE + trace + NEXT_LINE + entete;
	}

	private String cutClassName(int gap, String n) {
		return (n.length() >= (NB_SPACES - gap))
				? n.substring(0, (NB_SPACES - gap) > n.length() ? n.length() - 1 : (NB_SPACES - gap)) : n;
	}

	private String calculateSpacesBetweenNameClassAndPipe(int gap, String n) {
		return n.length() >= (NB_SPACES - gap) ? EMPTY_STRING
				: duplicateCaracteres(SPACE, NB_SPACES - gap - n.length());
	}

	private String calculateSpacesBetweenCall() {
		String spacesAfter = duplicateCaracteres(SPACE, NB_SPACES / 2);
		String spacesBefore = (NB_SPACES % 2 == 1) ? spacesAfter.concat(SPACE) : spacesAfter;

		String spaces = duplicateCaracteres(spacesBefore.concat(PIPE).concat(spacesAfter), this.classes.size());
		return spaces;
	}

	private int calculateFramingGap() {
		return CLASSNAME_FRAGMENT_LEFT.length() + CLASSNAME_FRAGMENT_RIGHT.length();
	}

	private String createFramingClassName(int nb, String spaces) {
		return  spaces + duplicateCaracteres(CLASSNAME_FRAMING_L
				+ duplicateCaracteres(DASH,
						NB_SPACES - (CLASSNAME_FRAMING_L.length() + CLASSNAME_FRAMING_R.length()))
				+ CLASSNAME_FRAMING_R, nb);
	}

	public String printAction(int idxSrc, int idxDest, String action, boolean ret) {
		String str = EMPTY_STRING;

		String spaces = duplicateCaracteres(SPACE, calculMiddleNbSpaces());
		int idxStart = Math.min(idxSrc, idxDest);
		int idxEnd = Math.max(idxSrc, idxDest);

		String spacesBetween = duplicateCaracteres(SPACE, NB_SPACES);
		spaces += duplicateCaracteres(PIPE + spacesBetween, idxStart);

		str += printActionName(action, spaces, idxStart, spacesBetween, idxSrc == idxDest, ret);
		str += spaces;
		if (idxSrc == idxDest) {
			str += internCall(ret, idxEnd, spaces);
		} else {
			str += externCall(idxSrc, idxDest, idxStart, idxEnd, spacesBetween);
		}
		return str;
	}

	private String printActionName(String action, String spaces, int idxStart, String spacesBetween, boolean isInternCall, boolean isReturn) {
		String str = EMPTY_STRING;
		if (action != EMPTY_STRING) {
			if (isInternCall && isReturn) {
				action = (action.length() > (calculMiddleNbSpaces() - 2)) ? action.substring(0, (calculMiddleNbSpaces() - 2)) : action;
				action += calculMiddleNbSpaces() - action.length() - 2 <= 0 ? EMPTY_STRING
						: duplicateCaracteres(SPACE, (calculMiddleNbSpaces() - 2) - action.length());
				action += PIPE;
				action += duplicateCaracteres(SPACE, NB_SPACES/2);
			} else {
				action = (action.length() > (NB_SPACES - 1)) ? action.substring(0, (NB_SPACES - 1)) : action;
				action += NB_SPACES - action.length() <= 0 ? EMPTY_STRING
						: duplicateCaracteres(SPACE, (NB_SPACES - 1) - action.length());
			}
			
			str += spaces + PIPE + SPACE + action;
			str += duplicateCaracteres(PIPE.concat(spacesBetween), this.classes.size() - idxStart - 1);
			str += NEXT_LINE;
		}
		return str;
	}

	private String externCall(int idxSrc, int idxDest, int idxStart, int idxEnd, String spacesBetween) {
		String str = EMPTY_STRING;
		String arrow = duplicateCaracteres(DASH, NB_SPACES - 1);
		
		for (int i = idxStart; i < idxEnd; i++) {
			String tirets = duplicateCaracteres(DASH, NB_SPACES);
			if (i == idxStart && idxSrc > idxDest) {
				tirets = LEFT_ARROW.concat(arrow);
			}
			if (i == idxEnd - 1 && idxDest > idxSrc) {
				tirets = arrow.concat(RIGHT_ARROW);
			}

			str += PIPE + tirets;

		}
		return str + duplicateCaracteres(PIPE + spacesBetween, this.classes.size() - idxEnd);
	}

	private int calculMiddleNbSpaces() {
		return (NB_SPACES % 2 == 1) ? NB_SPACES / 2 + 1 : NB_SPACES / 2;
	}

	private String internCall(boolean ret, int idxEnd, String spaces) {
		String end = EMPTY_STRING;
		int tirets = calculMiddleNbSpaces() - 1;
		end += duplicateCaracteres(duplicateCaracteres(SPACE, NB_SPACES/2).concat(PIPE), this.classes.size() - idxEnd - 1);
		String line = duplicateCaracteres(SPACE, tirets).concat(PIPE);
		
		return (!ret) ? PIPE + duplicateCaracteres(DASH, tirets + 1) + end + NEXT_LINE + spaces + PIPE + line + end : PIPE + LEFT_ARROW + duplicateCaracteres(DASH, tirets) + end;
	}

	public String duplicateCaracteres(String str, int nb) {
		return String.join(EMPTY_STRING, Collections.nCopies(nb, str));
	}
}
