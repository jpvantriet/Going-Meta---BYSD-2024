### BOOST YOUR SKILLS DAY - 2024 ###
### Exercises derived from work by Wolfgang Viechtbauer
### see https://www.wvbauer.com/doku.php/home
### and see https://www.metafor-project.org/doku.php/metafor

### Step 1 ----------------------------------------------------
### install and activate metadat and metafor
install.packages("metadat")
install.packages("metafor")
library(metadat)
library(metafor)
### metadat is a package containing a large number of meta-analytic datasets
### metafor is a package containing a large number of functions requiered for meta-analysis

### Step 2 ----------------------------------------------------
# pick out a dataset
# copy in df_ objects and examine them
df_generation <- dat.mccurdy2020
head(df_generation)
# The generation effect is a cognitive phenomenon that describes the enhanced learning and recall of information
# when individuals actively generate or create that information themselves, as opposed to passively receiving it.
# https://wviechtb.github.io/metadat/reference/dat.mccurdy2020.html
# yi = mean recall rate for the condition
# vi =	numeric	corresponding sampling variance

### Step 3 ------------------------------------------------------
# fit a random-effects model and do moderator analyses
# first we fit the random-effects model
mod <- rma(yi ~ condition, vi, data=df_generation)
mod
# what do you conclude?

# we can test moderation with:
mod_moderation <- rma(yi ~ condition + NAME_OF_MODERATOR + condition:NAME_OF_MODERATOR, vi, data=df_generation)
mod_moderation

# which variables would you like to test as moderators?
# see https://wviechtb.github.io/metadat/reference/dat.mccurdy2020.html
# for a list of variables included in the study
# what do you conclude from the results?

### Step 4 ------------------------------------------------------
# actually, the data is more complicated than we've let on
# in reality, effect sizes are clustered within experiments/article/samples
# for instance: multiple effect sizes per study or multiple comparisons per study

### fit multilevel mixed-effects meta-regression model
mod_multilevel <- rma.mv(yi, vi, mods = ~ condition,
               random = list(~ 1 | article/experiment/sample/id, ~ 1 | pairing),
               data=df_generation, sparse=TRUE, digits=3)
mod_multilevel
### proportion of total amount of heterogeneity due to each component
data.frame(source=mod_multilevel$s.names, sigma2=round(res$sigma2, 3),
           prop=round(res$sigma2 / sum(res$sigma2), 2))

# can you understand what we mean by "clustered within experiments/article/samples"?
# how do you interpret the results of the analyses allocating the heterogeneity to each component? 