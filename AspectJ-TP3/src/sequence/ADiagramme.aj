package sequence;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Génération d'un diagramme de séquence sous forme ASCII
 * 
 * @author Helene MEYER
 *
 */
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

	/**
	 * ensemble des classes présentes sur le diagramme
	 */
	private List<String> classes = new ArrayList<>();

	/**
	 * ordre de chargement des aspect 
	 */
	declare precedence: orders.AClientOrder, singleton.ASingleton;

	/**
	 * le diagramme utilise toutes les classes dans le package impl
	 */
	pointcut diagramme() : call(* impl..*.*(..));

	/**
	 * récupération des informations sur les appels et impressions de celles-ci 
	 * 
	 * @return le résultat du proceed
	 */
	Object around(): diagramme() {
		List<String> className = new ArrayList<>();
		String src = thisJoinPoint.getThis() != null ? thisJoinPoint.getThis().getClass().getSimpleName() : MAIN;
		String action = thisJoinPoint.getSignature().getName();
		String dest = thisJoinPoint.getTarget() != null ? thisJoinPoint.getTarget().getClass().getSimpleName() : MAIN;
		if (!classes.contains(src)) {
			className.add(src);
		}
		if (!classes.contains(dest) && src!= null && !src.equalsIgnoreCase(dest)) {
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

	/**
	 * Imprime les noms des classes
	 * 
	 * @param names les nouveaux noms des classes à ajouter
	 * @return les lignes d'impression des noms des classes
	 */
	public String printNameClass(List<String> names) {
		if (names.isEmpty()) {
			return EMPTY_STRING;
		}
		String spaces = calculateSpacesBeforeCall();
		String entete = createFramingClassName(names.size(), spaces);
		int gap = calculateFramingGap();
		String trace = spaces;
		
		for (String n : names) {
			this.classes.add(n);
			String s = calculateSpacesAfterCall(gap, n);
			n = cutClassName(gap, n);
			trace += CLASSNAME_FRAGMENT_LEFT + n + s + CLASSNAME_FRAGMENT_RIGHT;
		}

		return entete + NEXT_LINE + trace + NEXT_LINE + entete;
	}

	/**
	 * Coupe le nom de la classe
	 * 
	 * @param gap l'espace des rectangles autour du nom
	 * @param n le nom de la classe
	 * @return le nom coupé
	 */
	private String cutClassName(int gap, String n) {
		return (n.length() >= (NB_SPACES - gap))
				? n.substring(0, (NB_SPACES - gap) > n.length() ? n.length() - 1 : (NB_SPACES - gap)) : n;
	}

	/**
	 * Retourne une chaine de caractere representant l'ensemble des lignes de vie des classes (après le traitement)
	 * 
	 * @param gap l'espace des rectangles autour du nom
	 * @param n le nom de la classe
	 * @return une chaîne de caractère contenant des espaces
	 */
	private String calculateSpacesAfterCall(int gap, String n) {
		return n.length() >= (NB_SPACES - gap) ? EMPTY_STRING
				: duplicateCaracteres(SPACE, NB_SPACES - gap - n.length());
	}

	/**
	 * Retourne une chaine de caractere representant l'ensemble des lignes de vie des classes (avant le traitement)
	 * 
	 * @return une chaine de caractere representant l'ensemble des lignes de vie des classes (avant le traitement)
	 */
	private String calculateSpacesBeforeCall() {
		String spacesAfter = duplicateCaracteres(SPACE, NB_SPACES / 2);
		String spacesBefore = (NB_SPACES % 2 == 1) ? spacesAfter.concat(SPACE) : spacesAfter;

		String spaces = duplicateCaracteres(spacesBefore.concat(PIPE).concat(spacesAfter), this.classes.size());
		return spaces;
	}

	/**
	 * Calcule le nombre de caractère que contient l'encadrement des noms de classes (à gauche et à droite)
	 * 
	 * @return le nombre de caractère que contient l'encadrement des noms de classe
	 */
	private int calculateFramingGap() {
		return CLASSNAME_FRAGMENT_LEFT.length() + CLASSNAME_FRAGMENT_RIGHT.length();
	}

	/**
	 * Créé l'encadrement des noms des classes
	 * 
	 * @param nb le nombre de classes à ajouter
	 * @param spaces les espaces à placer avant les nouvelles classes
	 * @return la chaîne de caractère représentant l'encadrement des noms des classes
	 */
	private String createFramingClassName(int nb, String spaces) {
		return  spaces + duplicateCaracteres(CLASSNAME_FRAMING_L
				+ duplicateCaracteres(DASH,
						NB_SPACES - (CLASSNAME_FRAMING_L.length() + CLASSNAME_FRAMING_R.length()))
				+ CLASSNAME_FRAMING_R, nb);
	}

	/**
	 * Chaine de caractere representant l'action ou la réponse avec la flèche de direction
	 * 
	 * @param idxSrc l'indice de la classe appelante dans la liste des classes
	 * @param idxDest l'indice de la classe appelee dans la liste des classes
	 * @param action action ou réponse
	 * @param ret vrai s'il s'agit d'une réponse a un appel sinon faux
	 * @return une chaine de caractere representant l'action ou la réponse avec la flèche de direction
	 */
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

	/**
	 * Creer la chaine de caractere représentant l'action ou la réponse
	 * 
	 * @param action l'action ou la réponse
	 * @param spaces les espaces et lignes de vie des classes avant celle de l'appel
	 * @param idxStart le premier indice de classe utilisée pour l'appel (source ou destination) : source si l'indice de la source est avant celui de la destination, sinon c'est l'indice de la destination
	 * @param spacesBetween chaine de caractere contenant des espaces
	 * @param isInternCall vrai s'il s'agit d'un appel à une même classe sinon faux
	 * @param isReturn vrai s'il s'agit d'une réponse a un appel sinon faux
	 * @return la chaine de caractere représentant l'action ou la réponse
	 */
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

	/**
	 * Traitement des appels externes
	 * 
	 * @param idxSrc indice de la classe source dans la liste des classes
	 * @param idxDest indice de la classe destination dans la liste des classes
	 * @param idxStart indice minimal de la classe source ou de destination
	 * @param idxEnd indice maximal de la classe source ou de destination
	 * @param spacesBetween chaine de caractere contenant des espaces
	 * @return une chaine de caractere qui traite les appels externes
	 */
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

	/**
	 * calcule le nombre d'espaces lorsqu'on divise par deux le nombre (nombre impair)
	 * 
	 * @return le nombre d'espace divisé par deux
	 */
	private int calculMiddleNbSpaces() {
		return (NB_SPACES % 2 == 1) ? NB_SPACES / 2 + 1 : NB_SPACES / 2;
	}

	/**
	 * Traitement des appels internes
	 * 
	 * @param ret vrai s'il s'agit d'une réponse sinon faux
	 * @param idxEnd indice de la classe appelée
	 * @param spaces les espaces et lignes de vie des classes avant celle de l'appel
	 * @return une chaine de caractere qui traite les appels internes
	 */
	private String internCall(boolean ret, int idxEnd, String spaces) {
		String end = EMPTY_STRING;
		int tirets = calculMiddleNbSpaces() - 1;
		end += duplicateCaracteres(duplicateCaracteres(SPACE, NB_SPACES/2).concat(PIPE), this.classes.size() - idxEnd - 1);
		String line = duplicateCaracteres(SPACE, tirets).concat(PIPE);
		
		return (!ret) ? PIPE + duplicateCaracteres(DASH, tirets + 1) + end + NEXT_LINE + spaces + PIPE + line + end : PIPE + LEFT_ARROW + duplicateCaracteres(DASH, tirets) + end;
	}

	/**
	 * Dupliquer une chaine de caractère
	 * 
	 * @param str la chaine de caractere a dupliquer
	 * @param nb le nombre de fois qu'il faut dupliquer la chaine de caractere
	 * @return la duplication de la chaine de caractere
	 */
	public String duplicateCaracteres(String str, int nb) {
		return nb <= 0 ? EMPTY_STRING : String.join(EMPTY_STRING, Collections.nCopies(nb, str));
	}
}
