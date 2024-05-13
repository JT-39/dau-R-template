
test_that("Basic Functionality Test", {
  local({
    
    # Create a non-temporary directory for testing
    temp_dir <- withr::local_tempdir()
    
    # Call the function with a valid path
    dau_proj_template(path = temp_dir, 
                      init_renv = FALSE,
                      include_structure_for_pkg = FALSE, 
                      create_adhoc_proj = FALSE,
                      include_github_gitignore = FALSE)
    
    # Verify that the project structure is created correctly
    expect_true(dir.exists(paste0(temp_dir, "/01_data")))
    expect_true(dir.exists(paste0(temp_dir, "/01_data/01_raw")))
    expect_true(dir.exists(paste0(temp_dir, "/01_data/02_clean")))

    # Function files
    expect_true(file.exists(paste0(temp_dir, "/R/helpers.R")))

    # Test files
    expect_true(file.exists(paste0(temp_dir,
                                   "/tests/testthat/test-helpers.R")))
    
    # Add more expectations for other directories and files as needed
    
  })
  
})
