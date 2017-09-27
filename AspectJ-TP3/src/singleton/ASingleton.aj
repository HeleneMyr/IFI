package singleton;

import java.util.HashMap;

/**
 * Implementation aspect du design pattern Singleton
 * 
 * @author Helene MEYER
 *
 */
public aspect ASingleton {
	
	/**
	 * récupère l'ensemble des classes instanciés
	 */
	private static final HashMap<String, Object> classes = new HashMap<>();
	
	/**
	 * design pattern singleton appliqué aux classes Clients et Orders
	 */
	declare parents: impl.Clients implements SingletonItf;
	declare parents: impl.Orders implements SingletonItf;
	
	/**
	 * interception de tous les appels du constructeur des classes implémentant l'interface SingletonItf
	 */
	pointcut single() : call(* ..SingletonItf+.new(..));
	
	/**
	 * Si l'instance existe deja, on recupere l'instance, sinon on en crée une nouvelle et on l'enregistre
	 * 
	 * @return l'instance
	 */
	Object around(): single() {
		String key = thisJoinPoint.getSignature().getDeclaringTypeName();
		
		if (!ASingleton.classes.containsKey(key)) {
			Object obj = proceed();
			ASingleton.classes.put(key, obj);
			return obj;
		}
		
		return ASingleton.classes.get(key);
	}
	
}
