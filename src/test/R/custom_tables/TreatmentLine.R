# sample custom code for TreatmentLine table

expect_treatment_line <- function(treatment_line_id, person_id, drug_era_start_date, drug_era_end_date, line_number, total_cycle_number, line_start_date, line_end_date, drug_concept_id, drug_exposure_count, treatment_type_id) {
  fields <- c()
  values <- c()

  if (!missing(treatment_line_id)) {
    fields <- c(fields, "treatment_line_id")
    values <- c(values, if (is.null(treatment_line_id)) "NULL" else if (is(treatment_line_id, "subQuery")) paste0("(", as.character(treatment_line_id), ")") else paste0("'", as.character(treatment_line_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) "NULL" else if (is(drug_concept_id, "subQuery")) paste0("(", as.character(drug_concept_id), ")") else paste0("'", as.character(drug_concept_id), "'"))
  }

  if (!missing(drug_era_start_date)) {
    fields <- c(fields, "drug_era_start_date")
    values <- c(values, if (is.null(drug_era_start_date)) "NULL" else if (is(drug_era_start_date, "subQuery")) paste0("(", as.character(drug_era_start_date), ")") else paste0("'", as.character(drug_era_start_date), "'"))
  }

  if (!missing(drug_era_end_date)) {
    fields <- c(fields, "drug_era_end_date")
    values <- c(values, if (is.null(drug_era_end_date)) "NULL" else if (is(drug_era_end_date, "subQuery")) paste0("(", as.character(drug_era_end_date), ")") else paste0("'", as.character(drug_era_end_date), "'"))
  }

  if (!missing(line_start_date)) {
    fields <- c(fields, "line_start_date")
    values <- c(values, if (is.null(line_start_date)) "NULL" else if (is(line_start_date, "subQuery")) paste0("(", as.character(line_start_date), ")") else paste0("'", as.character(line_start_date), "'"))
  }

  if (!missing(line_end_date)) {
    fields <- c(fields, "line_end_date")
    values <- c(values, if (is.null(line_end_date)) "NULL" else if (is(line_end_date, "subQuery")) paste0("(", as.character(line_end_date), ")") else paste0("'", as.character(line_end_date), "'"))
  }

  if (!missing(treatment_type_id)) {
    fields <- c(fields, "treatment_type_id")
    values <- c(values, if (is.null(treatment_type_id)) "NULL" else if (is(treatment_type_id, "subQuery")) paste0("(", as.character(treatment_type_id), ")") else paste0("'", as.character(treatment_type_id), "'"))
  }

  if (!missing(drug_exposure_count)) {
    fields <- c(fields, "drug_exposure_count")
    values <- c(values, if (is.null(drug_exposure_count)) "NULL" else if (is(drug_exposure_count, "subQuery")) paste0("(", as.character(drug_exposure_count), ")") else paste0("'", as.character(drug_exposure_count), "'"))
  }

  if (!missing(line_number)) {
    fields <- c(fields, "line_number")
    values <- c(values, if (is.null(line_number)) "NULL" else if (is(line_number, "subQuery")) paste0("(", as.character(line_number), ")") else paste0("'", as.character(line_number), "'"))
  }

  if (!missing(total_cycle_number)) {
    fields <- c(fields, "total_cycle_number")
    values <- c(values, if (is.null(total_cycle_number)) "NULL" else if (is(total_cycle_number, "subQuery")) paste0("(", as.character(total_cycle_number), ")") else paste0("'", as.character(total_cycle_number), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "treatment_line", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}


lookup_treatment_line <- function(fetchField, treatment_line_id, person_id, drug_era_start_date, drug_era_end_date, line_number, line_start_date, line_end_date, drug_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.treatment_line WHERE')
  first <- TRUE
  if (!missing(treatment_line_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " treatment_line_id = ", if (is.null(treatment_line_id)) "NULL" else if (is(treatment_line_id, "subQuery")) paste0("(", as.character(treatment_line_id), ")") else paste0("'", as.character(treatment_line_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id = ", if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(drug_era_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_era_start_date = ", if (is.null(drug_era_start_date)) "NULL" else if (is(drug_era_start_date, "subQuery")) paste0("(", as.character(drug_era_start_date), ")") else paste0("'", as.character(drug_era_start_date), "'"))
  }

  if (!missing(drug_era_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_era_end_date = ", if (is.null(drug_era_end_date)) "NULL" else if (is(drug_era_end_date, "subQuery")) paste0("(", as.character(drug_era_end_date), ")") else paste0("'", as.character(drug_era_end_date), "'"))
  }

  if (!missing(drug_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_concept_id = ", if (is.null(drug_concept_id)) "NULL" else if (is(drug_concept_id, "subQuery")) paste0("(", as.character(drug_concept_id), ")") else paste0("'", as.character(drug_concept_id), "'"))
  }

  if (!missing(line_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " line_start_date = ", if (is.null(line_start_date)) "NULL" else if (is(line_start_date, "subQuery")) paste0("(", as.character(line_start_date), ")") else paste0("'", as.character(line_start_date), "'"))
  }

  if (!missing(line_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " line_end_date = ", if (is.null(line_end_date)) "NULL" else if (is(line_end_date, "subQuery")) paste0("(", as.character(line_end_date), ")") else paste0("'", as.character(line_end_date), "'"))
  }

  if (!missing(line_number)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " line_number = ", if (is.null(line_number)) "NULL" else if (is(line_number, "subQuery")) paste0("(", as.character(line_number), ")") else paste0("'", as.character(line_number), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}
