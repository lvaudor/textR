---
title: Scraper des données du web
title_meta: Chapter 1
description: Ce chapitre vous montre comment scraper des données textuelles de sites web a l' aide des fonctions du package rvest.
---

## Extraire un élément textuel d'une page web depuis R

```yaml
type: NormalExercise
lang: r
xp: 100
skills: 1
key: d2c087ae11
```

Observez la **page web** qui décrit la recette du bavarois au chocolat blanc et aux framboises (son url se termine par .aspx mais le contenu est bien de l'html!!), 

Nous souhaitons récupérer le **nom de la recette** à partir du contenu html de la page.

Nous allons pour ce faire utiliser des fonctions du package `rvest`.

`@instructions`
- **lire la page** dans R
- **sélectionner l'élément** correspondant au titre de la recette
- **extraire le contenu** de cet élément
 
`@hint`
- l'élément correspondant au titre de la recette est de classe "main-title"
- pour sélectionner un élément de *classe* "pouetpouet", on écrit ".pouetpouet"

`@pre_exercise_code`

```{r}
```

`@sample_code`

```{r}
library(rvest)
url<-"http://www.marmiton.org/recettes/recette_bavarois-au-chocolat-blanc-et-aux-framboises_84502.aspx"

# lire la page dans R
html<-___(url)

# sélectionner l'élément correspondant au titre de la recette
element_titre<- html %>% html_nodes(___)

# extraire le contenu de cet élément
titre <- element_titre %>% ___()
```

`@solution`

```{r}
library(rvest)
url<-"http://www.marmiton.org/recettes/recette_bavarois-au-chocolat-blanc-et-aux-framboises_84502.aspx"

# lire la page dans R
html<-read_html(url)

# sélectionner l'élément correspondant au titre de la recette
element_titre<- html %>% html_nodes(".main-title")

# extraire le contenu de cet élément
titre <- element_titre %>% html_text()
```

`@sct`

```{r}
test_error
test_object("url")
test_object("html")
test_object("element_titre")
test_object("titre")
success_msg("Bravo! A défaut de pouvoir lécher la casserole, vous pouvez scraper la recette!")
```



---
## Se repérer dans l'arborescence d'une page web

```yaml
type: NormalExercise
key: 02108d11c5
lang: r
xp: 100
skills: 1
```

On repart de l'objet `html` de l'exercice précédent (même recette de bavarois, donc...). On va maintenant essayer de récupérer la liste des **ingrédients** (pour l'instant accompagnés de leurs unités de mesure: "g de biscuits à la cuillère", "g de beurre rammoli", etc.), et les **quantités** correspondantes (150, 170, etc.).

Vous pouvez essayer d'utiliser le **selectorGadget** ou **examiner le code source de la page** sur votre navigateur web pour déterminer quelle est la **classe des éléments** qui nous intéressent...

`@instructions`
Les noms des ingrédients sont renseignés par les éléments de classe "ingredient", tandis que les quantités sont renseignées dans les éléments de classe "recipe-ingredient-qt" 

`@hint`

`@pre_exercise_code`
```{r}
library(rvest)
html<-read_html("http://www.marmiton.org/recettes/recette_bavarois-au-chocolat-blanc-et-aux-framboises_84502.aspx")
```

`@sample_code`
```{r}
ingredients=html %>%
  html_nodes(___) %>% 
  html_text()
quantites=html %>%
  html_nodes(___)  %>%
  html_text()
```

`@solution`
```{r}
quantites=html %>%
  html_nodes(".recipe-ingredient-qt")  %>%
  html_text()
ingredients=html %>%
  html_nodes(".ingredient") %>% 
  html_text()
```

`@sct`
```{r}
test_error
test_object("quantites")
test_object("ingredients")
success_msg("Bien joué! Prenons maintenant notre nom de recette, nos ingrédients, et leurs quantités, et versons tout ça dans un moule rectangulaire")
```

---
## Retour au format rectangulaire, et mise en fonction!

```yaml
type: PureMultipleChoiceExercise
key: 81e8e12acf
xp: 50
skills: 1
```

Examinez le code suivant:

```{r}
library(rvest)
library(dplyr)

recup_ingredients=function(url){
    html<-read_html(url)
    # Recupere titre
    titre <- html %>%
      html_nodes(".main-title") %>% 
      html_text()
    # Recupere quantites
    quantites=html %>%
      html_nodes(".recipe-ingredient-qt")  %>%
      html_text()
    # Recupere ingredients
    ingredients=html %>%
      html_nodes(".ingredient") %>% 
      html_text()
    # Rassemble le tout dans une tibble 
    tib<-bind_cols(url=rep(url,length(ingredients)),
                   titre=rep(titre, length(ingredients)),
                   quantites=quantites,
                   ingredients=ingredients)
    return(tib)
}
```

Que fait la fonction `recup_ingredients()`?


`@possible_answers`
- Elle prend en entrée l'**url** d'une recette Marmiton et renvoie en sortie une **liste** de la liste des ingrédients et de la liste des quantités.
- Elle prend en entrée l'**url** d'une recette Marmiton et renvoie en sortie une **table** renseignant les ingrédients et leurs quantités.
- Elle prend en entrée l'**url** d'une recette Marmiton et renvoie en sortie les **éléments html** ("nodes") relatifs aux ingrédients.
- Elle prend en entrée le **nom** d'une recette Marmiton et renvoie en sortie une **table** renseignant les ingrédients et leurs quantités

`@hint`

`@feedback`
- Non, l'objet en sortie (tib) n'est pas une liste, mais une table (tibble)
- Oui!! c'est bien ça...
- Non, nous sommes allés plus loin que la simple extraction des éléments html...
- Non, telle que cette fonction est écrite, on ne peut pas fournir en entrée le nom de la recette...
