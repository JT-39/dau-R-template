#' Create standard analysis template for RStudio project
#'
#' @param path path of the new project
#' @param include_structure_for_pkg additional Analysis for publication folder
#' @param include_github_gitignore should a gitingore file be created
#' @param ... additional parameters, currently not used
#'
#' @return no return values, just the folders and README are created
#' @importFrom utils installed.packages
#' @importFrom usethis create_package use_test
#' @export
dau_proj_template <- function(
    path,
    include_structure_for_pkg,
    include_github_gitignore,
    ...) {
  
  # Package setup
  if (include_structure_for_pkg) {

    usethis::create_package(path = path, open = FALSE)
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
    dir.create(path, recursive = TRUE, showWarnings = FALSE)
  }

  
  # create folder structure
  dir.create(paste0(path, "/Data"))
  dir.create(paste0(path, "/Data/01_Raw"))
  dir.create(paste0(path, "/Data/02_Clean"))
  
  dir.create(paste0(path, "/R"))
  dir.create(paste0(path, "/R/src"))
  file.create(paste0(path, "/R/src/fun_load_data.R"))
  file.create(paste0(path, "/R/src/fun_helpers.R"))
  file.create(paste0(path, "/R/src/fun_transform_data.R"))

  dir.create(paste0(path, "/Analysis"))
  file.create(paste0(path, "/Analysis/analysis.Rmd"))
  file.create(paste0(path, "/Analysis/analysis.qmd"))
  
  # usethis::use_test()
  
  dir.create(paste0(path, "/Documentation"))
  dir.create(paste0(path, "/Documentation/01_Text"))
  dir.create(paste0(path, "/Documentation/02_Final_figures"))
  
  dir.create(paste0(path, "/Outputs"))
  dir.create(paste0(path, "/Outputs/01_Results"))
  dir.create(paste0(path, "/Outputs/02_Figures"))
  dir.create(paste0(path, "/Outputs/03_Tables"))
  
  dir.create(paste0(path, "/Misc"))
  dir.create(paste0(path, "/Misc/Public"))
  dir.create(paste0(path, "/Misc/Priv"))
  
  # .gitignore for Azure DevOps
  gitignore_content <- c(
    ".Rproj.user",
    ".Rhistory",
    ".RData",
    ".Ruserdata",
    "Data"
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
      "Data",
      "*/02_Results",
      "*/03_Figures",
      "*/04_Tables",
      "Documentation/02_Final_figures",
      "Outputs",
      "*.html"
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
    "## Git integration",
    "If you want to use git with your project (you should!), please do the following steps (replace `<name of your repository>` with the actual name):",
    "",
    "1.  Go to your git repository provider (github/gitlab) and create a new repository",
    "2.  DON'T check 'Add a README file'",
    "3.  Go to the Terminal within RStudio and type the following commands (for the URL, e.g. https://github.com):",
    "",
    "```bash",
    "git init",
    "git branch -M main",
    "git remote add origin <URL of your github/gitlab instance>/<name of your repository>.git",
    "```",
    "",
    "4.  Restart RStudio",
    "5.  Select the files you want to commit in the git pane, click 'commit', in the pop-up write a commit message and click 'commit'",
    "6.  In the terminal, execute the following command:",
    "",
    "```bash",
    "git push -u origin main",
    "```",
    "",
    "7.  For the following commits, you can use the 'push' button in the git pane",
    "",
    "Please note that the following directories and files are not tracked by git by default (but you can change it in the .gitignore file):",
    "",
    "-   01_Data",
    "-   all 02_Results folders",
    "-   all 03_Figures folders",
    "-   all 04_Tables folders",
    "-   03_Manuscript/02_Final_figures",
    "-   04_Presentation",
    "-   all html files",
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
