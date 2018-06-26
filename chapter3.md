---
title       : Manipuler du texte en langage naturel
description : Insert the chapter description here


---
## Tokenisation

```yaml
type: NormalExercise
key: 4b7358efd0
lang: r
xp: 100
skills: 1
```

`@instructions`

Examinez les premiers commentaires de la table `tib_comments` (déjà présente dans l'environnement). Dans cette table, **une ligne** correspond à **un commentaire**.

Tokenizez les commentaires pour obtenir la table `tib_comments_words`, pour laquelle **une ligne** correspond à **un mot**.



`@hint`
- Avez-vous bien spécifié que la tokenisation devait se faire mot à mot? 
- Avez-vous bien indiqué le nom de la colonne de `tib_comments_word` qui correspond à l'input? 
- Avez-vous bien fourni ces arguments en les indiquant entre des guillements?


`@pre_exercise_code`
```{r}
tib_comments=readr::read_csv("https://raw.githubusercontent.com/lvaudor/textR/c291e5cd0c0656ea7e2b8bf6c0485ba80b69b0d7/datasets/tib_comments.csv")
```

`@sample_code`
```{r}
library(dplyr)
tib_comments %>%
    select(title, commentext) %>%
    head()

library(tidytext)                              
tib_comments_words=unnest_tokens(tib_comments,
                                output=___,
                                input=___)
```

`@solution`
```{r}
library(dplyr)
tib_comments %>%
    select(commentext) %>%
    head()

library(tidytext)  
tib_comments_words=unnest_tokens(tib_comments,
                                output="word",
                                input="commentext")
```

`@sct`
```{r}
test_error()
test_object("tib_comments_words")
```

---
## Retirer les mots-outils

```yaml
type: NormalExercise
key: dd7c384372
lang: r
xp: 100
skills: 1
```


`@instructions`

On repart de la table `tib_comments_words` créée dans l'exercice précédent.

On charge la librairie `proustr`: examinez les mots-outils listés par la fonction `proust_stopwords`.

Complétez l'appel à `anti_join()` pour écarter de `tib_comments_words` les mots présents dans le jeu de données renvoyé par `proust_stopwords()`  

`@hint`

`@pre_exercise_code`
```{r}
tib_comments <- readr::read_csv("https://raw.githubusercontent.com/lvaudor/textR/c291e5cd0c0656ea7e2b8bf6c0485ba80b69b0d7/datasets/tib_comments.csv")

library(tidytext)  
tib_comments_words <- unnest_tokens(tib_comments,
                                    output="word",
                                    input="commentext")
```

`@sample_code`
```{r}
library(proustr)
proust_stopwords()

library(dplyr)
tib_comments_mainwords <- anti_join(tib_comments_words,
                                    ___)
```

`@solution`
```{r}
library(proustr)
proust_stopwords()

library(dplyr)
tib_comments_mainwords <- anti_join(tib_comments_words,
                                    proust_stopwords())
```

`@sct`
```{r}
test_error()
test_object(tib_comments_mainwords)
```



---
## Racinisation

```yaml
type: NormalExercise
key: c28fe2bb6d
lang: r
xp: 100
skills: 1
```


`@instructions`

On repart de la table `tib_comments_mainwords` créée précédemment (déjà présente dans l'environnement). Créez la table `tib_comments_mainwords_stemmed` en utilisant pour cela la fonction adéquate du package `proustr`.

`@hint`
Avez-vous trouvé de quelle fonction il s'agissait? il s'agit de `pr_stem_words()`...

`@pre_exercise_code`
```{r}
tib_comments <- readr::read_csv("https://raw.githubusercontent.com/lvaudor/textR/c291e5cd0c0656ea7e2b8bf6c0485ba80b69b0d7/datasets/tib_comments.csv")

library(tidytext)  
tib_comments_words <- unnest_tokens(tib_comments,
                                    output="word",
                                    input="commentext")
library(proustr)
library(dplyr)
tib_comments_mainwords <- anti_join(tib_comments_words,
                                    proust_stopwords())                                     
```

`@sample_code`
```{r}
library(proustr)
tib_comments_mainwords_stemmed=___
```

`@solution`
```{r}
library(proustr)
tib_comments_mainwords_stemmed=pr_stem_words(tib_comments_mainwords,
                                             word)
```

`@sct`
```{r}
test_object(tib_comments_mainwords_stemmed)
```

---
## Sentiments

```yaml
type: NormalExercise
key: c3ee1afd6f
lang: r
xp: 100
skills: 1
```


`@instructions`


- récupérez les tables `scores` et `sentiments` qui associent, respectivement, une **polarité** (positive ou négative) et un **sentiment** à un certain nombre de mots en français.
- réalisez la jointure qui permet d'associer les mots issus des commentaires des recettes à une polarité positive ou négative (on repart de la table `tib_comments_mainwords`, déjà présente dans l'environnement).


`@hint`

`@pre_exercise_code`
```{r}
tib_comments <- readr::read_csv("https://raw.githubusercontent.com/lvaudor/textR/c291e5cd0c0656ea7e2b8bf6c0485ba80b69b0d7/datasets/tib_comments.csv")

library(tidytext)  
tib_comments_words <- unnest_tokens(tib_comments,
                                    output="word",
                                    input="commentext")
library(proustr)
tib_comments_mainwords <- filter(tib_comments_words,
                                 !(word %in% proust_stopwords()$word))  
                                 
tib_comments_mainwords_stemmed <- pr_stem_words(tib_comments_mainwords,
                                             word)
```

`@sample_code`
```{r}
library(proustr)
scores <- ___
sentiments <- ___
   
tib_comments_polarity <- tib_comments_mainwords %>%
    left_join(___) 

library(dplyr)    
tib_comments_polarity  %>%
  group_by(word,polarity) %>% 
  summarise(n=n()) %>% 
  arrange(desc(n))
```

`@solution`
```{r}
library(proustr)
scores <- proust_sentiments(type="score")
polarites <- proust_sentiments()

tib_comments_polarity <- tib_comments_mainwords %>%
    left_join(polarites) 

library(dplyr)
tib_comments_polarity  %>%
  group_by(word,polarity) %>% 
  summarise(n=n()) %>% 
  arrange(desc(n))
```

`@sct`
```{r}
test_error()
```
