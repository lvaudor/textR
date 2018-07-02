---
title       : Visualisation
description : Ce chapitre vous montre comment réaliser quelques graphiques à partir de données lexicales.Diapos ici <a class="white-link" href="http://perso.ens-lyon.fr/lise.vaudor/tutos/tuto_texte/tuto_texte_part4.html"  target="_blank">.

---

## Nuage de mots

```yaml
type: NormalExercise
key: 615077e0c5
lang: r
xp: 100
skills: 1
```


`@instructions`

On va maintenant réaliser un nuage de mots à partir de la table `tib_mots_nonvides`. Pour ce faire il nous faut calculer la fréquence d'occurrence des mots.

`@hint`

`@pre_exercise_code`
```{r}
tib_commentaires=readr::read_csv("https://raw.githubusercontent.com/lvaudor/tuto_texte_Marmiton/master/data/tib_commentaires.csv")

library(tidytext)  
tib_mots <- unnest_tokens(tib_commentaires,
                          output="word",
                          input="texte")
library(proustr)
library(dplyr)
tib_mots_nonvides <- anti_join(tib_mots,
                               proust_stopwords())       
```

`@sample_code`
```{r}
tib_mots_frequence=tib_mots_nonvides %>% 
  group_by(word) %>% 
  summarise(freq=n())%>% 
  filter(freq>=10)

library(wordcloud)  
wordcloud(tib_mots_frequence$word,
          tib_mots_frequence$freq)
```

`@solution`
```{r}
tib_mots_frequence=tib_mots_nonvides %>% 
  group_by(word) %>% 
  summarise(freq=n())%>% 
  filter(freq>=10)

library(wordcloud)  
wordcloud(tib_mots_frequence$word,
          tib_mots_frequence$freq)
```

`@sct`
```{r}
ex() %>% check_error()
ex() %>% check_library("wordcloud")
ex() %>% check_function("wordcloud") %>% {
check_arg(.,"freq") %>% check_equal()
check_arg(.,"word") %>% check_equal()
}
```



---
## barplot

```yaml
type: NormalExercise
key: 92873aa904
lang: r
xp: 100
skills: 1
```


`@instructions`

`@hint`

`@pre_exercise_code`
```{r}
tib_commentaires=readr::read_csv("https://raw.githubusercontent.com/lvaudor/tuto_texte_Marmiton/master/data/tib_commentaires.csv")

library(tidytext)  
tib_mots <- unnest_tokens(tib_commentaires,
                          output="word",
                          input="texte")
library(proustr)
library(dplyr)
tib_mots_nonvides <- anti_join(tib_mots,
                               proust_stopwords())    
```

`@sample_code`
```{r}
tib_commentaires %>%
  summarise(mnote=mean(note,na.rm=TRUE)) %>% pull(mnote)

tib_mots_frequence=tib_mots_nonvides %>% 
  mutate(bonne_note=note>mean(note,na.rm=TRUE))
  group_by(word) %>% 
  summarise(freq=n())%>% 
  filter(freq>=10)
  
library(ggplot2)
```

`@solution`
```{r}
tib_commentaires %>%
  summarise(mnote=mean(note,na.rm=TRUE)) %>% pull(mnote)

tib_mots_frequence=tib_mots_nonvides %>% 
  mutate(bonne_note=note>mean(note,na.rm=TRUE))
  group_by(word) %>% 
  summarise(freq=n())%>% 
  filter(freq>=10)
  
library(ggplot2)
```

`@sct`
```{r}
ex() %>% check_error()
```
