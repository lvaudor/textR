---
title: Manipuler des chaines de caractère
description: Ce chapitre vous montre comment scraper des données textuelles de sites web à l'aide des fonctions du package rvest.
---

## An exercise title written in sentence case

```yaml
type: NormalExercise
lang: r
xp: 100
skills: 1
key: d1facd47cd
```

This is the assignment text. It should help provide students with the background information needed.
The instructions that follow should be in bullet point form with clear guidance for what is expected.

`@instructions`
- Instruction 1
- Instruction 2
- Instruction 3
- Instruction 4

`@hint`
- Here is the hint for this setup problem. 
- It should get students 50% of the way to the correct answer.
- So don't provide the answer, but don't just reiterate the instructions.
- Typically one hint per instruction is a sensible amount.

`@pre_exercise_code`

```{r}
#library(ggplot2)
```

`@sample_code`

```{r}
url="http://www.marmiton.org/recettes/recette_bavarois-au-chocolat-blanc-et-aux-framboises_84502.aspx"
```

`@solution`

```{r}
url="http://www.marmiton.org/recettes/recette_bavarois-au-chocolat-blanc-et-aux-framboises_84502.aspx"
```

`@sct`

```{r}
test_error
test_object("url")
success_msg("Some praise! Then reinforce a learning objective from the exercise.")
```


