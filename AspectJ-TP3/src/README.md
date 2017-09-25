#AspectJ AOP - TP3
Hélène MEYER  
Master 2 IAGL  
25/09/2017

* **Execution**  


Pour lancer le programme, il suffit de lancer le Main  
  
* **Explications du code **  

#####Implémentation du TP1 et TP2

Toutes les sources se trouvent dans le package impl.  
L'aspect *AClientOrder* permet de faire la relation entre le client et la commande. 

#####Implémentation du design pattern singleton

Pour implémenter le design pattern singleton, le constructeur de la classe en question est intercepté.  
A chaque appel, si l'instance a déjà été enregistrée dans la map, on la récupère.  
Sinon l'instance est créée et elle est enregistrée dans la map.  
Pour choisir les classes sur lesquelles le design pattern s'applique, il suffit d'implémenter l'interface Singleton.
Le code se trouve dans l'aspect *ASingleton*

Voici comment définir une classe qui suit le pattern Singleton:  

    declare parents: impl.Clients implements Singleton;
    declare parents: impl.Orders implements Singleton;

Voici la ligne pour récupérer toutes les classes qui suivent le pattern Singleton:

    pointcut single() : call(* ..Singleton+.new(..));

#####Diagramme d'échange de messages

Un diagramme d'échange de messages sous forme ASCII a été codé dans l'aspect *ADiagramme*.  

Pour mémoriser l'ensemble des classes, une liste est utilisée.
A chaque nouvel appel, une vérification du nom de la classe est faite.
Si le nom de la classe n'existe pas dans la liste, celui-ci est ajouté au diagramme.

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

Une fois que tous les noms de classes sont affichés, les appels sont tracés.
Une flèche de l'appel A vers B est affiché et le nom de la méthode est affiché juste au dessus.

    System.out.println(printAction(classes.indexOf(src), classes.indexOf(dest), action, false));

Puis, le lancement de la fonctionnalité est lancé. Le résultat est récupéré. 
Et une flèche de retour B vers A est affiché avec le résultat juste au dessus.

    Object ret = proceed();
    System.out.println(printAction(classes.indexOf(dest), classes.indexOf(src),
				ret != null ? ret.toString() : EMPTY_STRING, true));
    

Les appels internes et externes sur les classes sont différenciés:

    if (idxSrc == idxDest) {
    	str += internCall(ret, idxEnd, spaces);
    } else {
    	str += externCall(idxSrc, idxDest, idxStart, idxEnd, spacesBetween);
    }

Etant donné que l'aspect *ADiagramme* trace toutes les méthodes appelées entre les objets, il faut que tous les appels soient chargés avant que *ADiagramme* ne se lance:

    declare precedence: sequence.AClientOrder, singleton.ASingleton;
