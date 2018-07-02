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

On va maintenant réaliser un nuage de mots à partir de la table `tib_mots_nonvides` (déjà dans l'environnement).


`@instructions`

Calculez la **fréquence d'occurrence** des mots et **filtrez** pour ne garder que les mots avec une fréquence **supérieure ou égale à 20**.

`@hint`
Avez-vous bien réussi à calculer `tib_mots_frequence` (`summarise(freq=n())` et `filter(freq>=20)` et à passer les bons arguments à la fonction `wordcloud()` (`tib_mots_frequence$word` et `tib_mots_frequence$freq`)?

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
  summarise(freq=___)%>% 
  filter(___)

library(wordcloud)  
wordcloud(___,
          ___)
```

`@solution`
```{r}
tib_mots_frequence=tib_mots_nonvides %>% 
  group_by(word) %>% 
  summarise(freq=n())%>% 
  filter(freq>=20)

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
success_msg("Bien joué! Un nuage de mots sur un rapport, c'est comme un espuma sur une assiette: ça en jette.")
```



---
## Diagramme en bâtons

```yaml
type: NormalExercise
key: 92873aa904
lang: r
xp: 100
skills: 1
```


`@instructions`

On va maintenant réaliser un diagramme en bâtons montrant les ayant les 15 fréquences les plus élevées à l'aide des fonctions de `ggplot2`

`@hint`
Avez-vous bien utilisé la fonction `geom_bar()` en spécifiant que l'on représente en y f(y) où f= la fonction identité?


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
  summarise(freq=n()) %>% 
  sample_n(___,___)

library(ggplot2)
ggplot(tib_mots_frequence, aes(x=___, y=___))+
  geom_bar(stat="identity")+
  coord_flip()
```

`@solution`
```{r}
tib_mots_frequence=tib_mots_nonvides %>% 
  group_by(word) %>% 
  summarise(freq=n()) %>% 
  sample_n(15,freq)

library(ggplot2)
ggplot(tib_mots_frequence, aes(x=word, y=freq))+
  geom_bar(stat="identity")+
  coord_flip()
```

`@sct`
```{r}
ex() %>% check_error()
ex() %>% check_library("ggplot2")
ex() %>% check_function("ggplot") %>% {
check_arg(.,"data") %>% check_equal()
check_arg(.,"mapping") %>% check_equal()
}
ex() %>% check_function("coord_flip")
ex() %>% check_function("geom_bar")
success_msg("Bravo! Voilà un graphique simple mais efficace pour représenter les fréquences lexicales.")
```
