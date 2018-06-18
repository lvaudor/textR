---
title: Scraper des données du web
title_meta: Chapter 1
description: Ce chapitre vous montre comment scraper des données textuelles de sites web a l' aide des fonctions du package rvest.
---

## Lire un fichier html depuis R

```yaml
type: NormalExercise
lang: r
xp: 100
skills: 1
key: d2c087ae11
```

Observez la **page web** qui décrit la recette du bavarois au chocolat blanc et aux framboises (son url se termine par .aspx mais le contenu est bien de l'html!!), 

Nous souhaitons récupérer le **nom de la recette** à partir du contenu html de la page.

Nous allons pour ce faire utiliser des fonctions du package `readr`.

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
myhtml<-___(url)

# sélectionner l'élément correspondant au titre de la recette
element_titre<- myhtml %>% html_nodes(___)

# extraire le contenu de cet élément
titre <- element_titre %>% ___()
```

`@solution`

```{r}
library(rvest)
url<-"http://www.marmiton.org/recettes/recette_bavarois-au-chocolat-blanc-et-aux-framboises_84502.aspx"

# lire la page dans R
myhtml<-html_read(url)

# sélectionner l'élément correspondant au titre de la recette
element_titre<- myhtml %>% html_nodes(".main-title")

# extraire le contenu de cet élément
titre <- element_titre %>% html_text()


```

`@sct`

```{r}
test_error
test_object("url")
test_object("myhtml")
test_object("element_titre")
test_object("titre")
success_msg("Some praise! Then reinforce a learning objective from the exercise.")
```