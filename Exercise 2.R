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
# fit a random-effects model and do publication bias analyses
# first we fit the random-effects model
mod <- rma(yi, vi, data=df_red_female)
mod
# what do you conclude?

# now let's make a funnel plot
funnel(mod)
# what do you conclude?

# there is a statistical test that tests funnel plot asymmetry
# a significant result suggest asymmetry
# let's try it
regtest(mod, model="rma", predictor="sei", ret.fit=FALSE)
# what do you conclude

# we can also look at moderation
# suppose the effect size is smaller in studies we have more confidence in?
# what variable in the dataset could be an indication of study quality?

# moderation is tested with:
mod <- rma(yi~NAME_OF_MODERATOR, vi, data=df_red_female)
mod

# more time left?
# see if you can make the funnel plot prettier
# check out https://wviechtb.github.io/metafor/reference/funnel.html
# to see how you can improve the plot