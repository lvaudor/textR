---
title       : Visualisation
description : Ce chapitre vous montre comment réaliser quelques graphiques à partir de données lexicales.

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

On va maintenant 

`@hint`

`@pre_exercise_code`
```{r}
tib_comments <- readr::read_csv("https://raw.githubusercontent.com/lvaudor/textR/c291e5cd0c0656ea7e2b8bf6c0485ba80b69b0d7/datasets/tib_comments.csv")

library(tidytext)  
tib_comments_words <- unnest_tokens(tib_comments,
                                    output="word",
                                    input="commentext")
library(proustr)
library(dplyr)
tib_comments_mainwords <- filter(tib_comments_words,
                                 !(word %in% proust_stopwords()$word))  
```

`@sample_code`
```{r}
tib_mots_frequence=tib_comments_mainwords %>% 
  group_by(word) %>% 
  summarise(freq=n())%>% 
  filter(freq>=10)

library(wordcloud)  
wordcloud(tib_mots_frequence$word,
          tib_mots_frequence$freq)
```

`@solution`
```{r}
tib_mots_frequence=tib_comments_mainwords %>% 
  group_by(word) %>% 
  summarise(freq=n())%>% 
  filter(freq>=10)

library(wordcloud)  
wordcloud(tib_mots_frequence$word,
          tib_mots_frequence$freq)
```

`@sct`
```{r}
test_error()
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

library(tidytext)  
tib_comments_words <- unnest_tokens(tib_comments,
                                    output="word",
                                    input="commentext")
library(proustr)
library(dplyr)
tib_comments_mainwords <- filter(tib_comments_words,
                                 !(word %in% proust_stopwords()$word))  
```

`@sample_code`
```{r}
tib_comments %>%
  summarise(mnote=mean(note,na.rm=TRUE)) %>% pull(mnote)

tib_mots_frequence=tib_comments_mainwords %>% 
  mutate(bonne_note=note>mean(note,na.rm=TRUE))
  group_by(word) %>% 
  summarise(freq=n())%>% 
  filter(freq>=10)
  
library(ggplot2)

```

`@solution`
```{r}

```

`@sct`
```{r}

```
