#' Create standard DAU template for RStudio project
#'
#' @param path path of the new project
#' @param include_structure_for_pkg additional structure for package development
#' @param include_github_gitignore should a strict gitingore file for GitHub be created
#' @param ... additional parameters, currently not used
#'
#' @return no return values, just the folders and README are created
#' @importFrom utils installed.packages
#' @importFrom withr with_dir
#' @importFrom usethis create_package create_project use_testthat use_test 
#' @importFrom usethis proj_set
#' @export
dau_proj_template <- function(
    path,
    include_structure_for_pkg,
    include_github_gitignore,
    ...) {
  
  # Package setup
  if (include_structure_for_pkg) {

    usethis::create_package(path = path, open = FALSE)
    withr::with_dir(path, {
      usethis::use_testthat()
    })
  #   
  #   # # Extras
  #   # usethis::use_r("helpers")
  #   # usethis::use_test()
  #   # usethis::use_readme_rmd()
  #   # usethis::use_rmd()
  #   # usethis::use_code_of_conduct(Sys.getenv("USERNAME"))
  #   # usethis::use_vignette("helpers")
  #   # usethis::use_version(which = "dev")
  #   
  #   
  } else {
    # ensure that the path exists
    usethis::create_project(path = path, open = FALSE)
    usethis::proj_set(path)
  }

  
  # create folder structure
  dir.create(paste0(path, "/01_Data"))
  dir.create(paste0(path, "/01_Data/01_Raw"))
  dir.create(paste0(path, "/01_Data/02_Clean"))
  
  
  usethis::use_r(name = "load_data.R", open = FALSE)
  usethis::use_r(name = "helpers.R", open = FALSE)
  dir.create(paste0(path, "/R/src"))
  help_text <- c(paste0('# Your functions can go here. Then, when you want to ',
                        'call those functions, run\n',
                        '# `source("R/helpers.R")` at the start of your script.\n',
                        'print("Your scripts and functions should be in the R ',
                        'folder.")'
                        ))
  writeLines(help_text, paste0(path, "/R/helpers.R"))
  
  
  usethis::use_testthat()
  usethis::use_test("load_data.R", open = FALSE)
  usethis::use_test("helpers.R", open = FALSE)

  
  dir.create(paste0(path, "/02_Analysis"))
  file.create(paste0(path, "/02_Analysis/analysis.Rmd"))
  file.create(paste0(path, "/02_Analysis/analysis.qmd"))
  
  dir.create(paste0(path, "/03_Documentation"))
  dir.create(paste0(path, "/03_Documentation/01_text"))
  dir.create(paste0(path, "/03_Documentation/02_figures"))
  
  dir.create(paste0(path, "/04_Outputs"))
  dir.create(paste0(path, "/04_Outputs/01_results"))
  dir.create(paste0(path, "/04_Outputs/02_figures"))
  dir.create(paste0(path, "/04_Outputs/03_tables"))
  
  dir.create(paste0(path, "/05_Misc"))
  dir.create(paste0(path, "/05_Misc/01_public"))
  dir.create(paste0(path, "/05_Misc/02_priv"))
  
  # .gitignore for Azure DevOps
  gitignore_content <- c(
    ".Rproj.user",
    ".Rhistory",
    ".RData",
    ".Ruserdata",
    "01_Data"
  )
  
  gitignore_content <- paste0(gitignore_content, collapse = "\n")
  writeLines(gitignore_content, con = file.path(path, ".gitignore"))
  
  # create a .gitignore file
  if (include_github_gitignore) {
    gitignore_content <- c(
      ".Rproj.user",
      ".Rhistory",
      ".RData",
      ".Ruserdata",
      "01_Data",
      "*/02_results",
      "*/03_figures",
      "*/04_tables",
      "03_Documentation/02_figures",
      "04_Outputs",      
      "05_Misc/02_priv",
      "*.html",
      "*.xlsx"
    )
    
    gitignore_content <- paste0(gitignore_content, collapse = "\n")
    writeLines(gitignore_content, con = file.path(path, ".gitignore"))
    
  }
  
  # create a readme
  content <- c(
    "# Readme",
    "This is the template for a standard data analysis.",
    "Please give an overview what you do in this project and how to navigate it.",
    "",
    "## Introduction",
    "TODO: Give a short introduction of your project. Let this section explain the objectives or the motivation behind this project.",
    "",
    "## Getting Started",
    "TODO: Guide users through getting your code up and running on their own system. In this section you can talk about:",
    "1.	Installation process",
    "2.	Software dependencies",
    "3.	Latest releases",
    "4.	API references",
    "",
    "# Build and Test",
    "TODO: Describe and show how to build your code and run the tests.",
    "",
    "# Contribute",
    "TODO: Explain how other users and developers can contribute to make your code better.",
    "",
    "## Git integration",
    "If you want to use git with your project (you should!), please do the following steps (replace `<name of your repository>` with the actual name):",
    "",
    "1.  Go to your git repository provider (GitHub/Azure DevOps) and create a new repository",
    "2.  DON'T check 'Add a README file'",
    "3.  Go to the Terminal within RStudio and type the following commands (for the URL, e.g. https://github.com):",
    "",
    "```bash",
    "git init",
    "git branch -M main",
    "git remote add origin <URL of your GitHub/Azure DevOps instance>/<name of your repository>.git",
    "```",
    "",
    "4.  Restart RStudio",
    "5.  Type in the R terminal `bash git add .` to add all files to the commit",
    '5.  Type in the R terminal `bash git commit -m "Your commit message (initial commit)"` to commit those files with a message.',
    "6.  In the terminal, execute the following command:",
    "",
    "```bash",
    "git push -u origin main",
    "```",
    "",
    "7.  For the following commits, repeat this process",
    "",
    "Please note that the following directories and files are not tracked by git by default (but you can change it in the .gitignore file):",
    "",
    "-   01_Data",
    "",
    "NOTE: For sharing content on GitHub you should have ticked the 'Create a .gitignore file for GitHub' checkbox when creating the projetc.",
    "This will give create a strict .gitignore which is suitable for sharing code to the public.",
    "Please also review to ensure no sensitive information is shared.",
    "",
    "For more information about the integration of git and RStudio, check out https://happygitwithr.com."
  )
  content <- paste0(content, collapse = "\n")
  writeLines(content, con = file.path(path, "README.md"))
  
  # initialise renv
  if (requireNamespace("renv", quietly = TRUE)) {
    renv::init(project = normalizePath(path),
               bare = TRUE)
  } else {
    warning(
      paste0("renv couldn't be used as the `renv` package is not installed.",
             "If you want to use renv, please first install it with `install",
             ".packages('renv')`")
    )
  }
}
