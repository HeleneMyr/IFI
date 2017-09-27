#AspectJ AOP - TP3
Helene MEYER  
Master 2 IAGL  
25/09/2017

* **Execution**  


Pour lancer le programme, il suffit de lancer le Main  
  
* **Explications du code **  

#####Implementation du TP1 et TP2

Toutes les sources se trouvent dans le package impl.  
L'aspect *AClientOrder* permet de faire la relation entre le client et la commande. 

#####Implementation du design pattern singleton

Pour implementer le design pattern singleton, le constructeur de la classe en question est intercepte.  
A chaque appel, si l'instance a deja ete enregistree dans la map, on la recupere.  
Sinon l'instance est creee et elle est enregistree dans la map.  
Pour choisir les classes sur lesquelles le design pattern s'applique, il suffit d'implementer l'interface Singleton.
Le code se trouve dans l'aspect *ASingleton*

Voici comment definir une classe qui suit le pattern Singleton:  

    declare parents: impl.Clients implements SingletonItf;
    declare parents: impl.Orders implements SingletonItf;

Voici la ligne pour recuperer toutes les classes qui suivent le pattern Singleton:

    pointcut single() : call(* ..SingletonItf+.new(..));

#####Diagramme d'echange de messages

Un diagramme d'echange de messages sous forme ASCII a ete code dans l'aspect *ADiagramme*.  

Pour memoriser l'ensemble des classes, une liste est utilisee.
A chaque nouvel appel, une verification du nom de la classe est faite.
Si le nom de la classe n'existe pas dans la liste, celui-ci est ajoute au diagramme.

    List<String> className = new ArrayList<>();
    [...]
    if (!classes.contains(src)) {
    	className.add(src);
    }
    if (!classes.contains(dest) && src!= null && !src.equalsIgnoreCase(dest)) {
    	className.add(dest);
    }
    if (!className.isEmpty())
    	System.out.println(printNameClass(className));

Une fois que tous les noms de classes sont affiches, les appels sont traces.
Une fleche de l'appel A vers B est affiche et le nom de la methode est affiche juste au dessus.

    System.out.println(printAction(classes.indexOf(src), classes.indexOf(dest), action, false));

Puis, le lancement de la fonctionnalite est lance. Le resultat est recupere. 
Et une fleche de retour B vers A est affiche avec le resultat juste au dessus.

    Object ret = proceed();
    System.out.println(printAction(classes.indexOf(dest), classes.indexOf(src),
				ret != null ? ret.toString() : EMPTY_STRING, true));
    

Les appels internes et externes sur les classes sont differencies:

    if (idxSrc == idxDest) {
    	str += internCall(ret, idxEnd, spaces);
    } else {
    	str += externCall(idxSrc, idxDest, idxStart, idxEnd, spacesBetween);
    }

Etant donne que l'aspect *ADiagramme* trace toutes les methodes appelees entre les objets, il faut que tous les appels soient charges avant que *ADiagramme* ne se lance:

    declare precedence: sequence.AClientOrder, singleton.ASingleton;


* **Tests**

Des tests sont disponibles dans le dossier test