---
title       : Manipuler du texte en langage naturel
title_meta: Chapter 3
description : Ce chapitre vous montre comment à partir de texte en langage naturel (ici en français) mettre en forme des tables clean et tidy vous permettant quelques analyses lexicales.

---
## Tokenisation

```yaml
type: NormalExercise
key: 4b7358efd0
lang: r
xp: 100
skills: 1
```


Examinez les premiers commentaires de la table `tib_commentaires` (en fait, une sous-partie seulement de cette table, déjà présente dans l'environnement).
(Il y a un problème apparent d'encodage quand j'affiche un objet de classe `tibble` mais si vous affichez seulement tib_commentaires$texte ça va -on va faire comme s'il n'y avait pas de problème, vu que j'ai mis le problème de l'encodage de caractères sous le tapis pour ce tuto, d'accord ?- ;-) ).

Dans cette table, **une ligne** correspond à **un commentaire**.

`@instructions`
Tokenisez les commentaires pour obtenir la table `tib_mots`, pour laquelle **une ligne** correspond à **un mot**.


`@hint`
- Avez-vous bien spécifié que la tokenisation devait se faire mot à mot? 
- Avez-vous bien indiqué le nom de la colonne de `tib_mots` qui correspond à l'input? 
- Avez-vous bien fourni ces arguments en les indiquant entre des guillements?


`@pre_exercise_code`
```{r}
tib_commentaires=readr::read_csv("https://raw.githubusercontent.com/lvaudor/tuto_texte_Marmiton/master/data/ptib_commentaires.csv")
```

`@sample_code`
```{r}
library(dplyr)
tib_commentaires %>%
    select(title, texte) %>%
    head()

library(tidytext)                              
tib_mots <- unnest_tokens(tib_commentaires,
                          output=___,
                          input=___)
```

`@solution`
```{r}
library(dplyr)
tib_commentaires %>%
    select(texte) %>%
    head()

library(tidytext)  
tib_mots <- unnest_tokens(tib_commentaires,
                          output="word",
                          input="texte")
```

`@sct`
```{r}
ex() %>% check_error()
ex() %>% check_library("dplyr")
ex() %>% check_library("tidytext")
ex() %>% check_function("unnest_tokens") %>% {
check_arg(.,"tbl") %>% check_equal()
check_arg(.,"output") %>% check_equal()
check_arg(.,"input") %>% check_equal()
}
ex() %>% check_object("tib_mots") %>% check_equal()
success_msg("Yes! La fonction unnest_tokens() nous mâche bien le travail pour la suite...")
```

---
## Retirer les mots-outils

```yaml
type: NormalExercise
key: dd7c384372
lang: r
xp: 50
skills: 1
```

On repart de la table `tib_mots` créée précédemment lors de l'étape de tokenisation.

`@instructions`

On charge la librairie `proustr`: examinez les mots-outils listés par la fonction `proust_stopwords`.

Complétez l'appel à `anti_join()` pour écarter de `tib_mots` les mots présents dans le jeu de données renvoyé par `proust_stopwords()`  

`@hint`
Il s'agit ici de faire une jointure "anti": tous les mots de `tib_mots` **sauf** ceux qui apparaissent dans `proust_stopwords()`!

`@pre_exercise_code`
```{r}
tib_mots=readr::read_csv("https://raw.githubusercontent.com/lvaudor/tuto_texte_Marmiton/master/data/tib_mots.csv")
library(tidytext)  
```

`@sample_code`
```{r}
library(proustr)
proust_stopwords()

library(dplyr)
tib_mots_nonvides <- ____join(tib_mots,
                               ___)
```

`@solution`
```{r}
library(proustr)
proust_stopwords()

library(dplyr)
tib_mots_nonvides <- anti_join(tib_mots,
                               proust_stopwords())
```

`@sct`
```{r}
ex() %>% check_error()

ex() %>% check_library("proustr")
ex() %>% check_library("dplyr")

ex() %>% check_object("tib_mots_nonvides") %>% check_equal()
ex() %>% check_function("anti_join") %>% {
check_arg(.,"x") %>% check_equal()
check_arg(.,"y") %>% check_equal()
}
test_object("tib_mots_nonvides")
success_msg("Super! On va maintenant se concentrer sur ce tableau `tib_mots_nonvides` pour la suite des exercices...")
```



---
## Racinisation

```yaml
type: NormalExercise
key: c28fe2bb6d
lang: r
xp: 25
skills: 1
```

On repart de la table `tib_mots_nonvides` créée précédemment (déjà présente dans l'environnement).

`@instructions`

Créez la table `tib_racines` en utilisant pour cela la fonction adéquate du package `proustr`.

`@hint`
Avez-vous trouvé de quelle fonction il s'agissait? il s'agit de `pr_stem_words()`...

`@pre_exercise_code`
```{r}
tib_mots_nonvides=readr::read_csv("https://raw.githubusercontent.com/lvaudor/tuto_texte_Marmiton/master/data/tib_mots_nonvides.csv")
library(tidytext)  
```

`@sample_code`
```{r}
library(proustr)
tib_racines <- ___
```

`@solution`
```{r}
library(proustr)
tib_racines <-  pr_stem_words(tib_mots_nonvides,
                              word)
```

`@sct`
```{r}
ex() %>% check_error()

ex() %>% check_library("proustr")

ex() %>% check_object("tib_racines") %>% check_equal()
ex() %>% check_function("pr_stem_words") %>% {
check_arg(.,"df")
check_arg(.,"col")
}
success_msg("Bien joué! Vous pouvez constater que la racinisation est très simple à mettre en oeuvre grâce à la fonction `pr_stem_words()`")
```

---
## Sentiments

```yaml
type: NormalExercise
key: c3ee1afd6f
lang: r
xp: 50
skills: 1
```

On va maintenant essayer d'associer aux mots des commentaires des **sentiments**...

`@instructions`

- créez les tables `scores` et `sentiments` qui associent, respectivement, une **polarité** (positive ou négative) et un **sentiment** à un certain nombre de mots en français.
- réalisez la jointure qui permet d'associer les mots issus des commentaires des recettes à une polarité positive ou négative (on repart de la table `tib_mots_nonvides`, déjà présente dans l'environnement).


`@hint`
Les tables `scores` et `sentiments` sont renvoyées par la fonction `proust_sentiments()` (pour des valeurs de l'argument `type` différentes). 

`@pre_exercise_code`
```{r}
tib_mots_nonvides=readr::read_csv("https://raw.githubusercontent.com/lvaudor/tuto_texte_Marmiton/master/data/tib_mots_nonvides.csv")
```

`@sample_code`
```{r}
library(proustr)
scores <- ___
sentiments <- ___

library(dplyr)    
tib_polarites <- tib_mots_nonvides %>%
    left_join(___) 

tib_polarites  %>%
  group_by(word,polarity) %>% 
  summarise(n=n()) %>% 
  arrange(desc(n))
```

`@solution`
```{r}
library(proustr)
scores <- proust_sentiments(type="score")
polarites <- proust_sentiments()

library(dplyr)
tib_polarites <- tib_mots_nonvides %>%
    left_join(polarites) 

tib_polarites  %>%
  group_by(word,polarity) %>% 
  summarise(n=n()) %>% 
  arrange(desc(n))
```

`@sct`
```{r}
ex() %>% check_error()

ex() %>% check_library("proustr")
ex() %>% check_library("dplyr")

ex() %>% check_object("scores") %>% check_equal()
ex() %>% check_object("polarites") %>% check_equal()
ex() %>% check_object("tib_polarites") %>% check_equal()

success_msg("Très bien! Comme vous pouvez le voir le lexique de Marmiton ressort plutôt comme positif... C'est un feel-good site!")
```
