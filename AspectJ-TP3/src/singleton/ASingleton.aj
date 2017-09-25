package singleton;

import java.util.HashMap;

public aspect ASingleton {
	
	private static final HashMap<String, Object> classes = new HashMap<>();
	
	declare parents: impl.Clients implements Singleton;
	declare parents: impl.Orders implements Singleton;
	
	pointcut single() : call(* ..Singleton+.new(..));
	
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
