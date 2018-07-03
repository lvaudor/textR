---
title: Scraper des données du web
title_meta: Chapter 1
description: Ce chapitre vous montre comment scraper les informations affichées dans des pages html à l' aide des fonctions du package rvest.

---
## Un exo pour comprendre les exos Datacamp

```yaml
type: NormalExercise
key: cad10d2f39
lang: r
xp: 10
skills: 1
```

Cet exercice sert purement et simplement à vous montrer comment fonctionne la plateforme Datacamp... 

`@instructions`

Ici, vous trouverez les **instructions** pour réaliser les exercices. Ici, imaginons que le but de l'exercice soit d'assigner la valeur 33 à l'objet `a`.

En face, vous avez:

- **en haut à droite** un éditeur, et 
- en **bas à gauche** une **console R**. L'environnement peut déjà contenir un certain nombre d'objets (des jeux de données par exemple).

Si vous ne parvenez pas à résoudre l'exercice, vous pouvez demander un indice (bouton **Take Hint**, ci-dessous), puis demander la solution (**Show Answer**) si l'indice n'est pas suffisant pour vous débloquer...

`@hint`
Avez-vous bien changé ___ en '33'?

`@pre_exercise_code`
```{r}
```

`@sample_code`
```{r}
# L'éditeur fonctionne (à peu de choses près) comme l'éditeur RStudio. Vous pouvez envoyer une ligne de code vers la console (en bas) en vous plaçant sur la ligne et en tapant Ctrl+Entrée sur votre clavier. Vous pouvez aussi envoyer l'ensemble de vos lignes de commandes en appuyant sur le bouton "Run code".

# Dans la plupart des exercices quelques lignes de commandes seront fournies, et ce sera à vous de les compléter en fonction des instructions.

a <- ___


# Les évaluations d'exercice consistent parfois à vérifier que la valeur de certains objets que vous avez créés correspond à ce qu'on attend...
# Essayez donc de ne pas changer leur nom au risque que la validation de votre exercice échoue...

# Si vous avez effacé certaines portions du code fourni au début et que vous estimez que c'était une erreur, vous pouvez appuyer sur le bouton "flèche en rond" (**reset sample code**).


#Une fois que vous avez complété et testé les lignes de commandes, et que vous pensez avoir la solution de l'exercice, vous pouvez **soumettre votre réponse** en appuyant sur le bouton "Submit". Un certain nombre de tests sont alors exécutés automatiquement pour déterminer si vous avez bien réussi l'exercice.

```

`@solution`
```{r}
a <- 33
```

`@sct`
```{r}
ex() %>% check_error()
ex() %>% check_object("a") %>% check_equal()
success_msg("Parfait! Vous allez pouvoir vous lancer dans les 'vrais' exercices...")
```



---
## Extraire un élément textuel d'une page web

```yaml
type: NormalExercise
lang: r
xp: 50
skills: 1
key: d2c087ae11
```

Observez la **page web** qui décrit la recette du bavarois au chocolat blanc et aux framboises (son url se termine par .aspx mais le contenu est bien de l'html!!), 

Nous souhaitons récupérer le **nom de la recette** à partir du contenu html de la page.

Nous allons pour ce faire utiliser des fonctions du package `rvest`.

`@instructions`
- **lire la page** dans R
- **sélectionner l'élément** correspondant au titre de la recette
- **extraire le contenu textuel** de cet élément
 
`@hint`
- l'élément correspondant au titre de la recette est de classe "main-title"
- pour sélectionner un élément de *classe* "pouetpouet", on écrit ".pouetpouet"

`@pre_exercise_code`

```{r}
```

`@sample_code`

```{r}
library(dplyr)
library(rvest)
url <- "http://www.marmiton.org/recettes/recette_bavarois-au-chocolat-blanc-et-aux-framboises_84502.aspx"

# lire la page dans R
html <- ___(url)

# sélectionner l'élément correspondant au titre de la recette
element_titre <- html %>%
    html_nodes(___)

# extraire le contenu de cet élément
titre <- element_titre %>%
    ___()
```

`@solution`

```{r}
library(dplyr)
library(rvest)
url <- "http://www.marmiton.org/recettes/recette_bavarois-au-chocolat-blanc-et-aux-framboises_84502.aspx"

# lire la page dans R
html <- read_html(url)

# sélectionner l'élément correspondant au titre de la recette
element_titre <- html %>%
    html_nodes(".main-title")

# extraire le contenu de cet élément
titre <- element_titre %>%
    html_text()
```

`@sct`

```{r}
ex() %>% check_error()
ex() %>% check_object("url")

ex() %>% check_object("html")
ex() %>% check_function("read_html") %>% check_arg("x") %>% check_equal()

ex() %>% check_object("element_titre") %>% check_equal()
ex() %>% check_function("html_nodes") %>% check_arg("css") %>% check_equal()

ex() %>% check_object("titre") %>% check_equal()
ex() %>% check_function("html_text")

success_msg("Bravo! A défaut de pouvoir lécher la casserole, vous pouvez scraper la recette!")
```


---
## Se repérer dans la page web

```yaml
type: NormalExercise
key: 02108d11c5
lang: r
xp: 50
skills: 1
```

On repart de l'objet `html` de l'exercice précédent (même recette de bavarois, donc...).  

`@instructions`

Récupérer le nom des **ingrédients** (pour l'instant accompagnés de leurs unités de mesure: "g de biscuits à la cuillère", "g de beurre rammoli", etc.), et les **quantités** correspondantes (150, 170, etc.).

Vous pouvez essayer d'utiliser le **selectorGadget** ou **examiner le code source de la page** sur votre navigateur web pour déterminer quelle est la **classe des éléments** qui nous intéressent ici...

`@hint`
Les noms des ingrédients sont renseignés par les éléments de classe "ingredient", tandis que les quantités sont renseignées dans les éléments de classe "recipe-ingredient-qt" 


`@pre_exercise_code`
```{r}
library(rvest)
html <- read_html("http://www.marmiton.org/recettes/recette_bavarois-au-chocolat-blanc-et-aux-framboises_84502.aspx")
```

`@sample_code`
```{r}
library(rvest)

ingredients <- html %>%
  html_nodes(___) %>% 
  html_text()
quantites <- html %>%
  html_nodes(___)  %>%
  html_text()
```

`@solution`
```{r}
library(rvest)

quantites <- html %>%
  html_nodes(".recipe-ingredient-qt")  %>%
  html_text()
ingredients <- html %>%
  html_nodes(".ingredient") %>% 
  html_text()
```

`@sct`
```{r}
ex() %>% check_error()

ex() %>% check_library("rvest")

ex() %>% check_function("html_nodes",index=1) %>% check_arg("x") %>% check_equal()
ex() %>% check_object("quantites") %>% check_equal()

ex() %>% check_function("html_nodes",index=2) %>% check_arg("x") %>% check_equal()
ex() %>% check_object("ingredients") %>% check_equal()

success_msg("Bien joué! Prenons maintenant notre nom de recette, nos ingrédients, et leurs quantités, et versons tout ça dans un moule rectangulaire")
```

---
## Retour au format rectangulaire

```yaml
type: MultipleChoiceExercise
key: e53526251d
xp: 25
skills: 1
```

Examinez le code suivant (il nécessite de charger les packages `rvest` et `dplyr` pour fonctionner):

```{r}
recup_ingredients <- function(url){
    html <- read_html(url)
    titre <- html %>%
      html_nodes(".main-title") %>% 
      html_text()
    quantites <- html %>%
      html_nodes(".recipe-ingredient-qt")  %>%
      html_text()
    ingredients <- html %>%
      html_nodes(".ingredient") %>% 
      html_text()
    tib <- bind_cols(url=rep(url,length(ingredients)),
                   titre=rep(titre, length(ingredients)),
                   quantites=quantites,
                   ingredients=ingredients)
    return(tib)
}
```
Que fait la fonction `recup_ingredients()`?

`@possible_answers`
- Elle prend en entrée l'**url** d'une recette Marmiton et renvoie une **liste** de la liste des ingrédients et de la liste des quantités.
- Elle prend en entrée l'**url** d'une recette Marmiton et renvoie une **table** renseignant les ingrédients et leurs quantités.
- Elle prend en entrée l'**url** d'une recette Marmiton et renvoie les **éléments html** ("nodes") relatifs aux ingrédients.
- Elle prend en entrée le **nom** d'une recette Marmiton et renvoie une **table** renseignant les ingrédients et leurs quantités

`@hint`
Le nom de l'input (`url`) et de l'output (`tib`) sont des indices, car la fonction est vraiment très bien écrite!...

`@sct`
```{r}
msg1 <- "Non, l'objet en sortie (tib) n'est pas une liste, mais une table (tibble)"
msg2 <- "Avez-vous remarqué que non contents d'être revenus au format rectangulaire, nous avons mis l'ensemble des opérations en fonction??"
msg3 <- "Non, nous sommes allés plus loin que la simple extraction des éléments html..."
msg4 <- "Non, telle que cette fonction est écrite, on ne peut pas fournir en entrée le nom de la recette..."
test_mc(correct=2, feedback_msgs = c(msg1, msg2, msg3, msg4))
```


---
## Iteration sur plusieurs pages


```yaml
type: NormalExercise
key: 3d5388c816
lang: r
xp: 50
skills: 1
```

Deux objets se trouvent déjà dans l'environnement: 

- `urls` (un vecteur de 5 urls pointant vers 5 recettes de dessert Marmiton)
- `recup_ingredients()`, la fonction définie précédemment 

`@instructions`

Appliquez itérativement la fonction `recup_ingredients()` à `urls`, à l'aide de la fonction `map()` du package `purrr`.

`@hint`
Avez-vous bien indiqué le nom de la liste et le nom de la fonction aux bons endroits? (Indiquez le nom de la fonction sans guillemets!)...

`@pre_exercise_code`
```{r}
library(rvest)
library(dplyr)
urls <- list("http://www.marmiton.org/recettes/recette_bavarois-au-chocolat-blanc-et-aux-framboises_84502.aspx",
             "http://www.marmiton.org/recettes/recette_milk-shake-pomme-banane-et-kiwi_312444.aspx",
             "http://www.marmiton.org/recettes/recette_salade-de-fruits-hivernale_86644.aspx",
             "http://www.marmiton.org/recettes/recette_muffins-moelleux-aux-chocolat-au-coeur-chocolat-blanc-banane-de-sandrine_65377.aspx",
             "http://www.marmiton.org/recettes/recette_marbre-3-couleurs_222805.aspx")
recup_ingredients <- function(url){
    html <- read_html(url)
    # Recupere titre
    titre <- html %>%
      html_nodes(".main-title") %>% 
      html_text()
    # Recupere quantites
    quantites <- html %>%
      html_nodes(".recipe-ingredient-qt")  %>%
      html_text()
    # Recupere ingredients
    ingredients <- html %>%
      html_nodes(".ingredient") %>% 
      html_text()
    # Rassemble le tout dans une tibble 
    tib <- bind_cols(url=rep(url,length(ingredients)),
                     titre=rep(titre, length(ingredients)),
                     quantites=quantites,
                     ingredients=ingredients)
    return(tib)
}
```

`@sample_code`
```{r}
library(purrr)

# Applique iterativement recup_ingredients à chaque element de urls
tibs <- map(___,___)

# Recolle toutes les tables en une seule (possible car meme nombre de colonnes)
tib_ingredients <- bind_rows(tibs)
```

`@solution`
```{r}
library(purrr)

# Applique iterativement recup_ingredients a chaque element de urls
tibs <- map(urls,recup_ingredients)

# Recolle toutes les tables en une seule (possible car meme nombre de colonnes)
tib_ingredients <- bind_rows(tibs)
```

`@sct`
```{r}
ex() %>% check_error()

ex() %>% check_object("urls") %>% check_equal()
ex() %>% check_object("recup_ingredients") %>% check_equal()

ex() %>% check_object("tibs") %>% check_equal()
ex() %>% check_function("map") %>% {
check_arg(.,".x")
check_arg(.,".f")
}

ex() %>% check_function("bind_rows") 
ex() %>% check_object("tib_ingredients") %>% check_equal()

success_msg("Super! Vous savez maintenant itérer une fonction grâce aux fonctions de purrr... Trop fort, non?")
```


