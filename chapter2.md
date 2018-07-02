---
title       : Manipuler des chaînes de caractère
description : Ce chapitre vous montre comment manipuler, transformer, nettoyer des chaînes de caractère à l'aide des fonctions du package `stringr`.Diapos ici <a class="white-link" href="http://perso.ens-lyon.fr/lise.vaudor/tutos/tuto_texte/tuto_texte_part2.html"  target="_blank">.
---

## Remplacer un pattern par un autre

```yaml
type: NormalExercise
key: 4c919a781d
lang: r
xp: 25
skills: 1
```


`@instructions`

Transformez le vecteur `ingredients` en `ingredients_corr`, en **remplaçant** "cuillère à soupe" par "CàS" et en utilisant pour ce faire une des fonctions du package `stringr`.

`@hint`

`@pre_exercise_code`
```{r}

```

`@sample_code`
```{r}
library(stringr)
ingredients <- c("cuillère à soupe d'huile",
                 "dl de lait",
                 "cuillère de sucre",
                 "cuillère à soupe d'eau",
                 "g de farine",
                 "cuillère à café d'extrait de vanille")

ingredients_corr <- ___
```

`@solution`
```{r}
library(stringr)
ingredients <- c("cuillère à soupe d'huile",
                 "dl de lait",
                 "cuillère de sucre",
                 "cuillère à soupe d'eau",
                 "g de farine",
                 "cuillère à café d'extrait de vanille")

ingredients_corr <- str_replace(ingredients, "cuillère à soupe","CàS")
```

`@sct`
```{r}
ex() %>% check_error()
ex() %>% check_library("stringr")
ex() %>% check_object("ingredients") 
ex() %>% check_object("ingredients_corr")
ex() %>% check_function("str_replace") %>% {
check_arg(.,"string") %>% check_equal()
check_arg(.,"pattern") %>% check_equal()
check_arg(.,"replacement") %>% check_equal()
}

```


---
## Comprendre une expression régulière

```yaml
type: MultipleChoiceExercise
key: 4eb98c3ed1
lang: r
xp: 50
skills: 1
```

`@instructions`
Examinez cette expression régulière:

```{r}
"\\w?g"
```

Pour quels éléments le pattern sera-t-il détecté parmi les ingrédients suivants:

- "kg de farine de blé",
- "cuillère de sauce aigre-douce",
- "dl de lait d'amande",
- "g de chocolat amer")

`@possible_answers`
- "kg de farine de blé",et "cuillère de sauce aigre-douce"
- "kg de farine de blé", "cuillère de sauce aigre-douce"," et "g de chocolat amer"
- "kg de farine de blé et "g de chocolat amer
- "g de chocolat amer"

`@sct`
```{r}
msg1 <- "Non, le point d'interrogation signifie 0 ou 1 lettre avant le 'g'..."
msg2 <- "Oui! le 'g' peut être placé n'importe où, et être (ou non) précédé d'une lettre"
msg3 <- "Non... N'y a-t-il pas un autre 'g' quelque part qui pourrait correspondre?"
msg4 <- "Non, le 'g' peut n'être précédé par rien, mais il peut aussi être précédé d'une lettre..."
test_mc(correct=2, feedback_msgs = c(msg1, msg2, msg3, msg4))
```

---


## Décomposer une chaîne de caractère

```yaml
type: NormalExercise
key: e183fa15f8
lang: r
xp: 100
skills: 1
```


`@instructions`

Examinez le code ci-contre. Le premier appel à str_match isole l'unité de mesure -"g" ou "l" précédé ou non d'une autre lettre- du reste des chaînes de caractère

Complétez le deuxième appel pour aussi isoler les " de " ou " d'" dans les chaînes de caractère.

`@hint`
Avez-vous pensé aux espaces (un de part et d'autre du "de"), un avant le "d'", et à préceder l'apostrophe d'un "\" ?


`@pre_exercise_code`
```{r}

```

`@sample_code`

```{r}
library(stringr)

ingredients <- c(" g de chocolat",
                 " kg de farine", 
                 " ml de lait",
                 " dl d'huile",
                 " g de café soluble",
                 " l de lait")

match1 <- str_match(ingredients,"(\\w?g|\\w?l)(.*)")
match1
match2 <- str_match(ingredients,"(\\w?g|\\w?l)(___)(.*)"
match2
```

`@solution`
```{r}
library(stringr)

ingredients <- c(" g de chocolat",
                 " kg de farine", 
                 " ml de lait",
                 " dl d'huile",
                 " g de café soluble",
                 " l de lait")

match1 <- str_match(ingredients,"(\\w?g|\\w?l)(.*)")
match1
match2 <- str_match(ingredients,"(\\w?g|\\w?l)( de | d\')(.*)")
match2
```

`@sct`
```{r}
ex() %>% check_error()
ex() %>% check_library("stringr")
ex() %>% check_object("ingredients") %>% check_equal()
ex() %>% check_object("match2") %>% check_equal()
```

---
## Ecrire une expression régulière

```yaml
type: NormalExercise
key: cf6710de05
lang: r
xp: 100
skills: 1
```


`@instructions`
Le vecteur `notes` ci-contre correspond à des notes attribuées par les internautes aux recettes Marmiton. 


`@hint`

`@pre_exercise_code`
```{r}

```

`@sample_code`
```{r}
notes <- c("5/5","3/5","4/5","5/5","4/5")
```

`@solution`
```{r}

```

`@sct`
```{r}

```
