
public aspect ATrace {

	pointcut toBeTraced():
		call( void B.print(..) ) ||
		execution( void B.print(..) );
	
	before() : toBeTraced()
	{
		System.out.println(thisJoinPoint.getKind());
		System.out.println(thisJoinPoint.getSourceLocation().getFileName());
		System.out.println("source : " + thisJoinPoint.getThis());
		System.out.println("cible : " + thisJoinPoint.getTarget());
		System.out.println("méthode : " + thisJoinPoint.getSignature().getName());
		for (Object o : thisJoinPoint.getArgs()) {
			System.out.println("paramètre : " + o.toString());
		}
		
	}
	
}
