library(tidyverse)

# handy function of the week

############
# complete #
############

# found this when I was doing all sort of ridicious cross joins
# this makes things far far simpler

df <- starwars

# filter our data frame
df <- df |>
  filter(species %in% c('Human', 'Gungan'))

# let have a quick look at it

# lets pull a summary of species and gender
df_sum <- df |>
  summarise(num = n(), .by = c('species', 'gender'))

# the .by is the same as doing a group_by

# we have a summary but we do not have a row saying at that there are no female 
# gungans, that row is simply omitted - maybe we want the results in a table or
# something, this can be annoying.

# <<<< COMPLETE!!! >>>>

df_sum_complete <- df |>
  summarise(num = n(), .by = c('species', 'gender')) |>
  complete(species, gender)

# this fills in our data frame with any missing groups 
# however our missing groups are na
# lets give them a default

df_sum_complete_with_default <- df |>
  summarise(num = n(), .by = c('species', 'gender')) |>
  complete(species, gender, fill = list(num = 0))

# another example            
# eg with time series with missing dates

library(NHSRdatasets)

df <- ae_attendances

df <- df |>
  filter(org_code %in% c('RWW', 'RXC'),
         type == 'other') |>
  mutate(org_code = as.character(org_code))

# use complete to fill in blanks of dates and org codes
df_complete <- df |>
  complete(period, org_code)

# give each missing na a difference default value
df_complete_fill <- df |>
  complete(period, org_code, 
           fill = list(type = '1',
                       attendances = 0,
                       breaches = 0,
                       admissions = 999999))




