---
title       : Visualisation
title_meta: Chapter 4
description : Ce chapitre vous montre comment réaliser quelques graphiques à partir de données lexicales.

---
## Un peu de tri

```yaml
type: NormalExercise
key: 166d428a58
lang: r
xp: 50
skills: 1
```

Avant de se lancer dans la production de graphiques, on va faire un peu de tri dans les mots pour ne garder que les plus fréquents (sinon, nos graphiques seront surchargés!). On va pour cela utiliser la table `tib_mots_nonvides` (déjà dans l'environnement).

`@instructions`

**Ajoutez une colonne** `freq`, qui compte la fréquence d'occurrence des lemmes dans la table `tib_mots_nonvides` (-> table `tib1`).

**Résumez** les fréquences d'occurrence des lemmes dans `tib_mots_nonvides` (-> table `tib2`).

`@hint`
La nuance est dans la différence entre `mutate()` et `summarise()`.


`@pre_exercise_code`
```{r}
tib_mots_nonvides=readr::read_csv("https://raw.githubusercontent.com/lvaudor/tuto_texte_Marmiton/master/data/tib_mots_nonvides.csv")
```

`@sample_code`
```{r}
library(dplyr)
tib1 <- tib_mots_nonvides %>% 
  group_by(lemme) %>% 
  ___(freq=___)
dim(tib1)
  
tib2 <- tib_mots_nonvides %>% 
  group_by(lemme) %>% 
  ___(freq=___)  
dim(tib2)
```

`@solution`
```{r}
library(dplyr)
tib1 <- tib_mots_nonvides %>% 
  group_by(lemme) %>% 
  mutate(freq=n())
dim(tib1)
  
tib2 <- tib_mots_nonvides %>% 
  group_by(lemme) %>% 
  summarise(freq=n())
dim(tib2)
```

`@sct`
```{r}
ex() %>% check_error()

ex() %>% check_library("dplyr")

ex() %>% check_object("tib1")
ex() %>% check_function("mutate")

ex() %>% check_object("tib2")
ex() %>% check_function("summarise")

success_msg("Bien joué! Pour faire un graphique de type nuage de mots, on va typiquement avoir besoin du genre d'opération réalisé avec summarise... Pour travailler sur les cooccurrences, on ne veut pas perdre le lien entre les mots (c'est-à-dire leur appartenance à un commentaire commun) donc on va plutôt avoir besoin du genre d'opération réalisé avec mutate.")
```

---
## Nuage de mots

```yaml
type: NormalExercise
key: 615077e0c5
lang: r
xp: 50
skills: 1
```


On va faire notre premier **nuage de mots**, en filtrant les données pour ne garder qu'une partie des mots...

`@instructions`

Créez un tableau qui résume la **fréquence d'occurrence** des lemmes et **filtrez** pour ne garder que les lemmes avec une fréquence **supérieure ou égale à 20**.
Réalisez le nuage des mots à l'aide du jeu de données résultant `tib_mots_frequence`.

`@hint`
Avez-vous bien réussi à calculer `tib_mots_frequence` (`summarise(freq=n())` et `filter(freq>=20)` et à passer les bons arguments à la fonction `wordcloud()` (`tib_mots_frequence$lemme` et `tib_mots_frequence$freq`)?

`@pre_exercise_code`
```{r}
tib_mots_nonvides=readr::read_csv("https://raw.githubusercontent.com/lvaudor/tuto_texte_Marmiton/master/data/tib_mots_nonvides.csv")
```

`@sample_code`
```{r}
library(dplyr
tib_mots_frequence=tib_mots_nonvides %>% 
  group_by(lemme) %>% 
  summarise(freq=n())%>% 
  filter(___)

library(wordcloud)  
wordcloud(___,
          ___)
```

`@solution`
```{r}
library(dplyr)
tib_mots_frequence=tib_mots_nonvides %>% 
  group_by(lemme) %>% 
  summarise(freq=n())%>% 
  filter(freq>=20)

library(wordcloud)  
wordcloud(tib_mots_frequence$lemme,
          tib_mots_frequence$freq)
```

`@sct`
```{r}
ex() %>% check_error()

ex() %>% check_library("dplyr")
ex() %>% check_library("wordcloud")

ex() %>% check_function("wordcloud") %>% {
check_arg(.,"freq") %>% check_equal()
check_arg(.,"word") %>% check_equal()
}

success_msg("Bien joué! Un nuage de mots sur un rapport, c'est comme un espuma sur une assiette: ça en jette.")
```




---
## Diagramme en bâtons

```yaml
type: NormalExercise
key: 92873aa904
lang: r
xp: 50
skills: 1
```

On va maintenant réaliser un **diagramme en bâtons** montrant les fréquences des mots les plus utilisés dans les commentaires Marmiton.

`@instructions`

Réduisez le nombre de lemmes à intégrer au graphique en ne conservant que ceux qui ont les 15 fréquences les plus élevées?
.

`@hint`
On a calculé par nous-même les fréquences (afin de faire un tri préalable) donc on passe cette fréquence en variable "y" à ggplot...


`@pre_exercise_code`
```{r}
tib_mots_nonvides=readr::read_csv("https://raw.githubusercontent.com/lvaudor/tuto_texte_Marmiton/master/data/tib_mots_nonvides.csv")
```

`@sample_code`
```{r}
tib_mots_frequence=tib_mots_nonvides %>% 
  group_by(___) %>% 
  ___(freq=n()) %>% 
  top_n(___,___)

library(ggplot2)
ggplot(tib_mots_frequence, aes(x=___, y=___))+
  geom_bar(stat="identity")+
  coord_flip()
```

`@solution`
```{r}
tib_mots_frequence=tib_mots_nonvides %>% 
  group_by(lemme) %>% 
  summarise(freq=n()) %>% 
  top_n(15,freq)

library(ggplot2)
ggplot(tib_mots_frequence, aes(x=word, y=freq))+
  geom_bar(stat="identity")+
  coord_flip()
```

`@sct`
```{r}
ex() %>% check_error()
ex() %>% check_library("ggplot2")

ex() %>% check_function("summarise")
ex() %>% check_function("top_n") %>% check_arg("n") %>% check_equal()

ex() %>% check_function("ggplot") %>% {
check_arg(.,"data") %>% check_equal()
check_arg(.,"mapping") %>% check_equal()
}

ex() %>% check_function("geom_bar") %>% check_arg("stat") %>% check_equal()
success_msg("Bravo! Voilà un graphique simple mais efficace pour représenter les fréquences lexicales.")
```


---
## Co-occurrences

```yaml
type: NormalExercise
key: f468d79672
lang: r
xp: 100
skills: 1
```

On s'intéresse maintenant à la cooccurrence des **lemmes** (les plus fréquents) par **recette**.

`@instructions`

Filtrez la table `tib_mots_nonvides` pour ne garder que les lemmes dont la fréquence est supérieure ou égale à 50.
Calculez `mots_comptes` et `mots_cors`

`@hint`
Avez-vous bien pensé qu'on ne cherchait pas à **résumer** l'information par mot mais simplement à **rajouter une variable `freq` qui va nous servir à filtrer les mots? Par ailleurs, c'est bien la **recette** qui définit la cooccurrence (et non le commentaire)... 


`@pre_exercise_code`
```{r}
tib_mots_nonvides=readr::read_csv("https://raw.githubusercontent.com/lvaudor/tuto_texte_Marmiton/master/data/tib_mots_nonvides.csv")
```

`@sample_code`
```{r}
library(dplyr)
tib_mots_filtree <- tib_mots_nonvides %>% 
  group_by(___) %>%
  ___(freq=__) %>% 
  filter(freq>=___) %>% 
  ungroup() 


library(widyr)
mots_comptes <- tib_mots_filtree %>%
  _______(___,___,sort=TRUE) 

mots_cors <- tib_mots_filtree %>% 
  _______(___,___,sort=TRUE)

mots_paires <- left_join(mots_comptes,
                         mots_cors,
                         by=c("item1","item2"))
```

`@solution`
```{r}
library(dplyr)
tib_mots_filtree <- tib_mots_nonvides %>% 
  group_by(lemme) %>%
  mutate(n=n()) %>% 
  filter(n>50) %>% 
  ungroup() 


library(widyr)
mots_comptes <-tib_mots_filtree %>%
  pairwise_count(lemme,recette,sort=TRUE) 

mots_cors <- tib_mots_filtree %>% 
  pairwise_cor(lemme,recette,sort=TRUE)

mots_paires=left_join(mots_comptes,
                      mots_cors,
                      by=c("item1","item2"))
```

`@sct`
```{r}
ex() %>% check_error()
ex() %>% check_library("widyr")
ex() %>% check_library("dplyr")
ex() %>% check_object("mots_comptes")
ex() %>% check_function("pairwise_count") %>% {
check_arg(.,"tbl")
check_arg(.,"item")
}

ex() %>% check_object("mots_cors")
ex() %>% check_function("pairwise_cor") %>% {
check_arg(.,"tbl")
check_arg(.,"item")
}

success_msg("Bien joué! Cette opération, en définissant des liens entre les mots, va nous permettre de réaliser un graphe de toute beauté...")
```


---
## Graphe

```yaml
type: NormalExercise
key: 9b03e5b33d
lang: r
xp: 50
skills: 1
```

On va maintenant réaliser un graphe à partir du tableau réalisé précédemment (`mots_paires` (déjà présent dans l'environnement).

`@instructions`
Filtrez le tableau pour ne conserver que les paires dont la **fréquence de cooccurrence** est **supérieure ou égale à 20** et la **corrélation** est **supérieure ou égale à 0.3**. On retire également le mot "recette" qui est omniprésent!

`@hint`
Avez-vous bien transformé la table `mots_paires_filtre` en objet de classe `igraph` à l'aide de la fonction `graph_from_data_frame()`?


`@pre_exercise_code`
```{r}
mots_paires=readr::read_csv("https://raw.githubusercontent.com/lvaudor/tuto_texte_Marmiton/master/data/mots_paires.csv")
```

`@sample_code`
```{r}
library(dplyr)
mots_paires_filtre=mots_paires %>%
   filter(n>20,
          correlation>0.3,
          item1!="recette" & item2!="recette")

library(ggraph)
tib_graph <- _____(mots_paires_filtre)

ggraph(__________,layout = "fr") +
   geom_edge_link() +
   geom_node_point(color = "lightblue", size = 5) +
   geom_node_text(aes(label = name), repel = TRUE) +
   theme_void()
```

`@solution`
```{r}
library(dplyr)
mots_paires_filtre=mots_paires %>%
   filter(n>20,
          correlation>0.3,
          item1!="recette" & item2!="recette")

library(ggraph)
tib_graph <- ______(mots_paires_filtre)

ggraph(tib_graph, layout = "fr") +
   geom_edge_link() +
   geom_node_point(color = "lightblue", size = 5) +
   geom_node_text(aes(label = name), repel = TRUE) +
   theme_void()
```

`@sct`
```{r}
ex() %>% check_error()
ex() %>% check_library("ggraph")
ex() %>% check_object("tib_graph")
ex() %>% check_function("graph_from_data_frame")
ex() %>% check_function("ggraph")
success_msg("Magnifique! Eh bien, c'est fini pour aujourd'hui. Je crois qu'on a bien mérité d'aller prendre notre goûter.")
```
