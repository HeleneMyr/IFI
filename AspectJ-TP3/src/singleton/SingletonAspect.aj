package singleton;

import java.util.HashMap;

public aspect SingletonAspect {
	
	private static final HashMap<String, Object> classes = new HashMap<>();
	
//	declare parents: impl.Client implements Singleton;
//	declare parents: impl.Order implements Singleton;
	
	pointcut single() : call(* ..Singleton+.new(..));
	
	Object around(): single() {
		String key = thisJoinPoint.getSignature().getDeclaringTypeName();
		
		if (!SingletonAspect.classes.containsKey(key)) {
			System.out.println("Creation de l'objet " + key);
			Object obj = proceed();
			SingletonAspect.classes.put(key, obj);
			return obj;
		}
		
		System.out.println("Récupération de l'objet " + key);
		return SingletonAspect.classes.get(key);
	}
	
}
