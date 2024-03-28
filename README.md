# The analysistemplates package

The RStudio projects of your colleagues all have a different structure? It is
difficult to navigate and understand others' projects? Or even your own project
from a few months/years ago? Therefore, it is useful
if you all agree on a standard folder structure for your analysis. Templates can
help to enforce this. Currently, this package provides one standard data analysis
template for RStudio projects geared towards scientific use cases. Whenever you
start a new project in RStudio, this package provides the standard folder structure
directly in your code editor. Also, it can help you improving reproducibility by
using git and `renv`.

![folder structure of the template](man/figures/overview_folder_structure.png)

## Installation

``` r
remotes::install_github("JT-39/dau-R-template")
```

## Usage

To create a new project with the folder structure shown below, follow these steps:

1.  Install the package
2.  Restart RStudio
3.  When creating a new RStudio project with the "New directory" option, choose "Standard analysis template"

    ![RStudio Project Wizard showing the "Standard analysis template" option](man/figures/project_wizard_with_template.png)

4.  During initialization you can select if a folder called `06_Analysis_for_publication` is included (check "Include Analysis for publication folder")
5.  You can select if you want to generate a `.gitignore` file (check "Create a .gitignore file")
6.  You can select if you want to use `renv` (check "Use renv with this project")
7.  Once you've created the project, you will be provided with the instructions how to create a git repository for your project and connect to github/gitlab

## Template overview

A new project contains the following folder structure:

```
|-- Data
|   |-- 01_Raw
|   `-- 02_Clean
|   R
|   |-- src
|   |   |-- fun_load_data.R
|   |   |-- fun_helpers.R
|   |   |-- fun_transform_data.R
|-- Analysis
|   |-- analysis.Rmd
|   |-- analysis.qmd
|-- Documentation
|   |-- 01_Text
|   `-- 02_Final_figures
|-- Outputs
|   |-- 01_Results              
|   |-- 02_Figures              
|   `-- 03_Tables    
|-- Misc
|   |-- Public              
|   |-- Priv
|-- README.md
|-- .gitignore                  
|-- renv                        
```
## Planned features

- better integration with git/github

## I want a different template

You can easily create your own template. Fork this repo and create a new pair of
`<my_template>.R` and `<my_template>.dcf` files. `<my_template>.dcf` defines
how your template is named and which options are shown when you select the
template in the project wizard. `<my_template>.R` defines what happens when the
template is used. Have a look at `standard_analysis.R` and `standard_analysis.dcf`
for inspiration or check out the [RStudio Extensions documentation](https://rstudio.github.io/rstudio-extensions/rstudio_project_templates.html).
