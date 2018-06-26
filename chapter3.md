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

Examinez les premiers commentaires de la table tib_comments (déjà présente dans l'environnement). Dans cette table, **une ligne** correspond à **un commentaire**.

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

On repart de la table `tib_comments_word` créée dans l'exercice précédent.

On charge la librairie `proustr`: examinez les mots-outils listés par la fonction `proust_stopwords`.

Complétez l'appel à `filter()` pour écarter les mots listés dans la colonne `word` du jeu de données renvoyé par `proust_stopwords()`  

`@hint`

`@pre_exercise_code`
```{r}
tib_comments=readr::read_csv("https://raw.githubusercontent.com/lvaudor/textR/c291e5cd0c0656ea7e2b8bf6c0485ba80b69b0d7/datasets/tib_comments.csv")

library(tidytext)  
tib_comments_words <- unnest_tokens(tib_comments,
                                    output="word",
                                    input="commentext")
```

`@sample_code`
```{r}
library(proustr)
proust_stopwords()

tib_comments_mainwords <- filter(tib_comments_words,
                                 !(word %in% ___))
```

`@solution`
```{r}
library(proustr)
proust_stopwords()

tib_comments_mainwords <- filter(tib_comments_words,
                                 !(word %in% proust_stopwords()$word))
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

On repart de la table `tib_comments_mainwords` créée précédemment (déjà contenue dans l'environnement). Créez la table `tib_comments_mainwords_stemmed` en utilisant pour cela la fonction adéquate du package `proustr`.

`@hint`
Avez-vous trouvé de quelle fonction il s'agissait? il s'agit

`@pre_exercise_code`
```{r}
tib_comments=readr::read_csv("https://raw.githubusercontent.com/lvaudor/textR/c291e5cd0c0656ea7e2b8bf6c0485ba80b69b0d7/datasets/tib_comments.csv")

library(tidytext)  
tib_comments_words <- unnest_tokens(tib_comments,
                                    output="word",
                                    input="commentext")
library(proustr)
tib_comments_mainwords <- filter(tib_comments_words,
                                 !(word %in% proust_stopwords()$word))                                     
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

```
