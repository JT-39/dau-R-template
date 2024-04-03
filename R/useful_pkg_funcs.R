# # Useful functions to call while building a package
# 
# ## To update the package documentation on new packages being used
# # Namespace file
# usethis::use_package()
# 
# # Description file
# devtools::document()
# 
# 
# ## To check the package
# devtools::check()
# 
# ## Load the package locally
# devtools::load_all() 
#
# ## Build the package
# devtools::build()
# 
# ## Build the package website
# pkgdown::build_site()
# 
# ## Hex logo
# # Add a logo
# usethis::use_logo("hex-dauRtemplate.png")
# 
# # Add favicon
# pkgdown::build_favicons()
#
#
# ## Add testthat to Suggests in DESCRIPTION
#
# ## May need to add library(waldo) to tests/testthat.R
#
#
# ## Auto adding files using {usethat}
# # Files in the R/ folder
# usethat::use_r("file_name")
#
# # Setup empty {testthat} folder structure
# usethis::use_testthat()
#
# # Setup corresponding test files to function file in R/
# usethis::use_test("file_name")


