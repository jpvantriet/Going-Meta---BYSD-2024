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
df_red <- dat.lehmann2018
head(df_red)
# The red-romance hypothesis: does the color red enhances heterosexual attraction in romantic contexts
# https://wviechtb.github.io/metadat/reference/dat.lehmann2018.html
# yi = Standardized mean difference
# vi =	Corresponding sampling variance

# let's look at the red-romance hypothesis among female participants only
df_red_female <- df_red[df_red$Gender == "Females", ]

### Step 3 ------------------------------------------------------
# fit a random-effects model and make a forest plot
# first we fit the random-effects model
mod <- rma(yi, vi, data=df_red_female)
mod
# what do you conclude?

# now let's make the forest plot
forest(mod)

# okay, this looks awful
# for starters, let's add some useful labels for the studies
forest(mod, slab = Short_Title)

# still not great - let's make it nicer
# check https://wviechtb.github.io/metafor/reference/forest.rma.html
# and https://www.metafor-project.org/doku.php/plots:forest_plot
# to see if you can make the plot prettier