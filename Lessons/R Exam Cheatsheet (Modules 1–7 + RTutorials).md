# R Exam Cheatsheet (Modules 1–7 + RTutorials)

Oct 21, 2026 · @Francisco

## 1. Quick reference

Built from the course site (Modules 1–7, Tips, Shortcuts, RTutorials 1–3). Skim this section first; the rest is detail.

| Action | Windows / Linux | Mac |
| --- | --- | --- |
| Insert R chunk | Ctrl + Alt + I | Cmd + Option + I |
| Knit document | Ctrl + Shift + K | Cmd + Option + K |
| Insert assignment `<-` | Alt + - | Option + - |
| Insert pipe `%>%` | Ctrl + Shift + M | Shift + Cmd + M |
| Run line / selection | Ctrl + Enter | Cmd + Enter |
| Zoom Source / Console / Help / History / Files / Plots / Packages / Environment / Viewer | Ctrl + Shift + 1 to 9 | Cmd + Shift + 1 to 9 |

Console prompt: `>` = ready; `+` = R is waiting for more input (missing `)` or quote). Press `Esc` to cancel.

```r
install.packages("dplyr")      # once per computer
library(dplyr)                  # every session
?lm   # or help(lm)           # help for a function
getwd(); setwd("c:/docs/mydir") # forward slashes /, not \
citation(); citation("dplyr")   # how to cite R / a package

df <- read.csv("file.csv")
df <- read.table("file.txt", header = TRUE, sep = "\t")
library(readxl); df <- read_excel("file.xlsx", sheet = 1)

head(df); str(df); summary(df); colnames(df)
class(x); mean(x, na.rm = TRUE); median(x); sd(x)
table(df$col); prop.table(table(df$col))
```

Pre-flight checklist (from the course Tips page): all quotes closed, all `()` `[]` `{}` closed, and the file path is relative to the folder where the `.Rmd` is saved (`read.csv("data/datos.csv")` for a `data/` subfolder).

## 2. R basics: objects, types, structures (Modules 1 and 4)

R is a free, open-source language for statistics, created by Ross Ihaka and Robert Gentleman (University of Auckland), based on S. RStudio is the IDE (code editor, console, environment/history, plots/files panes).

**Assigning and naming.** `x <- 5` is standard. `=` is used for function arguments (`mean(x = c(1,2,3))`). R is case sensitive (`foo`, `Foo`, `FOO` differ), names cannot start with a number, and avoid special characters.

**Data types:** `numeric` (2.5), `integer` (`2L`), `logical` (`TRUE`/`FALSE`), `character` ("text"), `complex` (`1+4i`).

| Symbol | Meaning |
| --- | --- |
| `<-` | assignment |
| `#` | comment |
| `==` | equality test |
| `+ - * /` | arithmetic |
| `> < >= <=` | comparison |
| `&` | logical AND |
| `~` | model formula (`y ~ x`) |
| `$` | pull a column / list element |
| `:` | sequence (`2:10`) |
| `c()` | combine into a vector |

**Data structures**

|  | Linear | Rectangular |
| --- | --- | --- |
| All same type | Vector: `c(1, 2, 3)` | Matrix: `matrix(1:6, nrow = 2)` |
| Mixed types | List: `list("a", 1, TRUE)` | Data frame: `data.frame(name = c("A","B"), age = c(30,25))` |

Factor = categorical data with predefined levels: `factor(c("low","high"))`. A data frame is a list of equal-length vectors, each column can have a different type.

```r
a <- c(1,2,3,4,5);  b <- c(6,7,8,9,10)
a + b            # 7 9 11 13 15 (same-length vectors, element-wise)
a * b            # 6 14 24 36 50
sort(c(3,2,20,25,5))   # 2 3 5 20 25

my_list <- list(Numbers = c(1,2,3,4,5), Words = c("apple","banana","cherry"))
my_matrix <- matrix(data = 1:9, nrow = 3, ncol = 3, byrow = TRUE)
```

**Indexing** (`[row, column]`)

```r
df[,1]        # first column
df[1,]        # first row
df[1,1]       # row 1, column 1
df[2:10,1]    # rows 2 to 10 of column 1
df$island[2:15]   # elements 2 to 15 of the island column
# Trap: penguins$body_mass is NULL, the column is body_mass_g
```

**Quick summaries** (penguins example from class)

```r
mean(penguins$body_mass_g, na.rm = TRUE)    # 4201.754
median(penguins$body_mass_g, na.rm = TRUE)  # 4050
table(penguins$island)             # Biscoe 168, Dream 124, Torgersen 52
prop.table(table(penguins$island)) # 0.488, 0.360, 0.151
summary(penguins$body_mass_g)      # min, quartiles, mean, max, NA count
```

**Writing a function:** name, input, body, output via `return()`.

```r
fahrenheit_to_celsius <- function(temp_F) {
  temp_C <- (temp_F - 32) * 5 / 9
  return(temp_C)
}
fahrenheit_to_celsius(32)   # 0
```

**Housekeeping.** Workspace holds objects (`save.image()`), History holds commands (`savehistory()`), plots are saved with `ggsave()`. The `here` package builds paths: `here("data", "file-name.csv")`.

## 3. R Markdown and Markdown structure (Modules 2, 3, 4)

Markdown is a lightweight markup language (it formats text; it is not a programming language). An R Markdown file (`.Rmd`) has three parts: the YAML header, Markdown text, and code chunks. **Knitting** runs the chunks, interprets the Markdown, and produces HTML, PDF or Word. PDF output needs LaTeX (`tinytex::install_tinytex()`). Create one with File > New File > R Markdown.

```markdown
---
title: "Untitled"
author: "name"
date: "`r format(Sys.time(), '%Y-%b-%d, %I:%M %p')`"
output: html_document
---
```

#========= Put this after YAML ============#

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE,
                      results = "markup")
```
#==========================================#

The four default YAML fields are `title`, `author`, `date`, `output`. The title is not the file name.

| Element | Syntax |
| --- | --- |
| Headings | `# H1`, `## H2`, `### H3`, `#### H4` |
| Line break inside a paragraph | two spaces at line end, or `<br>` |
| New paragraph | blank line |
| Bold | `**very**` or `__very__` |
| Italics | `*word*` or `_word_` |
| Unordered list | `- item`, `* item` or `+ item` (indent for sub-items) |
| Ordered list | `1. item` |
| Link | `[text](https://url)` |
| Image | `![caption](path/img.png)` or `<img src="img.jpg" width="550"/>` or `knitr::include_graphics("image.png")` |
| Inline code | `` `x + 2` `` (single backticks) |
| Code block | three backticks above and below |
| Table | pipes `\|` between columns, hyphens under the header row |

Table alignment uses colons in the header separator: `:---` left, `:---:` centered, `---:` right.

```markdown
| Left | Centered | Right |
| :--- | :---: | ---: |
| Apples | Red | 5000 |
```

**Code chunk** = three backticks + `{r options}`; insert with Ctrl + Cmd + I.

| Chunk option | Effect |
| --- | --- |
| `eval = FALSE` | do not run the code |
| `echo = FALSE` | run it, hide the code, show the output |
| `include = FALSE` | run it, hide both code and output (good for setup) |
| `message = FALSE` | hide messages (for example from `library(dplyr)`) |
| `warning = FALSE` | hide warnings (for example from `log(-1)`) |


Markdown limits: no track changes, no font size or color control, weak for complex tables, footnotes and equations. Why use it: code, results and text in one reproducible document; one source, many output formats.

**GitHub and website (Module 3).** Git = version control. GitHub = web platform that hosts Git repositories. Workflow: create a GitHub account, create a public repository (README, `.gitignore` for R, MIT license), copy the URL under Code, then in RStudio File > New Project > Version Control > Git, paste the URL, create the project. Edit your `.Rmd` (output `prettydoc::html_pretty`, theme `cayman`, highlight `github`), knit, and push changes to GitHub.

## 4. dplyr (Module 5)

dplyr is a grammar of data manipulation from the tidyverse. Every verb takes a data frame first, refers to columns without `$`, and returns a new tibble. Load with `library(dplyr)`.

| Verb | Does | Group |
| --- | --- | --- |
| `filter()` | keep rows meeting conditions | rows |
| `arrange()` | reorder rows (`desc()` for descending) | rows |
| `slice()` | pick rows by position | rows |
| `select()` | pick columns | columns |
| `rename()` | rename columns (`new = old`) | columns |
| `mutate()` | create or transform columns | columns |
| `group_by()` + `summarise()` | grouped summaries | groups |
| `count()` | count observations per group | groups |

**Pipe:** `%>%` (Ctrl + Shift + M) reads as "then"; base R pipe is `|>` (R 4.1+, no package needed). `%>%` comes from magrittr and supports the `.` placeholder.

```r
library(dplyr)
starwars %>% filter(species == "Droid")                  # one condition
starwars %>% filter(skin_color == "light", eye_color == "brown")  # comma = AND
filter(starwars, skin_color == "light" & eye_color == "brown")   # & also works
subset(starwars, species == "Droid")                      # base R equivalent

starwars %>% arrange(height, mass)        # ties in height broken by mass
starwars %>% arrange(desc(height))        # descending
starwars %>% slice(5:10)                  # rows 5 to 10
starwars %>% slice_head(n = 3)            # first 3 rows (slice_tail = last)

starwars %>% select(hair_color, skin_color, eye_color)
starwars %>% select(hair_color:eye_color)       # range of columns
starwars %>% select(!(hair_color:eye_color))    # drop a range with !
starwars %>% select(-hair_color, -eye_color)    # drop with -
starwars %>% select(1, 2, hair_color)           # positions + names
starwars %>% select(contains("c"))              # name contains
starwars %>% select(starts_with("n"))           # name starts with
starwars %>% select(ends_with("d"))             # name ends with
starwars %>% select(height_m, height, everything())  # reorder, rest after

starwars %>% rename(Character = name)
# base R: colnames(starwars)[colnames(starwars) == "name"] <- "Character"

starwars %>% mutate(height_m = height / 100)
starwars %>% mutate(height_m = height / 100, .keep = "none")   # keep only new column
starwars %>% mutate(height_cat = ifelse(height > 100, "tall", "small"))
# ifelse(condition, value_if_TRUE, value_if_FALSE)

starwars %>% summarise(height = mean(height, na.rm = TRUE))
starwars %>% group_by(species) %>%
  summarise(mean_height = mean(height, na.rm = TRUE), sd_height = sd(height, na.rm = TRUE))
starwars %>% group_by(homeworld, gender) %>%
  summarise(mean_height_by_gender = mean(height, na.rm = TRUE))
starwars %>% group_by(species) %>% count(homeworld, sort = TRUE)
starwars %>% sample_n(10)                       # 10 random rows
```

Watch for: `na.rm = TRUE` ignores missing values. In `summarise(height = mean(height), min = min(height))` the second line sees the already-averaged `height`, so min and max both return 175; name the new column something else (`mean_height`). A grouped tibble stays grouped after `summarise()` on two variables (message: "grouped output by 'homeworld'").

## 5. Base R plots and the tests used with them (Module 6)

Five essential plots: bar plot (summary values), scatter plot (two numeric variables), line graph (change over time), histogram (distribution), boxplot (variation between and within groups).

| Plot | Function | Key arguments |
| --- | --- | --- |
| Bar | `barplot(height, names.arg, ...)` | `col`, `border`, `main`, `xlab`, `ylab`, `las = 2` (rotate labels), `cex.names`, `horiz = TRUE` |
| Scatter | `plot(y ~ x, data)` | `type = "p"` points, `col`, `lwd`, `pch` |
| Line | `plot(x, y, type = "l")` | `type`: `"p"` points, `"l"` lines, `"o"` both |
| Histogram | `hist(x)` | `breaks` (number of bins), `col`, `border` |
| Boxplot | `boxplot(x)` or `boxplot(y ~ group, data)` | `col`, `border`, `main`, `ylab` |

Boxplot anatomy: center line = median; box = Q1 to Q3 (IQR); whiskers reach up to 1.5 x IQR; points beyond are potential outliers.

```r
# Bar plot of mean density per concentration (DNase, built in)
data(DNase)
mean_density <- aggregate(density ~ conc, data = DNase, FUN = mean)
barplot(height = mean_density$density, names.arg = mean_density$conc,
        col = "lightblue", border = "gray30", main = "Mean DNase I Activity",
        xlab = "Concentration (mg/mL)", ylab = "Mean Optical Density",
        las = 2, cex.names = 0.8)       # add horiz = TRUE for horizontal bars

# Scatter plot + regression line (coronary data, read with readxl)
library(readxl); coronary <- read_excel("data/coronary.xlsx")
plot(coronary$dbp ~ coronary$chol, type = "p", col = "blue", lwd = 2,
     xlab = "Total Cholesterol (mmol/L)", ylab = "Diastolic BP (mmHg)",
     main = "Cholesterol and Diastolic BP")
abline(lm(dbp ~ chol, data = coronary), col = "red", lwd = 2, lty = 2)

# Line chart: sort first, then type = "l"
coronary <- coronary[order(coronary$age), ]
plot(coronary$age, coronary$chol, type = "l", col = "blue", lwd = 2,
     xlab = "Age (years)", ylab = "Cholesterol (mmol/L)")

hist(coronary$chol, main = "Distribution of Cholesterol",
     xlab = "Cholesterol (mmol/L)", col = "lightblue", border = "white")
boxplot(sbp ~ gender, data = coronary, col = "lightblue", border = "darkblue")
```

**Tests from this module**

```r
shapiro.test(coronary$chol)                  # normality
cor.test(coronary$chol, coronary$dbp,
         method = "spearman", exact = FALSE) # rank correlation; exact = FALSE avoids tie warnings
anova_model <- aov(sbp ~ gender, data = coronary); summary(anova_model)
shapiro.test(residuals(anova_model))         # ANOVA assumption: normal residuals
bartlett.test(sbp ~ gender, data = coronary) # ANOVA assumption: equal variances
```

| Test | Null hypothesis | Class result | Decision at 0.05 |
| --- | --- | --- | --- |
| Shapiro-Wilk, chol | data are normal | W = 0.986, p = 0.048 | reject: not normal |
| Shapiro-Wilk, dbp | data are normal | W = 0.978, p = 0.0033 | reject: not normal |
| Spearman, chol vs dbp | rho = 0 | rho = 0.369, p < 0.001 | significant positive monotonic relationship |
| ANOVA, sbp by gender | equal means | F = 0.04, p = 0.842 | fail to reject |
| Shapiro-Wilk, ANOVA residuals | residuals normal | W = 0.967, p = 0.00011 | reject: normality violated |
| Bartlett, sbp by gender | equal variances | K-squared = 4.68, p = 0.030 | reject: variances differ |

Rule of thumb: p < 0.05 rejects the null. Spearman is preferred over Pearson when the variables are not normal. rho > 0 means both rise together; rho < 0 means one rises as the other falls.

## 6. ggplot2 (Module 7)

`ggplot2` is the package; `ggplot()` is the function. It implements Wilkinson's Grammar of Graphics (Hadley Wickham). Plots are built in layers joined with `+`. It works best with tidy data (rows = observations, columns = variables).

**Minimum for any plot: data + aesthetic mappings `aes()` + a geom.** Everything else (stat, position, coordinates, facets, scales, theme) has defaults.

```r
library(ggplot2)
ggplot(data = <DATA>, mapping = aes(<MAPPINGS>)) +
  <GEOM_FUNCTION>() +
  <COORD> + <FACET> + <SCALE> + <THEME>     # optional layers

ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()
```

**Global vs local mappings.** `aes()` inside `ggplot()` applies to every geom; `aes()` inside one geom applies only to it.

```r
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + geom_smooth()   # global
ggplot(mpg) + geom_point(aes(x = displ, y = hwy)) +
  geom_smooth(aes(x = displ, y = hwy))                                # local
```

| Aesthetic | Controls |
| --- | --- |
| `x`, `y` | axes |
| `color` | color of points and lines (outlines) |
| `fill` | color of areas (bars, histograms) |
| `alpha` | transparency |
| `shape` | point shape |
| `linetype` | solid, dashed, dotted |
| `size` | point or line size |
| `label` | text shown with `geom_text()` |

| Geom | Makes |
| --- | --- |
| `geom_histogram()` | histogram |
| `geom_density()` | density plot |
| `geom_point()` | scatter plot |
| `geom_jitter()` | jittered points (categorical or discrete x) |
| `geom_col()` | bars from values you already have (counts) |
| `geom_bar()` | bars counting all observations |
| `geom_line()` | line connecting observations |
| `geom_smooth()` | smoothed trend line |
| `geom_boxplot()` | boxplot |

**Faceting (small multiples)**

```r
facet_wrap(~ var, ncol = 2)       # one variable, wrapped panels
facet_grid(var1 ~ var2)           # var1 = rows, var2 = columns
```

```r
# Penguins from the intro class
ggplot(data = penguins, aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(aes(color = species, shape = species))

# After mutate(): histogram filled by a new category
starwars %>%
  mutate(height_cat = ifelse(height > 100, "tall", "small")) %>%
  ggplot(aes(x = height, fill = height_cat)) + geom_histogram()
```

Tips: `geom_histogram()` defaults to 30 bins (message: pick a better `binwidth`). Assign a plot to an object (`p <- ggplot(...)`) and call `print(p)` to display it. Save with `ggsave()`. Other tools mentioned: tidyplots, plotly (interactive), r-charts.

## 7. Definitions

| Term | Definition (as used in the course) |
| --- | --- |
| R | Free, open-source language and environment for statistics; created by Ihaka and Gentleman, based on S |
| RStudio | An IDE (integrated development environment) for R: editor, console, environment, plots |
| CRAN | Comprehensive R Archive Network, where R and packages are downloaded |
| Package | Collection of functions, data and code that extends R; `install.packages()` once, `library()` each session |
| Object | Anything stored in R under a name (a number, string, vector, data frame, plot, model) |
| Function | Takes input and produces output; `name(arguments)` |
| Argument | A value passed inside a function's parentheses, assigned with `=` |
| Vector | Sequence of elements of the same type |
| Factor | Categorical data with predefined levels |
| List | Collection of objects of different lengths or classes |
| Matrix | Two-dimensional table where all values share one type |
| Data frame | Tabular object: a list of equal-length vectors, columns may differ in type |
| Tibble | The tidyverse version of a data frame (what dplyr returns) |
| NA / `na.rm = TRUE` | Missing value / drop missing values before calculating |
| Working directory | Folder R reads files from; in R Markdown it is the folder holding the `.Rmd` |
| Comment | Text after `#`, ignored by R |
| Markup language | Uses symbols to format text (Markdown, HTML); it does not run computations |
| Markdown | Lightweight markup language (2004) for plain-text formatting |
| R Markdown | `.Rmd` file mixing YAML, Markdown text and R code chunks |
| YAML header | Block at the top of an `.Rmd` (title, author, date, output) controlling the knitted file |
| Code chunk | Block of R code inside an `.Rmd`; behavior set with options like `echo` and `eval` |
| Knit | Run the chunks and render the `.Rmd` into HTML, PDF or Word |
| Git / GitHub | Version control system / online platform hosting Git repositories |
| Pipe `%>%` | Passes the result of one function into the next; read as "then" |
| Tidy data | Each row is an observation, each column a variable |
| Variable | A characteristic being observed or measured |
| Quantitative variable | Measurable amount: continuous (any value in a range, e.g. weight) or discrete (whole-number counts) |
| Qualitative variable | Category: nominal (no order, e.g. color), ordinal (ordered, e.g. Likert scale) |
| Grammar of Graphics | Wilkinson's framework: a plot is data + aesthetics + geoms + stats + scales, coords, facets, theme |
| Aesthetic (`aes`) | Mapping of a variable to x, y, color, fill, size, shape, alpha |
| Geom | The visual mark: points, bars, lines, histogram |
| Facet | Splitting a plot into small-multiple panels by a variable |
| Median, IQR, outlier | Middle value; Q3 minus Q1; point beyond 1.5 x IQR from the box |
| Shapiro-Wilk | Test of normality; p < 0.05 means data are not normal |
| Spearman correlation | Rank-based (monotonic) correlation; useful when data are not normal |
| ANOVA (`aov`) | Tests whether group means differ; assumes normal residuals and equal variances |
| Bartlett test | Tests whether variances are equal across groups; p < 0.05 means unequal |

## 8. RTutorials 1–3 with worked answers

The tutorials are submitted as knitted HTML from an `.Rmd`; each question is answered in an R chunk. Tutorial 2 asks for at least 6 rows of output (`head(..., 6)`). The answers below are mine, not the instructor's key.

### RTutorial 1: basics and chunk options (10 questions)

```r
height <- 175; height                  # Q1
25 * 4 - 10                            # Q2  -> 90
sqrt(81)                               # Q3  -> 9
message <- "R is fun!"; message        # Q4
a <- 10; b <- 5; c <- a + b; c         # Q5  -> 15
15 > 20                                # Q6  -> FALSE
class("Hello World")                   # Q7  -> "character"
grades <- c(80, 90, 75, 95, 85)        # Q10
average <- mean(grades); average       #     -> 85
```

Q8 and Q9 change the chunk header, not the code:

````markdown
```{r warning=FALSE}
log(-1)          # Q8: hides "NaNs produced"
```

```{r message=FALSE}
library(dplyr)   # Q9: hides "Attaching package" messages
```
````

### RTutorial 2: dplyr with gapminder (10 questions)

```r
library(dplyr); library(gapminder); data(gapminder)

class(gapminder)                                              # Q1 "tbl_df" "tbl" "data.frame"
gapminder %>% filter(lifeExp < 29) %>% head(6)                # Q2
gapminder %>% filter(country == "Rwanda", year > 1979) %>% head(6)   # Q3
gapminder %>% select(-gdpPercap) %>% head(6)                  # Q4
gapminder %>% arrange(lifeExp) %>% head(6)                    # Q5 ascending
gapminder %>% arrange(desc(lifeExp)) %>% head(6)              # Q6 descending
gapminder %>% select(year, lifeExp) %>% head(6)               # Q7
gapminder %>% filter(country == "Cambodia") %>%
  select(year, lifeExp) %>% head(6)                           # Q8
gapminder %>% filter(continent == "Africa") %>% head(6)       # Q9
gapminder %>% mutate(lifeExp_months = lifeExp * 12) %>% head(6)      # Q10
```

Q4 saved as a new dataset: `gap_no_gdp <- gapminder %>% select(-gdpPercap)`. Q9 asks to "select" countries in Africa, which is a row filter on `continent`; add `%>% distinct(country)` to list each country once.

### RTutorial 3: ggplot2 and normality with `trees` (5 questions)

```r
library(ggplot2); data("trees"); head(trees)

ggplot(trees, aes(x = Girth)) + geom_histogram(bins = 10, fill = "steelblue", color = "white")   # Q1
ggplot(trees, aes(x = Volume)) + geom_histogram(bins = 10, fill = "steelblue", color = "white")  # Q2
ggplot(trees, aes(x = Girth, y = Volume)) + geom_point()      # Q3 scatterplot
shapiro.test(trees$Volume)                                    # Q4
shapiro.test(trees$Girth)                                     # Q5
```

| Variable | W | p-value | Conclusion at 0.05 |
| --- | --- | --- | --- |
| Volume | 0.888 | 0.0036 | p < 0.05, reject normality: not normally distributed |
| Girth | 0.941 | 0.089 | p > 0.05, cannot reject normality: consistent with a normal distribution |

I computed these two Shapiro-Wilk results independently from the 31-row `trees` data (Python, same algorithm as R's `shapiro.test`); run them in R to confirm the printed output.

## 9. Extra practice exercises with answers

Each block lists the question as a comment, then the answer. Datasets are ones used in class (`penguins` from palmerpenguins, `mpg`, `trees`, `starwars`, `gapminder`) or built into R.

### A. R basics

```r
# 1. Make a vector 2, 4, 6, 8, 10. Find its mean and sum.
x <- c(2, 4, 6, 8, 10); mean(x)   # 6
sum(x)                            # 30

# 2. Pull the 3rd element, elements 2 to 4, and values greater than 5.
x[3]          # 6
x[2:4]        # 4 6 8
x[x > 5]      # 6 8 10

# 3. Classes of 5L, TRUE, factor("a"), matrix(1:4, 2).
class(5L)               # "integer"
class(TRUE)             # "logical"
class(factor("a"))      # "factor"
class(matrix(1:4, 2))   # "matrix" "array"

# 4. What does c(1, "a", TRUE) return? (a vector holds ONE type)
c(1, "a", TRUE)         # "1" "a" "TRUE"  (coerced to character)

# 5. Build a data frame (species A, B, C; mass 10, 20, 30); get the mass column and row 2.
df <- data.frame(species = c("A", "B", "C"), mass = c(10, 20, 30))
df$mass       # 10 20 30
df[2, ]       # B, 20

# 6. Write celsius_to_fahrenheit() and test with 100.
celsius_to_fahrenheit <- function(temp_C) {
  temp_F <- temp_C * 9 / 5 + 32
  return(temp_F)
}
celsius_to_fahrenheit(100)   # 212

# 7. You run `3 +` and the console shows `+`. Why, and how do you recover?
# R is waiting for more input (incomplete command). Press Esc.
```

### B. R Markdown

````markdown
# 1. Write: a level-2 heading, one bold word, a bullet list, and a link.
## Results
This is **important**.
- item one
- item two
[R project](https://www.r-project.org)

# 2. Run code, hide the code, show the plot:        ```{r echo=FALSE}
# 3. Run code, hide code AND output:                 ```{r include=FALSE}
# 4. Show code but do not run it:                    ```{r eval=FALSE}
# 5. Hide warnings / hide messages:                  ```{r warning=FALSE}  /  ```{r message=FALSE}
````

Shortcuts: insert chunk = Ctrl + Alt + I (Cmd + Option + I); knit = Ctrl + Shift + K. YAML fields: `title`, `author`, `date`, `output` (use `html_document`).

### C. dplyr with `penguins`

```r
library(dplyr); library(palmerpenguins)

# 1. Only Adelie penguins.
penguins %>% filter(species == "Adelie")
# 2. The 5 heaviest penguins.
penguins %>% arrange(desc(body_mass_g)) %>% slice_head(n = 5)
# 3. Mean body mass per species, ignoring NA.
penguins %>% group_by(species) %>% summarise(mean_mass = mean(body_mass_g, na.rm = TRUE))
# 4. How many penguins per island? (class output: Biscoe 168, Dream 124, Torgersen 52)
penguins %>% count(island)
# 5. New column: body mass in kg.
penguins %>% mutate(body_mass_kg = body_mass_g / 1000)
# 6. Keep only columns starting with "bill".
penguins %>% select(starts_with("bill"))
# 7. Label each bird "large" if heavier than 4000 g, else "small".
penguins %>% mutate(size = ifelse(body_mass_g > 4000, "large", "small"))
# 8. Gentoo with flippers longer than 220 mm; show species, island, flipper length.
penguins %>%
  filter(species == "Gentoo", flipper_length_mm > 220) %>%
  select(species, island, flipper_length_mm)
```

### D. Plots, ggplot2 and tests

```r
# 1. Base R histogram of trees$Height with 8 bins.
hist(trees$Height, breaks = 8, col = "lightblue", border = "white",
     main = "Tree height", xlab = "Height (ft)")
# 2. Base R boxplot of mpg by number of cylinders (built-in mtcars).
boxplot(mpg ~ cyl, data = mtcars, col = "lightgreen")
# 3. Base R scatter of Volume vs Girth with a dashed red regression line.
plot(trees$Girth, trees$Volume, xlab = "Girth", ylab = "Volume")
abline(lm(Volume ~ Girth, data = trees), col = "red", lty = 2)

# 4. ggplot scatter of hwy vs displ colored by drive type.
ggplot(mpg, aes(x = displ, y = hwy, color = drv)) + geom_point()
# 5. Same plot, one panel per vehicle class.
ggplot(mpg, aes(x = displ, y = hwy, color = drv)) + geom_point() + facet_wrap(~ class)
# 6. Bar chart of how many cars in each class.
ggplot(mpg, aes(x = class)) + geom_bar()
# 7. Histogram of hwy filled by drive type.
ggplot(mpg, aes(x = hwy, fill = drv)) + geom_histogram(bins = 15)
```

Short answers:

1. **Three required parts of every ggplot:** data, aesthetic mappings `aes()`, and a geom.
2. **`color` vs `fill`:** `color` is points and outlines; `fill` is the inside of areas (bars, histograms).
3. **Global vs local `aes()`:** inside `ggplot()` it applies to all geoms; inside one geom it applies only to that layer.
4. **`geom_col()` vs `geom_bar()`:** `geom_col()` plots values you already have; `geom_bar()` counts observations for you.
5. **A Shapiro-Wilk test gives p = 0.03.** Reject the null of normality (p < 0.05): the data are not normal, so prefer a rank method such as Spearman.
6. **Bartlett test gives p = 0.30.** Cannot reject equal variances, so the ANOVA homogeneity assumption holds.
7. **Boxplot reading:** line = median, box = Q1 to Q3, whiskers reach 1.5 x IQR, dots beyond are outliers.

### Common mistakes to scan for before you submit

- `=` vs `==` vs `<-`: assignment is `<-`, comparison is `==`.
- In ggplot2 the `+` goes at the END of a line, never the start; same for `%>%`.
- Forgetting `library(...)` in the current session, or a package not installed.
- Missing values: add `na.rm = TRUE` to `mean()`, `median()`, `sd()`, `min()`, `max()`.
- Case sensitivity (`Height` is not `height`) and wrong column names (`body_mass` vs `body_mass_g`).
- Unclosed quote, parenthesis or bracket (console shows `+`).
- Data file not found: path must be relative to the `.Rmd` folder.
