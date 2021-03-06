# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# a
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' @title Adds annotations
#' 
#' @description 
#' Method outputs text to configured readme file and to console
#'  
#' @param ... Text to output
#' 
#' @export
a = function(...){
  my_output = paste0(...)
  if(!is.null(README_PATH)){
    cat(my_output," ", file=README_PATH, append = TRUE, sep="\n")
  }
  cat(my_output)
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# configure_output_columns
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' @title Defines columns for output data
#' 
#' @description 
#' Method to set RUN_ONLY_COLUMNS and PATIENT_ONLY_COLUMNS to be output to final data.
#'  
#' @export
configure_output_columns = function(){
  RUN_ONLY_COLUMNS <<- c(
    'Run_ID', 'Sequencing_Method', 'Analyte', 'Biopsy_Site', 'Specific_Biopsy_Site','Metastatic_Biopsy', 'Sample_Treated',
    'Sample_Treatment', 'Sample_Type', 'Normal', 'Primary_Tumor', 'Read_Length',
    'Batch_ID', 'Sequencer', 'Sequencer_ID', 'Sample_Prep', 'FFPE', 'Storage', 'Storage_Method',
    'File_Prefix', 'Run_Name', 'Pre_On_Treatment_Match', 'Somatic_Workflow_Match',
    'Center'
  )
  
  PATIENT_ONLY_COLUMNS <<- c(
    'Patient_ID', 'TCGA_Tissue', 'TCGA_Subtype', 'Cancer_Tissue', 'Tissue_Subtype',
    'M_Stage', 'Metastasized', 'Clinical_Stage', 'Response', 'Responder', 'Progression', 'Clinical_Benefit',
    'OS_e', 'OS_d', 'PFS_e', 'PFS_d', 'Age', 'Sex',
    'Race', 'Caucasian', 'Asian', 'African', 'Nat_American', 'Pac_Islander', 'Likely_Caucasian',
    'ICI_Rx', 'aPD1_Rx', 'aCTLA4_Rx', 'ICI_Pathway', 'ICI_Target',
    'Non_ICI_Rx', 'NeoICI_Rx',  'ICI_Tx', 'aPD1_Tx', 'aCTLA4_Tx', 'aCTLA4_aPD1_Tx',
    'Non_ICI_Tx', 'NeoICI_Tx',
    'Prior_Rx', 'Prior_ICI_Rx', 'Prior_Tx', 'Prior_ICI_Tx', 'Prior_aCTLA4_Tx', 'Prior_aMAPK_Tx',
    'Subsq_Rx', 'Subsq_ICI_Rx', 'Subsq_Tx', 'Subsq_ICI_Tx', 'Subsq_aCTLA4_aPD1_Tx', 'Subsq_aCTLA4_Tx',
    'Subsq_aMAPK_Tx',
    'Patient_Name', 'Dataset'
  )
  
  RUN_COLUMNS <<- c(RUN_ONLY_COLUMNS, PATIENT_ONLY_COLUMNS)
}

#configure_output_columns()

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# list_missing_columns
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' @title Prints any column names not yet defined in data
#' 
#' @description 
#' Method to print out any col_names not yet defined in the data passed in. Intended to help with preparing valid data.
#'
#' @param dat data to look for column names within
#' @param col_names vector representing full set of column names expected
#'  
#' @export
#' 
list_missing_columns = function(dat, col_names){
  missing = setdiff(col_names, colnames(dat))
  #  missing = col_names[!(col_names %in% colnames(dat))]
  if(length(missing) == 0) cat("There are no missing columns.")
  else{
    cat(paste("There are ", length(missing), " missing columns:\n")) 
    cat(paste(missing, collapse="\n"))
  }
}

#list_missing_columns(data.frame(Patient_ID=NA, Dataset=NA), c("Patient_ID", "Patient_Name", "Dataset"))

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# configure_readme
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#' @title Configure readme file
#' 
#' @description 
#' Method sets the readme path and removes existing readme file
#'  
#' @param output_dir path in which to save readme file
#' @param file_prefix value to use as prefix to _readme.txt file
#' 
#' @export
configure_readme = function( output_dir, file_prefix ){
  README_PATH <<- file.path(output_dir, paste0(file_prefix, "_readme.txt"))
  
  if(file.exists(README_PATH)) file.remove( README_PATH )
  
  a("Readme path set to: ", README_PATH)
}
