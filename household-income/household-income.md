# Visualisation of Household Income Data of Singapore
YuXuan Tay  
Sunday, February 08, 2015  



## Introduction

In this exercise, I will attempt to create a few visualisation of the household income data of Singapore.
The purpose of this exercise is to gain an understanding of the income distribution and trend in Singapore.
Plots will be drawn with the `ggvis` visualisation package, which produces SVG graphics.
This means they will be scalable to the reader's discretion.

The data is obtained from [data.gov.sg](http://data.gov.sg/), 
which is the national database for public government data. 
Specifically, I will be exploring the average household income and distribution data prepared by the
Singapore Department of Statistics ([SingStats](http://www.singstat.gov.sg/)). The data contained information in the years 2000 to 2013.

## Data


```r
# load libraries
library(tidyr); library(dplyr); library(stringr)
library(ggplot2); library(ggvis)
library(knitr)
```

The 3 main datasets I will be looking at are as follows:

- average and median monthly household income
- average monthly household income by deciles
- households by monthly household income

SingStats prepared a few similar datasets depending on the definitions of households and income.
For households, the following definitions are available:

- resident households
- resident **employed** households
- resident households **per household member**
- resident **employed** households **per household member**

For income,

- income **including** employer CPF contributions
- income **excluding** employer CPF contributions

For consistency, I have used the datasets for resident employed households 
and for income excluding employer CPF contributions. 
That is because I am interested in the income distribution of Singapore and would like to exclude the unemloyed.
Excluding employer CPF contributions would be to do a fair comparison since foreigners are also included
and they do not receive these contributions.

## Average and Median Monthly Household Income

Let's first look at the average and median monthly household income.
All the data presented in this page is obtained directly from the [data.gov.sg](https://data.gov.sg) website
with minimal processing to format the column names and save it into tab-separated text files.
Note that the income amounts presented are nominal numbers without accounting for inflation.


```r
income.average <- read.table('average_and_median_monthly_household_income.txt', header = T)
kable(income.average, caption = 'Table of Mean and Median Household Income')
```



Table: Table of Mean and Median Household Income

 year   mean   median
-----  -----  -------
 2000   5456     4000
 2001   5736     4141
 2002   5572     4038
 2003   5618     4050
 2004   5761     4106
 2005   6052     4345
 2006   6280     4495
 2007   6889     4883
 2008   7752     5475
 2009   7549     5398
 2010   8058     5704
 2011   8864     6286
 2012   9515     6712
 2013   9597     7000

### Mean and Median Income Levels

Let's look at how this appears in a graph.


```r
income.average %>%
    select(year, mean, median) %>%
    ggvis(~factor(year)) %>%
    layer_lines(y = ~mean, stroke = "Mean") %>%
    layer_lines(y = ~median, stroke = "Median") %>%
    add_axis('x', title = 'Year') %>%
    add_axis('y', title = 'Income', title_offset = 60) %>%
    add_legend('stroke', title = 'Measure')
```

<!--html_preserve--><div id="plot_id354838499-container" class="ggvis-output-container">
<div id="plot_id354838499" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id354838499_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id354838499" data-renderer="svg">SVG</a>
 | 
<a id="plot_id354838499_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id354838499" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id354838499_download" class="ggvis-download" data-plot-id="plot_id354838499">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id354838499_spec = {
    "data": [
        {
            "name": ".0/arrange1",
            "format": {
                "type": "csv",
                "parse": {
                    "mean": "number"
                }
            },
            "values": "\"factor(year)\",\"mean\"\n\"2000\",5456\n\"2001\",5736\n\"2002\",5572\n\"2003\",5618\n\"2004\",5761\n\"2005\",6052\n\"2006\",6280\n\"2007\",6889\n\"2008\",7752\n\"2009\",7549\n\"2010\",8058\n\"2011\",8864\n\"2012\",9515\n\"2013\",9597"
        },
        {
            "name": ".0/arrange2",
            "format": {
                "type": "csv",
                "parse": {
                    "median": "number"
                }
            },
            "values": "\"factor(year)\",\"median\"\n\"2000\",4000\n\"2001\",4141\n\"2002\",4038\n\"2003\",4050\n\"2004\",4106\n\"2005\",4345\n\"2006\",4495\n\"2007\",4883\n\"2008\",5475\n\"2009\",5398\n\"2010\",5704\n\"2011\",6286\n\"2012\",6712\n\"2013\",7000"
        },
        {
            "name": "scale/stroke",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"Mean\"\n\"Median\""
        },
        {
            "name": "scale/x",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"2000\"\n\"2001\"\n\"2002\"\n\"2003\"\n\"2004\"\n\"2005\"\n\"2006\"\n\"2007\"\n\"2008\"\n\"2009\"\n\"2010\"\n\"2011\"\n\"2012\"\n\"2013\""
        },
        {
            "name": "scale/y",
            "format": {
                "type": "csv",
                "parse": {
                    "domain": "number"
                }
            },
            "values": "\"domain\"\n3720.15\n9876.85"
        }
    ],
    "scales": [
        {
            "name": "stroke",
            "type": "ordinal",
            "domain": {
                "data": "scale/stroke",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "category10"
        },
        {
            "name": "x",
            "type": "ordinal",
            "domain": {
                "data": "scale/x",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "width",
            "padding": 0.5
        },
        {
            "name": "y",
            "domain": {
                "data": "scale/y",
                "field": "data.domain"
            },
            "zero": false,
            "nice": false,
            "clamp": false,
            "range": "height"
        }
    ],
    "marks": [
        {
            "type": "line",
            "properties": {
                "update": {
                    "x": {
                        "scale": "x",
                        "field": "data.factor(year)"
                    },
                    "y": {
                        "scale": "y",
                        "field": "data.mean"
                    },
                    "stroke": {
                        "scale": "stroke",
                        "value": "Mean"
                    }
                },
                "ggvis": {
                    "data": {
                        "value": ".0/arrange1"
                    }
                }
            },
            "from": {
                "data": ".0/arrange1"
            }
        },
        {
            "type": "line",
            "properties": {
                "update": {
                    "x": {
                        "scale": "x",
                        "field": "data.factor(year)"
                    },
                    "y": {
                        "scale": "y",
                        "field": "data.median"
                    },
                    "stroke": {
                        "scale": "stroke",
                        "value": "Median"
                    }
                },
                "ggvis": {
                    "data": {
                        "value": ".0/arrange2"
                    }
                }
            },
            "from": {
                "data": ".0/arrange2"
            }
        }
    ],
    "width": 768,
    "height": 576,
    "legends": [
        {
            "orient": "right",
            "title": "Measure",
            "stroke": "stroke"
        }
    ],
    "axes": [
        {
            "type": "x",
            "scale": "x",
            "orient": "bottom",
            "title": "Year",
            "layer": "back",
            "grid": true
        },
        {
            "type": "y",
            "scale": "y",
            "orient": "left",
            "title": "Income",
            "titleOffset": 60,
            "layer": "back",
            "grid": true
        }
    ],
    "padding": null,
    "ggvis_opts": {
        "keep_aspect": false,
        "resizable": true,
        "padding": {

        },
        "duration": 250,
        "renderer": "svg",
        "hover_duration": 0,
        "width": 768,
        "height": 576
    },
    "handlers": null
}
;
ggvis.getPlot("plot_id354838499").parseSpec(plot_id354838499_spec);
</script><!--/html_preserve-->

A few observations can be made. From year 2000 to 2004, the average income levels were quite flat. 
This was possibly due to the dot-com bust, which led to a recession in Singapore. 
From 2004 onwards, income levels increased quickly except during 2009 due to the subprime mortgage crisis.

Another observation is that the mean income is substantially higher than the median income.
This is one of the arguments why mean income is not a good indicator of income levels in a country.
Mean income is not a robust measure of average as it is affected by extreme values.
A right-skewed income distribution will shift the mean income level even though 
this does not mean an elevated income for the majority of the population.
The skewed income distribution of Singapore will be more evident later when we explore the average income by deciles.
In general, it is always a good idea to be wary of mean or average values if the distribution of 
the variable is not clearly known.

On the other hand, the median income level gives the amount that separates the population of
income earners into half: 50% of them earn less than the median level and the other 50% earn more.
It is robust to extreme values since changes at both ends of the distribution do not affect it.


```r
income.average <- mutate(income.average,
                         mean.index.2000 = mean / first(mean),
                         median.index.2000 = median / first(median))
```

The nominal mean and median income levels have grown by 
75.9% and
75% respectively
in the 13-year period, with a compounded annual growth of
4.44% and
4.4% respectively.

### Ratio of Mean to Median Income Levels

Let us now examine the ratio of mean to median levels across the years.


```r
# compute mean-median ratio
income.average <- mutate(income.average, mean.median.ratio = mean / median)
income.average %>%
    select(year, mean.median.ratio) %>%
    ggvis(~factor(year), ~mean.median.ratio) %>%
    layer_lines() %>%
    add_axis('x', title = 'Year') %>%
    add_axis('y', title = 'Mean-Median Ratio', title_offset = 50)
```

<!--html_preserve--><div id="plot_id275550757-container" class="ggvis-output-container">
<div id="plot_id275550757" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id275550757_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id275550757" data-renderer="svg">SVG</a>
 | 
<a id="plot_id275550757_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id275550757" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id275550757_download" class="ggvis-download" data-plot-id="plot_id275550757">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id275550757_spec = {
    "data": [
        {
            "name": ".0/arrange1",
            "format": {
                "type": "csv",
                "parse": {
                    "mean.median.ratio": "number"
                }
            },
            "values": "\"factor(year)\",\"mean.median.ratio\"\n\"2000\",1.364\n\"2001\",1.38517266360782\n\"2002\",1.37989103516592\n\"2003\",1.38716049382716\n\"2004\",1.40306867998052\n\"2005\",1.39286536248562\n\"2006\",1.39710789766407\n\"2007\",1.41081302477985\n\"2008\",1.4158904109589\n\"2009\",1.39848091885884\n\"2010\",1.41269284712482\n\"2011\",1.41011772192173\n\"2012\",1.41761025029797\n\"2013\",1.371"
        },
        {
            "name": "scale/x",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"2000\"\n\"2001\"\n\"2002\"\n\"2003\"\n\"2004\"\n\"2005\"\n\"2006\"\n\"2007\"\n\"2008\"\n\"2009\"\n\"2010\"\n\"2011\"\n\"2012\"\n\"2013\""
        },
        {
            "name": "scale/y",
            "format": {
                "type": "csv",
                "parse": {
                    "domain": "number"
                }
            },
            "values": "\"domain\"\n1.3613194874851\n1.42029076281287"
        }
    ],
    "scales": [
        {
            "name": "x",
            "type": "ordinal",
            "domain": {
                "data": "scale/x",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "width",
            "padding": 0.5
        },
        {
            "name": "y",
            "domain": {
                "data": "scale/y",
                "field": "data.domain"
            },
            "zero": false,
            "nice": false,
            "clamp": false,
            "range": "height"
        }
    ],
    "marks": [
        {
            "type": "line",
            "properties": {
                "update": {
                    "stroke": {
                        "value": "#000000"
                    },
                    "x": {
                        "scale": "x",
                        "field": "data.factor(year)"
                    },
                    "y": {
                        "scale": "y",
                        "field": "data.mean\\.median\\.ratio"
                    }
                },
                "ggvis": {
                    "data": {
                        "value": ".0/arrange1"
                    }
                }
            },
            "from": {
                "data": ".0/arrange1"
            }
        }
    ],
    "width": 768,
    "height": 576,
    "legends": [

    ],
    "axes": [
        {
            "type": "x",
            "scale": "x",
            "orient": "bottom",
            "title": "Year",
            "layer": "back",
            "grid": true
        },
        {
            "type": "y",
            "scale": "y",
            "orient": "left",
            "title": "Mean-Median Ratio",
            "titleOffset": 50,
            "layer": "back",
            "grid": true
        }
    ],
    "padding": null,
    "ggvis_opts": {
        "keep_aspect": false,
        "resizable": true,
        "padding": {

        },
        "duration": 250,
        "renderer": "svg",
        "hover_duration": 0,
        "width": 768,
        "height": 576
    },
    "handlers": null
}
;
ggvis.getPlot("plot_id275550757").parseSpec(plot_id275550757_spec);
</script><!--/html_preserve-->

At first glance, it seems that, except for 2013, the mean-median ratio has been in a general increasing trend, 
which means that high earners are growing their income faster than low earners. 
However, the increase has been relatively low, at
3.93%
over the 12-year period. This suggests that the income distribution might be quite consistent over the period.
I think including zero into the y-axis will make this more obvious, but have not figured out how to 
set the limits of the axes with `ggvis`. 
This is also the reason why the axes in all other plots are unadjusted even though 
it would be a good idea to include zero in the y-axis in a few other plots to give a right sense of scale.

## Average Monthly Household Income Distribution by Deciles

A better way to explore the income distribution is to look at the average monthly income by deciles.
Do note that in this data, the numbers are for the average income by deciles and **not** of income at decile levels.
In other words, the numbers for decile 1 is for the average income for the bottom 10 percentile of households,
and not the 10th percentile level of income.
The 10th percentile level of income would actually represent the maximum income of 
the bottom 10 percentile of household.


```r
income.decile <- read.table('average_monthly_household_income_by_deciles.txt', header = T)
kable(income.decile, caption = 'Table of Average Household Income by Decile')
```



Table: Table of Average Household Income by Decile

 year   decile.1   decile.2   decile.3   decile.4   decile.5   decile.6   decile.7   decile.8   decile.9   decile.10
-----  ---------  ---------  ---------  ---------  ---------  ---------  ---------  ---------  ---------  ----------
 2000       1285       2062       2737       3367       4097       4830       5773       6919       8631       14862
 2001       1209       2040       2717       3434       4149       5015       5971       7365       9557       15905
 2002       1151       1956       2627       3312       4043       4884       5891       7187       9144       15524
 2003       1112       1942       2668       3330       4103       4981       5936       7273       9142       15688
 2004       1140       2009       2721       3431       4200       4978       6005       7256       9443       16425
 2005       1162       2064       2833       3645       4390       5301       6458       7846       9797       17021
 2006       1165       2114       2903       3673       4514       5477       6535       8046      10203       18170
 2007       1223       2218       3078       3950       4870       5962       7234       8694      11491       20174
 2008       1300       2464       3464       4420       5455       6753       8107       9849      12916       22797
 2009       1264       2462       3436       4495       5391       6601       7972       9733      12354       21784
 2010       1385       2679       3759       4887       5959       7090       8450      10142      12887       23345
 2011       1460       2834       3988       5200       6303       7587       9147      11193      14307       26622
 2012       1518       2985       4290       5529       6800       8196       9806      11973      15038       29012
 2013       1574       3045       4467       5696       7135       8479      10159      12521      15609       27287

I would first do some transformation to the data to compute a few other variables of interest.
It would also be necessary for me to reshape it from wide to long format with the `tidyr` package.


```r
# convert to long format
income.decile <- gather(income.decile, decile, income, -year)
# convert decile from string into numeric values
income.decile <- mutate(income.decile,
                        decile = as.numeric(str_extract(decile, '\\d+')))
# merge average dataset with decile dataset
income.average <- income.average %>%
                    select(year, mean, median) %>%
                    gather(decile, income, -year)
income.decile <- rbind(income.decile, income.average)
# format factor values
income.decile <- mutate(income.decile, decile = factor(decile, levels = c(1:10, 'mean', 'median')))
```

### Line Graph of Average Income by Deciles

This is how the original data looks like in a graph. 
The mean and median income levels have been included for comparisons.


```r
income.decile %>%
    select(year, decile, income) %>%
    mutate(strokeWidth = ifelse(decile %in% c('mean', 'median'), 2, 1),
           opacity = ifelse(decile %in% c('mean', 'median'), 0.7, 1)) %>%
    ggvis(~factor(year), ~income, stroke = ~factor(decile), 
          strokeWidth := ~strokeWidth, opacity := ~opacity) %>%
    group_by(decile) %>%
    layer_lines() %>%
    add_axis('x', title = 'Year') %>%
    add_axis('y', title = 'Average Income', title_offset = 60) %>%
    add_legend(c('stroke', 'strokeWidth','opacity'), title = 'Decile')
```

<!--html_preserve--><div id="plot_id781160081-container" class="ggvis-output-container">
<div id="plot_id781160081" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id781160081_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id781160081" data-renderer="svg">SVG</a>
 | 
<a id="plot_id781160081_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id781160081" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id781160081_download" class="ggvis-download" data-plot-id="plot_id781160081">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id781160081_spec = {
    "data": [
        {
            "name": ".0/group_by1/group_by2/arrange3_flat",
            "format": {
                "type": "csv",
                "parse": {
                    "strokeWidth": "number",
                    "opacity": "number",
                    "income": "number"
                }
            },
            "values": "\"factor(decile)\",\"strokeWidth\",\"opacity\",\"factor(year)\",\"income\"\n\"1\",1,1,\"2000\",1285\n\"2\",1,1,\"2000\",2062\n\"3\",1,1,\"2000\",2737\n\"4\",1,1,\"2000\",3367\n\"5\",1,1,\"2000\",4097\n\"6\",1,1,\"2000\",4830\n\"7\",1,1,\"2000\",5773\n\"8\",1,1,\"2000\",6919\n\"9\",1,1,\"2000\",8631\n\"10\",1,1,\"2000\",14862\n\"mean\",2,0.7,\"2000\",5456\n\"median\",2,0.7,\"2000\",4000\n\"1\",1,1,\"2001\",1209\n\"2\",1,1,\"2001\",2040\n\"3\",1,1,\"2001\",2717\n\"4\",1,1,\"2001\",3434\n\"5\",1,1,\"2001\",4149\n\"6\",1,1,\"2001\",5015\n\"7\",1,1,\"2001\",5971\n\"8\",1,1,\"2001\",7365\n\"9\",1,1,\"2001\",9557\n\"10\",1,1,\"2001\",15905\n\"mean\",2,0.7,\"2001\",5736\n\"median\",2,0.7,\"2001\",4141\n\"1\",1,1,\"2002\",1151\n\"2\",1,1,\"2002\",1956\n\"3\",1,1,\"2002\",2627\n\"4\",1,1,\"2002\",3312\n\"5\",1,1,\"2002\",4043\n\"6\",1,1,\"2002\",4884\n\"7\",1,1,\"2002\",5891\n\"8\",1,1,\"2002\",7187\n\"9\",1,1,\"2002\",9144\n\"10\",1,1,\"2002\",15524\n\"mean\",2,0.7,\"2002\",5572\n\"median\",2,0.7,\"2002\",4038\n\"1\",1,1,\"2003\",1112\n\"2\",1,1,\"2003\",1942\n\"3\",1,1,\"2003\",2668\n\"4\",1,1,\"2003\",3330\n\"5\",1,1,\"2003\",4103\n\"6\",1,1,\"2003\",4981\n\"7\",1,1,\"2003\",5936\n\"8\",1,1,\"2003\",7273\n\"9\",1,1,\"2003\",9142\n\"10\",1,1,\"2003\",15688\n\"mean\",2,0.7,\"2003\",5618\n\"median\",2,0.7,\"2003\",4050\n\"1\",1,1,\"2004\",1140\n\"2\",1,1,\"2004\",2009\n\"3\",1,1,\"2004\",2721\n\"4\",1,1,\"2004\",3431\n\"5\",1,1,\"2004\",4200\n\"6\",1,1,\"2004\",4978\n\"7\",1,1,\"2004\",6005\n\"8\",1,1,\"2004\",7256\n\"9\",1,1,\"2004\",9443\n\"10\",1,1,\"2004\",16425\n\"mean\",2,0.7,\"2004\",5761\n\"median\",2,0.7,\"2004\",4106\n\"1\",1,1,\"2005\",1162\n\"2\",1,1,\"2005\",2064\n\"3\",1,1,\"2005\",2833\n\"4\",1,1,\"2005\",3645\n\"5\",1,1,\"2005\",4390\n\"6\",1,1,\"2005\",5301\n\"7\",1,1,\"2005\",6458\n\"8\",1,1,\"2005\",7846\n\"9\",1,1,\"2005\",9797\n\"10\",1,1,\"2005\",17021\n\"mean\",2,0.7,\"2005\",6052\n\"median\",2,0.7,\"2005\",4345\n\"1\",1,1,\"2006\",1165\n\"2\",1,1,\"2006\",2114\n\"3\",1,1,\"2006\",2903\n\"4\",1,1,\"2006\",3673\n\"5\",1,1,\"2006\",4514\n\"6\",1,1,\"2006\",5477\n\"7\",1,1,\"2006\",6535\n\"8\",1,1,\"2006\",8046\n\"9\",1,1,\"2006\",10203\n\"10\",1,1,\"2006\",18170\n\"mean\",2,0.7,\"2006\",6280\n\"median\",2,0.7,\"2006\",4495\n\"1\",1,1,\"2007\",1223\n\"2\",1,1,\"2007\",2218\n\"3\",1,1,\"2007\",3078\n\"4\",1,1,\"2007\",3950\n\"5\",1,1,\"2007\",4870\n\"6\",1,1,\"2007\",5962\n\"7\",1,1,\"2007\",7234\n\"8\",1,1,\"2007\",8694\n\"9\",1,1,\"2007\",11491\n\"10\",1,1,\"2007\",20174\n\"mean\",2,0.7,\"2007\",6889\n\"median\",2,0.7,\"2007\",4883\n\"1\",1,1,\"2008\",1300\n\"2\",1,1,\"2008\",2464\n\"3\",1,1,\"2008\",3464\n\"4\",1,1,\"2008\",4420\n\"5\",1,1,\"2008\",5455\n\"6\",1,1,\"2008\",6753\n\"7\",1,1,\"2008\",8107\n\"8\",1,1,\"2008\",9849\n\"9\",1,1,\"2008\",12916\n\"10\",1,1,\"2008\",22797\n\"mean\",2,0.7,\"2008\",7752\n\"median\",2,0.7,\"2008\",5475\n\"1\",1,1,\"2009\",1264\n\"2\",1,1,\"2009\",2462\n\"3\",1,1,\"2009\",3436\n\"4\",1,1,\"2009\",4495\n\"5\",1,1,\"2009\",5391\n\"6\",1,1,\"2009\",6601\n\"7\",1,1,\"2009\",7972\n\"8\",1,1,\"2009\",9733\n\"9\",1,1,\"2009\",12354\n\"10\",1,1,\"2009\",21784\n\"mean\",2,0.7,\"2009\",7549\n\"median\",2,0.7,\"2009\",5398\n\"1\",1,1,\"2010\",1385\n\"2\",1,1,\"2010\",2679\n\"3\",1,1,\"2010\",3759\n\"4\",1,1,\"2010\",4887\n\"5\",1,1,\"2010\",5959\n\"6\",1,1,\"2010\",7090\n\"7\",1,1,\"2010\",8450\n\"8\",1,1,\"2010\",10142\n\"9\",1,1,\"2010\",12887\n\"10\",1,1,\"2010\",23345\n\"mean\",2,0.7,\"2010\",8058\n\"median\",2,0.7,\"2010\",5704\n\"1\",1,1,\"2011\",1460\n\"2\",1,1,\"2011\",2834\n\"3\",1,1,\"2011\",3988\n\"4\",1,1,\"2011\",5200\n\"5\",1,1,\"2011\",6303\n\"6\",1,1,\"2011\",7587\n\"7\",1,1,\"2011\",9147\n\"8\",1,1,\"2011\",11193\n\"9\",1,1,\"2011\",14307\n\"10\",1,1,\"2011\",26622\n\"mean\",2,0.7,\"2011\",8864\n\"median\",2,0.7,\"2011\",6286\n\"1\",1,1,\"2012\",1518\n\"2\",1,1,\"2012\",2985\n\"3\",1,1,\"2012\",4290\n\"4\",1,1,\"2012\",5529\n\"5\",1,1,\"2012\",6800\n\"6\",1,1,\"2012\",8196\n\"7\",1,1,\"2012\",9806\n\"8\",1,1,\"2012\",11973\n\"9\",1,1,\"2012\",15038\n\"10\",1,1,\"2012\",29012\n\"mean\",2,0.7,\"2012\",9515\n\"median\",2,0.7,\"2012\",6712\n\"1\",1,1,\"2013\",1574\n\"2\",1,1,\"2013\",3045\n\"3\",1,1,\"2013\",4467\n\"4\",1,1,\"2013\",5696\n\"5\",1,1,\"2013\",7135\n\"6\",1,1,\"2013\",8479\n\"7\",1,1,\"2013\",10159\n\"8\",1,1,\"2013\",12521\n\"9\",1,1,\"2013\",15609\n\"10\",1,1,\"2013\",27287\n\"mean\",2,0.7,\"2013\",9597\n\"median\",2,0.7,\"2013\",7000"
        },
        {
            "name": ".0/group_by1/group_by2/arrange3",
            "source": ".0/group_by1/group_by2/arrange3_flat",
            "transform": [
                {
                    "type": "treefacet",
                    "keys": [
                        "data.factor(decile)"
                    ]
                }
            ]
        },
        {
            "name": "scale/stroke",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"1\"\n\"2\"\n\"3\"\n\"4\"\n\"5\"\n\"6\"\n\"7\"\n\"8\"\n\"9\"\n\"10\"\n\"mean\"\n\"median\""
        },
        {
            "name": "scale/x",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"2000\"\n\"2001\"\n\"2002\"\n\"2003\"\n\"2004\"\n\"2005\"\n\"2006\"\n\"2007\"\n\"2008\"\n\"2009\"\n\"2010\"\n\"2011\"\n\"2012\"\n\"2013\""
        },
        {
            "name": "scale/y",
            "format": {
                "type": "csv",
                "parse": {
                    "domain": "number"
                }
            },
            "values": "\"domain\"\n-283\n30407"
        }
    ],
    "scales": [
        {
            "name": "stroke",
            "type": "ordinal",
            "domain": {
                "data": "scale/stroke",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "category10"
        },
        {
            "name": "x",
            "type": "ordinal",
            "domain": {
                "data": "scale/x",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "width",
            "padding": 0.5
        },
        {
            "name": "y",
            "domain": {
                "data": "scale/y",
                "field": "data.domain"
            },
            "zero": false,
            "nice": false,
            "clamp": false,
            "range": "height"
        }
    ],
    "marks": [
        {
            "type": "group",
            "from": {
                "data": ".0/group_by1/group_by2/arrange3"
            },
            "marks": [
                {
                    "type": "line",
                    "properties": {
                        "update": {
                            "stroke": {
                                "scale": "stroke",
                                "field": "data.factor(decile)"
                            },
                            "strokeWidth": {
                                "field": "data.strokeWidth"
                            },
                            "opacity": {
                                "field": "data.opacity"
                            },
                            "x": {
                                "scale": "x",
                                "field": "data.factor(year)"
                            },
                            "y": {
                                "scale": "y",
                                "field": "data.income"
                            }
                        },
                        "ggvis": {
                            "data": {
                                "value": ".0/group_by1/group_by2/arrange3"
                            }
                        }
                    }
                }
            ]
        }
    ],
    "width": 768,
    "height": 576,
    "legends": [
        {
            "orient": "right",
            "title": "Decile",
            "stroke": "stroke",
            "4": null,
            "5": null
        }
    ],
    "axes": [
        {
            "type": "x",
            "scale": "x",
            "orient": "bottom",
            "title": "Year",
            "layer": "back",
            "grid": true
        },
        {
            "type": "y",
            "scale": "y",
            "orient": "left",
            "title": "Average Income",
            "titleOffset": 60,
            "layer": "back",
            "grid": true
        }
    ],
    "padding": null,
    "ggvis_opts": {
        "keep_aspect": false,
        "resizable": true,
        "padding": {

        },
        "duration": 250,
        "renderer": "svg",
        "hover_duration": 0,
        "width": 768,
        "height": 576
    },
    "handlers": null
}
;
ggvis.getPlot("plot_id781160081").parseSpec(plot_id781160081_spec);
</script><!--/html_preserve-->

It immediately becomes obvious how skewed the income distribution of Singapore is,
with the top decile earners making substantially more than even the 2nd highest decile earners.
The general trend across the deciles is similar to the overall average income level.

Curiously, the top decile suffered a significant income drop in year 2013, 
while the other deciles were unaffected. I am puzzled as to the exact cause.

### Income Growth from Year 2000 by Deciles

For better comparision of growth, I will normalise the income levels of each decile to the year 2000 levels.


```r
# normalise average income of each decile to year 200 levels
income.decile <- income.decile %>%
                    group_by(decile) %>%
                    arrange(year) %>%
                    mutate(index.2000 = income / first(income)) %>%
                    ungroup()
income.decile %>%
    select(year, decile, index.2000) %>%
    mutate(strokeWidth = ifelse(decile %in% c('mean', 'median'), 2, 1),
           opacity = ifelse(decile %in% c('mean', 'median'), 0.7, 1)) %>%
    ggvis(~factor(year), ~index.2000, stroke = ~factor(decile), 
          strokeWidth := ~strokeWidth, opacity := ~opacity) %>%
    group_by(decile) %>%
    layer_lines() %>%
    add_axis('x', title = 'Year') %>%
    add_axis('y', title = 'Income Index to Year 2000 Levels', title_offset = 40) %>%
    add_legend(c('stroke', 'strokeWidth','opacity'), title = 'Decile')
```

<!--html_preserve--><div id="plot_id845228945-container" class="ggvis-output-container">
<div id="plot_id845228945" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id845228945_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id845228945" data-renderer="svg">SVG</a>
 | 
<a id="plot_id845228945_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id845228945" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id845228945_download" class="ggvis-download" data-plot-id="plot_id845228945">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id845228945_spec = {
    "data": [
        {
            "name": ".0/group_by1/group_by2/arrange3_flat",
            "format": {
                "type": "csv",
                "parse": {
                    "strokeWidth": "number",
                    "opacity": "number",
                    "index.2000": "number"
                }
            },
            "values": "\"factor(decile)\",\"strokeWidth\",\"opacity\",\"factor(year)\",\"index.2000\"\n\"1\",1,1,\"2000\",1\n\"2\",1,1,\"2000\",1\n\"3\",1,1,\"2000\",1\n\"4\",1,1,\"2000\",1\n\"5\",1,1,\"2000\",1\n\"6\",1,1,\"2000\",1\n\"7\",1,1,\"2000\",1\n\"8\",1,1,\"2000\",1\n\"9\",1,1,\"2000\",1\n\"10\",1,1,\"2000\",1\n\"mean\",2,0.7,\"2000\",1\n\"median\",2,0.7,\"2000\",1\n\"1\",1,1,\"2001\",0.940856031128405\n\"2\",1,1,\"2001\",0.989330746847721\n\"3\",1,1,\"2001\",0.992692729265619\n\"4\",1,1,\"2001\",1.01989901989902\n\"5\",1,1,\"2001\",1.01269221381499\n\"6\",1,1,\"2001\",1.03830227743271\n\"7\",1,1,\"2001\",1.03429759223974\n\"8\",1,1,\"2001\",1.06446018210724\n\"9\",1,1,\"2001\",1.10728768393002\n\"10\",1,1,\"2001\",1.07017897994886\n\"mean\",2,0.7,\"2001\",1.05131964809384\n\"median\",2,0.7,\"2001\",1.03525\n\"1\",1,1,\"2002\",0.895719844357977\n\"2\",1,1,\"2002\",0.948593598448109\n\"3\",1,1,\"2002\",0.959810010960906\n\"4\",1,1,\"2002\",0.983664983664984\n\"5\",1,1,\"2002\",0.986819624115206\n\"6\",1,1,\"2002\",1.0111801242236\n\"7\",1,1,\"2002\",1.02043997921358\n\"8\",1,1,\"2002\",1.03873392108686\n\"9\",1,1,\"2002\",1.05943691345151\n\"10\",1,1,\"2002\",1.04454313013053\n\"mean\",2,0.7,\"2002\",1.02126099706745\n\"median\",2,0.7,\"2002\",1.0095\n\"1\",1,1,\"2003\",0.865369649805448\n\"2\",1,1,\"2003\",0.94180407371484\n\"3\",1,1,\"2003\",0.974789915966387\n\"4\",1,1,\"2003\",0.989010989010989\n\"5\",1,1,\"2003\",1.00146448620942\n\"6\",1,1,\"2003\",1.03126293995859\n\"7\",1,1,\"2003\",1.02823488654079\n\"8\",1,1,\"2003\",1.05116346292817\n\"9\",1,1,\"2003\",1.05920519059205\n\"10\",1,1,\"2003\",1.05557798412058\n\"mean\",2,0.7,\"2003\",1.02969208211144\n\"median\",2,0.7,\"2003\",1.0125\n\"1\",1,1,\"2004\",0.88715953307393\n\"2\",1,1,\"2004\",0.974296799224054\n\"3\",1,1,\"2004\",0.994154183412495\n\"4\",1,1,\"2004\",1.01900801900802\n\"5\",1,1,\"2004\",1.02514034659507\n\"6\",1,1,\"2004\",1.03064182194617\n\"7\",1,1,\"2004\",1.04018707777585\n\"8\",1,1,\"2004\",1.04870646047117\n\"9\",1,1,\"2004\",1.09407948094079\n\"10\",1,1,\"2004\",1.1051675413807\n\"mean\",2,0.7,\"2004\",1.05590175953079\n\"median\",2,0.7,\"2004\",1.0265\n\"1\",1,1,\"2005\",0.904280155642023\n\"2\",1,1,\"2005\",1.00096993210475\n\"3\",1,1,\"2005\",1.03507489952503\n\"4\",1,1,\"2005\",1.08256608256608\n\"5\",1,1,\"2005\",1.07151574322675\n\"6\",1,1,\"2005\",1.09751552795031\n\"7\",1,1,\"2005\",1.11865581153646\n\"8\",1,1,\"2005\",1.13397889868478\n\"9\",1,1,\"2005\",1.13509442706523\n\"10\",1,1,\"2005\",1.1452698156372\n\"mean\",2,0.7,\"2005\",1.10923753665689\n\"median\",2,0.7,\"2005\",1.08625\n\"1\",1,1,\"2006\",0.906614785992218\n\"2\",1,1,\"2006\",1.02521823472357\n\"3\",1,1,\"2006\",1.06065034709536\n\"4\",1,1,\"2006\",1.09088209088209\n\"5\",1,1,\"2006\",1.1017817915548\n\"6\",1,1,\"2006\",1.13395445134576\n\"7\",1,1,\"2006\",1.13199376407414\n\"8\",1,1,\"2006\",1.16288480994363\n\"9\",1,1,\"2006\",1.18213416753563\n\"10\",1,1,\"2006\",1.22258107926255\n\"mean\",2,0.7,\"2006\",1.15102639296188\n\"median\",2,0.7,\"2006\",1.12375\n\"1\",1,1,\"2007\",0.951750972762646\n\"2\",1,1,\"2007\",1.07565470417071\n\"3\",1,1,\"2007\",1.12458896602119\n\"4\",1,1,\"2007\",1.17315117315117\n\"5\",1,1,\"2007\",1.18867463998047\n\"6\",1,1,\"2007\",1.2343685300207\n\"7\",1,1,\"2007\",1.25307465789018\n\"8\",1,1,\"2007\",1.25653996242232\n\"9\",1,1,\"2007\",1.33136368902792\n\"10\",1,1,\"2007\",1.35742161216525\n\"mean\",2,0.7,\"2007\",1.26264662756598\n\"median\",2,0.7,\"2007\",1.22075\n\"1\",1,1,\"2008\",1.01167315175097\n\"2\",1,1,\"2008\",1.19495635305529\n\"3\",1,1,\"2008\",1.26561929119474\n\"4\",1,1,\"2008\",1.31274131274131\n\"5\",1,1,\"2008\",1.33146204539907\n\"6\",1,1,\"2008\",1.39813664596273\n\"7\",1,1,\"2008\",1.40429586003811\n\"8\",1,1,\"2008\",1.42347159994219\n\"9\",1,1,\"2008\",1.49646622639323\n\"10\",1,1,\"2008\",1.53391199031086\n\"mean\",2,0.7,\"2008\",1.4208211143695\n\"median\",2,0.7,\"2008\",1.36875\n\"1\",1,1,\"2009\",0.983657587548638\n\"2\",1,1,\"2009\",1.19398642095053\n\"3\",1,1,\"2009\",1.25538911216661\n\"4\",1,1,\"2009\",1.33501633501634\n\"5\",1,1,\"2009\",1.31584085916524\n\"6\",1,1,\"2009\",1.36666666666667\n\"7\",1,1,\"2009\",1.38091113805647\n\"8\",1,1,\"2009\",1.40670617141205\n\"9\",1,1,\"2009\",1.43135210288495\n\"10\",1,1,\"2009\",1.46575158121383\n\"mean\",2,0.7,\"2009\",1.38361436950147\n\"median\",2,0.7,\"2009\",1.3495\n\"1\",1,1,\"2010\",1.07782101167315\n\"2\",1,1,\"2010\",1.2992240543162\n\"3\",1,1,\"2010\",1.37340153452685\n\"4\",1,1,\"2010\",1.45144045144045\n\"5\",1,1,\"2010\",1.45447888699048\n\"6\",1,1,\"2010\",1.46790890269151\n\"7\",1,1,\"2010\",1.46371037588775\n\"8\",1,1,\"2010\",1.46581875993641\n\"9\",1,1,\"2010\",1.49310624493106\n\"10\",1,1,\"2010\",1.57078455120441\n\"mean\",2,0.7,\"2010\",1.47690615835777\n\"median\",2,0.7,\"2010\",1.426\n\"1\",1,1,\"2011\",1.13618677042802\n\"2\",1,1,\"2011\",1.37439379243453\n\"3\",1,1,\"2011\",1.45706978443551\n\"4\",1,1,\"2011\",1.54440154440154\n\"5\",1,1,\"2011\",1.53844276299732\n\"6\",1,1,\"2011\",1.57080745341615\n\"7\",1,1,\"2011\",1.58444482937814\n\"8\",1,1,\"2011\",1.61771932360168\n\"9\",1,1,\"2011\",1.65762947514772\n\"10\",1,1,\"2011\",1.79127977392006\n\"mean\",2,0.7,\"2011\",1.62463343108504\n\"median\",2,0.7,\"2011\",1.5715\n\"1\",1,1,\"2012\",1.18132295719844\n\"2\",1,1,\"2012\",1.44762366634336\n\"3\",1,1,\"2012\",1.56740957252466\n\"4\",1,1,\"2012\",1.64211464211464\n\"5\",1,1,\"2012\",1.6597510373444\n\"6\",1,1,\"2012\",1.69689440993789\n\"7\",1,1,\"2012\",1.6985969166811\n\"8\",1,1,\"2012\",1.7304523775112\n\"9\",1,1,\"2012\",1.74232418028038\n\"10\",1,1,\"2012\",1.9520925851164\n\"mean\",2,0.7,\"2012\",1.74395161290323\n\"median\",2,0.7,\"2012\",1.678\n\"1\",1,1,\"2013\",1.22490272373541\n\"2\",1,1,\"2013\",1.47672162948594\n\"3\",1,1,\"2013\",1.63207891852393\n\"4\",1,1,\"2013\",1.69171369171369\n\"5\",1,1,\"2013\",1.7415181840371\n\"6\",1,1,\"2013\",1.75548654244306\n\"7\",1,1,\"2013\",1.75974363415902\n\"8\",1,1,\"2013\",1.80965457436046\n\"9\",1,1,\"2013\",1.80848105665624\n\"10\",1,1,\"2013\",1.83602476113578\n\"mean\",2,0.7,\"2013\",1.75898093841642\n\"median\",2,0.7,\"2013\",1.75"
        },
        {
            "name": ".0/group_by1/group_by2/arrange3",
            "source": ".0/group_by1/group_by2/arrange3_flat",
            "transform": [
                {
                    "type": "treefacet",
                    "keys": [
                        "data.factor(decile)"
                    ]
                }
            ]
        },
        {
            "name": "scale/stroke",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"1\"\n\"2\"\n\"3\"\n\"4\"\n\"5\"\n\"6\"\n\"7\"\n\"8\"\n\"9\"\n\"10\"\n\"mean\"\n\"median\""
        },
        {
            "name": "scale/x",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"2000\"\n\"2001\"\n\"2002\"\n\"2003\"\n\"2004\"\n\"2005\"\n\"2006\"\n\"2007\"\n\"2008\"\n\"2009\"\n\"2010\"\n\"2011\"\n\"2012\"\n\"2013\""
        },
        {
            "name": "scale/y",
            "format": {
                "type": "csv",
                "parse": {
                    "domain": "number"
                }
            },
            "values": "\"domain\"\n0.8110335030399\n2.00642873188195"
        }
    ],
    "scales": [
        {
            "name": "stroke",
            "type": "ordinal",
            "domain": {
                "data": "scale/stroke",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "category10"
        },
        {
            "name": "x",
            "type": "ordinal",
            "domain": {
                "data": "scale/x",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "width",
            "padding": 0.5
        },
        {
            "name": "y",
            "domain": {
                "data": "scale/y",
                "field": "data.domain"
            },
            "zero": false,
            "nice": false,
            "clamp": false,
            "range": "height"
        }
    ],
    "marks": [
        {
            "type": "group",
            "from": {
                "data": ".0/group_by1/group_by2/arrange3"
            },
            "marks": [
                {
                    "type": "line",
                    "properties": {
                        "update": {
                            "stroke": {
                                "scale": "stroke",
                                "field": "data.factor(decile)"
                            },
                            "strokeWidth": {
                                "field": "data.strokeWidth"
                            },
                            "opacity": {
                                "field": "data.opacity"
                            },
                            "x": {
                                "scale": "x",
                                "field": "data.factor(year)"
                            },
                            "y": {
                                "scale": "y",
                                "field": "data.index\\.2000"
                            }
                        },
                        "ggvis": {
                            "data": {
                                "value": ".0/group_by1/group_by2/arrange3"
                            }
                        }
                    }
                }
            ]
        }
    ],
    "width": 768,
    "height": 576,
    "legends": [
        {
            "orient": "right",
            "title": "Decile",
            "stroke": "stroke",
            "4": null,
            "5": null
        }
    ],
    "axes": [
        {
            "type": "x",
            "scale": "x",
            "orient": "bottom",
            "title": "Year",
            "layer": "back",
            "grid": true
        },
        {
            "type": "y",
            "scale": "y",
            "orient": "left",
            "title": "Income Index to Year 2000 Levels",
            "titleOffset": 40,
            "layer": "back",
            "grid": true
        }
    ],
    "padding": null,
    "ggvis_opts": {
        "keep_aspect": false,
        "resizable": true,
        "padding": {

        },
        "duration": 250,
        "renderer": "svg",
        "hover_duration": 0,
        "width": 768,
        "height": 576
    },
    "handlers": null
}
;
ggvis.getPlot("plot_id845228945").parseSpec(plot_id845228945_spec);
</script><!--/html_preserve-->

Income levels generally experienced healthy growth from year 2004 onwards.
The bottom income earners actually suffered stagnant income growth all the way till year 2009
and have significantly lagged behind the other deciles as a result.

It can also be observed that the extent income growth of each decile tend to follow decile levels,
with higher deciles experiencing better growth than lower deciles.

The total and compounded annual growth rates are presented in the table below.


```r
income.growth <- income.decile %>%
                    group_by(decile) %>%
                    summarise(growth.total = (last(index.2000) - 1) * 100,
                              growth.annual = (last(index.2000) ^ (1/13) - 1) * 100) %>%
                    ungroup()
kable(income.growth, digits = 2, caption = 'Table of Growth Rates between Years 2000 and 2013 by Deciles')
```



Table: Table of Growth Rates between Years 2000 and 2013 by Deciles

decile    growth.total   growth.annual
-------  -------------  --------------
1                22.49            1.57
2                47.67            3.04
3                63.21            3.84
4                69.17            4.13
5                74.15            4.36
6                75.55            4.42
7                75.97            4.44
8                80.97            4.67
9                80.85            4.66
10               83.60            4.78
mean             75.90            4.44
median           75.00            4.40

Next let's look at the distribution of income relative to the total income to investigate 
how it has changed over the years.


```r
# remove average values and compute proportion numbers
income.decile <- income.decile %>%
                    filter(decile %in% 1:10) %>%
                    mutate(decile = as.numeric(levels(decile)[decile]),
                           population.cumprop = decile / 10)
income.decile <- income.decile %>%
                    group_by(year) %>%
                    arrange(decile) %>%
                    mutate(income.prop = income / sum(income),
                           income.cumprop = cumsum(income.prop)) %>%
                    ungroup()
```

### Line Graph of Income Proportion by Deciles

First, a line graph for simple comparisons


```r
income.decile %>%
    ggvis(~factor(year), ~income.prop, stroke = ~factor(decile)) %>%
    group_by(decile) %>%
    layer_lines() %>%
    add_axis('x', title = 'Year') %>%
    add_axis('y', title = 'Income Proportion', title_offset = 50) %>%
    add_legend('stroke', title = 'Decile')
```

<!--html_preserve--><div id="plot_id380788553-container" class="ggvis-output-container">
<div id="plot_id380788553" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id380788553_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id380788553" data-renderer="svg">SVG</a>
 | 
<a id="plot_id380788553_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id380788553" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id380788553_download" class="ggvis-download" data-plot-id="plot_id380788553">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id380788553_spec = {
    "data": [
        {
            "name": ".0/group_by1/group_by2/arrange3_flat",
            "format": {
                "type": "csv",
                "parse": {
                    "income.prop": "number"
                }
            },
            "values": "\"factor(decile)\",\"factor(year)\",\"income.prop\"\n\"1\",\"2000\",0.0235507578395616\n\"2\",\"2000\",0.0377911771713432\n\"3\",\"2000\",0.0501621978263658\n\"4\",\"2000\",0.0617084837710536\n\"5\",\"2000\",0.0750875135164855\n\"6\",\"2000\",0.0885215255759397\n\"7\",\"2000\",0.105804299616957\n\"8\",\"2000\",0.126807543573484\n\"9\",\"2000\",0.158184117442223\n\"10\",\"2000\",0.272382383666587\n\"1\",\"2001\",0.0210766709668422\n\"2\",\"2001\",0.0355636135420662\n\"3\",\"2001\",0.0473658519577421\n\"4\",\"2001\",0.0598654161291447\n\"5\",\"2001\",0.0723301140127611\n\"6\",\"2001\",0.087427216624246\n\"7\",\"2001\",0.104093302186116\n\"8\",\"2001\",0.128395104773195\n\"9\",\"2001\",0.166608556187023\n\"10\",\"2001\",0.277274153620864\n\"1\",\"2002\",0.0206572264398141\n\"2\",\"2002\",0.0351047219081462\n\"3\",\"2002\",0.0471472926649796\n\"4\",\"2002\",0.0594411242125666\n\"5\",\"2002\",0.0725605269297726\n\"6\",\"2002\",0.0876541215743283\n\"7\",\"2002\",0.105726951309248\n\"8\",\"2002\",0.128986521653296\n\"9\",\"2002\",0.164109190760782\n\"10\",\"2002\",0.278612322547067\n\"1\",\"2003\",0.0197952825990209\n\"2\",\"2003\",0.0345705384957721\n\"3\",\"2003\",0.0474944370271473\n\"4\",\"2003\",0.0592790387182911\n\"5\",\"2003\",0.0730396083667112\n\"6\",\"2003\",0.088669336893636\n\"7\",\"2003\",0.105669781931464\n\"8\",\"2003\",0.129470404984424\n\"9\",\"2003\",0.162741433021807\n\"10\",\"2003\",0.279270137961727\n\"1\",\"2004\",0.0197889182058048\n\"2\",\"2004\",0.0348736286626857\n\"3\",\"2004\",0.0472330231912234\n\"4\",\"2004\",0.0595577003194001\n\"5\",\"2004\",0.072906540758228\n\"6\",\"2004\",0.0864116094986807\n\"7\",\"2004\",0.104238994584086\n\"8\",\"2004\",0.125954728509929\n\"9\",\"2004\",0.163918205804749\n\"10\",\"2004\",0.285116650465213\n\"1\",\"2005\",0.0192012161871871\n\"2\",\"2005\",0.034106118941785\n\"3\",\"2005\",0.0468132921327891\n\"4\",\"2005\",0.0602310094684138\n\"5\",\"2005\",0.0725415998810252\n\"6\",\"2005\",0.0875952211775204\n\"7\",\"2005\",0.106713815952542\n\"8\",\"2005\",0.129649519969595\n\"9\",\"2005\",0.161888394996447\n\"10\",\"2005\",0.281259811292695\n\"1\",\"2006\",0.0185509554140127\n\"2\",\"2006\",0.0336624203821656\n\"3\",\"2006\",0.0462261146496815\n\"4\",\"2006\",0.0584872611464968\n\"5\",\"2006\",0.0718789808917197\n\"6\",\"2006\",0.0872133757961783\n\"7\",\"2006\",0.10406050955414\n\"8\",\"2006\",0.12812101910828\n\"9\",\"2006\",0.162468152866242\n\"10\",\"2006\",0.289331210191083\n\"1\",\"2007\",0.0177519087293523\n\"2\",\"2007\",0.0321943855778442\n\"3\",\"2007\",0.0446773303916161\n\"4\",\"2007\",0.0573344558306964\n\"5\",\"2007\",0.0706883037710105\n\"6\",\"2007\",0.086538740674079\n\"7\",\"2007\",0.105001886956774\n\"8\",\"2007\",0.126193863035968\n\"9\",\"2007\",0.166792463784945\n\"10\",\"2007\",0.292826661247714\n\"1\",\"2008\",0.0167687842631409\n\"2\",\"2008\",0.0317832957110609\n\"3\",\"2008\",0.0446823605288617\n\"4\",\"2008\",0.0570138664946791\n\"5\",\"2008\",0.0703643985811029\n\"6\",\"2008\",0.0871073847146082\n\"7\",\"2008\",0.10457271847791\n\"8\",\"2008\",0.127042889390519\n\"9\",\"2008\",0.166604321186714\n\"10\",\"2008\",0.294059980651403\n\"1\",\"2009\",0.0167434959995761\n\"2\",\"2009\",0.0326127271763895\n\"3\",\"2009\",0.0455147565304933\n\"4\",\"2009\",0.0595427330048217\n\"5\",\"2009\",0.0714115402956605\n\"6\",\"2009\",0.0874397287129762\n\"7\",\"2009\",0.105600593440365\n\"8\",\"2009\",0.128927568484078\n\"9\",\"2009\",0.163646479097123\n\"10\",\"2009\",0.288560377258517\n\"1\",\"2010\",0.017187247930705\n\"2\",\"2010\",0.0332452254197535\n\"3\",\"2010\",0.0466475559361156\n\"4\",\"2010\",0.0606455455865381\n\"5\",\"2010\",0.0739485995805567\n\"6\",\"2010\",0.087983817926858\n\"7\",\"2010\",0.10486082672524\n\"8\",\"2010\",0.125857811200874\n\"9\",\"2010\",0.15992206792996\n\"10\",\"2010\",0.289701301763399\n\"1\",\"2011\",0.016470933315283\n\"2\",\"2011\",0.0319716609695288\n\"3\",\"2011\",0.0449904671653073\n\"4\",\"2011\",0.0586635981092271\n\"5\",\"2011\",0.0711070497850882\n\"6\",\"2011\",0.0855924459335973\n\"7\",\"2011\",0.103191525366365\n\"8\",\"2011\",0.126273394930111\n\"9\",\"2011\",0.161403865028598\n\"10\",\"2011\",0.300335059396893\n\"1\",\"2012\",0.0159542602499291\n\"2\",\"2012\",0.0313725078037143\n\"3\",\"2012\",0.0450881267932778\n\"4\",\"2012\",0.0581100822937139\n\"5\",\"2012\",0.0714683594858482\n\"6\",\"2012\",0.0861403932861782\n\"7\",\"2012\",0.103061578399739\n\"8\",\"2012\",0.125836862959421\n\"9\",\"2012\",0.15805017499238\n\"10\",\"2012\",0.304917653735798\n\"1\",\"2013\",0.0164006168465803\n\"2\",\"2013\",0.031728004001167\n\"3\",\"2013\",0.0465448255741258\n\"4\",\"2013\",0.0593506439378152\n\"5\",\"2013\",0.0743446005084816\n\"6\",\"2013\",0.0883486850331347\n\"7\",\"2013\",0.105853790688951\n\"8\",\"2013\",0.130465135664569\n\"9\",\"2013\",0.162641187012879\n\"10\",\"2013\",0.284322510732297"
        },
        {
            "name": ".0/group_by1/group_by2/arrange3",
            "source": ".0/group_by1/group_by2/arrange3_flat",
            "transform": [
                {
                    "type": "treefacet",
                    "keys": [
                        "data.factor(decile)"
                    ]
                }
            ]
        },
        {
            "name": "scale/stroke",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"1\"\n\"2\"\n\"3\"\n\"4\"\n\"5\"\n\"6\"\n\"7\"\n\"8\"\n\"9\"\n\"10\""
        },
        {
            "name": "scale/x",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"2000\"\n\"2001\"\n\"2002\"\n\"2003\"\n\"2004\"\n\"2005\"\n\"2006\"\n\"2007\"\n\"2008\"\n\"2009\"\n\"2010\"\n\"2011\"\n\"2012\"\n\"2013\""
        },
        {
            "name": "scale/y",
            "format": {
                "type": "csv",
                "parse": {
                    "domain": "number"
                }
            },
            "values": "\"domain\"\n0.0015060905756356\n0.319365823410092"
        }
    ],
    "scales": [
        {
            "name": "stroke",
            "type": "ordinal",
            "domain": {
                "data": "scale/stroke",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "category10"
        },
        {
            "name": "x",
            "type": "ordinal",
            "domain": {
                "data": "scale/x",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "width",
            "padding": 0.5
        },
        {
            "name": "y",
            "domain": {
                "data": "scale/y",
                "field": "data.domain"
            },
            "zero": false,
            "nice": false,
            "clamp": false,
            "range": "height"
        }
    ],
    "marks": [
        {
            "type": "group",
            "from": {
                "data": ".0/group_by1/group_by2/arrange3"
            },
            "marks": [
                {
                    "type": "line",
                    "properties": {
                        "update": {
                            "stroke": {
                                "scale": "stroke",
                                "field": "data.factor(decile)"
                            },
                            "x": {
                                "scale": "x",
                                "field": "data.factor(year)"
                            },
                            "y": {
                                "scale": "y",
                                "field": "data.income\\.prop"
                            }
                        },
                        "ggvis": {
                            "data": {
                                "value": ".0/group_by1/group_by2/arrange3"
                            }
                        }
                    }
                }
            ]
        }
    ],
    "width": 768,
    "height": 576,
    "legends": [
        {
            "orient": "right",
            "title": "Decile",
            "stroke": "stroke"
        }
    ],
    "axes": [
        {
            "type": "x",
            "scale": "x",
            "orient": "bottom",
            "title": "Year",
            "layer": "back",
            "grid": true
        },
        {
            "type": "y",
            "scale": "y",
            "orient": "left",
            "title": "Income Proportion",
            "titleOffset": 50,
            "layer": "back",
            "grid": true
        }
    ],
    "padding": null,
    "ggvis_opts": {
        "keep_aspect": false,
        "resizable": true,
        "padding": {

        },
        "duration": 250,
        "renderer": "svg",
        "hover_duration": 0,
        "width": 768,
        "height": 576
    },
    "handlers": null
}
;
ggvis.getPlot("plot_id380788553").parseSpec(plot_id380788553_spec);
</script><!--/html_preserve-->

Despite the unequal distribution of income, it can be observed from this graph that the distribution
has been quite consistent through the years.
Except for the slight increase in income proportion of the top decile earners,
the income proportion is quite flat for each decile from year 2000 to year 2013.

### Stacked Area Graph of Income Proportion by Deciles

The unequal distribution can be more easily observed in a stacked area graph.


```r
income.decile %>%
    group_by(year) %>%
    mutate(to = income.cumprop, from = c(0, to[-n()])) %>%
    ggvis(x = ~factor(year), fill = ~factor(decile), opacity := 0.8) %>%
    group_by(decile) %>%
    layer_ribbons(y = ~from, y2 = ~to) %>%
    add_axis('x', title = 'Year') %>%
    add_axis('y', title = 'Cumulative Income Proportion') %>%
    add_legend('fill', title = 'Decile')
```

<!--html_preserve--><div id="plot_id673486270-container" class="ggvis-output-container">
<div id="plot_id673486270" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id673486270_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id673486270" data-renderer="svg">SVG</a>
 | 
<a id="plot_id673486270_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id673486270" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id673486270_download" class="ggvis-download" data-plot-id="plot_id673486270">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id673486270_spec = {
    "data": [
        {
            "name": ".0/group_by1_flat",
            "format": {
                "type": "csv",
                "parse": {
                    "decile": "number",
                    "from": "number",
                    "to": "number"
                }
            },
            "values": "\"decile\",\"factor(year)\",\"factor(decile)\",\"from\",\"to\"\n1,\"2000\",\"1\",0,0.0235507578395616\n1,\"2001\",\"1\",0,0.0210766709668422\n1,\"2002\",\"1\",0,0.0206572264398141\n1,\"2003\",\"1\",0,0.0197952825990209\n1,\"2004\",\"1\",0,0.0197889182058048\n1,\"2005\",\"1\",0,0.0192012161871871\n1,\"2006\",\"1\",0,0.0185509554140127\n1,\"2007\",\"1\",0,0.0177519087293523\n1,\"2008\",\"1\",0,0.0167687842631409\n1,\"2009\",\"1\",0,0.0167434959995761\n1,\"2010\",\"1\",0,0.017187247930705\n1,\"2011\",\"1\",0,0.016470933315283\n1,\"2012\",\"1\",0,0.0159542602499291\n1,\"2013\",\"1\",0,0.0164006168465803\n2,\"2000\",\"2\",0.0235507578395616,0.0613419350109048\n2,\"2001\",\"2\",0.0210766709668422,0.0566402845089083\n2,\"2002\",\"2\",0.0206572264398141,0.0557619483479603\n2,\"2003\",\"2\",0.0197952825990209,0.0543658210947931\n2,\"2004\",\"2\",0.0197889182058048,0.0546625468684905\n2,\"2005\",\"2\",0.0192012161871871,0.053307335128972\n2,\"2006\",\"2\",0.0185509554140127,0.0522133757961783\n2,\"2007\",\"2\",0.0177519087293523,0.0499462943071966\n2,\"2008\",\"2\",0.0167687842631409,0.0485520799742019\n2,\"2009\",\"2\",0.0167434959995761,0.0493562231759657\n2,\"2010\",\"2\",0.017187247930705,0.0504324733504585\n2,\"2011\",\"2\",0.016470933315283,0.0484425942848118\n2,\"2012\",\"2\",0.0159542602499291,0.0473267680536433\n2,\"2013\",\"2\",0.0164006168465803,0.0481286208477473\n3,\"2000\",\"3\",0.0613419350109048,0.111504132837271\n3,\"2001\",\"3\",0.0566402845089083,0.10400613646665\n3,\"2002\",\"3\",0.0557619483479603,0.10290924101294\n3,\"2003\",\"3\",0.0543658210947931,0.10186025812194\n3,\"2004\",\"3\",0.0546625468684905,0.101895570059714\n3,\"2005\",\"3\",0.053307335128972,0.100120627261761\n3,\"2006\",\"3\",0.0522133757961783,0.0984394904458599\n3,\"2007\",\"3\",0.0499462943071966,0.0946236246988127\n3,\"2008\",\"3\",0.0485520799742019,0.0932344405030635\n3,\"2009\",\"3\",0.0493562231759657,0.094870979706459\n3,\"2010\",\"3\",0.0504324733504585,0.0970800292865741\n3,\"2011\",\"3\",0.0484425942848118,0.093433061450119\n3,\"2012\",\"3\",0.0473267680536433,0.0924148948469211\n3,\"2013\",\"3\",0.0481286208477473,0.094673446421873\n4,\"2000\",\"4\",0.111504132837271,0.173212616608324\n4,\"2001\",\"4\",0.10400613646665,0.163871552595795\n4,\"2002\",\"4\",0.10290924101294,0.162350365225507\n4,\"2003\",\"4\",0.10186025812194,0.161139296840231\n4,\"2004\",\"4\",0.101895570059714,0.161453270379114\n4,\"2005\",\"4\",0.100120627261761,0.160351636730175\n4,\"2006\",\"4\",0.0984394904458599,0.156926751592357\n4,\"2007\",\"4\",0.0946236246988127,0.151958080529509\n4,\"2008\",\"4\",0.0932344405030635,0.150248306997743\n4,\"2009\",\"4\",0.094870979706459,0.154413712711281\n4,\"2010\",\"4\",0.0970800292865741,0.157725574873112\n4,\"2011\",\"4\",0.093433061450119,0.152096659559346\n4,\"2012\",\"4\",0.0924148948469211,0.150524977140635\n4,\"2013\",\"4\",0.094673446421873,0.154024090359688\n5,\"2000\",\"5\",0.173212616608324,0.24830013012481\n5,\"2001\",\"5\",0.163871552595795,0.236201666608556\n5,\"2002\",\"5\",0.162350365225507,0.234910892155279\n5,\"2003\",\"5\",0.161139296840231,0.234178905206943\n5,\"2004\",\"5\",0.161453270379114,0.234359811137342\n5,\"2005\",\"5\",0.160351636730175,0.2328932366112\n5,\"2006\",\"5\",0.156926751592357,0.228805732484076\n5,\"2007\",\"5\",0.151958080529509,0.22264638430052\n5,\"2008\",\"5\",0.150248306997743,0.220612705578846\n5,\"2009\",\"5\",0.154413712711281,0.225825253006941\n5,\"2010\",\"5\",0.157725574873112,0.231674174453669\n5,\"2011\",\"5\",0.152096659559346,0.223203709344434\n5,\"2012\",\"5\",0.150524977140635,0.221993336626483\n5,\"2013\",\"5\",0.154024090359688,0.22836869086817\n6,\"2000\",\"6\",0.24830013012481,0.33682165570075\n6,\"2001\",\"6\",0.236201666608556,0.323628883232802\n6,\"2002\",\"6\",0.234910892155279,0.322565013729607\n6,\"2003\",\"6\",0.234178905206943,0.322848242100579\n6,\"2004\",\"6\",0.234359811137342,0.320771420636023\n6,\"2005\",\"6\",0.2328932366112,0.320488457788721\n6,\"2006\",\"6\",0.228805732484076,0.316019108280255\n6,\"2007\",\"6\",0.22264638430052,0.309185124974599\n6,\"2008\",\"6\",0.220612705578846,0.307720090293454\n6,\"2009\",\"6\",0.225825253006941,0.313264981719917\n6,\"2010\",\"6\",0.231674174453669,0.319657992380527\n6,\"2011\",\"6\",0.223203709344434,0.308796155278032\n6,\"2012\",\"6\",0.221993336626483,0.308133729912661\n6,\"2013\",\"6\",0.22836869086817,0.316717375901305\n7,\"2000\",\"7\",0.33682165570075,0.442625955317706\n7,\"2001\",\"7\",0.323628883232802,0.427722185418918\n7,\"2002\",\"7\",0.322565013729607,0.428291965038856\n7,\"2003\",\"7\",0.322848242100579,0.428518024032043\n7,\"2004\",\"7\",0.320771420636023,0.425010415220108\n7,\"2005\",\"7\",0.320488457788721,0.427202273741263\n7,\"2006\",\"7\",0.316019108280255,0.420079617834395\n7,\"2007\",\"7\",0.309185124974599,0.414187011931373\n7,\"2008\",\"7\",0.307720090293454,0.412292808771364\n7,\"2009\",\"7\",0.313264981719917,0.418865575160282\n7,\"2010\",\"7\",0.319657992380527,0.424518819105767\n7,\"2011\",\"7\",0.308796155278032,0.411987680644397\n7,\"2012\",\"7\",0.308133729912661,0.411195308312401\n7,\"2013\",\"7\",0.316717375901305,0.422571166590256\n8,\"2000\",\"8\",0.442625955317706,0.56943349889119\n8,\"2001\",\"8\",0.427722185418918,0.556117290192113\n8,\"2002\",\"8\",0.428291965038856,0.557278486692152\n8,\"2003\",\"8\",0.428518024032043,0.557988429016466\n8,\"2004\",\"8\",0.425010415220108,0.550965143730037\n8,\"2005\",\"8\",0.427202273741263,0.556851793710858\n8,\"2006\",\"8\",0.420079617834395,0.548200636942675\n8,\"2007\",\"8\",0.414187011931373,0.540380874967341\n8,\"2008\",\"8\",0.412292808771364,0.539335698161883\n8,\"2009\",\"8\",0.418865575160282,0.54779314364436\n8,\"2010\",\"8\",0.424518819105767,0.55037663030664\n8,\"2011\",\"8\",0.411987680644397,0.538261075574508\n8,\"2012\",\"8\",0.411195308312401,0.537032171271821\n8,\"2013\",\"8\",0.422571166590256,0.553036302254824\n9,\"2000\",\"9\",0.56943349889119,0.727617616333413\n9,\"2001\",\"9\",0.556117290192113,0.722725846379136\n9,\"2002\",\"9\",0.557278486692152,0.721387677452933\n9,\"2003\",\"9\",0.557988429016466,0.720729862038273\n9,\"2004\",\"9\",0.550965143730037,0.714883349534787\n9,\"2005\",\"9\",0.556851793710858,0.718740188707305\n9,\"2006\",\"9\",0.548200636942675,0.710668789808917\n9,\"2007\",\"9\",0.540380874967341,0.707173338752286\n9,\"2008\",\"9\",0.539335698161883,0.705940019348597\n9,\"2009\",\"9\",0.54779314364436,0.711439622741483\n9,\"2010\",\"9\",0.55037663030664,0.710298698236601\n9,\"2011\",\"9\",0.538261075574508,0.699664940603107\n9,\"2012\",\"9\",0.537032171271821,0.695082346264202\n9,\"2013\",\"9\",0.553036302254824,0.715677489267703\n10,\"2000\",\"10\",0.727617616333413,1\n10,\"2001\",\"10\",0.722725846379136,1\n10,\"2002\",\"10\",0.721387677452933,1\n10,\"2003\",\"10\",0.720729862038273,1\n10,\"2004\",\"10\",0.714883349534787,1\n10,\"2005\",\"10\",0.718740188707305,1\n10,\"2006\",\"10\",0.710668789808917,1\n10,\"2007\",\"10\",0.707173338752286,1\n10,\"2008\",\"10\",0.705940019348597,1\n10,\"2009\",\"10\",0.711439622741483,1\n10,\"2010\",\"10\",0.710298698236601,1\n10,\"2011\",\"10\",0.699664940603107,1\n10,\"2012\",\"10\",0.695082346264202,1\n10,\"2013\",\"10\",0.715677489267703,1"
        },
        {
            "name": ".0/group_by1",
            "source": ".0/group_by1_flat",
            "transform": [
                {
                    "type": "treefacet",
                    "keys": [
                        "data.decile"
                    ]
                }
            ]
        },
        {
            "name": "scale/fill",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"1\"\n\"2\"\n\"3\"\n\"4\"\n\"5\"\n\"6\"\n\"7\"\n\"8\"\n\"9\"\n\"10\""
        },
        {
            "name": "scale/x",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"2000\"\n\"2001\"\n\"2002\"\n\"2003\"\n\"2004\"\n\"2005\"\n\"2006\"\n\"2007\"\n\"2008\"\n\"2009\"\n\"2010\"\n\"2011\"\n\"2012\"\n\"2013\""
        },
        {
            "name": "scale/y",
            "format": {
                "type": "csv",
                "parse": {
                    "domain": "number"
                }
            },
            "values": "\"domain\"\n-0.05\n1.05"
        }
    ],
    "scales": [
        {
            "name": "fill",
            "type": "ordinal",
            "domain": {
                "data": "scale/fill",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "category10"
        },
        {
            "name": "x",
            "type": "ordinal",
            "domain": {
                "data": "scale/x",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "width",
            "padding": 0.5
        },
        {
            "name": "y",
            "domain": {
                "data": "scale/y",
                "field": "data.domain"
            },
            "zero": false,
            "nice": false,
            "clamp": false,
            "range": "height"
        }
    ],
    "marks": [
        {
            "type": "group",
            "from": {
                "data": ".0/group_by1"
            },
            "marks": [
                {
                    "type": "area",
                    "properties": {
                        "update": {
                            "x": {
                                "scale": "x",
                                "field": "data.factor(year)"
                            },
                            "fill": {
                                "scale": "fill",
                                "field": "data.factor(decile)"
                            },
                            "opacity": {
                                "value": 0.8
                            },
                            "y": {
                                "scale": "y",
                                "field": "data.from"
                            },
                            "y2": {
                                "scale": "y",
                                "field": "data.to"
                            }
                        },
                        "ggvis": {
                            "data": {
                                "value": ".0/group_by1"
                            }
                        }
                    }
                }
            ]
        }
    ],
    "width": 768,
    "height": 576,
    "legends": [
        {
            "orient": "right",
            "title": "Decile",
            "fill": "fill"
        }
    ],
    "axes": [
        {
            "type": "x",
            "scale": "x",
            "orient": "bottom",
            "title": "Year",
            "layer": "back",
            "grid": true
        },
        {
            "type": "y",
            "scale": "y",
            "orient": "left",
            "title": "Cumulative Income Proportion",
            "layer": "back",
            "grid": true
        }
    ],
    "padding": null,
    "ggvis_opts": {
        "keep_aspect": false,
        "resizable": true,
        "padding": {

        },
        "duration": 250,
        "renderer": "svg",
        "hover_duration": 0,
        "width": 768,
        "height": 576
    },
    "handlers": null
}
;
ggvis.getPlot("plot_id673486270").parseSpec(plot_id673486270_spec);
</script><!--/html_preserve-->

It can be observed that the top decile earners make more than 
the total income of the bottom 5 deciles earners.
In other words, the top 10% of earners made more income than the bottom 50% of income earners. WOW!
Similar comparisons can be made with top 2 vs bottom 6 deciles and top 3 vs bottom 7 deciles.
The top 30% of earners are responsible for more than half the total income of Singapore earners.

The cumulative proportion of income in Singapore from the bottom decile is show in the table below.


```r
income.decile %>%
    filter(year == 2013) %>%
    select(decile, income.cumprop) %>%
    mutate(income.cumprop = income.cumprop * 100) %>%
    kable(digits = 2, caption = 'Table of Cumulative Proportion of Income by Deciles in 2013')
```



Table: Table of Cumulative Proportion of Income by Deciles in 2013

 decile   income.cumprop
-------  ---------------
      1             1.64
      2             4.81
      3             9.47
      4            15.40
      5            22.84
      6            31.67
      7            42.26
      8            55.30
      9            71.57
     10           100.00

### Lorenz Curve

The unequal distribution can also be shown in a [Lorenz curve](https://en.wikipedia.org/wiki/Lorenz_curve), 
which plots the cumulative income proportion against cumulative population proportion.
The straight line joining zero and one shows perfect equality of income distribution.


```r
income.decile %>%
    select(year, population.cumprop, income.cumprop) %>%
    rbind(data.frame(year = 2000:2013, population.cumprop = 0, income.cumprop = 0)) %>%
    rbind(data.frame(year = NA, population.cumprop = c(0, 1), income.cumprop = c(0, 1))) %>%
    ggvis(~population.cumprop, ~income.cumprop, stroke = ~factor(year)) %>%
    group_by(year) %>%
    layer_lines() %>%
    add_axis('x', title = 'Cumulative Population Proportion') %>%
    add_axis('y', title = 'Cumulative Income Proportion', title_offset = 40) %>%
    add_legend('stroke', title = 'Year', values = 2000:2013)
```

<!--html_preserve--><div id="plot_id992566874-container" class="ggvis-output-container">
<div id="plot_id992566874" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id992566874_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id992566874" data-renderer="svg">SVG</a>
 | 
<a id="plot_id992566874_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id992566874" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id992566874_download" class="ggvis-download" data-plot-id="plot_id992566874">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id992566874_spec = {
    "data": [
        {
            "name": ".0/group_by1/group_by2/arrange3_flat",
            "format": {
                "type": "csv",
                "parse": {
                    "population.cumprop": "number",
                    "income.cumprop": "number"
                }
            },
            "values": "\"factor(year)\",\"population.cumprop\",\"income.cumprop\"\n\"2000\",0,0\n\"2001\",0,0\n\"2002\",0,0\n\"2003\",0,0\n\"2004\",0,0\n\"2005\",0,0\n\"2006\",0,0\n\"2007\",0,0\n\"2008\",0,0\n\"2009\",0,0\n\"2010\",0,0\n\"2011\",0,0\n\"2012\",0,0\n\"2013\",0,0\n\"2000\",0.1,0.0235507578395616\n\"2001\",0.1,0.0210766709668422\n\"2002\",0.1,0.0206572264398141\n\"2003\",0.1,0.0197952825990209\n\"2004\",0.1,0.0197889182058048\n\"2005\",0.1,0.0192012161871871\n\"2006\",0.1,0.0185509554140127\n\"2007\",0.1,0.0177519087293523\n\"2008\",0.1,0.0167687842631409\n\"2009\",0.1,0.0167434959995761\n\"2010\",0.1,0.017187247930705\n\"2011\",0.1,0.016470933315283\n\"2012\",0.1,0.0159542602499291\n\"2013\",0.1,0.0164006168465803\n\"2000\",0.2,0.0613419350109048\n\"2001\",0.2,0.0566402845089083\n\"2002\",0.2,0.0557619483479603\n\"2003\",0.2,0.0543658210947931\n\"2004\",0.2,0.0546625468684905\n\"2005\",0.2,0.053307335128972\n\"2006\",0.2,0.0522133757961783\n\"2007\",0.2,0.0499462943071966\n\"2008\",0.2,0.0485520799742019\n\"2009\",0.2,0.0493562231759657\n\"2010\",0.2,0.0504324733504585\n\"2011\",0.2,0.0484425942848118\n\"2012\",0.2,0.0473267680536433\n\"2013\",0.2,0.0481286208477473\n\"2000\",0.3,0.111504132837271\n\"2001\",0.3,0.10400613646665\n\"2002\",0.3,0.10290924101294\n\"2003\",0.3,0.10186025812194\n\"2004\",0.3,0.101895570059714\n\"2005\",0.3,0.100120627261761\n\"2006\",0.3,0.0984394904458599\n\"2007\",0.3,0.0946236246988127\n\"2008\",0.3,0.0932344405030635\n\"2009\",0.3,0.094870979706459\n\"2010\",0.3,0.0970800292865741\n\"2011\",0.3,0.093433061450119\n\"2012\",0.3,0.0924148948469211\n\"2013\",0.3,0.094673446421873\n\"2000\",0.4,0.173212616608324\n\"2001\",0.4,0.163871552595795\n\"2002\",0.4,0.162350365225507\n\"2003\",0.4,0.161139296840231\n\"2004\",0.4,0.161453270379114\n\"2005\",0.4,0.160351636730175\n\"2006\",0.4,0.156926751592357\n\"2007\",0.4,0.151958080529509\n\"2008\",0.4,0.150248306997743\n\"2009\",0.4,0.154413712711281\n\"2010\",0.4,0.157725574873112\n\"2011\",0.4,0.152096659559346\n\"2012\",0.4,0.150524977140635\n\"2013\",0.4,0.154024090359688\n\"2000\",0.5,0.24830013012481\n\"2001\",0.5,0.236201666608556\n\"2002\",0.5,0.234910892155279\n\"2003\",0.5,0.234178905206943\n\"2004\",0.5,0.234359811137342\n\"2005\",0.5,0.2328932366112\n\"2006\",0.5,0.228805732484076\n\"2007\",0.5,0.22264638430052\n\"2008\",0.5,0.220612705578846\n\"2009\",0.5,0.225825253006941\n\"2010\",0.5,0.231674174453669\n\"2011\",0.5,0.223203709344434\n\"2012\",0.5,0.221993336626483\n\"2013\",0.5,0.22836869086817\n\"2000\",0.6,0.33682165570075\n\"2001\",0.6,0.323628883232802\n\"2002\",0.6,0.322565013729607\n\"2003\",0.6,0.322848242100579\n\"2004\",0.6,0.320771420636023\n\"2005\",0.6,0.320488457788721\n\"2006\",0.6,0.316019108280255\n\"2007\",0.6,0.309185124974599\n\"2008\",0.6,0.307720090293454\n\"2009\",0.6,0.313264981719917\n\"2010\",0.6,0.319657992380527\n\"2011\",0.6,0.308796155278032\n\"2012\",0.6,0.308133729912661\n\"2013\",0.6,0.316717375901305\n\"2000\",0.7,0.442625955317706\n\"2001\",0.7,0.427722185418918\n\"2002\",0.7,0.428291965038856\n\"2003\",0.7,0.428518024032043\n\"2004\",0.7,0.425010415220108\n\"2005\",0.7,0.427202273741263\n\"2006\",0.7,0.420079617834395\n\"2007\",0.7,0.414187011931373\n\"2008\",0.7,0.412292808771364\n\"2009\",0.7,0.418865575160282\n\"2010\",0.7,0.424518819105767\n\"2011\",0.7,0.411987680644397\n\"2012\",0.7,0.411195308312401\n\"2013\",0.7,0.422571166590256\n\"2000\",0.8,0.56943349889119\n\"2001\",0.8,0.556117290192113\n\"2002\",0.8,0.557278486692152\n\"2003\",0.8,0.557988429016466\n\"2004\",0.8,0.550965143730037\n\"2005\",0.8,0.556851793710858\n\"2006\",0.8,0.548200636942675\n\"2007\",0.8,0.540380874967341\n\"2008\",0.8,0.539335698161883\n\"2009\",0.8,0.54779314364436\n\"2010\",0.8,0.55037663030664\n\"2011\",0.8,0.538261075574508\n\"2012\",0.8,0.537032171271821\n\"2013\",0.8,0.553036302254824\n\"2000\",0.9,0.727617616333413\n\"2001\",0.9,0.722725846379136\n\"2002\",0.9,0.721387677452933\n\"2003\",0.9,0.720729862038273\n\"2004\",0.9,0.714883349534787\n\"2005\",0.9,0.718740188707305\n\"2006\",0.9,0.710668789808917\n\"2007\",0.9,0.707173338752286\n\"2008\",0.9,0.705940019348597\n\"2009\",0.9,0.711439622741483\n\"2010\",0.9,0.710298698236601\n\"2011\",0.9,0.699664940603107\n\"2012\",0.9,0.695082346264202\n\"2013\",0.9,0.715677489267703\n\"2000\",1,1\n\"2001\",1,1\n\"2002\",1,1\n\"2003\",1,1\n\"2004\",1,1\n\"2005\",1,1\n\"2006\",1,1\n\"2007\",1,1\n\"2008\",1,1\n\"2009\",1,1\n\"2010\",1,1\n\"2011\",1,1\n\"2012\",1,1\n\"2013\",1,1\n\"NA\",0,0\n\"NA\",1,1"
        },
        {
            "name": ".0/group_by1/group_by2/arrange3",
            "source": ".0/group_by1/group_by2/arrange3_flat",
            "transform": [
                {
                    "type": "treefacet",
                    "keys": [
                        "data.factor(year)"
                    ]
                }
            ]
        },
        {
            "name": "scale/stroke",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"2000\"\n\"2001\"\n\"2002\"\n\"2003\"\n\"2004\"\n\"2005\"\n\"2006\"\n\"2007\"\n\"2008\"\n\"2009\"\n\"2010\"\n\"2011\"\n\"2012\"\n\"2013\""
        },
        {
            "name": "scale/x",
            "format": {
                "type": "csv",
                "parse": {
                    "domain": "number"
                }
            },
            "values": "\"domain\"\n-0.05\n1.05"
        },
        {
            "name": "scale/y",
            "format": {
                "type": "csv",
                "parse": {
                    "domain": "number"
                }
            },
            "values": "\"domain\"\n-0.05\n1.05"
        }
    ],
    "scales": [
        {
            "name": "stroke",
            "type": "ordinal",
            "domain": {
                "data": "scale/stroke",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "category10"
        },
        {
            "name": "x",
            "domain": {
                "data": "scale/x",
                "field": "data.domain"
            },
            "zero": false,
            "nice": false,
            "clamp": false,
            "range": "width"
        },
        {
            "name": "y",
            "domain": {
                "data": "scale/y",
                "field": "data.domain"
            },
            "zero": false,
            "nice": false,
            "clamp": false,
            "range": "height"
        }
    ],
    "marks": [
        {
            "type": "group",
            "from": {
                "data": ".0/group_by1/group_by2/arrange3"
            },
            "marks": [
                {
                    "type": "line",
                    "properties": {
                        "update": {
                            "stroke": {
                                "scale": "stroke",
                                "field": "data.factor(year)"
                            },
                            "x": {
                                "scale": "x",
                                "field": "data.population\\.cumprop"
                            },
                            "y": {
                                "scale": "y",
                                "field": "data.income\\.cumprop"
                            }
                        },
                        "ggvis": {
                            "data": {
                                "value": ".0/group_by1/group_by2/arrange3"
                            }
                        }
                    }
                }
            ]
        }
    ],
    "width": 768,
    "height": 576,
    "legends": [
        {
            "orient": "right",
            "title": "Year",
            "values": [
                2000,
                2001,
                2002,
                2003,
                2004,
                2005,
                2006,
                2007,
                2008,
                2009,
                2010,
                2011,
                2012,
                2013
            ],
            "stroke": "stroke"
        }
    ],
    "axes": [
        {
            "type": "x",
            "scale": "x",
            "orient": "bottom",
            "title": "Cumulative Population Proportion",
            "layer": "back",
            "grid": true
        },
        {
            "type": "y",
            "scale": "y",
            "orient": "left",
            "title": "Cumulative Income Proportion",
            "titleOffset": 40,
            "layer": "back",
            "grid": true
        }
    ],
    "padding": null,
    "ggvis_opts": {
        "keep_aspect": false,
        "resizable": true,
        "padding": {

        },
        "duration": 250,
        "renderer": "svg",
        "hover_duration": 0,
        "width": 768,
        "height": 576
    },
    "handlers": null
}
;
ggvis.getPlot("plot_id992566874").parseSpec(plot_id992566874_spec);
</script><!--/html_preserve-->

Consistent with the observation with the stacked area graph, the distribution of income
is fairly contant as shown by the well overlayed curves of 14 years of data.

### Ratio to Average Income of Bottom 10% by Deciles

Another way to show unequal income distrubution in a country is the ratio of 
the average income of the top 10 percentile to that of the bottom 10 percentile.
I have done so for all the deciles to the bottom decile as follows.


```r
# compute ratio of average income to bottom decile
income.decile <- income.decile %>%
                    group_by(year) %>%
                    arrange(decile) %>%
                    mutate(bottom.multiple = income / first(income)) %>%
                    ungroup()
income.decile %>%
    select(year, decile, bottom.multiple) %>%
    ggvis(~factor(year), ~bottom.multiple, stroke = ~factor(decile)) %>%
    group_by(decile) %>%
    layer_lines() %>%
    add_axis('x', title = 'Year') %>%
    add_axis('y', title = 'Multiple') %>%
    add_legend('stroke', title = 'Decile')
```

<!--html_preserve--><div id="plot_id480407310-container" class="ggvis-output-container">
<div id="plot_id480407310" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id480407310_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id480407310" data-renderer="svg">SVG</a>
 | 
<a id="plot_id480407310_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id480407310" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id480407310_download" class="ggvis-download" data-plot-id="plot_id480407310">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id480407310_spec = {
    "data": [
        {
            "name": ".0/group_by1/group_by2/arrange3_flat",
            "format": {
                "type": "csv",
                "parse": {
                    "bottom.multiple": "number"
                }
            },
            "values": "\"factor(decile)\",\"factor(year)\",\"bottom.multiple\"\n\"1\",\"2000\",1\n\"2\",\"2000\",1.60466926070039\n\"3\",\"2000\",2.12996108949416\n\"4\",\"2000\",2.62023346303502\n\"5\",\"2000\",3.18832684824903\n\"6\",\"2000\",3.75875486381323\n\"7\",\"2000\",4.49260700389105\n\"8\",\"2000\",5.38443579766537\n\"9\",\"2000\",6.71673151750973\n\"10\",\"2000\",11.5657587548638\n\"1\",\"2001\",1\n\"2\",\"2001\",1.68734491315136\n\"3\",\"2001\",2.24731182795699\n\"4\",\"2001\",2.84036393713813\n\"5\",\"2001\",3.4317617866005\n\"6\",\"2001\",4.14805624483044\n\"7\",\"2001\",4.93879239040529\n\"8\",\"2001\",6.09181141439206\n\"9\",\"2001\",7.90488006617039\n\"10\",\"2001\",13.1555004135649\n\"1\",\"2002\",1\n\"2\",\"2002\",1.69939183318853\n\"3\",\"2002\",2.28236316246742\n\"4\",\"2002\",2.87749782797567\n\"5\",\"2002\",3.5125977410947\n\"6\",\"2002\",4.24326672458732\n\"7\",\"2002\",5.11815812337098\n\"8\",\"2002\",6.24413553431798\n\"9\",\"2002\",7.94439617723719\n\"10\",\"2002\",13.4874022589053\n\"1\",\"2003\",1\n\"2\",\"2003\",1.74640287769784\n\"3\",\"2003\",2.39928057553957\n\"4\",\"2003\",2.99460431654676\n\"5\",\"2003\",3.68974820143885\n\"6\",\"2003\",4.47931654676259\n\"7\",\"2003\",5.33812949640288\n\"8\",\"2003\",6.54046762589928\n\"9\",\"2003\",8.22122302158273\n\"10\",\"2003\",14.1079136690647\n\"1\",\"2004\",1\n\"2\",\"2004\",1.76228070175439\n\"3\",\"2004\",2.38684210526316\n\"4\",\"2004\",3.00964912280702\n\"5\",\"2004\",3.68421052631579\n\"6\",\"2004\",4.36666666666667\n\"7\",\"2004\",5.26754385964912\n\"8\",\"2004\",6.36491228070175\n\"9\",\"2004\",8.28333333333333\n\"10\",\"2004\",14.4078947368421\n\"1\",\"2005\",1\n\"2\",\"2005\",1.77624784853701\n\"3\",\"2005\",2.43803786574871\n\"4\",\"2005\",3.1368330464716\n\"5\",\"2005\",3.77796901893287\n\"6\",\"2005\",4.56196213425129\n\"7\",\"2005\",5.55765920826162\n\"8\",\"2005\",6.75215146299484\n\"9\",\"2005\",8.43115318416523\n\"10\",\"2005\",14.6480206540447\n\"1\",\"2006\",1\n\"2\",\"2006\",1.81459227467811\n\"3\",\"2006\",2.49184549356223\n\"4\",\"2006\",3.15278969957082\n\"5\",\"2006\",3.87467811158798\n\"6\",\"2006\",4.70128755364807\n\"7\",\"2006\",5.60944206008584\n\"8\",\"2006\",6.90643776824034\n\"9\",\"2006\",8.75793991416309\n\"10\",\"2006\",15.5965665236051\n\"1\",\"2007\",1\n\"2\",\"2007\",1.81357318070319\n\"3\",\"2007\",2.51676206050695\n\"4\",\"2007\",3.22976287816844\n\"5\",\"2007\",3.98201144726083\n\"6\",\"2007\",4.87489779231398\n\"7\",\"2007\",5.91496320523303\n\"8\",\"2007\",7.10874897792314\n\"9\",\"2007\",9.39574816026165\n\"10\",\"2007\",16.4955028618152\n\"1\",\"2008\",1\n\"2\",\"2008\",1.89538461538462\n\"3\",\"2008\",2.66461538461538\n\"4\",\"2008\",3.4\n\"5\",\"2008\",4.19615384615385\n\"6\",\"2008\",5.19461538461538\n\"7\",\"2008\",6.23615384615385\n\"8\",\"2008\",7.57615384615385\n\"9\",\"2008\",9.93538461538462\n\"10\",\"2008\",17.5361538461538\n\"1\",\"2009\",1\n\"2\",\"2009\",1.94778481012658\n\"3\",\"2009\",2.71835443037975\n\"4\",\"2009\",3.55617088607595\n\"5\",\"2009\",4.26503164556962\n\"6\",\"2009\",5.22231012658228\n\"7\",\"2009\",6.30696202531646\n\"8\",\"2009\",7.7001582278481\n\"9\",\"2009\",9.77373417721519\n\"10\",\"2009\",17.2341772151899\n\"1\",\"2010\",1\n\"2\",\"2010\",1.93429602888087\n\"3\",\"2010\",2.71407942238267\n\"4\",\"2010\",3.52851985559567\n\"5\",\"2010\",4.30252707581227\n\"6\",\"2010\",5.11913357400722\n\"7\",\"2010\",6.10108303249097\n\"8\",\"2010\",7.32274368231047\n\"9\",\"2010\",9.30469314079422\n\"10\",\"2010\",16.85559566787\n\"1\",\"2011\",1\n\"2\",\"2011\",1.94109589041096\n\"3\",\"2011\",2.73150684931507\n\"4\",\"2011\",3.56164383561644\n\"5\",\"2011\",4.31712328767123\n\"6\",\"2011\",5.19657534246575\n\"7\",\"2011\",6.26506849315069\n\"8\",\"2011\",7.66643835616438\n\"9\",\"2011\",9.79931506849315\n\"10\",\"2011\",18.2342465753425\n\"1\",\"2012\",1\n\"2\",\"2012\",1.96640316205534\n\"3\",\"2012\",2.82608695652174\n\"4\",\"2012\",3.64229249011858\n\"5\",\"2012\",4.47957839262187\n\"6\",\"2012\",5.39920948616601\n\"7\",\"2012\",6.45981554677207\n\"8\",\"2012\",7.88735177865613\n\"9\",\"2012\",9.9064558629776\n\"10\",\"2012\",19.1119894598155\n\"1\",\"2013\",1\n\"2\",\"2013\",1.93456162642948\n\"3\",\"2013\",2.83799237611182\n\"4\",\"2013\",3.61880559085133\n\"5\",\"2013\",4.53303684879288\n\"6\",\"2013\",5.3869123252859\n\"7\",\"2013\",6.45425667090216\n\"8\",\"2013\",7.95489199491741\n\"9\",\"2013\",9.91677255400254\n\"10\",\"2013\",17.3360864040661"
        },
        {
            "name": ".0/group_by1/group_by2/arrange3",
            "source": ".0/group_by1/group_by2/arrange3_flat",
            "transform": [
                {
                    "type": "treefacet",
                    "keys": [
                        "data.factor(decile)"
                    ]
                }
            ]
        },
        {
            "name": "scale/stroke",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"1\"\n\"2\"\n\"3\"\n\"4\"\n\"5\"\n\"6\"\n\"7\"\n\"8\"\n\"9\"\n\"10\""
        },
        {
            "name": "scale/x",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"2000\"\n\"2001\"\n\"2002\"\n\"2003\"\n\"2004\"\n\"2005\"\n\"2006\"\n\"2007\"\n\"2008\"\n\"2009\"\n\"2010\"\n\"2011\"\n\"2012\"\n\"2013\""
        },
        {
            "name": "scale/y",
            "format": {
                "type": "csv",
                "parse": {
                    "domain": "number"
                }
            },
            "values": "\"domain\"\n0.0944005270092226\n20.0175889328063"
        }
    ],
    "scales": [
        {
            "name": "stroke",
            "type": "ordinal",
            "domain": {
                "data": "scale/stroke",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "category10"
        },
        {
            "name": "x",
            "type": "ordinal",
            "domain": {
                "data": "scale/x",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "width",
            "padding": 0.5
        },
        {
            "name": "y",
            "domain": {
                "data": "scale/y",
                "field": "data.domain"
            },
            "zero": false,
            "nice": false,
            "clamp": false,
            "range": "height"
        }
    ],
    "marks": [
        {
            "type": "group",
            "from": {
                "data": ".0/group_by1/group_by2/arrange3"
            },
            "marks": [
                {
                    "type": "line",
                    "properties": {
                        "update": {
                            "stroke": {
                                "scale": "stroke",
                                "field": "data.factor(decile)"
                            },
                            "x": {
                                "scale": "x",
                                "field": "data.factor(year)"
                            },
                            "y": {
                                "scale": "y",
                                "field": "data.bottom\\.multiple"
                            }
                        },
                        "ggvis": {
                            "data": {
                                "value": ".0/group_by1/group_by2/arrange3"
                            }
                        }
                    }
                }
            ]
        }
    ],
    "width": 768,
    "height": 576,
    "legends": [
        {
            "orient": "right",
            "title": "Decile",
            "stroke": "stroke"
        }
    ],
    "axes": [
        {
            "type": "x",
            "scale": "x",
            "orient": "bottom",
            "title": "Year",
            "layer": "back",
            "grid": true
        },
        {
            "type": "y",
            "scale": "y",
            "orient": "left",
            "title": "Multiple",
            "layer": "back",
            "grid": true
        }
    ],
    "padding": null,
    "ggvis_opts": {
        "keep_aspect": false,
        "resizable": true,
        "padding": {

        },
        "duration": 250,
        "renderer": "svg",
        "hover_duration": 0,
        "width": 768,
        "height": 576
    },
    "handlers": null
}
;
ggvis.getPlot("plot_id480407310").parseSpec(plot_id480407310_spec);
</script><!--/html_preserve-->

It can be observed that the top decile earned on average
17.34 times
the average income of the bottom decile in 2013.
Even the average income 2nd highest decile was 
9.92 times
the bottom decile in 2013.
While the ratios to the bottom decile had increase from year 2000, 
the consolation is that they has been relatively flat from around 2008 and 2009 onwards.
This meant that the bottom decile has been able to grow their income at the same proportion as the other deciles.

### Ratio to Average Income of Bottom 20% by Quintiles

It is usually the case that the ratio of income is made between the top 20% against the bottom 20%,
which will be what I attempt next.


```r
# create quintile groups and compute mean income
income.quintile <- income.decile %>%
                        mutate(quintile = (decile + 1) %/% 2) %>%
                        group_by(year, quintile) %>%
                        summarise(income = mean(income)) %>%
                        ungroup()
# compute ratio of average income to bottom quintile
income.quintile <- income.quintile %>%
    group_by(year) %>%
    arrange(quintile) %>%
    mutate(bottom.multiple = income / first(income)) %>%
    ungroup()
income.quintile %>%
    select(year, quintile, bottom.multiple) %>%
    ggvis(~factor(year), ~bottom.multiple, stroke = ~factor(quintile)) %>%
    group_by(quintile) %>%
    layer_lines() %>%
    add_axis('x', title = 'Year') %>%
    add_axis('y', title = 'Multiple') %>%
    add_legend('stroke', title = 'Quintile')
```

<!--html_preserve--><div id="plot_id677406055-container" class="ggvis-output-container">
<div id="plot_id677406055" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id677406055_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id677406055" data-renderer="svg">SVG</a>
 | 
<a id="plot_id677406055_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id677406055" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id677406055_download" class="ggvis-download" data-plot-id="plot_id677406055">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id677406055_spec = {
    "data": [
        {
            "name": ".0/group_by1/group_by2/arrange3_flat",
            "format": {
                "type": "csv",
                "parse": {
                    "bottom.multiple": "number"
                }
            },
            "values": "\"factor(quintile)\",\"factor(year)\",\"bottom.multiple\"\n\"1\",\"2000\",1\n\"2\",\"2000\",1.82372273677921\n\"3\",\"2000\",2.66716462503735\n\"4\",\"2000\",3.79205258440394\n\"5\",\"2000\",7.01912160143412\n\"1\",\"2001\",1\n\"2\",\"2001\",1.89319790704832\n\"3\",\"2001\",2.82056017236073\n\"4\",\"2001\",4.10464758387196\n\"5\",\"2001\",7.8368728839643\n\"1\",\"2002\",1\n\"2\",\"2002\",1.91149018345671\n\"3\",\"2002\",2.87318957193434\n\"4\",\"2002\",4.2092050209205\n\"5\",\"2002\",7.93949147087222\n\"1\",\"2003\",1\n\"2\",\"2003\",1.96398166339227\n\"3\",\"2003\",2.97445972495088\n\"4\",\"2003\",4.32514734774067\n\"5\",\"2003\",8.13032089063523\n\"1\",\"2004\",1\n\"2\",\"2004\",1.95363607494443\n\"3\",\"2004\",2.91457605589076\n\"4\",\"2004\",4.21117815179422\n\"5\",\"2004\",8.21467132422991\n\"1\",\"2005\",1\n\"2\",\"2005\",2.00805951642901\n\"3\",\"2005\",3.00402975821451\n\"4\",\"2005\",4.43397396156231\n\"5\",\"2005\",8.31308121512709\n\"1\",\"2006\",1\n\"2\",\"2006\",2.00548947849954\n\"3\",\"2006\",3.04696553827386\n\"4\",\"2006\",4.44678255565721\n\"5\",\"2006\",8.65294297041781\n\"1\",\"2007\",1\n\"2\",\"2007\",2.04242952630049\n\"3\",\"2007\",3.14792211566405\n\"4\",\"2007\",4.6288869514676\n\"5\",\"2007\",9.20226678291194\n\"1\",\"2008\",1\n\"2\",\"2008\",2.09458023379384\n\"3\",\"2008\",3.24335812964931\n\"4\",\"2008\",4.77045696068013\n\"5\",\"2008\",9.48804463336876\n\"1\",\"2009\",1\n\"2\",\"2009\",2.12855609232421\n\"3\",\"2009\",3.21846484165325\n\"4\",\"2009\",4.75174449812131\n\"5\",\"2009\",9.16210413311863\n\"1\",\"2010\",1\n\"2\",\"2010\",2.12746062992126\n\"3\",\"2010\",3.21087598425197\n\"4\",\"2010\",4.5748031496063\n\"5\",\"2010\",8.91535433070866\n\"1\",\"2011\",1\n\"2\",\"2011\",2.13972985561248\n\"3\",\"2011\",3.23474615742897\n\"4\",\"2011\",4.73684210526316\n\"5\",\"2011\",9.5316721006055\n\"1\",\"2012\",1\n\"2\",\"2012\",2.18054630246502\n\"3\",\"2012\",3.3302242949145\n\"4\",\"2012\",4.83655340883855\n\"5\",\"2012\",9.78236731068177\n\"1\",\"2013\",1\n\"2\",\"2013\",2.20025979649275\n\"3\",\"2013\",3.38038536479758\n\"4\",\"2013\",4.91015371292488\n\"5\",\"2013\",9.28685862740853"
        },
        {
            "name": ".0/group_by1/group_by2/arrange3",
            "source": ".0/group_by1/group_by2/arrange3_flat",
            "transform": [
                {
                    "type": "treefacet",
                    "keys": [
                        "data.factor(quintile)"
                    ]
                }
            ]
        },
        {
            "name": "scale/stroke",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"1\"\n\"2\"\n\"3\"\n\"4\"\n\"5\""
        },
        {
            "name": "scale/x",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"2000\"\n\"2001\"\n\"2002\"\n\"2003\"\n\"2004\"\n\"2005\"\n\"2006\"\n\"2007\"\n\"2008\"\n\"2009\"\n\"2010\"\n\"2011\"\n\"2012\"\n\"2013\""
        },
        {
            "name": "scale/y",
            "format": {
                "type": "csv",
                "parse": {
                    "domain": "number"
                }
            },
            "values": "\"domain\"\n0.560881634465912\n10.2214856762159"
        }
    ],
    "scales": [
        {
            "name": "stroke",
            "type": "ordinal",
            "domain": {
                "data": "scale/stroke",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "category10"
        },
        {
            "name": "x",
            "type": "ordinal",
            "domain": {
                "data": "scale/x",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "width",
            "padding": 0.5
        },
        {
            "name": "y",
            "domain": {
                "data": "scale/y",
                "field": "data.domain"
            },
            "zero": false,
            "nice": false,
            "clamp": false,
            "range": "height"
        }
    ],
    "marks": [
        {
            "type": "group",
            "from": {
                "data": ".0/group_by1/group_by2/arrange3"
            },
            "marks": [
                {
                    "type": "line",
                    "properties": {
                        "update": {
                            "stroke": {
                                "scale": "stroke",
                                "field": "data.factor(quintile)"
                            },
                            "x": {
                                "scale": "x",
                                "field": "data.factor(year)"
                            },
                            "y": {
                                "scale": "y",
                                "field": "data.bottom\\.multiple"
                            }
                        },
                        "ggvis": {
                            "data": {
                                "value": ".0/group_by1/group_by2/arrange3"
                            }
                        }
                    }
                }
            ]
        }
    ],
    "width": 768,
    "height": 576,
    "legends": [
        {
            "orient": "right",
            "title": "Quintile",
            "stroke": "stroke"
        }
    ],
    "axes": [
        {
            "type": "x",
            "scale": "x",
            "orient": "bottom",
            "title": "Year",
            "layer": "back",
            "grid": true
        },
        {
            "type": "y",
            "scale": "y",
            "orient": "left",
            "title": "Multiple",
            "layer": "back",
            "grid": true
        }
    ],
    "padding": null,
    "ggvis_opts": {
        "keep_aspect": false,
        "resizable": true,
        "padding": {

        },
        "duration": 250,
        "renderer": "svg",
        "hover_duration": 0,
        "width": 768,
        "height": 576
    },
    "handlers": null
}
;
ggvis.getPlot("plot_id677406055").parseSpec(plot_id677406055_spec);
</script><!--/html_preserve-->

The general trend is the same, with the top 20% earning 
9.29 times
the average income of the bottom 20% of earners in 2013.

## Distribution of Households by Monthly Income

Finally, I will explore the distribution of households by monttly income in Singapore.
The raw data is shown in the table as follows.


```r
income.distribution <- read.table('households-by-monthly-income.txt', header = T, check.names = F)
kable(income.distribution, digits = 2, caption = 'Table of Household Proportion by Monthly Income')
```



Table: Table of Household Proportion by Monthly Income

 year   unemployed   [0, 1000)   [1000, 2000)   [2000, 3000)   [3000, 4000)   [4000, 5000)   [5000, 6000)   [6000, 7000)   [7000, 8000)   [8000, 9000)   [9000, 10000)   [10000, 11000)   [11000, 12000)   [12000, 13000)   [13000, 14000)   [14000, 15000)   [15000, 17500)   [17500, 20000)   [20000, Inf)
-----  -----------  ----------  -------------  -------------  -------------  -------------  -------------  -------------  -------------  -------------  --------------  ---------------  ---------------  ---------------  ---------------  ---------------  ---------------  ---------------  -------------
 2000          8.6         3.9           13.8           14.7           13.1           10.3            8.2            6.3            4.6            3.5             2.6              2.1              1.5              1.2              0.9              0.7              1.3              0.8            2.0
 2001          6.9         4.4           13.3           14.2           12.6           10.0            8.3            6.3            4.7            3.9             3.0              2.2              1.7              1.4              1.1              0.8              1.6              1.1            2.5
 2002          9.0         4.6           13.6           14.1           12.4            9.8            7.9            6.1            4.8            3.6             2.9              2.3              1.3              1.3              1.0              0.7              1.5              1.0            2.2
 2003          9.7         5.2           13.0           13.9           12.2            9.7            8.2            6.0            4.6            3.6             2.6              2.2              1.5              1.3              1.1              0.7              1.4              0.9            2.3
 2004          9.8         4.8           12.9           13.6           12.2            9.8            7.8            6.0            4.8            3.8             2.7              2.1              1.6              1.4              1.0              0.7              1.5              0.9            2.5
 2005         10.0         4.8           12.3           12.7           11.5            9.4            7.9            6.3            5.0            3.9             2.8              2.4              1.8              1.5              1.2              0.9              1.7              1.0            2.9
 2006          9.0         4.9           11.9           12.4           11.3            9.5            8.2            6.4            4.9            3.9             3.0              2.6              1.9              1.6              1.2              0.9              1.6              1.3            3.4
 2007          8.6         4.7           10.9           11.2           10.6            9.2            7.9            6.7            5.3            4.2             3.4              3.0              1.9              2.0              1.5              1.1              2.1              1.5            4.2
 2008          8.6         4.0            9.5            9.8            9.7            8.9            7.6            6.4            5.9            4.6             3.9              3.4              2.5              2.0              1.6              1.4              2.7              1.8            5.5
 2009          9.6         4.3            9.0            9.9            9.9            8.5            8.2            6.7            5.2            4.6             3.7              3.4              2.4              2.3              1.8              1.4              2.6              1.6            4.9
 2010         10.5         3.7            8.2            9.3            9.3            8.6            7.8            6.6            5.6            4.8             3.9              3.4              2.6              2.2              1.8              1.5              2.8              1.8            5.7
 2011          9.3         3.4            7.5            8.3            8.3            8.2            7.5            6.7            6.0            5.2             4.2              3.7              2.7              2.5              2.1              1.8              3.6              2.2            6.8
 2012          9.2         3.2            7.0            7.3            7.7            8.0            7.3            6.4            5.9            5.3             4.2              4.2              3.2              2.6              2.3              1.9              3.8              2.6            7.7
 2013          9.4         2.9            7.2            7.2            7.4            7.4            6.9            6.3            5.8            5.0             4.6              4.3              3.3              3.0              2.5              2.1              4.0              2.6            8.3

Some data transformation is necessary as the umemployed proportions are not the interest of this exercise.
I would exclude the percentages and scale up the rest of the percentages accordingly.


```r
# convert to long format
income.distribution <- income.distribution %>%
                            gather(income, percentage, -year)
# exclude unemployed and rescale proportion
income.distribution <- income.distribution %>%
                            filter(income != 'unemployed') %>%
                            droplevels() %>%
                            group_by(year) %>%
                            mutate(proportion = percentage / sum(percentage)) %>%
                            ungroup()
```

### Line Graph of Household Proportion by Income Grooup

Due to the large number of groups which also follow different trends, I have elected to split this into
2 graphs.


```r
# for monthly income groups less than 7000
income.distribution %>%
    filter(income %in% levels(income)[1:7]) %>%
    droplevels() %>%
    ggvis(~factor(year), ~proportion, stroke = ~income) %>%
    group_by(income) %>%
    layer_lines() %>%
    add_axis('x', title = 'Year') %>%
    add_axis('y', title = 'Population Proportion', title_offset = 40) %>%
    add_legend('stroke', title = 'Income Group')
```

<!--html_preserve--><div id="plot_id868340416-container" class="ggvis-output-container">
<div id="plot_id868340416" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id868340416_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id868340416" data-renderer="svg">SVG</a>
 | 
<a id="plot_id868340416_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id868340416" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id868340416_download" class="ggvis-download" data-plot-id="plot_id868340416">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id868340416_spec = {
    "data": [
        {
            "name": ".0/group_by1/group_by2/arrange3_flat",
            "format": {
                "type": "csv",
                "parse": {
                    "proportion": "number"
                }
            },
            "values": "\"income\",\"factor(year)\",\"proportion\"\n\"[0, 1000)\",\"2000\",0.0426229508196721\n\"[0, 1000)\",\"2001\",0.0472610096670247\n\"[0, 1000)\",\"2002\",0.0504939626783754\n\"[0, 1000)\",\"2003\",0.0575221238938053\n\"[0, 1000)\",\"2004\",0.0532741398446171\n\"[0, 1000)\",\"2005\",0.0533333333333333\n\"[0, 1000)\",\"2006\",0.0539053905390539\n\"[0, 1000)\",\"2007\",0.0514223194748359\n\"[0, 1000)\",\"2008\",0.043859649122807\n\"[0, 1000)\",\"2009\",0.0475663716814159\n\"[0, 1000)\",\"2010\",0.0412946428571429\n\"[0, 1000)\",\"2011\",0.0374862183020948\n\"[0, 1000)\",\"2012\",0.0353200883002208\n\"[0, 1000)\",\"2013\",0.0319383259911894\n\"[1000, 2000)\",\"2000\",0.150819672131148\n\"[1000, 2000)\",\"2001\",0.142857142857143\n\"[1000, 2000)\",\"2002\",0.149286498353458\n\"[1000, 2000)\",\"2003\",0.143805309734513\n\"[1000, 2000)\",\"2004\",0.143174250832408\n\"[1000, 2000)\",\"2005\",0.136666666666667\n\"[1000, 2000)\",\"2006\",0.130913091309131\n\"[1000, 2000)\",\"2007\",0.11925601750547\n\"[1000, 2000)\",\"2008\",0.104166666666667\n\"[1000, 2000)\",\"2009\",0.0995575221238938\n\"[1000, 2000)\",\"2010\",0.0915178571428571\n\"[1000, 2000)\",\"2011\",0.0826901874310915\n\"[1000, 2000)\",\"2012\",0.0772626931567329\n\"[1000, 2000)\",\"2013\",0.079295154185022\n\"[2000, 3000)\",\"2000\",0.160655737704918\n\"[2000, 3000)\",\"2001\",0.152524167561762\n\"[2000, 3000)\",\"2002\",0.154774972557629\n\"[2000, 3000)\",\"2003\",0.153761061946903\n\"[2000, 3000)\",\"2004\",0.150943396226415\n\"[2000, 3000)\",\"2005\",0.141111111111111\n\"[2000, 3000)\",\"2006\",0.136413641364136\n\"[2000, 3000)\",\"2007\",0.12253829321663\n\"[2000, 3000)\",\"2008\",0.107456140350877\n\"[2000, 3000)\",\"2009\",0.109513274336283\n\"[2000, 3000)\",\"2010\",0.103794642857143\n\"[2000, 3000)\",\"2011\",0.0915104740904079\n\"[2000, 3000)\",\"2012\",0.0805739514348786\n\"[2000, 3000)\",\"2013\",0.079295154185022\n\"[3000, 4000)\",\"2000\",0.143169398907104\n\"[3000, 4000)\",\"2001\",0.135338345864662\n\"[3000, 4000)\",\"2002\",0.136114160263447\n\"[3000, 4000)\",\"2003\",0.134955752212389\n\"[3000, 4000)\",\"2004\",0.135405105438402\n\"[3000, 4000)\",\"2005\",0.127777777777778\n\"[3000, 4000)\",\"2006\",0.124312431243124\n\"[3000, 4000)\",\"2007\",0.115973741794311\n\"[3000, 4000)\",\"2008\",0.106359649122807\n\"[3000, 4000)\",\"2009\",0.109513274336283\n\"[3000, 4000)\",\"2010\",0.103794642857143\n\"[3000, 4000)\",\"2011\",0.0915104740904079\n\"[3000, 4000)\",\"2012\",0.0849889624724062\n\"[3000, 4000)\",\"2013\",0.0814977973568282\n\"[4000, 5000)\",\"2000\",0.112568306010929\n\"[4000, 5000)\",\"2001\",0.107411385606874\n\"[4000, 5000)\",\"2002\",0.107574094401756\n\"[4000, 5000)\",\"2003\",0.107300884955752\n\"[4000, 5000)\",\"2004\",0.108768035516093\n\"[4000, 5000)\",\"2005\",0.104444444444444\n\"[4000, 5000)\",\"2006\",0.104510451045105\n\"[4000, 5000)\",\"2007\",0.100656455142232\n\"[4000, 5000)\",\"2008\",0.0975877192982456\n\"[4000, 5000)\",\"2009\",0.0940265486725664\n\"[4000, 5000)\",\"2010\",0.0959821428571429\n\"[4000, 5000)\",\"2011\",0.0904079382579934\n\"[4000, 5000)\",\"2012\",0.0883002207505519\n\"[4000, 5000)\",\"2013\",0.0814977973568282\n\"[5000, 6000)\",\"2000\",0.0896174863387978\n\"[5000, 6000)\",\"2001\",0.0891514500537057\n\"[5000, 6000)\",\"2002\",0.0867178924259056\n\"[5000, 6000)\",\"2003\",0.0907079646017699\n\"[5000, 6000)\",\"2004\",0.0865704772475028\n\"[5000, 6000)\",\"2005\",0.0877777777777778\n\"[5000, 6000)\",\"2006\",0.0902090209020902\n\"[5000, 6000)\",\"2007\",0.0864332603938731\n\"[5000, 6000)\",\"2008\",0.0833333333333333\n\"[5000, 6000)\",\"2009\",0.0907079646017699\n\"[5000, 6000)\",\"2010\",0.0870535714285714\n\"[5000, 6000)\",\"2011\",0.0826901874310915\n\"[5000, 6000)\",\"2012\",0.0805739514348786\n\"[5000, 6000)\",\"2013\",0.0759911894273128\n\"[6000, 7000)\",\"2000\",0.0688524590163934\n\"[6000, 7000)\",\"2001\",0.0676691729323308\n\"[6000, 7000)\",\"2002\",0.0669593852908891\n\"[6000, 7000)\",\"2003\",0.0663716814159292\n\"[6000, 7000)\",\"2004\",0.0665926748057714\n\"[6000, 7000)\",\"2005\",0.07\n\"[6000, 7000)\",\"2006\",0.0704070407040704\n\"[6000, 7000)\",\"2007\",0.0733041575492341\n\"[6000, 7000)\",\"2008\",0.0701754385964912\n\"[6000, 7000)\",\"2009\",0.0741150442477876\n\"[6000, 7000)\",\"2010\",0.0736607142857143\n\"[6000, 7000)\",\"2011\",0.0738699007717751\n\"[6000, 7000)\",\"2012\",0.0706401766004415\n\"[6000, 7000)\",\"2013\",0.0693832599118943"
        },
        {
            "name": ".0/group_by1/group_by2/arrange3",
            "source": ".0/group_by1/group_by2/arrange3_flat",
            "transform": [
                {
                    "type": "treefacet",
                    "keys": [
                        "data.income"
                    ]
                }
            ]
        },
        {
            "name": "scale/stroke",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"[0, 1000)\"\n\"[1000, 2000)\"\n\"[2000, 3000)\"\n\"[3000, 4000)\"\n\"[4000, 5000)\"\n\"[5000, 6000)\"\n\"[6000, 7000)\""
        },
        {
            "name": "scale/x",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"2000\"\n\"2001\"\n\"2002\"\n\"2003\"\n\"2004\"\n\"2005\"\n\"2006\"\n\"2007\"\n\"2008\"\n\"2009\"\n\"2010\"\n\"2011\"\n\"2012\"\n\"2013\""
        },
        {
            "name": "scale/y",
            "format": {
                "type": "csv",
                "parse": {
                    "domain": "number"
                }
            },
            "values": "\"domain\"\n0.025502455405503\n0.167091608290604"
        }
    ],
    "scales": [
        {
            "name": "stroke",
            "type": "ordinal",
            "domain": {
                "data": "scale/stroke",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "category10"
        },
        {
            "name": "x",
            "type": "ordinal",
            "domain": {
                "data": "scale/x",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "width",
            "padding": 0.5
        },
        {
            "name": "y",
            "domain": {
                "data": "scale/y",
                "field": "data.domain"
            },
            "zero": false,
            "nice": false,
            "clamp": false,
            "range": "height"
        }
    ],
    "marks": [
        {
            "type": "group",
            "from": {
                "data": ".0/group_by1/group_by2/arrange3"
            },
            "marks": [
                {
                    "type": "line",
                    "properties": {
                        "update": {
                            "stroke": {
                                "scale": "stroke",
                                "field": "data.income"
                            },
                            "x": {
                                "scale": "x",
                                "field": "data.factor(year)"
                            },
                            "y": {
                                "scale": "y",
                                "field": "data.proportion"
                            }
                        },
                        "ggvis": {
                            "data": {
                                "value": ".0/group_by1/group_by2/arrange3"
                            }
                        }
                    }
                }
            ]
        }
    ],
    "width": 768,
    "height": 576,
    "legends": [
        {
            "orient": "right",
            "title": "Income Group",
            "stroke": "stroke"
        }
    ],
    "axes": [
        {
            "type": "x",
            "scale": "x",
            "orient": "bottom",
            "title": "Year",
            "layer": "back",
            "grid": true
        },
        {
            "type": "y",
            "scale": "y",
            "orient": "left",
            "title": "Population Proportion",
            "titleOffset": 40,
            "layer": "back",
            "grid": true
        }
    ],
    "padding": null,
    "ggvis_opts": {
        "keep_aspect": false,
        "resizable": true,
        "padding": {

        },
        "duration": 250,
        "renderer": "svg",
        "hover_duration": 0,
        "width": 768,
        "height": 576
    },
    "handlers": null
}
;
ggvis.getPlot("plot_id868340416").parseSpec(plot_id868340416_spec);
</script><!--/html_preserve-->

This graph shows the proportion of households with monthly income less than 7000.
The proportions in these income groups were generally decreasing, which is expected given
the income growth experienced. 
The proportion of households earning below 1000 fell below the year 2000 levels only
after year 2009, however, it started at a very low base of 
4.26%


```r
# for monthly income groups more than 7000
income.distribution %>%
    filter(income %in% levels(income)[8:18]) %>%
    droplevels() %>%
    ggvis(~factor(year), ~proportion, stroke = ~income) %>%
    group_by(income) %>%
    layer_lines() %>%
    add_axis('x', title = 'Year') %>%
    add_axis('y', title = 'Population Proportion', title_offset = 40) %>%
    add_legend('stroke', title = 'Income Group')
```

<!--html_preserve--><div id="plot_id845694015-container" class="ggvis-output-container">
<div id="plot_id845694015" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id845694015_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id845694015" data-renderer="svg">SVG</a>
 | 
<a id="plot_id845694015_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id845694015" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id845694015_download" class="ggvis-download" data-plot-id="plot_id845694015">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id845694015_spec = {
    "data": [
        {
            "name": ".0/group_by1/group_by2/arrange3_flat",
            "format": {
                "type": "csv",
                "parse": {
                    "proportion": "number"
                }
            },
            "values": "\"income\",\"factor(year)\",\"proportion\"\n\"[7000, 8000)\",\"2000\",0.0502732240437158\n\"[7000, 8000)\",\"2001\",0.0504833512352309\n\"[7000, 8000)\",\"2002\",0.0526893523600439\n\"[7000, 8000)\",\"2003\",0.0508849557522124\n\"[7000, 8000)\",\"2004\",0.0532741398446171\n\"[7000, 8000)\",\"2005\",0.0555555555555556\n\"[7000, 8000)\",\"2006\",0.0539053905390539\n\"[7000, 8000)\",\"2007\",0.0579868708971554\n\"[7000, 8000)\",\"2008\",0.0646929824561404\n\"[7000, 8000)\",\"2009\",0.0575221238938053\n\"[7000, 8000)\",\"2010\",0.0625\n\"[7000, 8000)\",\"2011\",0.0661521499448732\n\"[7000, 8000)\",\"2012\",0.065121412803532\n\"[7000, 8000)\",\"2013\",0.0638766519823789\n\"[8000, 9000)\",\"2000\",0.0382513661202186\n\"[8000, 9000)\",\"2001\",0.041890440386681\n\"[8000, 9000)\",\"2002\",0.0395170142700329\n\"[8000, 9000)\",\"2003\",0.0398230088495575\n\"[8000, 9000)\",\"2004\",0.0421753607103219\n\"[8000, 9000)\",\"2005\",0.0433333333333333\n\"[8000, 9000)\",\"2006\",0.0429042904290429\n\"[8000, 9000)\",\"2007\",0.0459518599562363\n\"[8000, 9000)\",\"2008\",0.0504385964912281\n\"[8000, 9000)\",\"2009\",0.0508849557522124\n\"[8000, 9000)\",\"2010\",0.0535714285714286\n\"[8000, 9000)\",\"2011\",0.0573318632855568\n\"[8000, 9000)\",\"2012\",0.0584988962472406\n\"[8000, 9000)\",\"2013\",0.0550660792951542\n\"[9000, 10000)\",\"2000\",0.0284153005464481\n\"[9000, 10000)\",\"2001\",0.0322234156820623\n\"[9000, 10000)\",\"2002\",0.0318331503841932\n\"[9000, 10000)\",\"2003\",0.0287610619469027\n\"[9000, 10000)\",\"2004\",0.0299667036625971\n\"[9000, 10000)\",\"2005\",0.0311111111111111\n\"[9000, 10000)\",\"2006\",0.033003300330033\n\"[9000, 10000)\",\"2007\",0.037199124726477\n\"[9000, 10000)\",\"2008\",0.0427631578947368\n\"[9000, 10000)\",\"2009\",0.040929203539823\n\"[9000, 10000)\",\"2010\",0.0435267857142857\n\"[9000, 10000)\",\"2011\",0.0463065049614112\n\"[9000, 10000)\",\"2012\",0.0463576158940397\n\"[9000, 10000)\",\"2013\",0.0506607929515418\n\"[10000, 11000)\",\"2000\",0.0229508196721312\n\"[10000, 11000)\",\"2001\",0.0236305048335124\n\"[10000, 11000)\",\"2002\",0.0252469813391877\n\"[10000, 11000)\",\"2003\",0.0243362831858407\n\"[10000, 11000)\",\"2004\",0.02330743618202\n\"[10000, 11000)\",\"2005\",0.0266666666666667\n\"[10000, 11000)\",\"2006\",0.0286028602860286\n\"[10000, 11000)\",\"2007\",0.0328227571115974\n\"[10000, 11000)\",\"2008\",0.037280701754386\n\"[10000, 11000)\",\"2009\",0.0376106194690265\n\"[10000, 11000)\",\"2010\",0.0379464285714286\n\"[10000, 11000)\",\"2011\",0.0407938257993385\n\"[10000, 11000)\",\"2012\",0.0463576158940397\n\"[10000, 11000)\",\"2013\",0.0473568281938326\n\"[11000, 12000)\",\"2000\",0.0163934426229508\n\"[11000, 12000)\",\"2001\",0.0182599355531686\n\"[11000, 12000)\",\"2002\",0.0142700329308452\n\"[11000, 12000)\",\"2003\",0.0165929203539823\n\"[11000, 12000)\",\"2004\",0.0177580466148724\n\"[11000, 12000)\",\"2005\",0.02\n\"[11000, 12000)\",\"2006\",0.0209020902090209\n\"[11000, 12000)\",\"2007\",0.0207877461706783\n\"[11000, 12000)\",\"2008\",0.0274122807017544\n\"[11000, 12000)\",\"2009\",0.0265486725663717\n\"[11000, 12000)\",\"2010\",0.0290178571428571\n\"[11000, 12000)\",\"2011\",0.0297684674751929\n\"[11000, 12000)\",\"2012\",0.0353200883002208\n\"[11000, 12000)\",\"2013\",0.0363436123348018\n\"[12000, 13000)\",\"2000\",0.0131147540983607\n\"[12000, 13000)\",\"2001\",0.0150375939849624\n\"[12000, 13000)\",\"2002\",0.0142700329308452\n\"[12000, 13000)\",\"2003\",0.0143805309734513\n\"[12000, 13000)\",\"2004\",0.0155382907880133\n\"[12000, 13000)\",\"2005\",0.0166666666666667\n\"[12000, 13000)\",\"2006\",0.0176017601760176\n\"[12000, 13000)\",\"2007\",0.0218818380743982\n\"[12000, 13000)\",\"2008\",0.0219298245614035\n\"[12000, 13000)\",\"2009\",0.0254424778761062\n\"[12000, 13000)\",\"2010\",0.0245535714285714\n\"[12000, 13000)\",\"2011\",0.0275633958103638\n\"[12000, 13000)\",\"2012\",0.0286975717439294\n\"[12000, 13000)\",\"2013\",0.0330396475770925\n\"[13000, 14000)\",\"2000\",0.00983606557377049\n\"[13000, 14000)\",\"2001\",0.0118152524167562\n\"[13000, 14000)\",\"2002\",0.0109769484083425\n\"[13000, 14000)\",\"2003\",0.0121681415929204\n\"[13000, 14000)\",\"2004\",0.0110987791342952\n\"[13000, 14000)\",\"2005\",0.0133333333333333\n\"[13000, 14000)\",\"2006\",0.0132013201320132\n\"[13000, 14000)\",\"2007\",0.0164113785557987\n\"[13000, 14000)\",\"2008\",0.0175438596491228\n\"[13000, 14000)\",\"2009\",0.0199115044247788\n\"[13000, 14000)\",\"2010\",0.0200892857142857\n\"[13000, 14000)\",\"2011\",0.0231532524807056\n\"[13000, 14000)\",\"2012\",0.0253863134657837\n\"[13000, 14000)\",\"2013\",0.0275330396475771\n\"[14000, 15000)\",\"2000\",0.00765027322404371\n\"[14000, 15000)\",\"2001\",0.00859291084854995\n\"[14000, 15000)\",\"2002\",0.00768386388583974\n\"[14000, 15000)\",\"2003\",0.00774336283185841\n\"[14000, 15000)\",\"2004\",0.00776914539400666\n\"[14000, 15000)\",\"2005\",0.01\n\"[14000, 15000)\",\"2006\",0.0099009900990099\n\"[14000, 15000)\",\"2007\",0.012035010940919\n\"[14000, 15000)\",\"2008\",0.0153508771929825\n\"[14000, 15000)\",\"2009\",0.0154867256637168\n\"[14000, 15000)\",\"2010\",0.0167410714285714\n\"[14000, 15000)\",\"2011\",0.019845644983462\n\"[14000, 15000)\",\"2012\",0.0209713024282561\n\"[14000, 15000)\",\"2013\",0.0231277533039648\n\"[15000, 17500)\",\"2000\",0.014207650273224\n\"[15000, 17500)\",\"2001\",0.0171858216970999\n\"[15000, 17500)\",\"2002\",0.0164654226125137\n\"[15000, 17500)\",\"2003\",0.0154867256637168\n\"[15000, 17500)\",\"2004\",0.0166481687014428\n\"[15000, 17500)\",\"2005\",0.0188888888888889\n\"[15000, 17500)\",\"2006\",0.0176017601760176\n\"[15000, 17500)\",\"2007\",0.0229759299781182\n\"[15000, 17500)\",\"2008\",0.0296052631578947\n\"[15000, 17500)\",\"2009\",0.0287610619469027\n\"[15000, 17500)\",\"2010\",0.03125\n\"[15000, 17500)\",\"2011\",0.0396912899669239\n\"[15000, 17500)\",\"2012\",0.0419426048565121\n\"[15000, 17500)\",\"2013\",0.0440528634361234\n\"[17500, 20000)\",\"2000\",0.0087431693989071\n\"[17500, 20000)\",\"2001\",0.0118152524167562\n\"[17500, 20000)\",\"2002\",0.0109769484083425\n\"[17500, 20000)\",\"2003\",0.00995575221238938\n\"[17500, 20000)\",\"2004\",0.00998890122086571\n\"[17500, 20000)\",\"2005\",0.0111111111111111\n\"[17500, 20000)\",\"2006\",0.0143014301430143\n\"[17500, 20000)\",\"2007\",0.0164113785557987\n\"[17500, 20000)\",\"2008\",0.0197368421052632\n\"[17500, 20000)\",\"2009\",0.0176991150442478\n\"[17500, 20000)\",\"2010\",0.0200892857142857\n\"[17500, 20000)\",\"2011\",0.0242557883131202\n\"[17500, 20000)\",\"2012\",0.0286975717439294\n\"[17500, 20000)\",\"2013\",0.0286343612334802\n\"[20000, Inf)\",\"2000\",0.0218579234972678\n\"[20000, Inf)\",\"2001\",0.0268528464017186\n\"[20000, Inf)\",\"2002\",0.0241492864983535\n\"[20000, Inf)\",\"2003\",0.0254424778761062\n\"[20000, Inf)\",\"2004\",0.0277469478357381\n\"[20000, Inf)\",\"2005\",0.0322222222222222\n\"[20000, Inf)\",\"2006\",0.0374037403740374\n\"[20000, Inf)\",\"2007\",0.0459518599562363\n\"[20000, Inf)\",\"2008\",0.0603070175438596\n\"[20000, Inf)\",\"2009\",0.0542035398230089\n\"[20000, Inf)\",\"2010\",0.0636160714285714\n\"[20000, Inf)\",\"2011\",0.0749724366041896\n\"[20000, Inf)\",\"2012\",0.0849889624724062\n\"[20000, Inf)\",\"2013\",0.091409691629956"
        },
        {
            "name": ".0/group_by1/group_by2/arrange3",
            "source": ".0/group_by1/group_by2/arrange3_flat",
            "transform": [
                {
                    "type": "treefacet",
                    "keys": [
                        "data.income"
                    ]
                }
            ]
        },
        {
            "name": "scale/stroke",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"[7000, 8000)\"\n\"[8000, 9000)\"\n\"[9000, 10000)\"\n\"[10000, 11000)\"\n\"[11000, 12000)\"\n\"[12000, 13000)\"\n\"[13000, 14000)\"\n\"[14000, 15000)\"\n\"[15000, 17500)\"\n\"[17500, 20000)\"\n\"[20000, Inf)\""
        },
        {
            "name": "scale/x",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"2000\"\n\"2001\"\n\"2002\"\n\"2003\"\n\"2004\"\n\"2005\"\n\"2006\"\n\"2007\"\n\"2008\"\n\"2009\"\n\"2010\"\n\"2011\"\n\"2012\"\n\"2013\""
        },
        {
            "name": "scale/y",
            "format": {
                "type": "csv",
                "parse": {
                    "domain": "number"
                }
            },
            "values": "\"domain\"\n0.0034623023037481\n0.0955976625502516"
        }
    ],
    "scales": [
        {
            "name": "stroke",
            "type": "ordinal",
            "domain": {
                "data": "scale/stroke",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "category10"
        },
        {
            "name": "x",
            "type": "ordinal",
            "domain": {
                "data": "scale/x",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "width",
            "padding": 0.5
        },
        {
            "name": "y",
            "domain": {
                "data": "scale/y",
                "field": "data.domain"
            },
            "zero": false,
            "nice": false,
            "clamp": false,
            "range": "height"
        }
    ],
    "marks": [
        {
            "type": "group",
            "from": {
                "data": ".0/group_by1/group_by2/arrange3"
            },
            "marks": [
                {
                    "type": "line",
                    "properties": {
                        "update": {
                            "stroke": {
                                "scale": "stroke",
                                "field": "data.income"
                            },
                            "x": {
                                "scale": "x",
                                "field": "data.factor(year)"
                            },
                            "y": {
                                "scale": "y",
                                "field": "data.proportion"
                            }
                        },
                        "ggvis": {
                            "data": {
                                "value": ".0/group_by1/group_by2/arrange3"
                            }
                        }
                    }
                }
            ]
        }
    ],
    "width": 768,
    "height": 576,
    "legends": [
        {
            "orient": "right",
            "title": "Income Group",
            "stroke": "stroke"
        }
    ],
    "axes": [
        {
            "type": "x",
            "scale": "x",
            "orient": "bottom",
            "title": "Year",
            "layer": "back",
            "grid": true
        },
        {
            "type": "y",
            "scale": "y",
            "orient": "left",
            "title": "Population Proportion",
            "titleOffset": 40,
            "layer": "back",
            "grid": true
        }
    ],
    "padding": null,
    "ggvis_opts": {
        "keep_aspect": false,
        "resizable": true,
        "padding": {

        },
        "duration": 250,
        "renderer": "svg",
        "hover_duration": 0,
        "width": 768,
        "height": 576
    },
    "handlers": null
}
;
ggvis.getPlot("plot_id845694015").parseSpec(plot_id845694015_spec);
</script><!--/html_preserve-->

On the other hand, the proportions for the groups with monthly income above 7000 were generally increasing.
The most exaggerated increase belonged to the group for the highest income group: 
those making more than 20,000 per month.

### Stacked Area Graph of Household Proportion by Monthly Income

I think it may be more intersting to observe this distribution of household by a stacked area graph.


```r
income.distribution %>%
    group_by(year) %>%
    mutate(to = cumsum(proportion), from = c(0, to[-n()])) %>%
    ggvis(x = ~factor(year), fill = ~factor(income), opacity := 0.8) %>%
    group_by(income) %>%
    layer_ribbons(y = ~from, y2 = ~to) %>%
    add_axis('x', title = 'Year') %>%
    add_axis('y', title = 'Cumulative Population Proportion') %>%
    add_legend('fill', title = 'Income Group')
```

<!--html_preserve--><div id="plot_id993948120-container" class="ggvis-output-container">
<div id="plot_id993948120" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id993948120_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id993948120" data-renderer="svg">SVG</a>
 | 
<a id="plot_id993948120_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id993948120" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id993948120_download" class="ggvis-download" data-plot-id="plot_id993948120">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id993948120_spec = {
    "data": [
        {
            "name": ".0/group_by1_flat",
            "format": {
                "type": "csv",
                "parse": {
                    "from": "number",
                    "to": "number"
                }
            },
            "values": "\"income\",\"factor(year)\",\"factor(income)\",\"from\",\"to\"\n\"[0, 1000)\",\"2000\",\"[0, 1000)\",0,0.0426229508196721\n\"[0, 1000)\",\"2001\",\"[0, 1000)\",0,0.0472610096670247\n\"[0, 1000)\",\"2002\",\"[0, 1000)\",0,0.0504939626783754\n\"[0, 1000)\",\"2003\",\"[0, 1000)\",0,0.0575221238938053\n\"[0, 1000)\",\"2004\",\"[0, 1000)\",0,0.0532741398446171\n\"[0, 1000)\",\"2005\",\"[0, 1000)\",0,0.0533333333333333\n\"[0, 1000)\",\"2006\",\"[0, 1000)\",0,0.0539053905390539\n\"[0, 1000)\",\"2007\",\"[0, 1000)\",0,0.0514223194748359\n\"[0, 1000)\",\"2008\",\"[0, 1000)\",0,0.043859649122807\n\"[0, 1000)\",\"2009\",\"[0, 1000)\",0,0.0475663716814159\n\"[0, 1000)\",\"2010\",\"[0, 1000)\",0,0.0412946428571429\n\"[0, 1000)\",\"2011\",\"[0, 1000)\",0,0.0374862183020948\n\"[0, 1000)\",\"2012\",\"[0, 1000)\",0,0.0353200883002208\n\"[0, 1000)\",\"2013\",\"[0, 1000)\",0,0.0319383259911894\n\"[1000, 2000)\",\"2000\",\"[1000, 2000)\",0.0426229508196721,0.19344262295082\n\"[1000, 2000)\",\"2001\",\"[1000, 2000)\",0.0472610096670247,0.190118152524168\n\"[1000, 2000)\",\"2002\",\"[1000, 2000)\",0.0504939626783754,0.199780461031833\n\"[1000, 2000)\",\"2003\",\"[1000, 2000)\",0.0575221238938053,0.201327433628319\n\"[1000, 2000)\",\"2004\",\"[1000, 2000)\",0.0532741398446171,0.196448390677026\n\"[1000, 2000)\",\"2005\",\"[1000, 2000)\",0.0533333333333333,0.19\n\"[1000, 2000)\",\"2006\",\"[1000, 2000)\",0.0539053905390539,0.184818481848185\n\"[1000, 2000)\",\"2007\",\"[1000, 2000)\",0.0514223194748359,0.170678336980306\n\"[1000, 2000)\",\"2008\",\"[1000, 2000)\",0.043859649122807,0.148026315789474\n\"[1000, 2000)\",\"2009\",\"[1000, 2000)\",0.0475663716814159,0.14712389380531\n\"[1000, 2000)\",\"2010\",\"[1000, 2000)\",0.0412946428571429,0.1328125\n\"[1000, 2000)\",\"2011\",\"[1000, 2000)\",0.0374862183020948,0.120176405733186\n\"[1000, 2000)\",\"2012\",\"[1000, 2000)\",0.0353200883002208,0.112582781456954\n\"[1000, 2000)\",\"2013\",\"[1000, 2000)\",0.0319383259911894,0.111233480176211\n\"[2000, 3000)\",\"2000\",\"[2000, 3000)\",0.19344262295082,0.354098360655738\n\"[2000, 3000)\",\"2001\",\"[2000, 3000)\",0.190118152524168,0.342642320085929\n\"[2000, 3000)\",\"2002\",\"[2000, 3000)\",0.199780461031833,0.354555433589462\n\"[2000, 3000)\",\"2003\",\"[2000, 3000)\",0.201327433628319,0.355088495575221\n\"[2000, 3000)\",\"2004\",\"[2000, 3000)\",0.196448390677026,0.347391786903441\n\"[2000, 3000)\",\"2005\",\"[2000, 3000)\",0.19,0.331111111111111\n\"[2000, 3000)\",\"2006\",\"[2000, 3000)\",0.184818481848185,0.321232123212321\n\"[2000, 3000)\",\"2007\",\"[2000, 3000)\",0.170678336980306,0.293216630196937\n\"[2000, 3000)\",\"2008\",\"[2000, 3000)\",0.148026315789474,0.255482456140351\n\"[2000, 3000)\",\"2009\",\"[2000, 3000)\",0.14712389380531,0.256637168141593\n\"[2000, 3000)\",\"2010\",\"[2000, 3000)\",0.1328125,0.236607142857143\n\"[2000, 3000)\",\"2011\",\"[2000, 3000)\",0.120176405733186,0.211686879823594\n\"[2000, 3000)\",\"2012\",\"[2000, 3000)\",0.112582781456954,0.193156732891832\n\"[2000, 3000)\",\"2013\",\"[2000, 3000)\",0.111233480176211,0.190528634361233\n\"[3000, 4000)\",\"2000\",\"[3000, 4000)\",0.354098360655738,0.497267759562842\n\"[3000, 4000)\",\"2001\",\"[3000, 4000)\",0.342642320085929,0.477980665950591\n\"[3000, 4000)\",\"2002\",\"[3000, 4000)\",0.354555433589462,0.490669593852909\n\"[3000, 4000)\",\"2003\",\"[3000, 4000)\",0.355088495575221,0.490044247787611\n\"[3000, 4000)\",\"2004\",\"[3000, 4000)\",0.347391786903441,0.482796892341842\n\"[3000, 4000)\",\"2005\",\"[3000, 4000)\",0.331111111111111,0.458888888888889\n\"[3000, 4000)\",\"2006\",\"[3000, 4000)\",0.321232123212321,0.445544554455446\n\"[3000, 4000)\",\"2007\",\"[3000, 4000)\",0.293216630196937,0.409190371991247\n\"[3000, 4000)\",\"2008\",\"[3000, 4000)\",0.255482456140351,0.361842105263158\n\"[3000, 4000)\",\"2009\",\"[3000, 4000)\",0.256637168141593,0.366150442477876\n\"[3000, 4000)\",\"2010\",\"[3000, 4000)\",0.236607142857143,0.340401785714286\n\"[3000, 4000)\",\"2011\",\"[3000, 4000)\",0.211686879823594,0.303197353914002\n\"[3000, 4000)\",\"2012\",\"[3000, 4000)\",0.193156732891832,0.278145695364238\n\"[3000, 4000)\",\"2013\",\"[3000, 4000)\",0.190528634361233,0.272026431718062\n\"[4000, 5000)\",\"2000\",\"[4000, 5000)\",0.497267759562842,0.60983606557377\n\"[4000, 5000)\",\"2001\",\"[4000, 5000)\",0.477980665950591,0.585392051557465\n\"[4000, 5000)\",\"2002\",\"[4000, 5000)\",0.490669593852909,0.598243688254665\n\"[4000, 5000)\",\"2003\",\"[4000, 5000)\",0.490044247787611,0.597345132743363\n\"[4000, 5000)\",\"2004\",\"[4000, 5000)\",0.482796892341842,0.591564927857936\n\"[4000, 5000)\",\"2005\",\"[4000, 5000)\",0.458888888888889,0.563333333333333\n\"[4000, 5000)\",\"2006\",\"[4000, 5000)\",0.445544554455446,0.55005500550055\n\"[4000, 5000)\",\"2007\",\"[4000, 5000)\",0.409190371991247,0.509846827133479\n\"[4000, 5000)\",\"2008\",\"[4000, 5000)\",0.361842105263158,0.459429824561403\n\"[4000, 5000)\",\"2009\",\"[4000, 5000)\",0.366150442477876,0.460176991150442\n\"[4000, 5000)\",\"2010\",\"[4000, 5000)\",0.340401785714286,0.436383928571429\n\"[4000, 5000)\",\"2011\",\"[4000, 5000)\",0.303197353914002,0.393605292171996\n\"[4000, 5000)\",\"2012\",\"[4000, 5000)\",0.278145695364238,0.36644591611479\n\"[4000, 5000)\",\"2013\",\"[4000, 5000)\",0.272026431718062,0.35352422907489\n\"[5000, 6000)\",\"2000\",\"[5000, 6000)\",0.60983606557377,0.699453551912568\n\"[5000, 6000)\",\"2001\",\"[5000, 6000)\",0.585392051557465,0.674543501611171\n\"[5000, 6000)\",\"2002\",\"[5000, 6000)\",0.598243688254665,0.684961580680571\n\"[5000, 6000)\",\"2003\",\"[5000, 6000)\",0.597345132743363,0.688053097345133\n\"[5000, 6000)\",\"2004\",\"[5000, 6000)\",0.591564927857936,0.678135405105438\n\"[5000, 6000)\",\"2005\",\"[5000, 6000)\",0.563333333333333,0.651111111111111\n\"[5000, 6000)\",\"2006\",\"[5000, 6000)\",0.55005500550055,0.64026402640264\n\"[5000, 6000)\",\"2007\",\"[5000, 6000)\",0.509846827133479,0.596280087527352\n\"[5000, 6000)\",\"2008\",\"[5000, 6000)\",0.459429824561403,0.542763157894737\n\"[5000, 6000)\",\"2009\",\"[5000, 6000)\",0.460176991150442,0.550884955752212\n\"[5000, 6000)\",\"2010\",\"[5000, 6000)\",0.436383928571429,0.5234375\n\"[5000, 6000)\",\"2011\",\"[5000, 6000)\",0.393605292171996,0.476295479603087\n\"[5000, 6000)\",\"2012\",\"[5000, 6000)\",0.36644591611479,0.447019867549669\n\"[5000, 6000)\",\"2013\",\"[5000, 6000)\",0.35352422907489,0.429515418502203\n\"[6000, 7000)\",\"2000\",\"[6000, 7000)\",0.699453551912568,0.768306010928962\n\"[6000, 7000)\",\"2001\",\"[6000, 7000)\",0.674543501611171,0.742212674543502\n\"[6000, 7000)\",\"2002\",\"[6000, 7000)\",0.684961580680571,0.75192096597146\n\"[6000, 7000)\",\"2003\",\"[6000, 7000)\",0.688053097345133,0.754424778761062\n\"[6000, 7000)\",\"2004\",\"[6000, 7000)\",0.678135405105438,0.74472807991121\n\"[6000, 7000)\",\"2005\",\"[6000, 7000)\",0.651111111111111,0.721111111111111\n\"[6000, 7000)\",\"2006\",\"[6000, 7000)\",0.64026402640264,0.710671067106711\n\"[6000, 7000)\",\"2007\",\"[6000, 7000)\",0.596280087527352,0.669584245076586\n\"[6000, 7000)\",\"2008\",\"[6000, 7000)\",0.542763157894737,0.612938596491228\n\"[6000, 7000)\",\"2009\",\"[6000, 7000)\",0.550884955752212,0.625\n\"[6000, 7000)\",\"2010\",\"[6000, 7000)\",0.5234375,0.597098214285714\n\"[6000, 7000)\",\"2011\",\"[6000, 7000)\",0.476295479603087,0.550165380374862\n\"[6000, 7000)\",\"2012\",\"[6000, 7000)\",0.447019867549669,0.51766004415011\n\"[6000, 7000)\",\"2013\",\"[6000, 7000)\",0.429515418502203,0.498898678414097\n\"[7000, 8000)\",\"2000\",\"[7000, 8000)\",0.768306010928962,0.818579234972678\n\"[7000, 8000)\",\"2001\",\"[7000, 8000)\",0.742212674543502,0.792696025778733\n\"[7000, 8000)\",\"2002\",\"[7000, 8000)\",0.75192096597146,0.804610318331504\n\"[7000, 8000)\",\"2003\",\"[7000, 8000)\",0.754424778761062,0.805309734513274\n\"[7000, 8000)\",\"2004\",\"[7000, 8000)\",0.74472807991121,0.798002219755827\n\"[7000, 8000)\",\"2005\",\"[7000, 8000)\",0.721111111111111,0.776666666666667\n\"[7000, 8000)\",\"2006\",\"[7000, 8000)\",0.710671067106711,0.764576457645765\n\"[7000, 8000)\",\"2007\",\"[7000, 8000)\",0.669584245076586,0.727571115973742\n\"[7000, 8000)\",\"2008\",\"[7000, 8000)\",0.612938596491228,0.677631578947368\n\"[7000, 8000)\",\"2009\",\"[7000, 8000)\",0.625,0.682522123893805\n\"[7000, 8000)\",\"2010\",\"[7000, 8000)\",0.597098214285714,0.659598214285714\n\"[7000, 8000)\",\"2011\",\"[7000, 8000)\",0.550165380374862,0.616317530319735\n\"[7000, 8000)\",\"2012\",\"[7000, 8000)\",0.51766004415011,0.582781456953642\n\"[7000, 8000)\",\"2013\",\"[7000, 8000)\",0.498898678414097,0.562775330396476\n\"[8000, 9000)\",\"2000\",\"[8000, 9000)\",0.818579234972678,0.856830601092896\n\"[8000, 9000)\",\"2001\",\"[8000, 9000)\",0.792696025778733,0.834586466165414\n\"[8000, 9000)\",\"2002\",\"[8000, 9000)\",0.804610318331504,0.844127332601537\n\"[8000, 9000)\",\"2003\",\"[8000, 9000)\",0.805309734513274,0.845132743362832\n\"[8000, 9000)\",\"2004\",\"[8000, 9000)\",0.798002219755827,0.840177580466149\n\"[8000, 9000)\",\"2005\",\"[8000, 9000)\",0.776666666666667,0.82\n\"[8000, 9000)\",\"2006\",\"[8000, 9000)\",0.764576457645765,0.807480748074807\n\"[8000, 9000)\",\"2007\",\"[8000, 9000)\",0.727571115973742,0.773522975929978\n\"[8000, 9000)\",\"2008\",\"[8000, 9000)\",0.677631578947368,0.728070175438596\n\"[8000, 9000)\",\"2009\",\"[8000, 9000)\",0.682522123893805,0.733407079646018\n\"[8000, 9000)\",\"2010\",\"[8000, 9000)\",0.659598214285714,0.713169642857143\n\"[8000, 9000)\",\"2011\",\"[8000, 9000)\",0.616317530319735,0.673649393605292\n\"[8000, 9000)\",\"2012\",\"[8000, 9000)\",0.582781456953642,0.641280353200883\n\"[8000, 9000)\",\"2013\",\"[8000, 9000)\",0.562775330396476,0.61784140969163\n\"[9000, 10000)\",\"2000\",\"[9000, 10000)\",0.856830601092896,0.885245901639344\n\"[9000, 10000)\",\"2001\",\"[9000, 10000)\",0.834586466165414,0.866809881847476\n\"[9000, 10000)\",\"2002\",\"[9000, 10000)\",0.844127332601537,0.87596048298573\n\"[9000, 10000)\",\"2003\",\"[9000, 10000)\",0.845132743362832,0.873893805309735\n\"[9000, 10000)\",\"2004\",\"[9000, 10000)\",0.840177580466149,0.870144284128746\n\"[9000, 10000)\",\"2005\",\"[9000, 10000)\",0.82,0.851111111111111\n\"[9000, 10000)\",\"2006\",\"[9000, 10000)\",0.807480748074807,0.84048404840484\n\"[9000, 10000)\",\"2007\",\"[9000, 10000)\",0.773522975929978,0.810722100656455\n\"[9000, 10000)\",\"2008\",\"[9000, 10000)\",0.728070175438596,0.770833333333333\n\"[9000, 10000)\",\"2009\",\"[9000, 10000)\",0.733407079646018,0.774336283185841\n\"[9000, 10000)\",\"2010\",\"[9000, 10000)\",0.713169642857143,0.756696428571429\n\"[9000, 10000)\",\"2011\",\"[9000, 10000)\",0.673649393605292,0.719955898566703\n\"[9000, 10000)\",\"2012\",\"[9000, 10000)\",0.641280353200883,0.687637969094923\n\"[9000, 10000)\",\"2013\",\"[9000, 10000)\",0.61784140969163,0.668502202643172\n\"[10000, 11000)\",\"2000\",\"[10000, 11000)\",0.885245901639344,0.908196721311475\n\"[10000, 11000)\",\"2001\",\"[10000, 11000)\",0.866809881847476,0.890440386680988\n\"[10000, 11000)\",\"2002\",\"[10000, 11000)\",0.87596048298573,0.901207464324918\n\"[10000, 11000)\",\"2003\",\"[10000, 11000)\",0.873893805309735,0.898230088495575\n\"[10000, 11000)\",\"2004\",\"[10000, 11000)\",0.870144284128746,0.893451720310766\n\"[10000, 11000)\",\"2005\",\"[10000, 11000)\",0.851111111111111,0.877777777777778\n\"[10000, 11000)\",\"2006\",\"[10000, 11000)\",0.84048404840484,0.869086908690869\n\"[10000, 11000)\",\"2007\",\"[10000, 11000)\",0.810722100656455,0.843544857768052\n\"[10000, 11000)\",\"2008\",\"[10000, 11000)\",0.770833333333333,0.808114035087719\n\"[10000, 11000)\",\"2009\",\"[10000, 11000)\",0.774336283185841,0.811946902654867\n\"[10000, 11000)\",\"2010\",\"[10000, 11000)\",0.756696428571429,0.794642857142857\n\"[10000, 11000)\",\"2011\",\"[10000, 11000)\",0.719955898566703,0.760749724366042\n\"[10000, 11000)\",\"2012\",\"[10000, 11000)\",0.687637969094923,0.733995584988963\n\"[10000, 11000)\",\"2013\",\"[10000, 11000)\",0.668502202643172,0.715859030837004\n\"[11000, 12000)\",\"2000\",\"[11000, 12000)\",0.908196721311475,0.924590163934426\n\"[11000, 12000)\",\"2001\",\"[11000, 12000)\",0.890440386680988,0.908700322234157\n\"[11000, 12000)\",\"2002\",\"[11000, 12000)\",0.901207464324918,0.915477497255763\n\"[11000, 12000)\",\"2003\",\"[11000, 12000)\",0.898230088495575,0.914823008849558\n\"[11000, 12000)\",\"2004\",\"[11000, 12000)\",0.893451720310766,0.911209766925638\n\"[11000, 12000)\",\"2005\",\"[11000, 12000)\",0.877777777777778,0.897777777777778\n\"[11000, 12000)\",\"2006\",\"[11000, 12000)\",0.869086908690869,0.88998899889989\n\"[11000, 12000)\",\"2007\",\"[11000, 12000)\",0.843544857768052,0.864332603938731\n\"[11000, 12000)\",\"2008\",\"[11000, 12000)\",0.808114035087719,0.835526315789474\n\"[11000, 12000)\",\"2009\",\"[11000, 12000)\",0.811946902654867,0.838495575221239\n\"[11000, 12000)\",\"2010\",\"[11000, 12000)\",0.794642857142857,0.823660714285714\n\"[11000, 12000)\",\"2011\",\"[11000, 12000)\",0.760749724366042,0.790518191841235\n\"[11000, 12000)\",\"2012\",\"[11000, 12000)\",0.733995584988963,0.769315673289183\n\"[11000, 12000)\",\"2013\",\"[11000, 12000)\",0.715859030837004,0.752202643171806\n\"[12000, 13000)\",\"2000\",\"[12000, 13000)\",0.924590163934426,0.937704918032787\n\"[12000, 13000)\",\"2001\",\"[12000, 13000)\",0.908700322234157,0.923737916219119\n\"[12000, 13000)\",\"2002\",\"[12000, 13000)\",0.915477497255763,0.929747530186608\n\"[12000, 13000)\",\"2003\",\"[12000, 13000)\",0.914823008849558,0.929203539823009\n\"[12000, 13000)\",\"2004\",\"[12000, 13000)\",0.911209766925638,0.926748057713652\n\"[12000, 13000)\",\"2005\",\"[12000, 13000)\",0.897777777777778,0.914444444444444\n\"[12000, 13000)\",\"2006\",\"[12000, 13000)\",0.88998899889989,0.907590759075908\n\"[12000, 13000)\",\"2007\",\"[12000, 13000)\",0.864332603938731,0.886214442013129\n\"[12000, 13000)\",\"2008\",\"[12000, 13000)\",0.835526315789474,0.857456140350877\n\"[12000, 13000)\",\"2009\",\"[12000, 13000)\",0.838495575221239,0.863938053097345\n\"[12000, 13000)\",\"2010\",\"[12000, 13000)\",0.823660714285714,0.848214285714286\n\"[12000, 13000)\",\"2011\",\"[12000, 13000)\",0.790518191841235,0.818081587651599\n\"[12000, 13000)\",\"2012\",\"[12000, 13000)\",0.769315673289183,0.798013245033113\n\"[12000, 13000)\",\"2013\",\"[12000, 13000)\",0.752202643171806,0.785242290748899\n\"[13000, 14000)\",\"2000\",\"[13000, 14000)\",0.937704918032787,0.947540983606557\n\"[13000, 14000)\",\"2001\",\"[13000, 14000)\",0.923737916219119,0.935553168635875\n\"[13000, 14000)\",\"2002\",\"[13000, 14000)\",0.929747530186608,0.940724478594951\n\"[13000, 14000)\",\"2003\",\"[13000, 14000)\",0.929203539823009,0.941371681415929\n\"[13000, 14000)\",\"2004\",\"[13000, 14000)\",0.926748057713652,0.937846836847947\n\"[13000, 14000)\",\"2005\",\"[13000, 14000)\",0.914444444444444,0.927777777777778\n\"[13000, 14000)\",\"2006\",\"[13000, 14000)\",0.907590759075908,0.920792079207921\n\"[13000, 14000)\",\"2007\",\"[13000, 14000)\",0.886214442013129,0.902625820568928\n\"[13000, 14000)\",\"2008\",\"[13000, 14000)\",0.857456140350877,0.875\n\"[13000, 14000)\",\"2009\",\"[13000, 14000)\",0.863938053097345,0.883849557522124\n\"[13000, 14000)\",\"2010\",\"[13000, 14000)\",0.848214285714286,0.868303571428572\n\"[13000, 14000)\",\"2011\",\"[13000, 14000)\",0.818081587651599,0.841234840132304\n\"[13000, 14000)\",\"2012\",\"[13000, 14000)\",0.798013245033113,0.823399558498896\n\"[13000, 14000)\",\"2013\",\"[13000, 14000)\",0.785242290748899,0.812775330396476\n\"[14000, 15000)\",\"2000\",\"[14000, 15000)\",0.947540983606557,0.955191256830601\n\"[14000, 15000)\",\"2001\",\"[14000, 15000)\",0.935553168635875,0.944146079484425\n\"[14000, 15000)\",\"2002\",\"[14000, 15000)\",0.940724478594951,0.94840834248079\n\"[14000, 15000)\",\"2003\",\"[14000, 15000)\",0.941371681415929,0.949115044247788\n\"[14000, 15000)\",\"2004\",\"[14000, 15000)\",0.937846836847947,0.945615982241953\n\"[14000, 15000)\",\"2005\",\"[14000, 15000)\",0.927777777777778,0.937777777777778\n\"[14000, 15000)\",\"2006\",\"[14000, 15000)\",0.920792079207921,0.930693069306931\n\"[14000, 15000)\",\"2007\",\"[14000, 15000)\",0.902625820568928,0.914660831509847\n\"[14000, 15000)\",\"2008\",\"[14000, 15000)\",0.875,0.890350877192982\n\"[14000, 15000)\",\"2009\",\"[14000, 15000)\",0.883849557522124,0.899336283185841\n\"[14000, 15000)\",\"2010\",\"[14000, 15000)\",0.868303571428572,0.885044642857143\n\"[14000, 15000)\",\"2011\",\"[14000, 15000)\",0.841234840132304,0.861080485115766\n\"[14000, 15000)\",\"2012\",\"[14000, 15000)\",0.823399558498896,0.844370860927152\n\"[14000, 15000)\",\"2013\",\"[14000, 15000)\",0.812775330396476,0.835903083700441\n\"[15000, 17500)\",\"2000\",\"[15000, 17500)\",0.955191256830601,0.969398907103825\n\"[15000, 17500)\",\"2001\",\"[15000, 17500)\",0.944146079484425,0.961331901181525\n\"[15000, 17500)\",\"2002\",\"[15000, 17500)\",0.94840834248079,0.964873765093304\n\"[15000, 17500)\",\"2003\",\"[15000, 17500)\",0.949115044247788,0.964601769911504\n\"[15000, 17500)\",\"2004\",\"[15000, 17500)\",0.945615982241953,0.962264150943396\n\"[15000, 17500)\",\"2005\",\"[15000, 17500)\",0.937777777777778,0.956666666666667\n\"[15000, 17500)\",\"2006\",\"[15000, 17500)\",0.930693069306931,0.948294829482948\n\"[15000, 17500)\",\"2007\",\"[15000, 17500)\",0.914660831509847,0.937636761487965\n\"[15000, 17500)\",\"2008\",\"[15000, 17500)\",0.890350877192982,0.919956140350877\n\"[15000, 17500)\",\"2009\",\"[15000, 17500)\",0.899336283185841,0.928097345132743\n\"[15000, 17500)\",\"2010\",\"[15000, 17500)\",0.885044642857143,0.916294642857143\n\"[15000, 17500)\",\"2011\",\"[15000, 17500)\",0.861080485115766,0.90077177508269\n\"[15000, 17500)\",\"2012\",\"[15000, 17500)\",0.844370860927152,0.886313465783665\n\"[15000, 17500)\",\"2013\",\"[15000, 17500)\",0.835903083700441,0.879955947136564\n\"[17500, 20000)\",\"2000\",\"[17500, 20000)\",0.969398907103825,0.978142076502732\n\"[17500, 20000)\",\"2001\",\"[17500, 20000)\",0.961331901181525,0.973147153598282\n\"[17500, 20000)\",\"2002\",\"[17500, 20000)\",0.964873765093304,0.975850713501647\n\"[17500, 20000)\",\"2003\",\"[17500, 20000)\",0.964601769911504,0.974557522123894\n\"[17500, 20000)\",\"2004\",\"[17500, 20000)\",0.962264150943396,0.972253052164262\n\"[17500, 20000)\",\"2005\",\"[17500, 20000)\",0.956666666666667,0.967777777777778\n\"[17500, 20000)\",\"2006\",\"[17500, 20000)\",0.948294829482948,0.962596259625963\n\"[17500, 20000)\",\"2007\",\"[17500, 20000)\",0.937636761487965,0.954048140043764\n\"[17500, 20000)\",\"2008\",\"[17500, 20000)\",0.919956140350877,0.93969298245614\n\"[17500, 20000)\",\"2009\",\"[17500, 20000)\",0.928097345132743,0.945796460176991\n\"[17500, 20000)\",\"2010\",\"[17500, 20000)\",0.916294642857143,0.936383928571429\n\"[17500, 20000)\",\"2011\",\"[17500, 20000)\",0.90077177508269,0.92502756339581\n\"[17500, 20000)\",\"2012\",\"[17500, 20000)\",0.886313465783665,0.915011037527594\n\"[17500, 20000)\",\"2013\",\"[17500, 20000)\",0.879955947136564,0.908590308370044\n\"[20000, Inf)\",\"2000\",\"[20000, Inf)\",0.978142076502732,1\n\"[20000, Inf)\",\"2001\",\"[20000, Inf)\",0.973147153598282,1\n\"[20000, Inf)\",\"2002\",\"[20000, Inf)\",0.975850713501647,1\n\"[20000, Inf)\",\"2003\",\"[20000, Inf)\",0.974557522123894,1\n\"[20000, Inf)\",\"2004\",\"[20000, Inf)\",0.972253052164262,1\n\"[20000, Inf)\",\"2005\",\"[20000, Inf)\",0.967777777777778,1\n\"[20000, Inf)\",\"2006\",\"[20000, Inf)\",0.962596259625963,1\n\"[20000, Inf)\",\"2007\",\"[20000, Inf)\",0.954048140043764,1\n\"[20000, Inf)\",\"2008\",\"[20000, Inf)\",0.93969298245614,1\n\"[20000, Inf)\",\"2009\",\"[20000, Inf)\",0.945796460176991,1\n\"[20000, Inf)\",\"2010\",\"[20000, Inf)\",0.936383928571429,1\n\"[20000, Inf)\",\"2011\",\"[20000, Inf)\",0.92502756339581,1\n\"[20000, Inf)\",\"2012\",\"[20000, Inf)\",0.915011037527594,1\n\"[20000, Inf)\",\"2013\",\"[20000, Inf)\",0.908590308370044,1"
        },
        {
            "name": ".0/group_by1",
            "source": ".0/group_by1_flat",
            "transform": [
                {
                    "type": "treefacet",
                    "keys": [
                        "data.income"
                    ]
                }
            ]
        },
        {
            "name": "scale/fill",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"[0, 1000)\"\n\"[1000, 2000)\"\n\"[2000, 3000)\"\n\"[3000, 4000)\"\n\"[4000, 5000)\"\n\"[5000, 6000)\"\n\"[6000, 7000)\"\n\"[7000, 8000)\"\n\"[8000, 9000)\"\n\"[9000, 10000)\"\n\"[10000, 11000)\"\n\"[11000, 12000)\"\n\"[12000, 13000)\"\n\"[13000, 14000)\"\n\"[14000, 15000)\"\n\"[15000, 17500)\"\n\"[17500, 20000)\"\n\"[20000, Inf)\""
        },
        {
            "name": "scale/x",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"2000\"\n\"2001\"\n\"2002\"\n\"2003\"\n\"2004\"\n\"2005\"\n\"2006\"\n\"2007\"\n\"2008\"\n\"2009\"\n\"2010\"\n\"2011\"\n\"2012\"\n\"2013\""
        },
        {
            "name": "scale/y",
            "format": {
                "type": "csv",
                "parse": {
                    "domain": "number"
                }
            },
            "values": "\"domain\"\n-0.05\n1.05"
        }
    ],
    "scales": [
        {
            "name": "fill",
            "type": "ordinal",
            "domain": {
                "data": "scale/fill",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "category10"
        },
        {
            "name": "x",
            "type": "ordinal",
            "domain": {
                "data": "scale/x",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "width",
            "padding": 0.5
        },
        {
            "name": "y",
            "domain": {
                "data": "scale/y",
                "field": "data.domain"
            },
            "zero": false,
            "nice": false,
            "clamp": false,
            "range": "height"
        }
    ],
    "marks": [
        {
            "type": "group",
            "from": {
                "data": ".0/group_by1"
            },
            "marks": [
                {
                    "type": "area",
                    "properties": {
                        "update": {
                            "x": {
                                "scale": "x",
                                "field": "data.factor(year)"
                            },
                            "fill": {
                                "scale": "fill",
                                "field": "data.factor(income)"
                            },
                            "opacity": {
                                "value": 0.8
                            },
                            "y": {
                                "scale": "y",
                                "field": "data.from"
                            },
                            "y2": {
                                "scale": "y",
                                "field": "data.to"
                            }
                        },
                        "ggvis": {
                            "data": {
                                "value": ".0/group_by1"
                            }
                        }
                    }
                }
            ]
        }
    ],
    "width": 768,
    "height": 576,
    "legends": [
        {
            "orient": "right",
            "title": "Income Group",
            "fill": "fill"
        }
    ],
    "axes": [
        {
            "type": "x",
            "scale": "x",
            "orient": "bottom",
            "title": "Year",
            "layer": "back",
            "grid": true
        },
        {
            "type": "y",
            "scale": "y",
            "orient": "left",
            "title": "Cumulative Population Proportion",
            "layer": "back",
            "grid": true
        }
    ],
    "padding": null,
    "ggvis_opts": {
        "keep_aspect": false,
        "resizable": true,
        "padding": {

        },
        "duration": 250,
        "renderer": "svg",
        "hover_duration": 0,
        "width": 768,
        "height": 576
    },
    "handlers": null
}
;
ggvis.getPlot("plot_id993948120").parseSpec(plot_id993948120_spec);
</script><!--/html_preserve-->

Not the most informative graph as the accumlated effects of the lower income groups makes it difficult
to make inference about the trends of the higher income groups.
A simple observation would be that about 50% of the households made less than 7000 monthly in 2013.
This is consistent with the median income level being 7000 monthly.
The income groups that formed the largest proportion of households are those between 1000 and 7000
and the higher earners above 20,000.

The cumulative proportion of households by income group in 2013 is shown in the table below.


```r
income.distribution %>%
    filter(year == 2013) %>%
    mutate(cumprop = cumsum(proportion) * 100) %>%
    select(income, cumprop) %>%
    kable(digits = 2, caption = 'Table of Cumulative Proportion of Households by Income Group in 2013')
```



Table: Table of Cumulative Proportion of Households by Income Group in 2013

income            cumprop
---------------  --------
[0, 1000)            3.19
[1000, 2000)        11.12
[2000, 3000)        19.05
[3000, 4000)        27.20
[4000, 5000)        35.35
[5000, 6000)        42.95
[6000, 7000)        49.89
[7000, 8000)        56.28
[8000, 9000)        61.78
[9000, 10000)       66.85
[10000, 11000)      71.59
[11000, 12000)      75.22
[12000, 13000)      78.52
[13000, 14000)      81.28
[14000, 15000)      83.59
[15000, 17500)      88.00
[17500, 20000)      90.86
[20000, Inf)       100.00

### Household Distribution by Monthly Income

Finally, let's look at the change in household distribution by monthly income over the years.


```r
income.distribution %>%
    ggvis(~income, ~proportion, stroke = ~factor(year)) %>%
    group_by(year) %>%
    layer_lines() %>%
    add_axis('x', title = 'Income Group', title_offset = 50,
             properties = axis_props(labels = list(angle = 20, align = 'left'))) %>%
    add_axis('y', title = 'Population Proportion', title_offset = 40) %>%
    add_legend('stroke', title = 'Year')
```

<!--html_preserve--><div id="plot_id966455674-container" class="ggvis-output-container">
<div id="plot_id966455674" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id966455674_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id966455674" data-renderer="svg">SVG</a>
 | 
<a id="plot_id966455674_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id966455674" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id966455674_download" class="ggvis-download" data-plot-id="plot_id966455674">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id966455674_spec = {
    "data": [
        {
            "name": ".0/group_by1/group_by2/arrange3_flat",
            "format": {
                "type": "csv",
                "parse": {
                    "proportion": "number"
                }
            },
            "values": "\"factor(year)\",\"income\",\"proportion\"\n\"2000\",\"[0, 1000)\",0.0426229508196721\n\"2001\",\"[0, 1000)\",0.0472610096670247\n\"2002\",\"[0, 1000)\",0.0504939626783754\n\"2003\",\"[0, 1000)\",0.0575221238938053\n\"2004\",\"[0, 1000)\",0.0532741398446171\n\"2005\",\"[0, 1000)\",0.0533333333333333\n\"2006\",\"[0, 1000)\",0.0539053905390539\n\"2007\",\"[0, 1000)\",0.0514223194748359\n\"2008\",\"[0, 1000)\",0.043859649122807\n\"2009\",\"[0, 1000)\",0.0475663716814159\n\"2010\",\"[0, 1000)\",0.0412946428571429\n\"2011\",\"[0, 1000)\",0.0374862183020948\n\"2012\",\"[0, 1000)\",0.0353200883002208\n\"2013\",\"[0, 1000)\",0.0319383259911894\n\"2000\",\"[1000, 2000)\",0.150819672131148\n\"2001\",\"[1000, 2000)\",0.142857142857143\n\"2002\",\"[1000, 2000)\",0.149286498353458\n\"2003\",\"[1000, 2000)\",0.143805309734513\n\"2004\",\"[1000, 2000)\",0.143174250832408\n\"2005\",\"[1000, 2000)\",0.136666666666667\n\"2006\",\"[1000, 2000)\",0.130913091309131\n\"2007\",\"[1000, 2000)\",0.11925601750547\n\"2008\",\"[1000, 2000)\",0.104166666666667\n\"2009\",\"[1000, 2000)\",0.0995575221238938\n\"2010\",\"[1000, 2000)\",0.0915178571428571\n\"2011\",\"[1000, 2000)\",0.0826901874310915\n\"2012\",\"[1000, 2000)\",0.0772626931567329\n\"2013\",\"[1000, 2000)\",0.079295154185022\n\"2000\",\"[2000, 3000)\",0.160655737704918\n\"2001\",\"[2000, 3000)\",0.152524167561762\n\"2002\",\"[2000, 3000)\",0.154774972557629\n\"2003\",\"[2000, 3000)\",0.153761061946903\n\"2004\",\"[2000, 3000)\",0.150943396226415\n\"2005\",\"[2000, 3000)\",0.141111111111111\n\"2006\",\"[2000, 3000)\",0.136413641364136\n\"2007\",\"[2000, 3000)\",0.12253829321663\n\"2008\",\"[2000, 3000)\",0.107456140350877\n\"2009\",\"[2000, 3000)\",0.109513274336283\n\"2010\",\"[2000, 3000)\",0.103794642857143\n\"2011\",\"[2000, 3000)\",0.0915104740904079\n\"2012\",\"[2000, 3000)\",0.0805739514348786\n\"2013\",\"[2000, 3000)\",0.079295154185022\n\"2000\",\"[3000, 4000)\",0.143169398907104\n\"2001\",\"[3000, 4000)\",0.135338345864662\n\"2002\",\"[3000, 4000)\",0.136114160263447\n\"2003\",\"[3000, 4000)\",0.134955752212389\n\"2004\",\"[3000, 4000)\",0.135405105438402\n\"2005\",\"[3000, 4000)\",0.127777777777778\n\"2006\",\"[3000, 4000)\",0.124312431243124\n\"2007\",\"[3000, 4000)\",0.115973741794311\n\"2008\",\"[3000, 4000)\",0.106359649122807\n\"2009\",\"[3000, 4000)\",0.109513274336283\n\"2010\",\"[3000, 4000)\",0.103794642857143\n\"2011\",\"[3000, 4000)\",0.0915104740904079\n\"2012\",\"[3000, 4000)\",0.0849889624724062\n\"2013\",\"[3000, 4000)\",0.0814977973568282\n\"2000\",\"[4000, 5000)\",0.112568306010929\n\"2001\",\"[4000, 5000)\",0.107411385606874\n\"2002\",\"[4000, 5000)\",0.107574094401756\n\"2003\",\"[4000, 5000)\",0.107300884955752\n\"2004\",\"[4000, 5000)\",0.108768035516093\n\"2005\",\"[4000, 5000)\",0.104444444444444\n\"2006\",\"[4000, 5000)\",0.104510451045105\n\"2007\",\"[4000, 5000)\",0.100656455142232\n\"2008\",\"[4000, 5000)\",0.0975877192982456\n\"2009\",\"[4000, 5000)\",0.0940265486725664\n\"2010\",\"[4000, 5000)\",0.0959821428571429\n\"2011\",\"[4000, 5000)\",0.0904079382579934\n\"2012\",\"[4000, 5000)\",0.0883002207505519\n\"2013\",\"[4000, 5000)\",0.0814977973568282\n\"2000\",\"[5000, 6000)\",0.0896174863387978\n\"2001\",\"[5000, 6000)\",0.0891514500537057\n\"2002\",\"[5000, 6000)\",0.0867178924259056\n\"2003\",\"[5000, 6000)\",0.0907079646017699\n\"2004\",\"[5000, 6000)\",0.0865704772475028\n\"2005\",\"[5000, 6000)\",0.0877777777777778\n\"2006\",\"[5000, 6000)\",0.0902090209020902\n\"2007\",\"[5000, 6000)\",0.0864332603938731\n\"2008\",\"[5000, 6000)\",0.0833333333333333\n\"2009\",\"[5000, 6000)\",0.0907079646017699\n\"2010\",\"[5000, 6000)\",0.0870535714285714\n\"2011\",\"[5000, 6000)\",0.0826901874310915\n\"2012\",\"[5000, 6000)\",0.0805739514348786\n\"2013\",\"[5000, 6000)\",0.0759911894273128\n\"2000\",\"[6000, 7000)\",0.0688524590163934\n\"2001\",\"[6000, 7000)\",0.0676691729323308\n\"2002\",\"[6000, 7000)\",0.0669593852908891\n\"2003\",\"[6000, 7000)\",0.0663716814159292\n\"2004\",\"[6000, 7000)\",0.0665926748057714\n\"2005\",\"[6000, 7000)\",0.07\n\"2006\",\"[6000, 7000)\",0.0704070407040704\n\"2007\",\"[6000, 7000)\",0.0733041575492341\n\"2008\",\"[6000, 7000)\",0.0701754385964912\n\"2009\",\"[6000, 7000)\",0.0741150442477876\n\"2010\",\"[6000, 7000)\",0.0736607142857143\n\"2011\",\"[6000, 7000)\",0.0738699007717751\n\"2012\",\"[6000, 7000)\",0.0706401766004415\n\"2013\",\"[6000, 7000)\",0.0693832599118943\n\"2000\",\"[7000, 8000)\",0.0502732240437158\n\"2001\",\"[7000, 8000)\",0.0504833512352309\n\"2002\",\"[7000, 8000)\",0.0526893523600439\n\"2003\",\"[7000, 8000)\",0.0508849557522124\n\"2004\",\"[7000, 8000)\",0.0532741398446171\n\"2005\",\"[7000, 8000)\",0.0555555555555556\n\"2006\",\"[7000, 8000)\",0.0539053905390539\n\"2007\",\"[7000, 8000)\",0.0579868708971554\n\"2008\",\"[7000, 8000)\",0.0646929824561404\n\"2009\",\"[7000, 8000)\",0.0575221238938053\n\"2010\",\"[7000, 8000)\",0.0625\n\"2011\",\"[7000, 8000)\",0.0661521499448732\n\"2012\",\"[7000, 8000)\",0.065121412803532\n\"2013\",\"[7000, 8000)\",0.0638766519823789\n\"2000\",\"[8000, 9000)\",0.0382513661202186\n\"2001\",\"[8000, 9000)\",0.041890440386681\n\"2002\",\"[8000, 9000)\",0.0395170142700329\n\"2003\",\"[8000, 9000)\",0.0398230088495575\n\"2004\",\"[8000, 9000)\",0.0421753607103219\n\"2005\",\"[8000, 9000)\",0.0433333333333333\n\"2006\",\"[8000, 9000)\",0.0429042904290429\n\"2007\",\"[8000, 9000)\",0.0459518599562363\n\"2008\",\"[8000, 9000)\",0.0504385964912281\n\"2009\",\"[8000, 9000)\",0.0508849557522124\n\"2010\",\"[8000, 9000)\",0.0535714285714286\n\"2011\",\"[8000, 9000)\",0.0573318632855568\n\"2012\",\"[8000, 9000)\",0.0584988962472406\n\"2013\",\"[8000, 9000)\",0.0550660792951542\n\"2000\",\"[9000, 10000)\",0.0284153005464481\n\"2001\",\"[9000, 10000)\",0.0322234156820623\n\"2002\",\"[9000, 10000)\",0.0318331503841932\n\"2003\",\"[9000, 10000)\",0.0287610619469027\n\"2004\",\"[9000, 10000)\",0.0299667036625971\n\"2005\",\"[9000, 10000)\",0.0311111111111111\n\"2006\",\"[9000, 10000)\",0.033003300330033\n\"2007\",\"[9000, 10000)\",0.037199124726477\n\"2008\",\"[9000, 10000)\",0.0427631578947368\n\"2009\",\"[9000, 10000)\",0.040929203539823\n\"2010\",\"[9000, 10000)\",0.0435267857142857\n\"2011\",\"[9000, 10000)\",0.0463065049614112\n\"2012\",\"[9000, 10000)\",0.0463576158940397\n\"2013\",\"[9000, 10000)\",0.0506607929515418\n\"2000\",\"[10000, 11000)\",0.0229508196721312\n\"2001\",\"[10000, 11000)\",0.0236305048335124\n\"2002\",\"[10000, 11000)\",0.0252469813391877\n\"2003\",\"[10000, 11000)\",0.0243362831858407\n\"2004\",\"[10000, 11000)\",0.02330743618202\n\"2005\",\"[10000, 11000)\",0.0266666666666667\n\"2006\",\"[10000, 11000)\",0.0286028602860286\n\"2007\",\"[10000, 11000)\",0.0328227571115974\n\"2008\",\"[10000, 11000)\",0.037280701754386\n\"2009\",\"[10000, 11000)\",0.0376106194690265\n\"2010\",\"[10000, 11000)\",0.0379464285714286\n\"2011\",\"[10000, 11000)\",0.0407938257993385\n\"2012\",\"[10000, 11000)\",0.0463576158940397\n\"2013\",\"[10000, 11000)\",0.0473568281938326\n\"2000\",\"[11000, 12000)\",0.0163934426229508\n\"2001\",\"[11000, 12000)\",0.0182599355531686\n\"2002\",\"[11000, 12000)\",0.0142700329308452\n\"2003\",\"[11000, 12000)\",0.0165929203539823\n\"2004\",\"[11000, 12000)\",0.0177580466148724\n\"2005\",\"[11000, 12000)\",0.02\n\"2006\",\"[11000, 12000)\",0.0209020902090209\n\"2007\",\"[11000, 12000)\",0.0207877461706783\n\"2008\",\"[11000, 12000)\",0.0274122807017544\n\"2009\",\"[11000, 12000)\",0.0265486725663717\n\"2010\",\"[11000, 12000)\",0.0290178571428571\n\"2011\",\"[11000, 12000)\",0.0297684674751929\n\"2012\",\"[11000, 12000)\",0.0353200883002208\n\"2013\",\"[11000, 12000)\",0.0363436123348018\n\"2000\",\"[12000, 13000)\",0.0131147540983607\n\"2001\",\"[12000, 13000)\",0.0150375939849624\n\"2002\",\"[12000, 13000)\",0.0142700329308452\n\"2003\",\"[12000, 13000)\",0.0143805309734513\n\"2004\",\"[12000, 13000)\",0.0155382907880133\n\"2005\",\"[12000, 13000)\",0.0166666666666667\n\"2006\",\"[12000, 13000)\",0.0176017601760176\n\"2007\",\"[12000, 13000)\",0.0218818380743982\n\"2008\",\"[12000, 13000)\",0.0219298245614035\n\"2009\",\"[12000, 13000)\",0.0254424778761062\n\"2010\",\"[12000, 13000)\",0.0245535714285714\n\"2011\",\"[12000, 13000)\",0.0275633958103638\n\"2012\",\"[12000, 13000)\",0.0286975717439294\n\"2013\",\"[12000, 13000)\",0.0330396475770925\n\"2000\",\"[13000, 14000)\",0.00983606557377049\n\"2001\",\"[13000, 14000)\",0.0118152524167562\n\"2002\",\"[13000, 14000)\",0.0109769484083425\n\"2003\",\"[13000, 14000)\",0.0121681415929204\n\"2004\",\"[13000, 14000)\",0.0110987791342952\n\"2005\",\"[13000, 14000)\",0.0133333333333333\n\"2006\",\"[13000, 14000)\",0.0132013201320132\n\"2007\",\"[13000, 14000)\",0.0164113785557987\n\"2008\",\"[13000, 14000)\",0.0175438596491228\n\"2009\",\"[13000, 14000)\",0.0199115044247788\n\"2010\",\"[13000, 14000)\",0.0200892857142857\n\"2011\",\"[13000, 14000)\",0.0231532524807056\n\"2012\",\"[13000, 14000)\",0.0253863134657837\n\"2013\",\"[13000, 14000)\",0.0275330396475771\n\"2000\",\"[14000, 15000)\",0.00765027322404371\n\"2001\",\"[14000, 15000)\",0.00859291084854995\n\"2002\",\"[14000, 15000)\",0.00768386388583974\n\"2003\",\"[14000, 15000)\",0.00774336283185841\n\"2004\",\"[14000, 15000)\",0.00776914539400666\n\"2005\",\"[14000, 15000)\",0.01\n\"2006\",\"[14000, 15000)\",0.0099009900990099\n\"2007\",\"[14000, 15000)\",0.012035010940919\n\"2008\",\"[14000, 15000)\",0.0153508771929825\n\"2009\",\"[14000, 15000)\",0.0154867256637168\n\"2010\",\"[14000, 15000)\",0.0167410714285714\n\"2011\",\"[14000, 15000)\",0.019845644983462\n\"2012\",\"[14000, 15000)\",0.0209713024282561\n\"2013\",\"[14000, 15000)\",0.0231277533039648\n\"2000\",\"[15000, 17500)\",0.014207650273224\n\"2001\",\"[15000, 17500)\",0.0171858216970999\n\"2002\",\"[15000, 17500)\",0.0164654226125137\n\"2003\",\"[15000, 17500)\",0.0154867256637168\n\"2004\",\"[15000, 17500)\",0.0166481687014428\n\"2005\",\"[15000, 17500)\",0.0188888888888889\n\"2006\",\"[15000, 17500)\",0.0176017601760176\n\"2007\",\"[15000, 17500)\",0.0229759299781182\n\"2008\",\"[15000, 17500)\",0.0296052631578947\n\"2009\",\"[15000, 17500)\",0.0287610619469027\n\"2010\",\"[15000, 17500)\",0.03125\n\"2011\",\"[15000, 17500)\",0.0396912899669239\n\"2012\",\"[15000, 17500)\",0.0419426048565121\n\"2013\",\"[15000, 17500)\",0.0440528634361234\n\"2000\",\"[17500, 20000)\",0.0087431693989071\n\"2001\",\"[17500, 20000)\",0.0118152524167562\n\"2002\",\"[17500, 20000)\",0.0109769484083425\n\"2003\",\"[17500, 20000)\",0.00995575221238938\n\"2004\",\"[17500, 20000)\",0.00998890122086571\n\"2005\",\"[17500, 20000)\",0.0111111111111111\n\"2006\",\"[17500, 20000)\",0.0143014301430143\n\"2007\",\"[17500, 20000)\",0.0164113785557987\n\"2008\",\"[17500, 20000)\",0.0197368421052632\n\"2009\",\"[17500, 20000)\",0.0176991150442478\n\"2010\",\"[17500, 20000)\",0.0200892857142857\n\"2011\",\"[17500, 20000)\",0.0242557883131202\n\"2012\",\"[17500, 20000)\",0.0286975717439294\n\"2013\",\"[17500, 20000)\",0.0286343612334802\n\"2000\",\"[20000, Inf)\",0.0218579234972678\n\"2001\",\"[20000, Inf)\",0.0268528464017186\n\"2002\",\"[20000, Inf)\",0.0241492864983535\n\"2003\",\"[20000, Inf)\",0.0254424778761062\n\"2004\",\"[20000, Inf)\",0.0277469478357381\n\"2005\",\"[20000, Inf)\",0.0322222222222222\n\"2006\",\"[20000, Inf)\",0.0374037403740374\n\"2007\",\"[20000, Inf)\",0.0459518599562363\n\"2008\",\"[20000, Inf)\",0.0603070175438596\n\"2009\",\"[20000, Inf)\",0.0542035398230089\n\"2010\",\"[20000, Inf)\",0.0636160714285714\n\"2011\",\"[20000, Inf)\",0.0749724366041896\n\"2012\",\"[20000, Inf)\",0.0849889624724062\n\"2013\",\"[20000, Inf)\",0.091409691629956"
        },
        {
            "name": ".0/group_by1/group_by2/arrange3",
            "source": ".0/group_by1/group_by2/arrange3_flat",
            "transform": [
                {
                    "type": "treefacet",
                    "keys": [
                        "data.factor(year)"
                    ]
                }
            ]
        },
        {
            "name": "scale/stroke",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"2000\"\n\"2001\"\n\"2002\"\n\"2003\"\n\"2004\"\n\"2005\"\n\"2006\"\n\"2007\"\n\"2008\"\n\"2009\"\n\"2010\"\n\"2011\"\n\"2012\"\n\"2013\""
        },
        {
            "name": "scale/x",
            "format": {
                "type": "csv",
                "parse": {

                }
            },
            "values": "\"domain\"\n\"[0, 1000)\"\n\"[1000, 2000)\"\n\"[2000, 3000)\"\n\"[3000, 4000)\"\n\"[4000, 5000)\"\n\"[5000, 6000)\"\n\"[6000, 7000)\"\n\"[7000, 8000)\"\n\"[8000, 9000)\"\n\"[9000, 10000)\"\n\"[10000, 11000)\"\n\"[11000, 12000)\"\n\"[12000, 13000)\"\n\"[13000, 14000)\"\n\"[14000, 15000)\"\n\"[15000, 17500)\"\n\"[17500, 20000)\"\n\"[20000, Inf)\""
        },
        {
            "name": "scale/y",
            "format": {
                "type": "csv",
                "parse": {
                    "domain": "number"
                }
            },
            "values": "\"domain\"\n-1.73472347597681e-18\n0.168306010928962"
        }
    ],
    "scales": [
        {
            "name": "stroke",
            "type": "ordinal",
            "domain": {
                "data": "scale/stroke",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "category10"
        },
        {
            "name": "x",
            "type": "ordinal",
            "domain": {
                "data": "scale/x",
                "field": "data.domain"
            },
            "points": true,
            "sort": false,
            "range": "width",
            "padding": 0.5
        },
        {
            "name": "y",
            "domain": {
                "data": "scale/y",
                "field": "data.domain"
            },
            "zero": false,
            "nice": false,
            "clamp": false,
            "range": "height"
        }
    ],
    "marks": [
        {
            "type": "group",
            "from": {
                "data": ".0/group_by1/group_by2/arrange3"
            },
            "marks": [
                {
                    "type": "line",
                    "properties": {
                        "update": {
                            "stroke": {
                                "scale": "stroke",
                                "field": "data.factor(year)"
                            },
                            "x": {
                                "scale": "x",
                                "field": "data.income"
                            },
                            "y": {
                                "scale": "y",
                                "field": "data.proportion"
                            }
                        },
                        "ggvis": {
                            "data": {
                                "value": ".0/group_by1/group_by2/arrange3"
                            }
                        }
                    }
                }
            ]
        }
    ],
    "width": 768,
    "height": 576,
    "legends": [
        {
            "orient": "right",
            "title": "Year",
            "stroke": "stroke"
        }
    ],
    "axes": [
        {
            "type": "x",
            "scale": "x",
            "orient": "bottom",
            "title": "Income Group",
            "titleOffset": 50,
            "layer": "back",
            "grid": true,
            "properties": {
                "labels": {
                    "angle": {
                        "value": 20
                    },
                    "align": {
                        "value": "left"
                    }
                }
            }
        },
        {
            "type": "y",
            "scale": "y",
            "orient": "left",
            "title": "Population Proportion",
            "titleOffset": 40,
            "layer": "back",
            "grid": true
        }
    ],
    "padding": null,
    "ggvis_opts": {
        "keep_aspect": false,
        "resizable": true,
        "padding": {

        },
        "duration": 250,
        "renderer": "svg",
        "hover_duration": 0,
        "width": 768,
        "height": 576
    },
    "handlers": null
}
;
ggvis.getPlot("plot_id966455674").parseSpec(plot_id966455674_spec);
</script><!--/html_preserve-->

As evident in the previous graphs, the proportion of households with income less than 6000 have been decreasing,
with the proportions moving to income groups more than 7000.
The group earning between 2000 and 3000 have traditionally formed the largest proportion of household in Singapore.
However, the proportion of household earning more than 20,000 formed the largest proportion in the latest
data in year 2013.

## Conclusion

I hope this visualisation exercise of household income data of Singapore has given some insights
into the distribution and trends of income in Singapore.
It has definitely been a good practice for me in using the data wrangling and visualisation packages
by [Hadley Wickham](http://had.co.nz/) (i.e. `dplyr`, `tidyr`, `ggvis`) 
and also writing reports in R Markdown.

Future work that can be explored includes the household expenses data published also by SingStats.
Other than monthly expenses data, it also contains breakdown of monthly income by a few categories.
These may allow further breakdown of monthly income distribution.
Inflation data can also be included to investigate real income growth and 
give a better comparison of income over the period.
Another information that can be added is monthly income at various percentile. 
Unfortunately, it is not part of the information published by SingStats.
