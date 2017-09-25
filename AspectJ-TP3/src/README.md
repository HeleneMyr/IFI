#AspectJ AOP - TP3
H�l�ne MEYER  
Master 2 IAGL  
25/09/2017

* **Execution**  


Pour lancer le programme, il suffit de lancer le Main  
  
* **Explications du code **  

#####Impl�mentation du TP1 et TP2

Toutes les sources se trouvent dans le package impl.  
L'aspect *AClientOrder* permet de faire la relation entre le client et la commande. 

#####Impl�mentation du design pattern singleton

Pour impl�menter le design pattern singleton, le constructeur de la classe en question est intercept�.  
A chaque appel, si l'instance a d�j� �t� enregistr�e dans la map, on la r�cup�re.  
Sinon l'instance est cr��e et elle est enregistr�e dans la map.  
Pour choisir les classes sur lesquelles le design pattern s'applique, il suffit d'impl�menter l'interface Singleton.
Le code se trouve dans l'aspect *ASingleton*

Voici comment d�finir une classe qui suit le pattern Singleton:  

    declare parents: impl.Clients implements Singleton;
    declare parents: impl.Orders implements Singleton;

Voici la ligne pour r�cup�rer toutes les classes qui suivent le pattern Singleton:

    pointcut single() : call(* ..Singleton+.new(..));

#####Diagramme d'�change de messages

Un diagramme d'�change de messages sous forme ASCII a �t� cod� dans l'aspect *ADiagramme*.  

Pour m�moriser l'ensemble des classes, une liste est utilis�e.
A chaque nouvel appel, une v�rification du nom de la classe est faite.
Si le nom de la classe n'existe pas dans la liste, celui-ci est ajout� au diagramme.

    List<String> className = new ArrayList<>();
    [...]
    if (!classes.contains(src)) {
    	className.add(src);
    }
    if (!classes.contains(dest)) {
    	className.add(dest);
    }
    if (!className.isEmpty())
    	System.out.println(printNameClass(className));

Une fois que tous les noms de classes sont affich�s, les appels sont trac�s.
Une fl�che de l'appel A vers B est affich� et le nom de la m�thode est affich� juste au dessus.

    System.out.println(printAction(classes.indexOf(src), classes.indexOf(dest), action, false));

Puis, le lancement de la fonctionnalit� est lanc�. Le r�sultat est r�cup�r�. 
Et une fl�che de retour B vers A est affich� avec le r�sultat juste au dessus.

    Object ret = proceed();
    System.out.println(printAction(classes.indexOf(dest), classes.indexOf(src),
				ret != null ? ret.toString() : EMPTY_STRING, true));
    

Les appels internes et externes sur les classes sont diff�renci�s:

    if (idxSrc == idxDest) {
    	str += internCall(ret, idxEnd, spaces);
    } else {
    	str += externCall(idxSrc, idxDest, idxStart, idxEnd, spacesBetween);
    }

Etant donn� que l'aspect *ADiagramme* trace toutes les m�thodes appel�es entre les objets, il faut que tous les appels soient charg�s avant que *ADiagramme* ne se lance:

    declare precedence: sequence.AClientOrder, singleton.ASingleton;
