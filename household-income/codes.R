setwd("~/GitHub/data-visualisation/household-income/")
dir()

##
# load libraries ----
##

library(tidyr); library(dplyr); library(stringr)
library(ggplot2); library(ggvis)
library(knitr)
# library(XLConnect); library(xlsx)

##
# Average Income by Decile ====
##

##
# read data ----
##

# read xls
# income.decile <- read.table("Average Monthly Household Income from Work excluding Employer CPF Contributions Among Resident Employed Households by Deciles.xls",
#                             skip = 4)
# income.decile <- income.decile[, -2]
# income.average <- read.table('Average and Median Monthly Household Income from Work Among Resident Employed Households.xls',
#                              skip = 4)
# income.average <- income.average[, -(2:3)]

# add column names
# names(income.decile) <- c('year', paste0('decile.', 1:10))
# names(income.average) <- c('year', 'mean', 'median')

# write tsv
# write.table(income.decile,
#             "average_monthly_household_income_by_deciles.txt",
#             row.names = F)
# write.table(income.average,
#             "average_and_median_monthly_household_income.txt",
#             row.names = F)

# read tsv
income.decile <- read.table('average_monthly_household_income_by_deciles.txt',
                            header = T)
income.average <- read.table('average_and_median_monthly_household_income.txt',
                             header = T)

##
# data transformation ----
##

# reshape to long format
# income.average <- gather(income.average, measure, income, -year)
income.decile <- gather(income.decile, decile, income, -year)

# add proportion numbers
income.average <- mutate(income.average, mean.median.ratio = mean / median)
income.decile <- mutate(income.decile,
                        decile = as.numeric(str_extract(decile, '\\d+')),
                        population.cumprop = decile / 10)
income.average <- income.average %>%
    select(year, mean, median) %>%
    gather(decile, income, -year)
income.decile <- rbind(income.decile, income.average)
income.decile <- mutate(income.decile, strokeWidth = ifelse(decile %in% c('mean', 'median'), 2, 1))
income.decile <- income.decile %>%
                    group_by(year) %>%
                    arrange(decile) %>%
                    mutate(income.prop = income / sum(income),
                           income.cumprop = cumsum(income.prop),
                           bottom.multiple = income / first(income)) %>%
                    ungroup()
income.decile <- income.decile %>%
    group_by(decile) %>%
    arrange(year) %>%
    mutate(index.2000 = income / first(income)) %>%
    ungroup()

##
# visualisation ----
##

# mean and median
# line graph
income.average %>%
    select(year, mean, median) %>%
    ggvis(~factor(year)) %>%
    layer_lines(y = ~mean, stroke = "Mean") %>%
    layer_lines(y = ~median, stroke = "Median") %>%
    add_axis('x', title = 'Year') %>%
    add_axis('y', title = 'Income', title_offset = 60) %>%
    add_legend('stroke', title = 'Measure')

income.average %>%
    select(year, mean.median.ratio) %>%
    ggvis(~factor(year), ~mean.median.ratio) %>%
    layer_lines() %>%
    add_axis('x', title = 'Year') %>%
    add_axis('y', title = 'Mean-Median Ratio', title_offset = 50)

# income.average %>%
#     select(year, measure, income) %>%
#     ggvis(~factor(year), ~income, stroke = ~measure) %>%
#     layer_lines() %>%
#     add_axis('x',
#              title = 'Year') %>%
#     add_axis('y',
#              title = 'Income',
#              title_offset = 60) %>%
#     add_legend('stroke',
#                title = 'Measure')

# income
# line graph
income.decile %>%
    select(year, decile, income) %>%
    ggvis(~factor(year), ~income, stroke = ~factor(decile)) %>%
    layer_lines() %>%
    add_axis('x',
             title = 'Year') %>%
    add_axis('y',
             title = 'Average Income',
             title_offset = 60) %>%
    add_legend('stroke',
               title = 'Decile')

# percentage
# line graph
income.decile %>%
    ggvis(~factor(year), ~income.prop, stroke = ~factor(decile)) %>%
    group_by() %>%
    layer_lines() %>%
    add_axis('x',
             title = 'Year') %>%
    add_axis('y',
             title = 'Income Proportion',
             title_offset = 40) %>%
    add_legend('stroke',
               title = 'Decile')

# stacked area
income.decile %>%
    group_by(year) %>%
    mutate(to = income.cumprop, from = c(0, to[-n()])) %>%
    ggvis(x = ~factor(year), fill = ~factor(decile), opacity := 0.8) %>%
    group_by(decile) %>%
    layer_ribbons(y = ~from, y2 = ~to) %>%
    add_axis('x',
             title = 'Year') %>%
    add_axis('y',
             title = 'Cumulative Income Proportion') %>%
    add_legend('fill',
               title = 'Decile')

# Lorenz curve
income.decile %>%
    select(year, population.cumprop, income.cumprop) %>%
    rbind(data.frame(year = 2000:2013, population.cumprop = 0, income.cumprop = 0)) %>%
    rbind(data.frame(year = NA, population.cumprop = c(0, 1), income.cumprop = c(0, 1))) %>%
    ggvis(~population.cumprop, ~income.cumprop, stroke = ~factor(year)) %>%
#     ggvis() %>%
#     layer_ribbons(x = ~x, y = ~0, y2 = ~y, data = data.frame(x = c(0, 1), y = c(0, 1))) %>%
#     ggvis(~population.cumprop, ~income.cumprop, stroke = ~factor(year)) %>%
#     add_data(income.decile) %>%
    layer_lines(~population.cumprop, ~income.cumprop, stroke = ~factor(year)) %>%
    add_axis('x',
             title = 'Cumulative Population Proportion') %>%
    add_axis('y',
             title = 'Cumulative Income Proportion',
             title_offset = 60) %>%
    add_legend('stroke',
               title = 'Year',
               values = 2000:2013)

# income multiple
income.decile %>%
    select(year, decile, bottom.multiple) %>%
    ggvis(~factor(year), ~bottom.multiple, stroke = ~factor(decile)) %>%
    layer_lines() %>%
    add_axis('x',
             title = 'Year') %>%
    add_axis('y',
             title = 'Multiple',
             title_offset = 60) %>%
    add_legend('stroke',
               title = 'Decile')

## 
# quintile ----
##

income.decile <- mutate(income.decile, quintile = (decile + 1) %/% 2)
income.quintile <- income.decile %>%
                        group_by(year, quintile) %>%
                        summarise(income = mean(income)) %>%
                        ungroup()
income.quintile <- income.quintile %>%
    group_by(year) %>%
    arrange(quintile) %>%
    mutate(bottom.multiple = income / first(income)) %>%
    ungroup()

# income multiple
income.quintile %>%
    select(year, quintile, bottom.multiple) %>%
    ggvis(~factor(year), ~bottom.multiple, stroke = ~factor(quintile)) %>%
    layer_lines() %>%
    add_axis('x',
             title = 'Year') %>%
    add_axis('y',
             title = 'Multiple',
             title_offset = 60) %>%
    add_legend('stroke',
               title = 'Quintile')

##
# Population Distribution by Income ----
##

##
# read data ====
##

# income.distribution <- read.table('Resident Households by Monthly Household Income from Work excluding Employer CPF Contributions.xls',
#                                   skip = 3)
# income.distribution <- income.distribution[, -c(2, 4)]

# add column names
# breaks <- c(0:15, 17.5, 20)
# names(income.distribution) <- c('year', 'unemployed', paste0('from.', breaks, 'k'))

# write tsv
# write.table(income.distribution,
#             'households-by-monthly-income.txt',
#             row.names = F)

# read tsv
income.distribution <- read.table('households-by-monthly-income.txt',
                                  header = T, check.names = F)

##
# data transformation ====
##

# convert to long format
income.distribution <- income.distribution %>%
                            gather(income, percentage, -year)

# exclude unemployed
income.distribution <- income.distribution %>%
                            filter(income != 'unemployed') %>%
                            droplevels() %>%
                            group_by(year) %>%
                            mutate(proportion = percentage / sum(percentage)) %>%
                            ungroup()

# rename income labels
# breaks <- c(0:15, 17.5, 20, Inf) * 1000
# income.distribution <- mutate(income.distribution,
#                               income = factor(income, labels = paste0('[', breaks[-19], ', ', breaks[-1], ')')))

##
# visualisation ====
##

# line graph
income.distribution %>%
    ggvis(~factor(year), ~proportion, stroke = ~income) %>%
    layer_lines() %>%
    add_axis('x',
         title = 'Year') %>%
    add_axis('y',
             title = 'Population Proportion',
             title_offset = 40) %>%
    add_legend('stroke',
               title = 'Income Group')

income.distribution %>%
    filter(income %in% levels(income)[1:7]) %>%
    droplevels() %>%
    ggvis(~factor(year), ~proportion, stroke = ~income) %>%
    layer_lines() %>%
    add_axis('x',
             title = 'Year') %>%
    add_axis('y',
             title = 'Population Proportion',
             title_offset = 40) %>%
    add_legend('stroke',
               title = 'Income Group')

income.distribution %>%
    filter(income %in% levels(income)[8:18]) %>%
    droplevels() %>%
    ggvis(~factor(year), ~proportion, stroke = ~income) %>%
    layer_lines() %>%
    add_axis('x',
             title = 'Year') %>%
    add_axis('y',
             title = 'Population Proportion',
             title_offset = 40) %>%
    add_legend('stroke',
               title = 'Income Group')

# stacked area
income.distribution %>%
    group_by(year) %>%
    mutate(to = cumsum(proportion), from = c(0, to[-n()])) %>%
    ggvis(x = ~factor(year), 
          fill = ~factor(income), 
          opacity := 0.8) %>%
    group_by(income) %>%
    layer_ribbons(y = ~from, y2 = ~to) %>%
    add_axis('x',
             title = 'Year') %>%
    add_axis('y',
             title = 'Cumulative Population Proportion') %>%
    add_legend('fill',
               title = 'Income Group')

# distribution by income
income.distribution %>%
    ggvis(~income, ~proportion, stroke = ~factor(year)) %>%
    group_by(year) %>%
    layer_lines() %>%
    add_axis('x', title = 'Income Group', title_offset = 50,
             properties = axis_props(labels = list(angle = 20, align = 'left'))) %>%
    add_axis('y', title = 'Population Proportion', title_offset = 40) %>%
    add_legend('stroke', title = 'Year')

###
# knitr
###

knit2html('household-income.Rmd')
