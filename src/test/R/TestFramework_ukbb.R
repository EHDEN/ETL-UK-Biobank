initFramework <- function() {
  frameworkContext <- new.env(parent = globalenv())
  class(frameworkContext) <- 'frameworkContext'
  assign('frameworkContext', frameworkContext, envir = globalenv())
  frameworkContext$inserts <- list()
  frameworkContext$expects <- list()
  frameworkContext$testId <- -1
  frameworkContext$testDescription <- ""
  frameworkContext$defaultValues <- new.env(parent = frameworkContext)

  # Baseline is treated differently to allow for more flexibility in column names.
  frameworkContext$baseline_names <- c()
  frameworkContext$baseline <- list()

  # A few defaults specific for succesfull person creation
  defaults <- list()
  defaults$eid <- '999'
  defaults$`31-0.0` <- '0'
  defaults$`34-0.0` <- '1950'
  defaults$`52-0.0` <- '1'
  defaults$`53-0.0` <- '2000-01-01'
  defaults$`54-0.0` <- '11004'
  defaults$`21000-0.0` <- '1'
  assign('baseline', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$eid <- '1002951'
  defaults$data_provider <- '3'
  defaults$event_dt <- '16/09/2014'
  defaults$read_2 <- ''
  defaults$read_3 <- ''
  defaults$value1 <- ''
  defaults$value2 <- ''
  defaults$value3 <- ''
  assign('gp_clinical', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$eid <- '1133122'
  defaults$data_provider <- '3'
  defaults$reg_date <- '02/02/1902'
  defaults$deduct_date <- ''
  assign('gp_registrations', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$eid <- '1130218'
  defaults$ins_index <- '0'
  defaults$arr_index <- '0'
  defaults$level <- '2'
  defaults$opdate <- ''
  defaults$oper3 <- ''
  defaults$oper3_nb <- ''
  defaults$oper4 <- 'X998'
  defaults$oper4_nb <- ''
  defaults$posopdur <- ''
  defaults$preopdur <- ''
  assign('hesin_oper', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$eid <- '1130218'
  defaults$ins_index <- '0'
  defaults$dsource <- 'HES'
  defaults$source <- '6'
  defaults$epistart <- ''
  defaults$epiend <- ''
  defaults$epidur <- '0'
  defaults$bedyear <- '0'
  defaults$epistat <- '3'
  defaults$epitype <- '1'
  defaults$epiorder <- '1'
  defaults$spell_index <- '0'
  defaults$spell_seq <- '0'
  defaults$spelbgin <- '2'
  defaults$spelend <- 'Y'
  defaults$speldur <- '0'
  defaults$pctcode <- ''
  defaults$gpprpct <- ''
  defaults$category <- ''
  defaults$elecdate <- ''
  defaults$elecdur <- ''
  defaults$admidate <- ''
  defaults$admimeth_uni <- '1001'
  defaults$admimeth <- '11'
  defaults$admisorc_uni <- '1000'
  defaults$admisorc <- '19'
  defaults$firstreg <- ''
  defaults$classpat_uni <- '1000'
  defaults$classpat <- '2'
  defaults$intmanag_uni <- '200'
  defaults$intmanag <- '2'
  defaults$mainspef_uni <- '1350'
  defaults$mainspef <- '100'
  defaults$tretspef_uni <- '1490'
  defaults$tretspef <- '300'
  defaults$operstat <- '1'
  defaults$disdate <- ''
  defaults$dismeth_uni <- '1000'
  defaults$dismeth <- '1'
  defaults$disdest_uni <- '1000'
  defaults$disdest <- '19'
  defaults$carersi <- '99'
  assign('hesin', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$eid <- '1089123'
  defaults$ins_index <- '0'
  defaults$arr_index <- '0'
  defaults$level <- '2'
  defaults$cause_icd10 <- 'I259'
  assign('death_cause', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$eid <- '1046090'
  defaults$specdate <- '09/04/2020'
  defaults$spectype <- '5'
  defaults$laboratory <- '3'
  defaults$origin <- '1'
  defaults$result <- '0'
  assign('covid', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$eid <- '1085407'
  defaults$ins_index <- '0'
  defaults$arr_index <- '0'
  defaults$level <- '2'
  defaults$diag_icd9 <- ''
  defaults$diag_icd9_nb <- ''
  defaults$diag_icd10 <- 'I10'
  defaults$diag_icd10_nb <- ''
  assign('hesin_diag', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$eid <- '1006846'
  defaults$data_provider <- '3'
  defaults$issue_date <- '10/02/2014'
  defaults$read_2 <- ''
  defaults$bnf_code <- ''
  defaults$dmd_code <- ''
  defaults$drug_name <- ''
  defaults$quantity <- ''
  assign('gp_prescriptions', defaults, envir = frameworkContext$defaultValues)

  defaults <- list()
  defaults$eid <- ''
  defaults$ins_index <- '0'
  defaults$dsource <- 'E/W'
  defaults$source <- '2'
  defaults$date_of_death <- ''
  assign('death', defaults, envir = frameworkContext$defaultValues)

  frameworkContext$sourceFieldsMapped <- c(
  )

  frameworkContext$targetFieldsMapped <- c(
  )

  frameworkContext$sourceFieldsTested <- c()
  frameworkContext$targetFieldsTested <- c()
}

initFramework()

set_defaults_baseline <- function(eid,`34-0.0`, `21000-0.0`, `21000-1.0`, `52-0.0`, `53-0.0`, `53-1.0`, `53-2.0`, `53-3.0`, `54-0.0`, `54-1.0`, `54-2.0`, `31-0.0`) {
  defaults <- get('baseline', envir = frameworkContext$defaultValues)
  if (!missing(eid)) {
    defaults$eid <- eid
  }
  if (!missing(`34-0.0`)) {
    defaults$`34-0.0` <- `34-0.0`
  }
  if (!missing(`21000-0.0`)) {
    defaults$`21000-0.0` <- `21000-0.0`
  }
  if (!missing(`21000-1.0`)) {
    defaults$`21000-1.0` <- `21000-1.0`
  }
  if (!missing(`52-0.0`)) {
    defaults$`52-0.0` <- `52-0.0`
  }
  if (!missing(`53-0.0`)) {
    defaults$`53-0.0` <- `53-0.0`
  }
  if (!missing(`53-1.0`)) {
    defaults$`53-1.0` <- `53-1.0`
  }
  if (!missing(`53-2.0`)) {
    defaults$`53-2.0` <- `53-2.0`
  }
  if (!missing(`53-3.0`)) {
    defaults$`53-3.0` <- `53-3.0`
  }
  if (!missing(`54-0.0`)) {
    defaults$`54-0.0` <- `54-0.0`
  }
  if (!missing(`54-1.0`)) {
    defaults$`54-1.0` <- `54-1.0`
  }
  if (!missing(`54-2.0`)) {
    defaults$`54-2.0` <- `54-2.0`
  }
  if (!missing(`31-0.0`)) {
    defaults$`31-0.0` <- `31-0.0`
  }
  assign('baseline', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_gp_clinical <- function(eid, data_provider, event_dt, read_2, read_3, value1, value2, value3) {
  defaults <- get('gp_clinical', envir = frameworkContext$defaultValues)
  if (!missing(eid)) {
    defaults$eid <- eid
  }
  if (!missing(data_provider)) {
    defaults$data_provider <- data_provider
  }
  if (!missing(event_dt)) {
    defaults$event_dt <- event_dt
  }
  if (!missing(read_2)) {
    defaults$read_2 <- read_2
  }
  if (!missing(read_3)) {
    defaults$read_3 <- read_3
  }
  if (!missing(value1)) {
    defaults$value1 <- value1
  }
  if (!missing(value2)) {
    defaults$value2 <- value2
  }
  if (!missing(value3)) {
    defaults$value3 <- value3
  }
  assign('gp_clinical', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_gp_registrations <- function(eid, data_provider, reg_date, deduct_date) {
  defaults <- get('gp_registrations', envir = frameworkContext$defaultValues)
  if (!missing(eid)) {
    defaults$eid <- eid
  }
  if (!missing(data_provider)) {
    defaults$data_provider <- data_provider
  }
  if (!missing(reg_date)) {
    defaults$reg_date <- reg_date
  }
  if (!missing(deduct_date)) {
    defaults$deduct_date <- deduct_date
  }
  assign('gp_registrations', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_hesin_oper <- function(eid, ins_index, arr_index, level, opdate, oper3, oper3_nb, oper4, oper4_nb, posopdur, preopdur) {
  defaults <- get('hesin_oper', envir = frameworkContext$defaultValues)
  if (!missing(eid)) {
    defaults$eid <- eid
  }
  if (!missing(ins_index)) {
    defaults$ins_index <- ins_index
  }
  if (!missing(arr_index)) {
    defaults$arr_index <- arr_index
  }
  if (!missing(level)) {
    defaults$level <- level
  }
  if (!missing(opdate)) {
    defaults$opdate <- opdate
  }
  if (!missing(oper3)) {
    defaults$oper3 <- oper3
  }
  if (!missing(oper3_nb)) {
    defaults$oper3_nb <- oper3_nb
  }
  if (!missing(oper4)) {
    defaults$oper4 <- oper4
  }
  if (!missing(oper4_nb)) {
    defaults$oper4_nb <- oper4_nb
  }
  if (!missing(posopdur)) {
    defaults$posopdur <- posopdur
  }
  if (!missing(preopdur)) {
    defaults$preopdur <- preopdur
  }
  assign('hesin_oper', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_hesin <- function(eid, ins_index, dsource, source, epistart, epiend, epidur, bedyear, epistat, epitype, epiorder, spell_index, spell_seq, spelbgin, spelend, speldur, pctcode, gpprpct, category, elecdate, elecdur, admidate, admimeth_uni, admimeth, admisorc_uni, admisorc, firstreg, classpat_uni, classpat, intmanag_uni, intmanag, mainspef_uni, mainspef, tretspef_uni, tretspef, operstat, disdate, dismeth_uni, dismeth, disdest_uni, disdest, carersi) {
  defaults <- get('hesin', envir = frameworkContext$defaultValues)
  if (!missing(eid)) {
    defaults$eid <- eid
  }
  if (!missing(ins_index)) {
    defaults$ins_index <- ins_index
  }
  if (!missing(dsource)) {
    defaults$dsource <- dsource
  }
  if (!missing(source)) {
    defaults$source <- source
  }
  if (!missing(epistart)) {
    defaults$epistart <- epistart
  }
  if (!missing(epiend)) {
    defaults$epiend <- epiend
  }
  if (!missing(epidur)) {
    defaults$epidur <- epidur
  }
  if (!missing(bedyear)) {
    defaults$bedyear <- bedyear
  }
  if (!missing(epistat)) {
    defaults$epistat <- epistat
  }
  if (!missing(epitype)) {
    defaults$epitype <- epitype
  }
  if (!missing(epiorder)) {
    defaults$epiorder <- epiorder
  }
  if (!missing(spell_index)) {
    defaults$spell_index <- spell_index
  }
  if (!missing(spell_seq)) {
    defaults$spell_seq <- spell_seq
  }
  if (!missing(spelbgin)) {
    defaults$spelbgin <- spelbgin
  }
  if (!missing(spelend)) {
    defaults$spelend <- spelend
  }
  if (!missing(speldur)) {
    defaults$speldur <- speldur
  }
  if (!missing(pctcode)) {
    defaults$pctcode <- pctcode
  }
  if (!missing(gpprpct)) {
    defaults$gpprpct <- gpprpct
  }
  if (!missing(category)) {
    defaults$category <- category
  }
  if (!missing(elecdate)) {
    defaults$elecdate <- elecdate
  }
  if (!missing(elecdur)) {
    defaults$elecdur <- elecdur
  }
  if (!missing(admidate)) {
    defaults$admidate <- admidate
  }
  if (!missing(admimeth_uni)) {
    defaults$admimeth_uni <- admimeth_uni
  }
  if (!missing(admimeth)) {
    defaults$admimeth <- admimeth
  }
  if (!missing(admisorc_uni)) {
    defaults$admisorc_uni <- admisorc_uni
  }
  if (!missing(admisorc)) {
    defaults$admisorc <- admisorc
  }
  if (!missing(firstreg)) {
    defaults$firstreg <- firstreg
  }
  if (!missing(classpat_uni)) {
    defaults$classpat_uni <- classpat_uni
  }
  if (!missing(classpat)) {
    defaults$classpat <- classpat
  }
  if (!missing(intmanag_uni)) {
    defaults$intmanag_uni <- intmanag_uni
  }
  if (!missing(intmanag)) {
    defaults$intmanag <- intmanag
  }
  if (!missing(mainspef_uni)) {
    defaults$mainspef_uni <- mainspef_uni
  }
  if (!missing(mainspef)) {
    defaults$mainspef <- mainspef
  }
  if (!missing(tretspef_uni)) {
    defaults$tretspef_uni <- tretspef_uni
  }
  if (!missing(tretspef)) {
    defaults$tretspef <- tretspef
  }
  if (!missing(operstat)) {
    defaults$operstat <- operstat
  }
  if (!missing(disdate)) {
    defaults$disdate <- disdate
  }
  if (!missing(dismeth_uni)) {
    defaults$dismeth_uni <- dismeth_uni
  }
  if (!missing(dismeth)) {
    defaults$dismeth <- dismeth
  }
  if (!missing(disdest_uni)) {
    defaults$disdest_uni <- disdest_uni
  }
  if (!missing(disdest)) {
    defaults$disdest <- disdest
  }
  if (!missing(carersi)) {
    defaults$carersi <- carersi
  }
  assign('hesin', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_death_cause <- function(eid, ins_index, arr_index, level, cause_icd10) {
  defaults <- get('death_cause', envir = frameworkContext$defaultValues)
  if (!missing(eid)) {
    defaults$eid <- eid
  }
  if (!missing(ins_index)) {
    defaults$ins_index <- ins_index
  }
  if (!missing(arr_index)) {
    defaults$arr_index <- arr_index
  }
  if (!missing(level)) {
    defaults$level <- level
  }
  if (!missing(cause_icd10)) {
    defaults$cause_icd10 <- cause_icd10
  }
  assign('death_cause', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_covid <- function(eid, specdate, spectype, laboratory, origin, result) {
  defaults <- get('covid', envir = frameworkContext$defaultValues)
  if (!missing(eid)) {
    defaults$eid <- eid
  }
  if (!missing(specdate)) {
    defaults$specdate <- specdate
  }
  if (!missing(spectype)) {
    defaults$spectype <- spectype
  }
  if (!missing(laboratory)) {
    defaults$laboratory <- laboratory
  }
  if (!missing(origin)) {
    defaults$origin <- origin
  }
  if (!missing(result)) {
    defaults$result <- result
  }
  assign('covid', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_hesin_diag <- function(eid, ins_index, arr_index, level, diag_icd9, diag_icd9_nb, diag_icd10, diag_icd10_nb) {
  defaults <- get('hesin_diag', envir = frameworkContext$defaultValues)
  if (!missing(eid)) {
    defaults$eid <- eid
  }
  if (!missing(ins_index)) {
    defaults$ins_index <- ins_index
  }
  if (!missing(arr_index)) {
    defaults$arr_index <- arr_index
  }
  if (!missing(level)) {
    defaults$level <- level
  }
  if (!missing(diag_icd9)) {
    defaults$diag_icd9 <- diag_icd9
  }
  if (!missing(diag_icd9_nb)) {
    defaults$diag_icd9_nb <- diag_icd9_nb
  }
  if (!missing(diag_icd10)) {
    defaults$diag_icd10 <- diag_icd10
  }
  if (!missing(diag_icd10_nb)) {
    defaults$diag_icd10_nb <- diag_icd10_nb
  }
  assign('hesin_diag', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_gp_prescriptions<- function(eid, data_provider, issue_date, read_2, bnf_code, dmd_code, drug_name, quantity) {
  defaults <- get('gp_prescriptions', envir = frameworkContext$defaultValues)
  if (!missing(eid)) {
    defaults$eid <- eid
  }
  if (!missing(data_provider)) {
    defaults$data_provider <- data_provider
  }
  if (!missing(issue_date)) {
    defaults$issue_date <- issue_date
  }
  if (!missing(read_2)) {
    defaults$read_2 <- read_2
  }
  if (!missing(bnf_code)) {
    defaults$bnf_code <- bnf_code
  }
  if (!missing(dmd_code)) {
    defaults$dmd_code <- dmd_code
  }
  if (!missing(drug_name)) {
    defaults$drug_name <- drug_name
  }
  if (!missing(quantity)) {
    defaults$quantity <- quantity
  }
  assign('gp_prescriptions', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

set_defaults_death_c <- function(eid, ins_index, dsource, source, date_of_death) {
  defaults <- get('death', envir = frameworkContext$defaultValues)
  if (!missing(eid)) {
    defaults$eid <- eid
  }
  if (!missing(ins_index)) {
    defaults$ins_index <- ins_index
  }
  if (!missing(dsource)) {
    defaults$dsource <- dsource
  }
  if (!missing(source)) {
    defaults$source <- source
  }
  if (!missing(date_of_death)) {
    defaults$date_of_death <- date_of_death
  }
  assign('death', defaults, envir = frameworkContext$defaultValues)
  invisible(defaults)
}

get_defaults_baseline <- function() {
  defaults <- get('baseline', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_gp_clinical <- function() {
  defaults <- get('gp_clinical', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_gp_registrations <- function() {
  defaults <- get('gp_registrations', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_hesin_oper <- function() {
  defaults <- get('hesin_oper', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_hesin <- function() {
  defaults <- get('hesin', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_death_cause <- function() {
  defaults <- get('death_cause', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_covid <- function() {
  defaults <- get('covid', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_hesin_diag <- function() {
  defaults <- get('hesin_diag', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_gp_prescriptions <- function() {
  defaults <- get('gp_prescriptions', envir = frameworkContext$defaultValues)
  return(defaults)
}

get_defaults_death_c <- function() {
  defaults <- get('death', envir = frameworkContext$defaultValues)
  return(defaults)
}

declareTest <- function(id, description) {
  frameworkContext$testId <- id
  frameworkContext$testDescription <- description
}


add_baseline <- function(...) {
  # Simplified to allow any column name.
  defaults <- get('baseline', envir = frameworkContext$defaultValues)

  kwargs <- list(...)

  # Defaults
  for (field_name in names(defaults)) {
    if (!(field_name %in% names(kwargs))) {
      kwargs[field_name] <- defaults[field_name]
    } else {
      frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, paste0('baseline.', field_name))
    }
  }

  frameworkContext$baseline_names <- unique(c(frameworkContext$baseline_names, names(kwargs)))
  frameworkContext$baseline[[length(frameworkContext$baseline) + 1]] <- kwargs

  invisible(NULL)
}

add_gp_clinical <- function(eid, data_provider, event_dt, read_2, read_3, value1, value2, value3) {
  defaults <- get('gp_clinical', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(eid)) {
    eid <- defaults$eid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'gp_clinical.eid')
  }
  fields <- c(fields, "eid")
  values <- c(values, if (is.null(eid)) "NULL" else if (is(eid, "subQuery")) paste0("(", as.character(eid), ")") else paste0("'", as.character(eid), "'"))

  if (missing(data_provider)) {
    data_provider <- defaults$data_provider
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'gp_clinical.data_provider')
  }
  fields <- c(fields, "data_provider")
  values <- c(values, if (is.null(data_provider)) "NULL" else if (is(data_provider, "subQuery")) paste0("(", as.character(data_provider), ")") else paste0("'", as.character(data_provider), "'"))

  if (missing(event_dt)) {
    event_dt <- defaults$event_dt
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'gp_clinical.event_dt')
  }
  fields <- c(fields, "event_dt")
  values <- c(values, if (is.null(event_dt)) "NULL" else if (is(event_dt, "subQuery")) paste0("(", as.character(event_dt), ")") else paste0("'", as.character(event_dt), "'"))

  if (missing(read_2)) {
    read_2 <- defaults$read_2
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'gp_clinical.read_2')
  }
  fields <- c(fields, "read_2")
  values <- c(values, if (is.null(read_2)) "NULL" else if (is(read_2, "subQuery")) paste0("(", as.character(read_2), ")") else paste0("'", as.character(read_2), "'"))

  if (missing(read_3)) {
    read_3 <- defaults$read_3
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'gp_clinical.read_3')
  }
  fields <- c(fields, "read_3")
  values <- c(values, if (is.null(read_3)) "NULL" else if (is(read_3, "subQuery")) paste0("(", as.character(read_3), ")") else paste0("'", as.character(read_3), "'"))

  if (missing(value1)) {
    value1 <- defaults$value1
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'gp_clinical.value1')
  }
  fields <- c(fields, "value1")
  values <- c(values, if (is.null(value1)) "NULL" else if (is(value1, "subQuery")) paste0("(", as.character(value1), ")") else paste0("'", as.character(value1), "'"))

  if (missing(value2)) {
    value2 <- defaults$value2
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'gp_clinical.value2')
  }
  fields <- c(fields, "value2")
  values <- c(values, if (is.null(value2)) "NULL" else if (is(value2, "subQuery")) paste0("(", as.character(value2), ")") else paste0("'", as.character(value2), "'"))

  if (missing(value3)) {
    value3 <- defaults$value3
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'gp_clinical.value3')
  }
  fields <- c(fields, "value3")
  values <- c(values, if (is.null(value3)) "NULL" else if (is(value3, "subQuery")) paste0("(", as.character(value3), ")") else paste0("'", as.character(value3), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "gp_clinical", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_gp_registrations <- function(eid, data_provider, reg_date, deduct_date) {
  defaults <- get('gp_registrations', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(eid)) {
    eid <- defaults$eid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'gp_registrations.eid')
  }
  fields <- c(fields, "eid")
  values <- c(values, if (is.null(eid)) "NULL" else if (is(eid, "subQuery")) paste0("(", as.character(eid), ")") else paste0("'", as.character(eid), "'"))

  if (missing(data_provider)) {
    data_provider <- defaults$data_provider
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'gp_registrations.data_provider')
  }
  fields <- c(fields, "data_provider")
  values <- c(values, if (is.null(data_provider)) "NULL" else if (is(data_provider, "subQuery")) paste0("(", as.character(data_provider), ")") else paste0("'", as.character(data_provider), "'"))

  if (missing(reg_date)) {
    reg_date <- defaults$reg_date
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'gp_registrations.reg_date')
  }
  fields <- c(fields, "reg_date")
  values <- c(values, if (is.null(reg_date)) "NULL" else if (is(reg_date, "subQuery")) paste0("(", as.character(reg_date), ")") else paste0("'", as.character(reg_date), "'"))

  if (missing(deduct_date)) {
    deduct_date <- defaults$deduct_date
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'gp_registrations.deduct_date')
  }
  fields <- c(fields, "deduct_date")
  values <- c(values, if (is.null(deduct_date)) "NULL" else if (is(deduct_date, "subQuery")) paste0("(", as.character(deduct_date), ")") else paste0("'", as.character(deduct_date), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "gp_registrations", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_hesin_oper <- function(eid, ins_index, arr_index, level, opdate, oper3, oper3_nb, oper4, oper4_nb, posopdur, preopdur) {
  defaults <- get('hesin_oper', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(eid)) {
    eid <- defaults$eid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin_oper.eid')
  }
  fields <- c(fields, "eid")
  values <- c(values, if (is.null(eid)) "NULL" else if (is(eid, "subQuery")) paste0("(", as.character(eid), ")") else paste0("'", as.character(eid), "'"))

  if (missing(ins_index)) {
    ins_index <- defaults$ins_index
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin_oper.ins_index')
  }
  fields <- c(fields, "ins_index")
  values <- c(values, if (is.null(ins_index)) "NULL" else if (is(ins_index, "subQuery")) paste0("(", as.character(ins_index), ")") else paste0("'", as.character(ins_index), "'"))

  if (missing(arr_index)) {
    arr_index <- defaults$arr_index
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin_oper.arr_index')
  }
  fields <- c(fields, "arr_index")
  values <- c(values, if (is.null(arr_index)) "NULL" else if (is(arr_index, "subQuery")) paste0("(", as.character(arr_index), ")") else paste0("'", as.character(arr_index), "'"))

  if (missing(level)) {
    level <- defaults$level
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin_oper.level')
  }
  fields <- c(fields, "level")
  values <- c(values, if (is.null(level)) "NULL" else if (is(level, "subQuery")) paste0("(", as.character(level), ")") else paste0("'", as.character(level), "'"))

  if (missing(opdate)) {
    opdate <- defaults$opdate
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin_oper.opdate')
  }
  fields <- c(fields, "opdate")
  values <- c(values, if (is.null(opdate)) "NULL" else if (is(opdate, "subQuery")) paste0("(", as.character(opdate), ")") else paste0("'", as.character(opdate), "'"))

  if (missing(oper3)) {
    oper3 <- defaults$oper3
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin_oper.oper3')
  }
  fields <- c(fields, "oper3")
  values <- c(values, if (is.null(oper3)) "NULL" else if (is(oper3, "subQuery")) paste0("(", as.character(oper3), ")") else paste0("'", as.character(oper3), "'"))

  if (missing(oper3_nb)) {
    oper3_nb <- defaults$oper3_nb
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin_oper.oper3_nb')
  }
  fields <- c(fields, "oper3_nb")
  values <- c(values, if (is.null(oper3_nb)) "NULL" else if (is(oper3_nb, "subQuery")) paste0("(", as.character(oper3_nb), ")") else paste0("'", as.character(oper3_nb), "'"))

  if (missing(oper4)) {
    oper4 <- defaults$oper4
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin_oper.oper4')
  }
  fields <- c(fields, "oper4")
  values <- c(values, if (is.null(oper4)) "NULL" else if (is(oper4, "subQuery")) paste0("(", as.character(oper4), ")") else paste0("'", as.character(oper4), "'"))

  if (missing(oper4_nb)) {
    oper4_nb <- defaults$oper4_nb
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin_oper.oper4_nb')
  }
  fields <- c(fields, "oper4_nb")
  values <- c(values, if (is.null(oper4_nb)) "NULL" else if (is(oper4_nb, "subQuery")) paste0("(", as.character(oper4_nb), ")") else paste0("'", as.character(oper4_nb), "'"))

  if (missing(posopdur)) {
    posopdur <- defaults$posopdur
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin_oper.posopdur')
  }
  fields <- c(fields, "posopdur")
  values <- c(values, if (is.null(posopdur)) "NULL" else if (is(posopdur, "subQuery")) paste0("(", as.character(posopdur), ")") else paste0("'", as.character(posopdur), "'"))

  if (missing(preopdur)) {
    preopdur <- defaults$preopdur
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin_oper.preopdur')
  }
  fields <- c(fields, "preopdur")
  values <- c(values, if (is.null(preopdur)) "NULL" else if (is(preopdur, "subQuery")) paste0("(", as.character(preopdur), ")") else paste0("'", as.character(preopdur), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "hesin_oper", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_hesin <- function(eid, ins_index, dsource, source, epistart, epiend, epidur, bedyear, epistat, epitype, epiorder, spell_index, spell_seq, spelbgin, spelend, speldur, pctcode, gpprpct, category, elecdate, elecdur, admidate, admimeth_uni, admimeth, admisorc_uni, admisorc, firstreg, classpat_uni, classpat, intmanag_uni, intmanag, mainspef_uni, mainspef, tretspef_uni, tretspef, operstat, disdate, dismeth_uni, dismeth, disdest_uni, disdest, carersi) {
  defaults <- get('hesin', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(eid)) {
    eid <- defaults$eid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.eid')
  }
  fields <- c(fields, "eid")
  values <- c(values, if (is.null(eid)) "NULL" else if (is(eid, "subQuery")) paste0("(", as.character(eid), ")") else paste0("'", as.character(eid), "'"))

  if (missing(ins_index)) {
    ins_index <- defaults$ins_index
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.ins_index')
  }
  fields <- c(fields, "ins_index")
  values <- c(values, if (is.null(ins_index)) "NULL" else if (is(ins_index, "subQuery")) paste0("(", as.character(ins_index), ")") else paste0("'", as.character(ins_index), "'"))

  if (missing(dsource)) {
    dsource <- defaults$dsource
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.dsource')
  }
  fields <- c(fields, "dsource")
  values <- c(values, if (is.null(dsource)) "NULL" else if (is(dsource, "subQuery")) paste0("(", as.character(dsource), ")") else paste0("'", as.character(dsource), "'"))

  if (missing(source)) {
    source <- defaults$source
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.source')
  }
  fields <- c(fields, "source")
  values <- c(values, if (is.null(source)) "NULL" else if (is(source, "subQuery")) paste0("(", as.character(source), ")") else paste0("'", as.character(source), "'"))

  if (missing(epistart)) {
    epistart <- defaults$epistart
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.epistart')
  }
  fields <- c(fields, "epistart")
  values <- c(values, if (is.null(epistart)) "NULL" else if (is(epistart, "subQuery")) paste0("(", as.character(epistart), ")") else paste0("'", as.character(epistart), "'"))

  if (missing(epiend)) {
    epiend <- defaults$epiend
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.epiend')
  }
  fields <- c(fields, "epiend")
  values <- c(values, if (is.null(epiend)) "NULL" else if (is(epiend, "subQuery")) paste0("(", as.character(epiend), ")") else paste0("'", as.character(epiend), "'"))

  if (missing(epidur)) {
    epidur <- defaults$epidur
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.epidur')
  }
  fields <- c(fields, "epidur")
  values <- c(values, if (is.null(epidur)) "NULL" else if (is(epidur, "subQuery")) paste0("(", as.character(epidur), ")") else paste0("'", as.character(epidur), "'"))

  if (missing(bedyear)) {
    bedyear <- defaults$bedyear
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.bedyear')
  }
  fields <- c(fields, "bedyear")
  values <- c(values, if (is.null(bedyear)) "NULL" else if (is(bedyear, "subQuery")) paste0("(", as.character(bedyear), ")") else paste0("'", as.character(bedyear), "'"))

  if (missing(epistat)) {
    epistat <- defaults$epistat
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.epistat')
  }
  fields <- c(fields, "epistat")
  values <- c(values, if (is.null(epistat)) "NULL" else if (is(epistat, "subQuery")) paste0("(", as.character(epistat), ")") else paste0("'", as.character(epistat), "'"))

  if (missing(epitype)) {
    epitype <- defaults$epitype
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.epitype')
  }
  fields <- c(fields, "epitype")
  values <- c(values, if (is.null(epitype)) "NULL" else if (is(epitype, "subQuery")) paste0("(", as.character(epitype), ")") else paste0("'", as.character(epitype), "'"))

  if (missing(epiorder)) {
    epiorder <- defaults$epiorder
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.epiorder')
  }
  fields <- c(fields, "epiorder")
  values <- c(values, if (is.null(epiorder)) "NULL" else if (is(epiorder, "subQuery")) paste0("(", as.character(epiorder), ")") else paste0("'", as.character(epiorder), "'"))

  if (missing(spell_index)) {
    spell_index <- defaults$spell_index
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.spell_index')
  }
  fields <- c(fields, "spell_index")
  values <- c(values, if (is.null(spell_index)) "NULL" else if (is(spell_index, "subQuery")) paste0("(", as.character(spell_index), ")") else paste0("'", as.character(spell_index), "'"))

  if (missing(spell_seq)) {
    spell_seq <- defaults$spell_seq
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.spell_seq')
  }
  fields <- c(fields, "spell_seq")
  values <- c(values, if (is.null(spell_seq)) "NULL" else if (is(spell_seq, "subQuery")) paste0("(", as.character(spell_seq), ")") else paste0("'", as.character(spell_seq), "'"))

  if (missing(spelbgin)) {
    spelbgin <- defaults$spelbgin
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.spelbgin')
  }
  fields <- c(fields, "spelbgin")
  values <- c(values, if (is.null(spelbgin)) "NULL" else if (is(spelbgin, "subQuery")) paste0("(", as.character(spelbgin), ")") else paste0("'", as.character(spelbgin), "'"))

  if (missing(spelend)) {
    spelend <- defaults$spelend
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.spelend')
  }
  fields <- c(fields, "spelend")
  values <- c(values, if (is.null(spelend)) "NULL" else if (is(spelend, "subQuery")) paste0("(", as.character(spelend), ")") else paste0("'", as.character(spelend), "'"))

  if (missing(speldur)) {
    speldur <- defaults$speldur
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.speldur')
  }
  fields <- c(fields, "speldur")
  values <- c(values, if (is.null(speldur)) "NULL" else if (is(speldur, "subQuery")) paste0("(", as.character(speldur), ")") else paste0("'", as.character(speldur), "'"))

  if (missing(pctcode)) {
    pctcode <- defaults$pctcode
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.pctcode')
  }
  fields <- c(fields, "pctcode")
  values <- c(values, if (is.null(pctcode)) "NULL" else if (is(pctcode, "subQuery")) paste0("(", as.character(pctcode), ")") else paste0("'", as.character(pctcode), "'"))

  if (missing(gpprpct)) {
    gpprpct <- defaults$gpprpct
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.gpprpct')
  }
  fields <- c(fields, "gpprpct")
  values <- c(values, if (is.null(gpprpct)) "NULL" else if (is(gpprpct, "subQuery")) paste0("(", as.character(gpprpct), ")") else paste0("'", as.character(gpprpct), "'"))

  if (missing(category)) {
    category <- defaults$category
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.category')
  }
  fields <- c(fields, "category")
  values <- c(values, if (is.null(category)) "NULL" else if (is(category, "subQuery")) paste0("(", as.character(category), ")") else paste0("'", as.character(category), "'"))

  if (missing(elecdate)) {
    elecdate <- defaults$elecdate
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.elecdate')
  }
  fields <- c(fields, "elecdate")
  values <- c(values, if (is.null(elecdate)) "NULL" else if (is(elecdate, "subQuery")) paste0("(", as.character(elecdate), ")") else paste0("'", as.character(elecdate), "'"))

  if (missing(elecdur)) {
    elecdur <- defaults$elecdur
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.elecdur')
  }
  fields <- c(fields, "elecdur")
  values <- c(values, if (is.null(elecdur)) "NULL" else if (is(elecdur, "subQuery")) paste0("(", as.character(elecdur), ")") else paste0("'", as.character(elecdur), "'"))

  if (missing(admidate)) {
    admidate <- defaults$admidate
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.admidate')
  }
  fields <- c(fields, "admidate")
  values <- c(values, if (is.null(admidate)) "NULL" else if (is(admidate, "subQuery")) paste0("(", as.character(admidate), ")") else paste0("'", as.character(admidate), "'"))

  if (missing(admimeth_uni)) {
    admimeth_uni <- defaults$admimeth_uni
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.admimeth_uni')
  }
  fields <- c(fields, "admimeth_uni")
  values <- c(values, if (is.null(admimeth_uni)) "NULL" else if (is(admimeth_uni, "subQuery")) paste0("(", as.character(admimeth_uni), ")") else paste0("'", as.character(admimeth_uni), "'"))

  if (missing(admimeth)) {
    admimeth <- defaults$admimeth
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.admimeth')
  }
  fields <- c(fields, "admimeth")
  values <- c(values, if (is.null(admimeth)) "NULL" else if (is(admimeth, "subQuery")) paste0("(", as.character(admimeth), ")") else paste0("'", as.character(admimeth), "'"))

  if (missing(admisorc_uni)) {
    admisorc_uni <- defaults$admisorc_uni
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.admisorc_uni')
  }
  fields <- c(fields, "admisorc_uni")
  values <- c(values, if (is.null(admisorc_uni)) "NULL" else if (is(admisorc_uni, "subQuery")) paste0("(", as.character(admisorc_uni), ")") else paste0("'", as.character(admisorc_uni), "'"))

  if (missing(admisorc)) {
    admisorc <- defaults$admisorc
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.admisorc')
  }
  fields <- c(fields, "admisorc")
  values <- c(values, if (is.null(admisorc)) "NULL" else if (is(admisorc, "subQuery")) paste0("(", as.character(admisorc), ")") else paste0("'", as.character(admisorc), "'"))

  if (missing(firstreg)) {
    firstreg <- defaults$firstreg
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.firstreg')
  }
  fields <- c(fields, "firstreg")
  values <- c(values, if (is.null(firstreg)) "NULL" else if (is(firstreg, "subQuery")) paste0("(", as.character(firstreg), ")") else paste0("'", as.character(firstreg), "'"))

  if (missing(classpat_uni)) {
    classpat_uni <- defaults$classpat_uni
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.classpat_uni')
  }
  fields <- c(fields, "classpat_uni")
  values <- c(values, if (is.null(classpat_uni)) "NULL" else if (is(classpat_uni, "subQuery")) paste0("(", as.character(classpat_uni), ")") else paste0("'", as.character(classpat_uni), "'"))

  if (missing(classpat)) {
    classpat <- defaults$classpat
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.classpat')
  }
  fields <- c(fields, "classpat")
  values <- c(values, if (is.null(classpat)) "NULL" else if (is(classpat, "subQuery")) paste0("(", as.character(classpat), ")") else paste0("'", as.character(classpat), "'"))

  if (missing(intmanag_uni)) {
    intmanag_uni <- defaults$intmanag_uni
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.intmanag_uni')
  }
  fields <- c(fields, "intmanag_uni")
  values <- c(values, if (is.null(intmanag_uni)) "NULL" else if (is(intmanag_uni, "subQuery")) paste0("(", as.character(intmanag_uni), ")") else paste0("'", as.character(intmanag_uni), "'"))

  if (missing(intmanag)) {
    intmanag <- defaults$intmanag
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.intmanag')
  }
  fields <- c(fields, "intmanag")
  values <- c(values, if (is.null(intmanag)) "NULL" else if (is(intmanag, "subQuery")) paste0("(", as.character(intmanag), ")") else paste0("'", as.character(intmanag), "'"))

  if (missing(mainspef_uni)) {
    mainspef_uni <- defaults$mainspef_uni
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.mainspef_uni')
  }
  fields <- c(fields, "mainspef_uni")
  values <- c(values, if (is.null(mainspef_uni)) "NULL" else if (is(mainspef_uni, "subQuery")) paste0("(", as.character(mainspef_uni), ")") else paste0("'", as.character(mainspef_uni), "'"))

  if (missing(mainspef)) {
    mainspef <- defaults$mainspef
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.mainspef')
  }
  fields <- c(fields, "mainspef")
  values <- c(values, if (is.null(mainspef)) "NULL" else if (is(mainspef, "subQuery")) paste0("(", as.character(mainspef), ")") else paste0("'", as.character(mainspef), "'"))

  if (missing(tretspef_uni)) {
    tretspef_uni <- defaults$tretspef_uni
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.tretspef_uni')
  }
  fields <- c(fields, "tretspef_uni")
  values <- c(values, if (is.null(tretspef_uni)) "NULL" else if (is(tretspef_uni, "subQuery")) paste0("(", as.character(tretspef_uni), ")") else paste0("'", as.character(tretspef_uni), "'"))

  if (missing(tretspef)) {
    tretspef <- defaults$tretspef
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.tretspef')
  }
  fields <- c(fields, "tretspef")
  values <- c(values, if (is.null(tretspef)) "NULL" else if (is(tretspef, "subQuery")) paste0("(", as.character(tretspef), ")") else paste0("'", as.character(tretspef), "'"))

  if (missing(operstat)) {
    operstat <- defaults$operstat
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.operstat')
  }
  fields <- c(fields, "operstat")
  values <- c(values, if (is.null(operstat)) "NULL" else if (is(operstat, "subQuery")) paste0("(", as.character(operstat), ")") else paste0("'", as.character(operstat), "'"))

  if (missing(disdate)) {
    disdate <- defaults$disdate
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.disdate')
  }
  fields <- c(fields, "disdate")
  values <- c(values, if (is.null(disdate)) "NULL" else if (is(disdate, "subQuery")) paste0("(", as.character(disdate), ")") else paste0("'", as.character(disdate), "'"))

  if (missing(dismeth_uni)) {
    dismeth_uni <- defaults$dismeth_uni
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.dismeth_uni')
  }
  fields <- c(fields, "dismeth_uni")
  values <- c(values, if (is.null(dismeth_uni)) "NULL" else if (is(dismeth_uni, "subQuery")) paste0("(", as.character(dismeth_uni), ")") else paste0("'", as.character(dismeth_uni), "'"))

  if (missing(dismeth)) {
    dismeth <- defaults$dismeth
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.dismeth')
  }
  fields <- c(fields, "dismeth")
  values <- c(values, if (is.null(dismeth)) "NULL" else if (is(dismeth, "subQuery")) paste0("(", as.character(dismeth), ")") else paste0("'", as.character(dismeth), "'"))

  if (missing(disdest_uni)) {
    disdest_uni <- defaults$disdest_uni
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.disdest_uni')
  }
  fields <- c(fields, "disdest_uni")
  values <- c(values, if (is.null(disdest_uni)) "NULL" else if (is(disdest_uni, "subQuery")) paste0("(", as.character(disdest_uni), ")") else paste0("'", as.character(disdest_uni), "'"))

  if (missing(disdest)) {
    disdest <- defaults$disdest
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.disdest')
  }
  fields <- c(fields, "disdest")
  values <- c(values, if (is.null(disdest)) "NULL" else if (is(disdest, "subQuery")) paste0("(", as.character(disdest), ")") else paste0("'", as.character(disdest), "'"))

  if (missing(carersi)) {
    carersi <- defaults$carersi
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin.carersi')
  }
  fields <- c(fields, "carersi")
  values <- c(values, if (is.null(carersi)) "NULL" else if (is(carersi, "subQuery")) paste0("(", as.character(carersi), ")") else paste0("'", as.character(carersi), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "hesin", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_death_cause <- function(eid, ins_index, arr_index, level, cause_icd10) {
  defaults <- get('death_cause', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(eid)) {
    eid <- defaults$eid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'death_cause.eid')
  }
  fields <- c(fields, "eid")
  values <- c(values, if (is.null(eid)) "NULL" else if (is(eid, "subQuery")) paste0("(", as.character(eid), ")") else paste0("'", as.character(eid), "'"))

  if (missing(ins_index)) {
    ins_index <- defaults$ins_index
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'death_cause.ins_index')
  }
  fields <- c(fields, "ins_index")
  values <- c(values, if (is.null(ins_index)) "NULL" else if (is(ins_index, "subQuery")) paste0("(", as.character(ins_index), ")") else paste0("'", as.character(ins_index), "'"))

  if (missing(arr_index)) {
    arr_index <- defaults$arr_index
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'death_cause.arr_index')
  }
  fields <- c(fields, "arr_index")
  values <- c(values, if (is.null(arr_index)) "NULL" else if (is(arr_index, "subQuery")) paste0("(", as.character(arr_index), ")") else paste0("'", as.character(arr_index), "'"))

  if (missing(level)) {
    level <- defaults$level
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'death_cause.level')
  }
  fields <- c(fields, "level")
  values <- c(values, if (is.null(level)) "NULL" else if (is(level, "subQuery")) paste0("(", as.character(level), ")") else paste0("'", as.character(level), "'"))

  if (missing(cause_icd10)) {
    cause_icd10 <- defaults$cause_icd10
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'death_cause.cause_icd10')
  }
  fields <- c(fields, "cause_icd10")
  values <- c(values, if (is.null(cause_icd10)) "NULL" else if (is(cause_icd10, "subQuery")) paste0("(", as.character(cause_icd10), ")") else paste0("'", as.character(cause_icd10), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "death_cause", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_covid <- function(eid, specdate, spectype, laboratory, origin, result) {
  defaults <- get('covid', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(eid)) {
    eid <- defaults$eid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'covid.eid')
  }
  fields <- c(fields, "eid")
  values <- c(values, if (is.null(eid)) "NULL" else if (is(eid, "subQuery")) paste0("(", as.character(eid), ")") else paste0("'", as.character(eid), "'"))

  if (missing(specdate)) {
    specdate <- defaults$specdate
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'covid.specdate')
  }
  fields <- c(fields, "specdate")
  values <- c(values, if (is.null(specdate)) "NULL" else if (is(specdate, "subQuery")) paste0("(", as.character(specdate), ")") else paste0("'", as.character(specdate), "'"))

  if (missing(spectype)) {
    spectype <- defaults$spectype
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'covid.spectype')
  }
  fields <- c(fields, "spectype")
  values <- c(values, if (is.null(spectype)) "NULL" else if (is(spectype, "subQuery")) paste0("(", as.character(spectype), ")") else paste0("'", as.character(spectype), "'"))

  if (missing(laboratory)) {
    laboratory <- defaults$laboratory
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'covid.laboratory')
  }
  fields <- c(fields, "laboratory")
  values <- c(values, if (is.null(laboratory)) "NULL" else if (is(laboratory, "subQuery")) paste0("(", as.character(laboratory), ")") else paste0("'", as.character(laboratory), "'"))

  if (missing(origin)) {
    origin <- defaults$origin
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'covid.origin')
  }
  fields <- c(fields, "origin")
  values <- c(values, if (is.null(origin)) "NULL" else if (is(origin, "subQuery")) paste0("(", as.character(origin), ")") else paste0("'", as.character(origin), "'"))

  if (missing(result)) {
    result <- defaults$result
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'covid.result')
  }
  fields <- c(fields, "result")
  values <- c(values, if (is.null(result)) "NULL" else if (is(result, "subQuery")) paste0("(", as.character(result), ")") else paste0("'", as.character(result), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "covid", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_hesin_diag <- function(eid, ins_index, arr_index, level, diag_icd9, diag_icd9_nb, diag_icd10, diag_icd10_nb) {
  defaults <- get('hesin_diag', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(eid)) {
    eid <- defaults$eid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin_diag.eid')
  }
  fields <- c(fields, "eid")
  values <- c(values, if (is.null(eid)) "NULL" else if (is(eid, "subQuery")) paste0("(", as.character(eid), ")") else paste0("'", as.character(eid), "'"))

  if (missing(ins_index)) {
    ins_index <- defaults$ins_index
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin_diag.ins_index')
  }
  fields <- c(fields, "ins_index")
  values <- c(values, if (is.null(ins_index)) "NULL" else if (is(ins_index, "subQuery")) paste0("(", as.character(ins_index), ")") else paste0("'", as.character(ins_index), "'"))

  if (missing(arr_index)) {
    arr_index <- defaults$arr_index
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin_diag.arr_index')
  }
  fields <- c(fields, "arr_index")
  values <- c(values, if (is.null(arr_index)) "NULL" else if (is(arr_index, "subQuery")) paste0("(", as.character(arr_index), ")") else paste0("'", as.character(arr_index), "'"))

  if (missing(level)) {
    level <- defaults$level
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin_diag.level')
  }
  fields <- c(fields, "level")
  values <- c(values, if (is.null(level)) "NULL" else if (is(level, "subQuery")) paste0("(", as.character(level), ")") else paste0("'", as.character(level), "'"))

  if (missing(diag_icd9)) {
    diag_icd9 <- defaults$diag_icd9
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin_diag.diag_icd9')
  }
  fields <- c(fields, "diag_icd9")
  values <- c(values, if (is.null(diag_icd9)) "NULL" else if (is(diag_icd9, "subQuery")) paste0("(", as.character(diag_icd9), ")") else paste0("'", as.character(diag_icd9), "'"))

  if (missing(diag_icd9_nb)) {
    diag_icd9_nb <- defaults$diag_icd9_nb
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin_diag.diag_icd9_nb')
  }
  fields <- c(fields, "diag_icd9_nb")
  values <- c(values, if (is.null(diag_icd9_nb)) "NULL" else if (is(diag_icd9_nb, "subQuery")) paste0("(", as.character(diag_icd9_nb), ")") else paste0("'", as.character(diag_icd9_nb), "'"))

  if (missing(diag_icd10)) {
    diag_icd10 <- defaults$diag_icd10
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin_diag.diag_icd10')
  }
  fields <- c(fields, "diag_icd10")
  values <- c(values, if (is.null(diag_icd10)) "NULL" else if (is(diag_icd10, "subQuery")) paste0("(", as.character(diag_icd10), ")") else paste0("'", as.character(diag_icd10), "'"))

  if (missing(diag_icd10_nb)) {
    diag_icd10_nb <- defaults$diag_icd10_nb
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'hesin_diag.diag_icd10_nb')
  }
  fields <- c(fields, "diag_icd10_nb")
  values <- c(values, if (is.null(diag_icd10_nb)) "NULL" else if (is(diag_icd10_nb, "subQuery")) paste0("(", as.character(diag_icd10_nb), ")") else paste0("'", as.character(diag_icd10_nb), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "hesin_diag", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_gp_prescriptions <- function(eid, data_provider, issue_date, read_2, bnf_code, dmd_code, drug_name, quantity) {
  defaults <- get('gp_prescriptions', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(eid)) {
    eid <- defaults$eid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'gp_prescriptions.eid')
  }
  fields <- c(fields, "eid")
  values <- c(values, if (is.null(eid)) "NULL" else if (is(eid, "subQuery")) paste0("(", as.character(eid), ")") else paste0("'", as.character(eid), "'"))

  if (missing(data_provider)) {
    data_provider <- defaults$data_provider
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'gp_prescriptions.data_provider')
  }
  fields <- c(fields, "data_provider")
  values <- c(values, if (is.null(data_provider)) "NULL" else if (is(data_provider, "subQuery")) paste0("(", as.character(data_provider), ")") else paste0("'", as.character(data_provider), "'"))

  if (missing(issue_date)) {
    issue_date <- defaults$issue_date
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'gp_prescriptions.issue_date')
  }
  fields <- c(fields, "issue_date")
  values <- c(values, if (is.null(issue_date)) "NULL" else if (is(issue_date, "subQuery")) paste0("(", as.character(issue_date), ")") else paste0("'", as.character(issue_date), "'"))

  if (missing(read_2)) {
    read_2 <- defaults$read_2
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'gp_prescriptions.read_2')
  }
  fields <- c(fields, "read_2")
  values <- c(values, if (is.null(read_2)) "NULL" else if (is(read_2, "subQuery")) paste0("(", as.character(read_2), ")") else paste0("'", as.character(read_2), "'"))

  if (missing(bnf_code)) {
    bnf_code <- defaults$bnf_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'gp_prescriptions.bnf_code')
  }
  fields <- c(fields, "bnf_code")
  values <- c(values, if (is.null(bnf_code)) "NULL" else if (is(bnf_code, "subQuery")) paste0("(", as.character(bnf_code), ")") else paste0("'", as.character(bnf_code), "'"))

  if (missing(dmd_code)) {
    dmd_code <- defaults$dmd_code
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'gp_prescriptions.dmd_code')
  }
  fields <- c(fields, "dmd_code")
  values <- c(values, if (is.null(dmd_code)) "NULL" else if (is(dmd_code, "subQuery")) paste0("(", as.character(dmd_code), ")") else paste0("'", as.character(dmd_code), "'"))

  if (missing(drug_name)) {
    drug_name <- defaults$drug_name
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'gp_prescriptions.drug_name')
  }
  fields <- c(fields, "drug_name")
  values <- c(values, if (is.null(drug_name)) "NULL" else if (is(drug_name, "subQuery")) paste0("(", as.character(drug_name), ")") else paste0("'", as.character(drug_name), "'"))

  if (missing(quantity)) {
    quantity <- defaults$quantity
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'gp_prescriptions.quantity')
  }
  fields <- c(fields, "quantity")
  values <- c(values, if (is.null(quantity)) "NULL" else if (is(quantity, "subQuery")) paste0("(", as.character(quantity), ")") else paste0("'", as.character(quantity), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "gp_prescriptions", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

add_death <- function(eid, ins_index, dsource, source, date_of_death) {
  defaults <- get('death', envir = frameworkContext$defaultValues)
  fields <- c()
  values <- c()
  if (missing(eid)) {
    eid <- defaults$eid
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'death.eid')
  }
  fields <- c(fields, "eid")
  values <- c(values, if (is.null(eid)) "NULL" else if (is(eid, "subQuery")) paste0("(", as.character(eid), ")") else paste0("'", as.character(eid), "'"))

  if (missing(ins_index)) {
    ins_index <- defaults$ins_index
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'death.ins_index')
  }
  fields <- c(fields, "ins_index")
  values <- c(values, if (is.null(ins_index)) "NULL" else if (is(ins_index, "subQuery")) paste0("(", as.character(ins_index), ")") else paste0("'", as.character(ins_index), "'"))

  if (missing(dsource)) {
    dsource <- defaults$dsource
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'death.dsource')
  }
  fields <- c(fields, "dsource")
  values <- c(values, if (is.null(dsource)) "NULL" else if (is(dsource, "subQuery")) paste0("(", as.character(dsource), ")") else paste0("'", as.character(dsource), "'"))

  if (missing(source)) {
    source <- defaults$source
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'death.source')
  }
  fields <- c(fields, "source")
  values <- c(values, if (is.null(source)) "NULL" else if (is(source, "subQuery")) paste0("(", as.character(source), ")") else paste0("'", as.character(source), "'"))

  if (missing(date_of_death)) {
    date_of_death <- defaults$date_of_death
  } else {
    frameworkContext$sourceFieldsTested <- c(frameworkContext$sourceFieldsTested, 'death.date_of_death')
  }
  fields <- c(fields, "date_of_death")
  values <- c(values, if (is.null(date_of_death)) "NULL" else if (is(date_of_death, "subQuery")) paste0("(", as.character(date_of_death), ")") else paste0("'", as.character(date_of_death), "'"))

  inserts <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, table = "death", fields = fields, values = values)
  frameworkContext$inserts[[length(frameworkContext$inserts) + 1]] <- inserts
  invisible(NULL)
}

expect_person <- function(person_id, gender_concept_id, year_of_birth, month_of_birth, day_of_birth, birth_datetime, death_datetime, race_concept_id, ethnicity_concept_id, location_id, provider_id, care_site_id, person_source_value, gender_source_value, gender_source_concept_id, race_source_value, race_source_concept_id, ethnicity_source_value, ethnicity_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.person_id')
  }

  if (!missing(gender_concept_id)) {
    fields <- c(fields, "gender_concept_id")
    values <- c(values, if (is.null(gender_concept_id)) "NULL" else if (is(gender_concept_id, "subQuery")) paste0("(", as.character(gender_concept_id), ")") else paste0("'", as.character(gender_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.gender_concept_id')
  }

  if (!missing(year_of_birth)) {
    fields <- c(fields, "year_of_birth")
    values <- c(values, if (is.null(year_of_birth)) "NULL" else if (is(year_of_birth, "subQuery")) paste0("(", as.character(year_of_birth), ")") else paste0("'", as.character(year_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.year_of_birth')
  }

  if (!missing(month_of_birth)) {
    fields <- c(fields, "month_of_birth")
    values <- c(values, if (is.null(month_of_birth)) "NULL" else if (is(month_of_birth, "subQuery")) paste0("(", as.character(month_of_birth), ")") else paste0("'", as.character(month_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.month_of_birth')
  }

  if (!missing(day_of_birth)) {
    fields <- c(fields, "day_of_birth")
    values <- c(values, if (is.null(day_of_birth)) "NULL" else if (is(day_of_birth, "subQuery")) paste0("(", as.character(day_of_birth), ")") else paste0("'", as.character(day_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.day_of_birth')
  }

  if (!missing(birth_datetime)) {
    fields <- c(fields, "birth_datetime")
    values <- c(values, if (is.null(birth_datetime)) "NULL" else if (is(birth_datetime, "subQuery")) paste0("(", as.character(birth_datetime), ")") else paste0("'", as.character(birth_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.birth_datetime')
  }

  if (!missing(death_datetime)) {
    fields <- c(fields, "death_datetime")
    values <- c(values, if (is.null(death_datetime)) "NULL" else if (is(death_datetime, "subQuery")) paste0("(", as.character(death_datetime), ")") else paste0("'", as.character(death_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.death_datetime')
  }

  if (!missing(race_concept_id)) {
    fields <- c(fields, "race_concept_id")
    values <- c(values, if (is.null(race_concept_id)) "NULL" else if (is(race_concept_id, "subQuery")) paste0("(", as.character(race_concept_id), ")") else paste0("'", as.character(race_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.race_concept_id')
  }

  if (!missing(ethnicity_concept_id)) {
    fields <- c(fields, "ethnicity_concept_id")
    values <- c(values, if (is.null(ethnicity_concept_id)) "NULL" else if (is(ethnicity_concept_id, "subQuery")) paste0("(", as.character(ethnicity_concept_id), ")") else paste0("'", as.character(ethnicity_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.ethnicity_concept_id')
  }

  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) "NULL" else if (is(location_id, "subQuery")) paste0("(", as.character(location_id), ")") else paste0("'", as.character(location_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.location_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.provider_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) "NULL" else if (is(care_site_id, "subQuery")) paste0("(", as.character(care_site_id), ")") else paste0("'", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.care_site_id')
  }

  if (!missing(person_source_value)) {
    fields <- c(fields, "person_source_value")
    values <- c(values, if (is.null(person_source_value)) "NULL" else if (is(person_source_value, "subQuery")) paste0("(", as.character(person_source_value), ")") else paste0("'", as.character(person_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.person_source_value')
  }

  if (!missing(gender_source_value)) {
    fields <- c(fields, "gender_source_value")
    values <- c(values, if (is.null(gender_source_value)) "NULL" else if (is(gender_source_value, "subQuery")) paste0("(", as.character(gender_source_value), ")") else paste0("'", as.character(gender_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.gender_source_value')
  }

  if (!missing(gender_source_concept_id)) {
    fields <- c(fields, "gender_source_concept_id")
    values <- c(values, if (is.null(gender_source_concept_id)) "NULL" else if (is(gender_source_concept_id, "subQuery")) paste0("(", as.character(gender_source_concept_id), ")") else paste0("'", as.character(gender_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.gender_source_concept_id')
  }

  if (!missing(race_source_value)) {
    fields <- c(fields, "race_source_value")
    values <- c(values, if (is.null(race_source_value)) "NULL" else if (is(race_source_value, "subQuery")) paste0("(", as.character(race_source_value), ")") else paste0("'", as.character(race_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.race_source_value')
  }

  if (!missing(race_source_concept_id)) {
    fields <- c(fields, "race_source_concept_id")
    values <- c(values, if (is.null(race_source_concept_id)) "NULL" else if (is(race_source_concept_id, "subQuery")) paste0("(", as.character(race_source_concept_id), ")") else paste0("'", as.character(race_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.race_source_concept_id')
  }

  if (!missing(ethnicity_source_value)) {
    fields <- c(fields, "ethnicity_source_value")
    values <- c(values, if (is.null(ethnicity_source_value)) "NULL" else if (is(ethnicity_source_value, "subQuery")) paste0("(", as.character(ethnicity_source_value), ")") else paste0("'", as.character(ethnicity_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.ethnicity_source_value')
  }

  if (!missing(ethnicity_source_concept_id)) {
    fields <- c(fields, "ethnicity_source_concept_id")
    values <- c(values, if (is.null(ethnicity_source_concept_id)) "NULL" else if (is(ethnicity_source_concept_id, "subQuery")) paste0("(", as.character(ethnicity_source_concept_id), ")") else paste0("'", as.character(ethnicity_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.ethnicity_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "person", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_observation_period <- function(observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(observation_period_id)) {
    fields <- c(fields, "observation_period_id")
    values <- c(values, if (is.null(observation_period_id)) "NULL" else if (is(observation_period_id, "subQuery")) paste0("(", as.character(observation_period_id), ")") else paste0("'", as.character(observation_period_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.observation_period_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.person_id')
  }

  if (!missing(observation_period_start_date)) {
    fields <- c(fields, "observation_period_start_date")
    values <- c(values, if (is.null(observation_period_start_date)) "NULL" else if (is(observation_period_start_date, "subQuery")) paste0("(", as.character(observation_period_start_date), ")") else paste0("'", as.character(observation_period_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.observation_period_start_date')
  }

  if (!missing(observation_period_end_date)) {
    fields <- c(fields, "observation_period_end_date")
    values <- c(values, if (is.null(observation_period_end_date)) "NULL" else if (is(observation_period_end_date, "subQuery")) paste0("(", as.character(observation_period_end_date), ")") else paste0("'", as.character(observation_period_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.observation_period_end_date')
  }

  if (!missing(period_type_concept_id)) {
    fields <- c(fields, "period_type_concept_id")
    values <- c(values, if (is.null(period_type_concept_id)) "NULL" else if (is(period_type_concept_id, "subQuery")) paste0("(", as.character(period_type_concept_id), ")") else paste0("'", as.character(period_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.period_type_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "observation_period", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_visit_occurrence <- function(visit_occurrence_id, person_id, visit_concept_id, visit_start_date, visit_start_datetime, visit_end_date, visit_end_datetime, visit_type_concept_id, provider_id, care_site_id, visit_source_value, visit_source_concept_id, admitting_source_concept_id, admitting_source_value, discharge_to_concept_id, discharge_to_source_value, preceding_visit_occurrence_id) {
  fields <- c()
  values <- c()
  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_occurrence_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.person_id')
  }

  if (!missing(visit_concept_id)) {
    fields <- c(fields, "visit_concept_id")
    values <- c(values, if (is.null(visit_concept_id)) "NULL" else if (is(visit_concept_id, "subQuery")) paste0("(", as.character(visit_concept_id), ")") else paste0("'", as.character(visit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_concept_id')
  }

  if (!missing(visit_start_date)) {
    fields <- c(fields, "visit_start_date")
    values <- c(values, if (is.null(visit_start_date)) "NULL" else if (is(visit_start_date, "subQuery")) paste0("(", as.character(visit_start_date), ")") else paste0("'", as.character(visit_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_start_date')
  }

  if (!missing(visit_start_datetime)) {
    fields <- c(fields, "visit_start_datetime")
    values <- c(values, if (is.null(visit_start_datetime)) "NULL" else if (is(visit_start_datetime, "subQuery")) paste0("(", as.character(visit_start_datetime), ")") else paste0("'", as.character(visit_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_start_datetime')
  }

  if (!missing(visit_end_date)) {
    fields <- c(fields, "visit_end_date")
    values <- c(values, if (is.null(visit_end_date)) "NULL" else if (is(visit_end_date, "subQuery")) paste0("(", as.character(visit_end_date), ")") else paste0("'", as.character(visit_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_end_date')
  }

  if (!missing(visit_end_datetime)) {
    fields <- c(fields, "visit_end_datetime")
    values <- c(values, if (is.null(visit_end_datetime)) "NULL" else if (is(visit_end_datetime, "subQuery")) paste0("(", as.character(visit_end_datetime), ")") else paste0("'", as.character(visit_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_end_datetime')
  }

  if (!missing(visit_type_concept_id)) {
    fields <- c(fields, "visit_type_concept_id")
    values <- c(values, if (is.null(visit_type_concept_id)) "NULL" else if (is(visit_type_concept_id, "subQuery")) paste0("(", as.character(visit_type_concept_id), ")") else paste0("'", as.character(visit_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_type_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.provider_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) "NULL" else if (is(care_site_id, "subQuery")) paste0("(", as.character(care_site_id), ")") else paste0("'", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.care_site_id')
  }

  if (!missing(visit_source_value)) {
    fields <- c(fields, "visit_source_value")
    values <- c(values, if (is.null(visit_source_value)) "NULL" else if (is(visit_source_value, "subQuery")) paste0("(", as.character(visit_source_value), ")") else paste0("'", as.character(visit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_source_value')
  }

  if (!missing(visit_source_concept_id)) {
    fields <- c(fields, "visit_source_concept_id")
    values <- c(values, if (is.null(visit_source_concept_id)) "NULL" else if (is(visit_source_concept_id, "subQuery")) paste0("(", as.character(visit_source_concept_id), ")") else paste0("'", as.character(visit_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_source_concept_id')
  }

  if (!missing(admitting_source_concept_id)) {
    fields <- c(fields, "admitting_source_concept_id")
    values <- c(values, if (is.null(admitting_source_concept_id)) "NULL" else if (is(admitting_source_concept_id, "subQuery")) paste0("(", as.character(admitting_source_concept_id), ")") else paste0("'", as.character(admitting_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.admitting_source_concept_id')
  }

  if (!missing(admitting_source_value)) {
    fields <- c(fields, "admitting_source_value")
    values <- c(values, if (is.null(admitting_source_value)) "NULL" else if (is(admitting_source_value, "subQuery")) paste0("(", as.character(admitting_source_value), ")") else paste0("'", as.character(admitting_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.admitting_source_value')
  }

  if (!missing(discharge_to_concept_id)) {
    fields <- c(fields, "discharge_to_concept_id")
    values <- c(values, if (is.null(discharge_to_concept_id)) "NULL" else if (is(discharge_to_concept_id, "subQuery")) paste0("(", as.character(discharge_to_concept_id), ")") else paste0("'", as.character(discharge_to_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.discharge_to_concept_id')
  }

  if (!missing(discharge_to_source_value)) {
    fields <- c(fields, "discharge_to_source_value")
    values <- c(values, if (is.null(discharge_to_source_value)) "NULL" else if (is(discharge_to_source_value, "subQuery")) paste0("(", as.character(discharge_to_source_value), ")") else paste0("'", as.character(discharge_to_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.discharge_to_source_value')
  }

  if (!missing(preceding_visit_occurrence_id)) {
    fields <- c(fields, "preceding_visit_occurrence_id")
    values <- c(values, if (is.null(preceding_visit_occurrence_id)) "NULL" else if (is(preceding_visit_occurrence_id, "subQuery")) paste0("(", as.character(preceding_visit_occurrence_id), ")") else paste0("'", as.character(preceding_visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.preceding_visit_occurrence_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "visit_occurrence", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_visit_detail <- function(visit_detail_id, person_id, visit_detail_concept_id, visit_detail_start_date, visit_detail_start_datetime, visit_detail_end_date, visit_detail_end_datetime, visit_detail_type_concept_id, provider_id, care_site_id, visit_detail_source_value, visit_detail_source_concept_id, admitted_from_source_value, admitted_from_concept_id, discharge_to_source_value, discharge_to_concept_id, preceding_visit_detail_id, visit_detail_parent_id, visit_occurrence_id) {
  fields <- c()
  values <- c()
  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.person_id')
  }

  if (!missing(visit_detail_concept_id)) {
    fields <- c(fields, "visit_detail_concept_id")
    values <- c(values, if (is.null(visit_detail_concept_id)) "NULL" else if (is(visit_detail_concept_id, "subQuery")) paste0("(", as.character(visit_detail_concept_id), ")") else paste0("'", as.character(visit_detail_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_concept_id')
  }

  if (!missing(visit_detail_start_date)) {
    fields <- c(fields, "visit_detail_start_date")
    values <- c(values, if (is.null(visit_detail_start_date)) "NULL" else if (is(visit_detail_start_date, "subQuery")) paste0("(", as.character(visit_detail_start_date), ")") else paste0("'", as.character(visit_detail_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_start_date')
  }

  if (!missing(visit_detail_start_datetime)) {
    fields <- c(fields, "visit_detail_start_datetime")
    values <- c(values, if (is.null(visit_detail_start_datetime)) "NULL" else if (is(visit_detail_start_datetime, "subQuery")) paste0("(", as.character(visit_detail_start_datetime), ")") else paste0("'", as.character(visit_detail_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_start_datetime')
  }

  if (!missing(visit_detail_end_date)) {
    fields <- c(fields, "visit_detail_end_date")
    values <- c(values, if (is.null(visit_detail_end_date)) "NULL" else if (is(visit_detail_end_date, "subQuery")) paste0("(", as.character(visit_detail_end_date), ")") else paste0("'", as.character(visit_detail_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_end_date')
  }

  if (!missing(visit_detail_end_datetime)) {
    fields <- c(fields, "visit_detail_end_datetime")
    values <- c(values, if (is.null(visit_detail_end_datetime)) "NULL" else if (is(visit_detail_end_datetime, "subQuery")) paste0("(", as.character(visit_detail_end_datetime), ")") else paste0("'", as.character(visit_detail_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_end_datetime')
  }

  if (!missing(visit_detail_type_concept_id)) {
    fields <- c(fields, "visit_detail_type_concept_id")
    values <- c(values, if (is.null(visit_detail_type_concept_id)) "NULL" else if (is(visit_detail_type_concept_id, "subQuery")) paste0("(", as.character(visit_detail_type_concept_id), ")") else paste0("'", as.character(visit_detail_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_type_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.provider_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) "NULL" else if (is(care_site_id, "subQuery")) paste0("(", as.character(care_site_id), ")") else paste0("'", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.care_site_id')
  }

  if (!missing(visit_detail_source_value)) {
    fields <- c(fields, "visit_detail_source_value")
    values <- c(values, if (is.null(visit_detail_source_value)) "NULL" else if (is(visit_detail_source_value, "subQuery")) paste0("(", as.character(visit_detail_source_value), ")") else paste0("'", as.character(visit_detail_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_source_value')
  }

  if (!missing(visit_detail_source_concept_id)) {
    fields <- c(fields, "visit_detail_source_concept_id")
    values <- c(values, if (is.null(visit_detail_source_concept_id)) "NULL" else if (is(visit_detail_source_concept_id, "subQuery")) paste0("(", as.character(visit_detail_source_concept_id), ")") else paste0("'", as.character(visit_detail_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_source_concept_id')
  }

  if (!missing(admitted_from_source_value)) {
    fields <- c(fields, "admitted_from_source_value")
    values <- c(values, if (is.null(admitted_from_source_value)) "NULL" else if (is(admitted_from_source_value, "subQuery")) paste0("(", as.character(admitted_from_source_value), ")") else paste0("'", as.character(admitted_from_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.admitted_from_source_value')
  }

  if (!missing(admitted_from_concept_id)) {
    fields <- c(fields, "admitted_from_concept_id")
    values <- c(values, if (is.null(admitted_from_concept_id)) "NULL" else if (is(admitted_from_concept_id, "subQuery")) paste0("(", as.character(admitted_from_concept_id), ")") else paste0("'", as.character(admitted_from_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.admitted_from_concept_id')
  }

  if (!missing(discharge_to_source_value)) {
    fields <- c(fields, "discharge_to_source_value")
    values <- c(values, if (is.null(discharge_to_source_value)) "NULL" else if (is(discharge_to_source_value, "subQuery")) paste0("(", as.character(discharge_to_source_value), ")") else paste0("'", as.character(discharge_to_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.discharge_to_source_value')
  }

  if (!missing(discharge_to_concept_id)) {
    fields <- c(fields, "discharge_to_concept_id")
    values <- c(values, if (is.null(discharge_to_concept_id)) "NULL" else if (is(discharge_to_concept_id, "subQuery")) paste0("(", as.character(discharge_to_concept_id), ")") else paste0("'", as.character(discharge_to_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.discharge_to_concept_id')
  }

  if (!missing(preceding_visit_detail_id)) {
    fields <- c(fields, "preceding_visit_detail_id")
    values <- c(values, if (is.null(preceding_visit_detail_id)) "NULL" else if (is(preceding_visit_detail_id, "subQuery")) paste0("(", as.character(preceding_visit_detail_id), ")") else paste0("'", as.character(preceding_visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.preceding_visit_detail_id')
  }

  if (!missing(visit_detail_parent_id)) {
    fields <- c(fields, "visit_detail_parent_id")
    values <- c(values, if (is.null(visit_detail_parent_id)) "NULL" else if (is(visit_detail_parent_id, "subQuery")) paste0("(", as.character(visit_detail_parent_id), ")") else paste0("'", as.character(visit_detail_parent_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_parent_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_occurrence_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "visit_detail", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_condition_occurrence <- function(condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_start_datetime, condition_end_date, condition_end_datetime, condition_type_concept_id, condition_status_concept_id, stop_reason, provider_id, visit_occurrence_id, visit_detail_id, condition_source_value, condition_source_concept_id, condition_status_source_value) {
  fields <- c()
  values <- c()
  if (!missing(condition_occurrence_id)) {
    fields <- c(fields, "condition_occurrence_id")
    values <- c(values, if (is.null(condition_occurrence_id)) "NULL" else if (is(condition_occurrence_id, "subQuery")) paste0("(", as.character(condition_occurrence_id), ")") else paste0("'", as.character(condition_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_occurrence_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.person_id')
  }

  if (!missing(condition_concept_id)) {
    fields <- c(fields, "condition_concept_id")
    values <- c(values, if (is.null(condition_concept_id)) "NULL" else if (is(condition_concept_id, "subQuery")) paste0("(", as.character(condition_concept_id), ")") else paste0("'", as.character(condition_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_concept_id')
  }

  if (!missing(condition_start_date)) {
    fields <- c(fields, "condition_start_date")
    values <- c(values, if (is.null(condition_start_date)) "NULL" else if (is(condition_start_date, "subQuery")) paste0("(", as.character(condition_start_date), ")") else paste0("'", as.character(condition_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_start_date')
  }

  if (!missing(condition_start_datetime)) {
    fields <- c(fields, "condition_start_datetime")
    values <- c(values, if (is.null(condition_start_datetime)) "NULL" else if (is(condition_start_datetime, "subQuery")) paste0("(", as.character(condition_start_datetime), ")") else paste0("'", as.character(condition_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_start_datetime')
  }

  if (!missing(condition_end_date)) {
    fields <- c(fields, "condition_end_date")
    values <- c(values, if (is.null(condition_end_date)) "NULL" else if (is(condition_end_date, "subQuery")) paste0("(", as.character(condition_end_date), ")") else paste0("'", as.character(condition_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_end_date')
  }

  if (!missing(condition_end_datetime)) {
    fields <- c(fields, "condition_end_datetime")
    values <- c(values, if (is.null(condition_end_datetime)) "NULL" else if (is(condition_end_datetime, "subQuery")) paste0("(", as.character(condition_end_datetime), ")") else paste0("'", as.character(condition_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_end_datetime')
  }

  if (!missing(condition_type_concept_id)) {
    fields <- c(fields, "condition_type_concept_id")
    values <- c(values, if (is.null(condition_type_concept_id)) "NULL" else if (is(condition_type_concept_id, "subQuery")) paste0("(", as.character(condition_type_concept_id), ")") else paste0("'", as.character(condition_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_type_concept_id')
  }

  if (!missing(condition_status_concept_id)) {
    fields <- c(fields, "condition_status_concept_id")
    values <- c(values, if (is.null(condition_status_concept_id)) "NULL" else if (is(condition_status_concept_id, "subQuery")) paste0("(", as.character(condition_status_concept_id), ")") else paste0("'", as.character(condition_status_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_status_concept_id')
  }

  if (!missing(stop_reason)) {
    fields <- c(fields, "stop_reason")
    values <- c(values, if (is.null(stop_reason)) "NULL" else if (is(stop_reason, "subQuery")) paste0("(", as.character(stop_reason), ")") else paste0("'", as.character(stop_reason), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.stop_reason')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.visit_detail_id')
  }

  if (!missing(condition_source_value)) {
    fields <- c(fields, "condition_source_value")
    values <- c(values, if (is.null(condition_source_value)) "NULL" else if (is(condition_source_value, "subQuery")) paste0("(", as.character(condition_source_value), ")") else paste0("'", as.character(condition_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_source_value')
  }

  if (!missing(condition_source_concept_id)) {
    fields <- c(fields, "condition_source_concept_id")
    values <- c(values, if (is.null(condition_source_concept_id)) "NULL" else if (is(condition_source_concept_id, "subQuery")) paste0("(", as.character(condition_source_concept_id), ")") else paste0("'", as.character(condition_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_source_concept_id')
  }

  if (!missing(condition_status_source_value)) {
    fields <- c(fields, "condition_status_source_value")
    values <- c(values, if (is.null(condition_status_source_value)) "NULL" else if (is(condition_status_source_value, "subQuery")) paste0("(", as.character(condition_status_source_value), ")") else paste0("'", as.character(condition_status_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_status_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "condition_occurrence", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_procedure_occurrence <- function(procedure_occurrence_id, person_id, procedure_concept_id, procedure_date, procedure_datetime, procedure_type_concept_id, modifier_concept_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, procedure_source_value, procedure_source_concept_id, modifier_source_value) {
  fields <- c()
  values <- c()
  if (!missing(procedure_occurrence_id)) {
    fields <- c(fields, "procedure_occurrence_id")
    values <- c(values, if (is.null(procedure_occurrence_id)) "NULL" else if (is(procedure_occurrence_id, "subQuery")) paste0("(", as.character(procedure_occurrence_id), ")") else paste0("'", as.character(procedure_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_occurrence_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.person_id')
  }

  if (!missing(procedure_concept_id)) {
    fields <- c(fields, "procedure_concept_id")
    values <- c(values, if (is.null(procedure_concept_id)) "NULL" else if (is(procedure_concept_id, "subQuery")) paste0("(", as.character(procedure_concept_id), ")") else paste0("'", as.character(procedure_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_concept_id')
  }

  if (!missing(procedure_date)) {
    fields <- c(fields, "procedure_date")
    values <- c(values, if (is.null(procedure_date)) "NULL" else if (is(procedure_date, "subQuery")) paste0("(", as.character(procedure_date), ")") else paste0("'", as.character(procedure_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_date')
  }

  if (!missing(procedure_datetime)) {
    fields <- c(fields, "procedure_datetime")
    values <- c(values, if (is.null(procedure_datetime)) "NULL" else if (is(procedure_datetime, "subQuery")) paste0("(", as.character(procedure_datetime), ")") else paste0("'", as.character(procedure_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_datetime')
  }

  if (!missing(procedure_type_concept_id)) {
    fields <- c(fields, "procedure_type_concept_id")
    values <- c(values, if (is.null(procedure_type_concept_id)) "NULL" else if (is(procedure_type_concept_id, "subQuery")) paste0("(", as.character(procedure_type_concept_id), ")") else paste0("'", as.character(procedure_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_type_concept_id')
  }

  if (!missing(modifier_concept_id)) {
    fields <- c(fields, "modifier_concept_id")
    values <- c(values, if (is.null(modifier_concept_id)) "NULL" else if (is(modifier_concept_id, "subQuery")) paste0("(", as.character(modifier_concept_id), ")") else paste0("'", as.character(modifier_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.modifier_concept_id')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) "NULL" else if (is(quantity, "subQuery")) paste0("(", as.character(quantity), ")") else paste0("'", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.quantity')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.visit_detail_id')
  }

  if (!missing(procedure_source_value)) {
    fields <- c(fields, "procedure_source_value")
    values <- c(values, if (is.null(procedure_source_value)) "NULL" else if (is(procedure_source_value, "subQuery")) paste0("(", as.character(procedure_source_value), ")") else paste0("'", as.character(procedure_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_source_value')
  }

  if (!missing(procedure_source_concept_id)) {
    fields <- c(fields, "procedure_source_concept_id")
    values <- c(values, if (is.null(procedure_source_concept_id)) "NULL" else if (is(procedure_source_concept_id, "subQuery")) paste0("(", as.character(procedure_source_concept_id), ")") else paste0("'", as.character(procedure_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_source_concept_id')
  }

  if (!missing(modifier_source_value)) {
    fields <- c(fields, "modifier_source_value")
    values <- c(values, if (is.null(modifier_source_value)) "NULL" else if (is(modifier_source_value, "subQuery")) paste0("(", as.character(modifier_source_value), ")") else paste0("'", as.character(modifier_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.modifier_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "procedure_occurrence", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_drug_exposure <- function(drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_start_datetime, drug_exposure_end_date, drug_exposure_end_datetime, verbatim_end_date, drug_type_concept_id, stop_reason, refills, quantity, days_supply, sig, route_concept_id, lot_number, provider_id, visit_occurrence_id, visit_detail_id, drug_source_value, drug_source_concept_id, route_source_value, dose_unit_source_value) {
  fields <- c()
  values <- c()
  if (!missing(drug_exposure_id)) {
    fields <- c(fields, "drug_exposure_id")
    values <- c(values, if (is.null(drug_exposure_id)) "NULL" else if (is(drug_exposure_id, "subQuery")) paste0("(", as.character(drug_exposure_id), ")") else paste0("'", as.character(drug_exposure_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.person_id')
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) "NULL" else if (is(drug_concept_id, "subQuery")) paste0("(", as.character(drug_concept_id), ")") else paste0("'", as.character(drug_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_concept_id')
  }

  if (!missing(drug_exposure_start_date)) {
    fields <- c(fields, "drug_exposure_start_date")
    values <- c(values, if (is.null(drug_exposure_start_date)) "NULL" else if (is(drug_exposure_start_date, "subQuery")) paste0("(", as.character(drug_exposure_start_date), ")") else paste0("'", as.character(drug_exposure_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_start_date')
  }

  if (!missing(drug_exposure_start_datetime)) {
    fields <- c(fields, "drug_exposure_start_datetime")
    values <- c(values, if (is.null(drug_exposure_start_datetime)) "NULL" else if (is(drug_exposure_start_datetime, "subQuery")) paste0("(", as.character(drug_exposure_start_datetime), ")") else paste0("'", as.character(drug_exposure_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_start_datetime')
  }

  if (!missing(drug_exposure_end_date)) {
    fields <- c(fields, "drug_exposure_end_date")
    values <- c(values, if (is.null(drug_exposure_end_date)) "NULL" else if (is(drug_exposure_end_date, "subQuery")) paste0("(", as.character(drug_exposure_end_date), ")") else paste0("'", as.character(drug_exposure_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_end_date')
  }

  if (!missing(drug_exposure_end_datetime)) {
    fields <- c(fields, "drug_exposure_end_datetime")
    values <- c(values, if (is.null(drug_exposure_end_datetime)) "NULL" else if (is(drug_exposure_end_datetime, "subQuery")) paste0("(", as.character(drug_exposure_end_datetime), ")") else paste0("'", as.character(drug_exposure_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_end_datetime')
  }

  if (!missing(verbatim_end_date)) {
    fields <- c(fields, "verbatim_end_date")
    values <- c(values, if (is.null(verbatim_end_date)) "NULL" else if (is(verbatim_end_date, "subQuery")) paste0("(", as.character(verbatim_end_date), ")") else paste0("'", as.character(verbatim_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.verbatim_end_date')
  }

  if (!missing(drug_type_concept_id)) {
    fields <- c(fields, "drug_type_concept_id")
    values <- c(values, if (is.null(drug_type_concept_id)) "NULL" else if (is(drug_type_concept_id, "subQuery")) paste0("(", as.character(drug_type_concept_id), ")") else paste0("'", as.character(drug_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_type_concept_id')
  }

  if (!missing(stop_reason)) {
    fields <- c(fields, "stop_reason")
    values <- c(values, if (is.null(stop_reason)) "NULL" else if (is(stop_reason, "subQuery")) paste0("(", as.character(stop_reason), ")") else paste0("'", as.character(stop_reason), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.stop_reason')
  }

  if (!missing(refills)) {
    fields <- c(fields, "refills")
    values <- c(values, if (is.null(refills)) "NULL" else if (is(refills, "subQuery")) paste0("(", as.character(refills), ")") else paste0("'", as.character(refills), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.refills')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) "NULL" else if (is(quantity, "subQuery")) paste0("(", as.character(quantity), ")") else paste0("'", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.quantity')
  }

  if (!missing(days_supply)) {
    fields <- c(fields, "days_supply")
    values <- c(values, if (is.null(days_supply)) "NULL" else if (is(days_supply, "subQuery")) paste0("(", as.character(days_supply), ")") else paste0("'", as.character(days_supply), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.days_supply')
  }

  if (!missing(sig)) {
    fields <- c(fields, "sig")
    values <- c(values, if (is.null(sig)) "NULL" else if (is(sig, "subQuery")) paste0("(", as.character(sig), ")") else paste0("'", as.character(sig), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.sig')
  }

  if (!missing(route_concept_id)) {
    fields <- c(fields, "route_concept_id")
    values <- c(values, if (is.null(route_concept_id)) "NULL" else if (is(route_concept_id, "subQuery")) paste0("(", as.character(route_concept_id), ")") else paste0("'", as.character(route_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.route_concept_id')
  }

  if (!missing(lot_number)) {
    fields <- c(fields, "lot_number")
    values <- c(values, if (is.null(lot_number)) "NULL" else if (is(lot_number, "subQuery")) paste0("(", as.character(lot_number), ")") else paste0("'", as.character(lot_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.lot_number')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.visit_detail_id')
  }

  if (!missing(drug_source_value)) {
    fields <- c(fields, "drug_source_value")
    values <- c(values, if (is.null(drug_source_value)) "NULL" else if (is(drug_source_value, "subQuery")) paste0("(", as.character(drug_source_value), ")") else paste0("'", as.character(drug_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_source_value')
  }

  if (!missing(drug_source_concept_id)) {
    fields <- c(fields, "drug_source_concept_id")
    values <- c(values, if (is.null(drug_source_concept_id)) "NULL" else if (is(drug_source_concept_id, "subQuery")) paste0("(", as.character(drug_source_concept_id), ")") else paste0("'", as.character(drug_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_source_concept_id')
  }

  if (!missing(route_source_value)) {
    fields <- c(fields, "route_source_value")
    values <- c(values, if (is.null(route_source_value)) "NULL" else if (is(route_source_value, "subQuery")) paste0("(", as.character(route_source_value), ")") else paste0("'", as.character(route_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.route_source_value')
  }

  if (!missing(dose_unit_source_value)) {
    fields <- c(fields, "dose_unit_source_value")
    values <- c(values, if (is.null(dose_unit_source_value)) "NULL" else if (is(dose_unit_source_value, "subQuery")) paste0("(", as.character(dose_unit_source_value), ")") else paste0("'", as.character(dose_unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.dose_unit_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "drug_exposure", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_device_exposure <- function(device_exposure_id, person_id, device_concept_id, device_exposure_start_date, device_exposure_start_datetime, device_exposure_end_date, device_exposure_end_datetime, device_type_concept_id, unique_device_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, device_source_value, device_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(device_exposure_id)) {
    fields <- c(fields, "device_exposure_id")
    values <- c(values, if (is.null(device_exposure_id)) "NULL" else if (is(device_exposure_id, "subQuery")) paste0("(", as.character(device_exposure_id), ")") else paste0("'", as.character(device_exposure_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.person_id')
  }

  if (!missing(device_concept_id)) {
    fields <- c(fields, "device_concept_id")
    values <- c(values, if (is.null(device_concept_id)) "NULL" else if (is(device_concept_id, "subQuery")) paste0("(", as.character(device_concept_id), ")") else paste0("'", as.character(device_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_concept_id')
  }

  if (!missing(device_exposure_start_date)) {
    fields <- c(fields, "device_exposure_start_date")
    values <- c(values, if (is.null(device_exposure_start_date)) "NULL" else if (is(device_exposure_start_date, "subQuery")) paste0("(", as.character(device_exposure_start_date), ")") else paste0("'", as.character(device_exposure_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_start_date')
  }

  if (!missing(device_exposure_start_datetime)) {
    fields <- c(fields, "device_exposure_start_datetime")
    values <- c(values, if (is.null(device_exposure_start_datetime)) "NULL" else if (is(device_exposure_start_datetime, "subQuery")) paste0("(", as.character(device_exposure_start_datetime), ")") else paste0("'", as.character(device_exposure_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_start_datetime')
  }

  if (!missing(device_exposure_end_date)) {
    fields <- c(fields, "device_exposure_end_date")
    values <- c(values, if (is.null(device_exposure_end_date)) "NULL" else if (is(device_exposure_end_date, "subQuery")) paste0("(", as.character(device_exposure_end_date), ")") else paste0("'", as.character(device_exposure_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_end_date')
  }

  if (!missing(device_exposure_end_datetime)) {
    fields <- c(fields, "device_exposure_end_datetime")
    values <- c(values, if (is.null(device_exposure_end_datetime)) "NULL" else if (is(device_exposure_end_datetime, "subQuery")) paste0("(", as.character(device_exposure_end_datetime), ")") else paste0("'", as.character(device_exposure_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_end_datetime')
  }

  if (!missing(device_type_concept_id)) {
    fields <- c(fields, "device_type_concept_id")
    values <- c(values, if (is.null(device_type_concept_id)) "NULL" else if (is(device_type_concept_id, "subQuery")) paste0("(", as.character(device_type_concept_id), ")") else paste0("'", as.character(device_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_type_concept_id')
  }

  if (!missing(unique_device_id)) {
    fields <- c(fields, "unique_device_id")
    values <- c(values, if (is.null(unique_device_id)) "NULL" else if (is(unique_device_id, "subQuery")) paste0("(", as.character(unique_device_id), ")") else paste0("'", as.character(unique_device_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.unique_device_id')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) "NULL" else if (is(quantity, "subQuery")) paste0("(", as.character(quantity), ")") else paste0("'", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.quantity')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.visit_detail_id')
  }

  if (!missing(device_source_value)) {
    fields <- c(fields, "device_source_value")
    values <- c(values, if (is.null(device_source_value)) "NULL" else if (is(device_source_value, "subQuery")) paste0("(", as.character(device_source_value), ")") else paste0("'", as.character(device_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_source_value')
  }

  if (!missing(device_source_concept_id)) {
    fields <- c(fields, "device_source_concept_id")
    values <- c(values, if (is.null(device_source_concept_id)) "NULL" else if (is(device_source_concept_id, "subQuery")) paste0("(", as.character(device_source_concept_id), ")") else paste0("'", as.character(device_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "device_exposure", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_measurement <- function(measurement_id, person_id, measurement_concept_id, measurement_date, measurement_datetime, measurement_time, measurement_type_concept_id, operator_concept_id, value_as_number, value_as_concept_id, unit_concept_id, range_low, range_high, provider_id, visit_occurrence_id, visit_detail_id, measurement_source_value, measurement_source_concept_id, unit_source_value, value_source_value) {
  fields <- c()
  values <- c()
  if (!missing(measurement_id)) {
    fields <- c(fields, "measurement_id")
    values <- c(values, if (is.null(measurement_id)) "NULL" else if (is(measurement_id, "subQuery")) paste0("(", as.character(measurement_id), ")") else paste0("'", as.character(measurement_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.person_id')
  }

  if (!missing(measurement_concept_id)) {
    fields <- c(fields, "measurement_concept_id")
    values <- c(values, if (is.null(measurement_concept_id)) "NULL" else if (is(measurement_concept_id, "subQuery")) paste0("(", as.character(measurement_concept_id), ")") else paste0("'", as.character(measurement_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_concept_id')
  }

  if (!missing(measurement_date)) {
    fields <- c(fields, "measurement_date")
    values <- c(values, if (is.null(measurement_date)) "NULL" else if (is(measurement_date, "subQuery")) paste0("(", as.character(measurement_date), ")") else paste0("'", as.character(measurement_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_date')
  }

  if (!missing(measurement_datetime)) {
    fields <- c(fields, "measurement_datetime")
    values <- c(values, if (is.null(measurement_datetime)) "NULL" else if (is(measurement_datetime, "subQuery")) paste0("(", as.character(measurement_datetime), ")") else paste0("'", as.character(measurement_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_datetime')
  }

  if (!missing(measurement_time)) {
    fields <- c(fields, "measurement_time")
    values <- c(values, if (is.null(measurement_time)) "NULL" else if (is(measurement_time, "subQuery")) paste0("(", as.character(measurement_time), ")") else paste0("'", as.character(measurement_time), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_time')
  }

  if (!missing(measurement_type_concept_id)) {
    fields <- c(fields, "measurement_type_concept_id")
    values <- c(values, if (is.null(measurement_type_concept_id)) "NULL" else if (is(measurement_type_concept_id, "subQuery")) paste0("(", as.character(measurement_type_concept_id), ")") else paste0("'", as.character(measurement_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_type_concept_id')
  }

  if (!missing(operator_concept_id)) {
    fields <- c(fields, "operator_concept_id")
    values <- c(values, if (is.null(operator_concept_id)) "NULL" else if (is(operator_concept_id, "subQuery")) paste0("(", as.character(operator_concept_id), ")") else paste0("'", as.character(operator_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.operator_concept_id')
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) "NULL" else if (is(value_as_number, "subQuery")) paste0("(", as.character(value_as_number), ")") else paste0("'", as.character(value_as_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.value_as_number')
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) "NULL" else if (is(value_as_concept_id, "subQuery")) paste0("(", as.character(value_as_concept_id), ")") else paste0("'", as.character(value_as_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.value_as_concept_id')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) "NULL" else if (is(unit_concept_id, "subQuery")) paste0("(", as.character(unit_concept_id), ")") else paste0("'", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.unit_concept_id')
  }

  if (!missing(range_low)) {
    fields <- c(fields, "range_low")
    values <- c(values, if (is.null(range_low)) "NULL" else if (is(range_low, "subQuery")) paste0("(", as.character(range_low), ")") else paste0("'", as.character(range_low), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.range_low')
  }

  if (!missing(range_high)) {
    fields <- c(fields, "range_high")
    values <- c(values, if (is.null(range_high)) "NULL" else if (is(range_high, "subQuery")) paste0("(", as.character(range_high), ")") else paste0("'", as.character(range_high), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.range_high')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.visit_detail_id')
  }

  if (!missing(measurement_source_value)) {
    fields <- c(fields, "measurement_source_value")
    values <- c(values, if (is.null(measurement_source_value)) "NULL" else if (is(measurement_source_value, "subQuery")) paste0("(", as.character(measurement_source_value), ")") else paste0("'", as.character(measurement_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_source_value')
  }

  if (!missing(measurement_source_concept_id)) {
    fields <- c(fields, "measurement_source_concept_id")
    values <- c(values, if (is.null(measurement_source_concept_id)) "NULL" else if (is(measurement_source_concept_id, "subQuery")) paste0("(", as.character(measurement_source_concept_id), ")") else paste0("'", as.character(measurement_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_source_concept_id')
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) "NULL" else if (is(unit_source_value, "subQuery")) paste0("(", as.character(unit_source_value), ")") else paste0("'", as.character(unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.unit_source_value')
  }

  if (!missing(value_source_value)) {
    fields <- c(fields, "value_source_value")
    values <- c(values, if (is.null(value_source_value)) "NULL" else if (is(value_source_value, "subQuery")) paste0("(", as.character(value_source_value), ")") else paste0("'", as.character(value_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.value_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "measurement", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_observation <- function(observation_id, person_id, observation_concept_id, observation_date, observation_datetime, observation_type_concept_id, value_as_number, value_as_string, value_as_concept_id, qualifier_concept_id, unit_concept_id, provider_id, visit_occurrence_id, visit_detail_id, observation_source_value, observation_source_concept_id, unit_source_value, qualifier_source_value, observation_event_id, obs_event_field_concept_id, value_as_datetime) {
  fields <- c()
  values <- c()
  if (!missing(observation_id)) {
    fields <- c(fields, "observation_id")
    values <- c(values, if (is.null(observation_id)) "NULL" else if (is(observation_id, "subQuery")) paste0("(", as.character(observation_id), ")") else paste0("'", as.character(observation_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.person_id')
  }

  if (!missing(observation_concept_id)) {
    fields <- c(fields, "observation_concept_id")
    values <- c(values, if (is.null(observation_concept_id)) "NULL" else if (is(observation_concept_id, "subQuery")) paste0("(", as.character(observation_concept_id), ")") else paste0("'", as.character(observation_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_concept_id')
  }

  if (!missing(observation_date)) {
    fields <- c(fields, "observation_date")
    values <- c(values, if (is.null(observation_date)) "NULL" else if (is(observation_date, "subQuery")) paste0("(", as.character(observation_date), ")") else paste0("'", as.character(observation_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_date')
  }

  if (!missing(observation_datetime)) {
    fields <- c(fields, "observation_datetime")
    values <- c(values, if (is.null(observation_datetime)) "NULL" else if (is(observation_datetime, "subQuery")) paste0("(", as.character(observation_datetime), ")") else paste0("'", as.character(observation_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_datetime')
  }

  if (!missing(observation_type_concept_id)) {
    fields <- c(fields, "observation_type_concept_id")
    values <- c(values, if (is.null(observation_type_concept_id)) "NULL" else if (is(observation_type_concept_id, "subQuery")) paste0("(", as.character(observation_type_concept_id), ")") else paste0("'", as.character(observation_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_type_concept_id')
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) "NULL" else if (is(value_as_number, "subQuery")) paste0("(", as.character(value_as_number), ")") else paste0("'", as.character(value_as_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_as_number')
  }

  if (!missing(value_as_string)) {
    fields <- c(fields, "value_as_string")
    values <- c(values, if (is.null(value_as_string)) "NULL" else if (is(value_as_string, "subQuery")) paste0("(", as.character(value_as_string), ")") else paste0("'", as.character(value_as_string), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_as_string')
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) "NULL" else if (is(value_as_concept_id, "subQuery")) paste0("(", as.character(value_as_concept_id), ")") else paste0("'", as.character(value_as_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_as_concept_id')
  }

  if (!missing(qualifier_concept_id)) {
    fields <- c(fields, "qualifier_concept_id")
    values <- c(values, if (is.null(qualifier_concept_id)) "NULL" else if (is(qualifier_concept_id, "subQuery")) paste0("(", as.character(qualifier_concept_id), ")") else paste0("'", as.character(qualifier_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.qualifier_concept_id')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) "NULL" else if (is(unit_concept_id, "subQuery")) paste0("(", as.character(unit_concept_id), ")") else paste0("'", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.unit_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.visit_detail_id')
  }

  if (!missing(observation_source_value)) {
    fields <- c(fields, "observation_source_value")
    values <- c(values, if (is.null(observation_source_value)) "NULL" else if (is(observation_source_value, "subQuery")) paste0("(", as.character(observation_source_value), ")") else paste0("'", as.character(observation_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_source_value')
  }

  if (!missing(observation_source_concept_id)) {
    fields <- c(fields, "observation_source_concept_id")
    values <- c(values, if (is.null(observation_source_concept_id)) "NULL" else if (is(observation_source_concept_id, "subQuery")) paste0("(", as.character(observation_source_concept_id), ")") else paste0("'", as.character(observation_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_source_concept_id')
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) "NULL" else if (is(unit_source_value, "subQuery")) paste0("(", as.character(unit_source_value), ")") else paste0("'", as.character(unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.unit_source_value')
  }

  if (!missing(qualifier_source_value)) {
    fields <- c(fields, "qualifier_source_value")
    values <- c(values, if (is.null(qualifier_source_value)) "NULL" else if (is(qualifier_source_value, "subQuery")) paste0("(", as.character(qualifier_source_value), ")") else paste0("'", as.character(qualifier_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.qualifier_source_value')
  }

  if (!missing(observation_event_id)) {
    fields <- c(fields, "observation_event_id")
    values <- c(values, if (is.null(observation_event_id)) "NULL" else if (is(observation_event_id, "subQuery")) paste0("(", as.character(observation_event_id), ")") else paste0("'", as.character(observation_event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_event_id')
  }

  if (!missing(obs_event_field_concept_id)) {
    fields <- c(fields, "obs_event_field_concept_id")
    values <- c(values, if (is.null(obs_event_field_concept_id)) "NULL" else if (is(obs_event_field_concept_id, "subQuery")) paste0("(", as.character(obs_event_field_concept_id), ")") else paste0("'", as.character(obs_event_field_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.obs_event_field_concept_id')
  }

  if (!missing(value_as_datetime)) {
    fields <- c(fields, "value_as_datetime")
    values <- c(values, if (is.null(value_as_datetime)) "NULL" else if (is(value_as_datetime, "subQuery")) paste0("(", as.character(value_as_datetime), ")") else paste0("'", as.character(value_as_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_as_datetime')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "observation", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_specimen <- function(specimen_id, person_id, specimen_concept_id, specimen_type_concept_id, specimen_date, specimen_datetime, quantity, unit_concept_id, anatomic_site_concept_id, disease_status_concept_id, specimen_source_id, specimen_source_value, unit_source_value, anatomic_site_source_value, disease_status_source_value) {
  fields <- c()
  values <- c()
  if (!missing(specimen_id)) {
    fields <- c(fields, "specimen_id")
    values <- c(values, if (is.null(specimen_id)) "NULL" else if (is(specimen_id, "subQuery")) paste0("(", as.character(specimen_id), ")") else paste0("'", as.character(specimen_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.person_id')
  }

  if (!missing(specimen_concept_id)) {
    fields <- c(fields, "specimen_concept_id")
    values <- c(values, if (is.null(specimen_concept_id)) "NULL" else if (is(specimen_concept_id, "subQuery")) paste0("(", as.character(specimen_concept_id), ")") else paste0("'", as.character(specimen_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_concept_id')
  }

  if (!missing(specimen_type_concept_id)) {
    fields <- c(fields, "specimen_type_concept_id")
    values <- c(values, if (is.null(specimen_type_concept_id)) "NULL" else if (is(specimen_type_concept_id, "subQuery")) paste0("(", as.character(specimen_type_concept_id), ")") else paste0("'", as.character(specimen_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_type_concept_id')
  }

  if (!missing(specimen_date)) {
    fields <- c(fields, "specimen_date")
    values <- c(values, if (is.null(specimen_date)) "NULL" else if (is(specimen_date, "subQuery")) paste0("(", as.character(specimen_date), ")") else paste0("'", as.character(specimen_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_date')
  }

  if (!missing(specimen_datetime)) {
    fields <- c(fields, "specimen_datetime")
    values <- c(values, if (is.null(specimen_datetime)) "NULL" else if (is(specimen_datetime, "subQuery")) paste0("(", as.character(specimen_datetime), ")") else paste0("'", as.character(specimen_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_datetime')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) "NULL" else if (is(quantity, "subQuery")) paste0("(", as.character(quantity), ")") else paste0("'", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.quantity')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) "NULL" else if (is(unit_concept_id, "subQuery")) paste0("(", as.character(unit_concept_id), ")") else paste0("'", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.unit_concept_id')
  }

  if (!missing(anatomic_site_concept_id)) {
    fields <- c(fields, "anatomic_site_concept_id")
    values <- c(values, if (is.null(anatomic_site_concept_id)) "NULL" else if (is(anatomic_site_concept_id, "subQuery")) paste0("(", as.character(anatomic_site_concept_id), ")") else paste0("'", as.character(anatomic_site_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.anatomic_site_concept_id')
  }

  if (!missing(disease_status_concept_id)) {
    fields <- c(fields, "disease_status_concept_id")
    values <- c(values, if (is.null(disease_status_concept_id)) "NULL" else if (is(disease_status_concept_id, "subQuery")) paste0("(", as.character(disease_status_concept_id), ")") else paste0("'", as.character(disease_status_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.disease_status_concept_id')
  }

  if (!missing(specimen_source_id)) {
    fields <- c(fields, "specimen_source_id")
    values <- c(values, if (is.null(specimen_source_id)) "NULL" else if (is(specimen_source_id, "subQuery")) paste0("(", as.character(specimen_source_id), ")") else paste0("'", as.character(specimen_source_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_source_id')
  }

  if (!missing(specimen_source_value)) {
    fields <- c(fields, "specimen_source_value")
    values <- c(values, if (is.null(specimen_source_value)) "NULL" else if (is(specimen_source_value, "subQuery")) paste0("(", as.character(specimen_source_value), ")") else paste0("'", as.character(specimen_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_source_value')
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) "NULL" else if (is(unit_source_value, "subQuery")) paste0("(", as.character(unit_source_value), ")") else paste0("'", as.character(unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.unit_source_value')
  }

  if (!missing(anatomic_site_source_value)) {
    fields <- c(fields, "anatomic_site_source_value")
    values <- c(values, if (is.null(anatomic_site_source_value)) "NULL" else if (is(anatomic_site_source_value, "subQuery")) paste0("(", as.character(anatomic_site_source_value), ")") else paste0("'", as.character(anatomic_site_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.anatomic_site_source_value')
  }

  if (!missing(disease_status_source_value)) {
    fields <- c(fields, "disease_status_source_value")
    values <- c(values, if (is.null(disease_status_source_value)) "NULL" else if (is(disease_status_source_value, "subQuery")) paste0("(", as.character(disease_status_source_value), ")") else paste0("'", as.character(disease_status_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.disease_status_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "specimen", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_note <- function(note_id, person_id, note_event_id, note_event_field_concept_id, note_date, note_datetime, note_type_concept_id, note_class_concept_id, note_title, note_text, encoding_concept_id, language_concept_id, provider_id, visit_occurrence_id, visit_detail_id, note_source_value) {
  fields <- c()
  values <- c()
  if (!missing(note_id)) {
    fields <- c(fields, "note_id")
    values <- c(values, if (is.null(note_id)) "NULL" else if (is(note_id, "subQuery")) paste0("(", as.character(note_id), ")") else paste0("'", as.character(note_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.person_id')
  }

  if (!missing(note_event_id)) {
    fields <- c(fields, "note_event_id")
    values <- c(values, if (is.null(note_event_id)) "NULL" else if (is(note_event_id, "subQuery")) paste0("(", as.character(note_event_id), ")") else paste0("'", as.character(note_event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_event_id')
  }

  if (!missing(note_event_field_concept_id)) {
    fields <- c(fields, "note_event_field_concept_id")
    values <- c(values, if (is.null(note_event_field_concept_id)) "NULL" else if (is(note_event_field_concept_id, "subQuery")) paste0("(", as.character(note_event_field_concept_id), ")") else paste0("'", as.character(note_event_field_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_event_field_concept_id')
  }

  if (!missing(note_date)) {
    fields <- c(fields, "note_date")
    values <- c(values, if (is.null(note_date)) "NULL" else if (is(note_date, "subQuery")) paste0("(", as.character(note_date), ")") else paste0("'", as.character(note_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_date')
  }

  if (!missing(note_datetime)) {
    fields <- c(fields, "note_datetime")
    values <- c(values, if (is.null(note_datetime)) "NULL" else if (is(note_datetime, "subQuery")) paste0("(", as.character(note_datetime), ")") else paste0("'", as.character(note_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_datetime')
  }

  if (!missing(note_type_concept_id)) {
    fields <- c(fields, "note_type_concept_id")
    values <- c(values, if (is.null(note_type_concept_id)) "NULL" else if (is(note_type_concept_id, "subQuery")) paste0("(", as.character(note_type_concept_id), ")") else paste0("'", as.character(note_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_type_concept_id')
  }

  if (!missing(note_class_concept_id)) {
    fields <- c(fields, "note_class_concept_id")
    values <- c(values, if (is.null(note_class_concept_id)) "NULL" else if (is(note_class_concept_id, "subQuery")) paste0("(", as.character(note_class_concept_id), ")") else paste0("'", as.character(note_class_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_class_concept_id')
  }

  if (!missing(note_title)) {
    fields <- c(fields, "note_title")
    values <- c(values, if (is.null(note_title)) "NULL" else if (is(note_title, "subQuery")) paste0("(", as.character(note_title), ")") else paste0("'", as.character(note_title), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_title')
  }

  if (!missing(note_text)) {
    fields <- c(fields, "note_text")
    values <- c(values, if (is.null(note_text)) "NULL" else if (is(note_text, "subQuery")) paste0("(", as.character(note_text), ")") else paste0("'", as.character(note_text), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_text')
  }

  if (!missing(encoding_concept_id)) {
    fields <- c(fields, "encoding_concept_id")
    values <- c(values, if (is.null(encoding_concept_id)) "NULL" else if (is(encoding_concept_id, "subQuery")) paste0("(", as.character(encoding_concept_id), ")") else paste0("'", as.character(encoding_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.encoding_concept_id')
  }

  if (!missing(language_concept_id)) {
    fields <- c(fields, "language_concept_id")
    values <- c(values, if (is.null(language_concept_id)) "NULL" else if (is(language_concept_id, "subQuery")) paste0("(", as.character(language_concept_id), ")") else paste0("'", as.character(language_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.language_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.visit_detail_id')
  }

  if (!missing(note_source_value)) {
    fields <- c(fields, "note_source_value")
    values <- c(values, if (is.null(note_source_value)) "NULL" else if (is(note_source_value, "subQuery")) paste0("(", as.character(note_source_value), ")") else paste0("'", as.character(note_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "note", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_note_nlp <- function(note_nlp_id, note_id, section_concept_id, snippet, offset, lexical_variant, note_nlp_concept_id, note_nlp_source_concept_id, nlp_system, nlp_date, nlp_datetime, term_exists, term_temporal, term_modifiers) {
  fields <- c()
  values <- c()
  if (!missing(note_nlp_id)) {
    fields <- c(fields, "note_nlp_id")
    values <- c(values, if (is.null(note_nlp_id)) "NULL" else if (is(note_nlp_id, "subQuery")) paste0("(", as.character(note_nlp_id), ")") else paste0("'", as.character(note_nlp_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_nlp_id')
  }

  if (!missing(note_id)) {
    fields <- c(fields, "note_id")
    values <- c(values, if (is.null(note_id)) "NULL" else if (is(note_id, "subQuery")) paste0("(", as.character(note_id), ")") else paste0("'", as.character(note_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_id')
  }

  if (!missing(section_concept_id)) {
    fields <- c(fields, "section_concept_id")
    values <- c(values, if (is.null(section_concept_id)) "NULL" else if (is(section_concept_id, "subQuery")) paste0("(", as.character(section_concept_id), ")") else paste0("'", as.character(section_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.section_concept_id')
  }

  if (!missing(snippet)) {
    fields <- c(fields, "snippet")
    values <- c(values, if (is.null(snippet)) "NULL" else if (is(snippet, "subQuery")) paste0("(", as.character(snippet), ")") else paste0("'", as.character(snippet), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.snippet')
  }

  if (!missing(offset)) {
    fields <- c(fields, "offset")
    values <- c(values, if (is.null(offset)) "NULL" else if (is(offset, "subQuery")) paste0("(", as.character(offset), ")") else paste0("'", as.character(offset), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.offset')
  }

  if (!missing(lexical_variant)) {
    fields <- c(fields, "lexical_variant")
    values <- c(values, if (is.null(lexical_variant)) "NULL" else if (is(lexical_variant, "subQuery")) paste0("(", as.character(lexical_variant), ")") else paste0("'", as.character(lexical_variant), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.lexical_variant')
  }

  if (!missing(note_nlp_concept_id)) {
    fields <- c(fields, "note_nlp_concept_id")
    values <- c(values, if (is.null(note_nlp_concept_id)) "NULL" else if (is(note_nlp_concept_id, "subQuery")) paste0("(", as.character(note_nlp_concept_id), ")") else paste0("'", as.character(note_nlp_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_nlp_concept_id')
  }

  if (!missing(note_nlp_source_concept_id)) {
    fields <- c(fields, "note_nlp_source_concept_id")
    values <- c(values, if (is.null(note_nlp_source_concept_id)) "NULL" else if (is(note_nlp_source_concept_id, "subQuery")) paste0("(", as.character(note_nlp_source_concept_id), ")") else paste0("'", as.character(note_nlp_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_nlp_source_concept_id')
  }

  if (!missing(nlp_system)) {
    fields <- c(fields, "nlp_system")
    values <- c(values, if (is.null(nlp_system)) "NULL" else if (is(nlp_system, "subQuery")) paste0("(", as.character(nlp_system), ")") else paste0("'", as.character(nlp_system), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.nlp_system')
  }

  if (!missing(nlp_date)) {
    fields <- c(fields, "nlp_date")
    values <- c(values, if (is.null(nlp_date)) "NULL" else if (is(nlp_date, "subQuery")) paste0("(", as.character(nlp_date), ")") else paste0("'", as.character(nlp_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.nlp_date')
  }

  if (!missing(nlp_datetime)) {
    fields <- c(fields, "nlp_datetime")
    values <- c(values, if (is.null(nlp_datetime)) "NULL" else if (is(nlp_datetime, "subQuery")) paste0("(", as.character(nlp_datetime), ")") else paste0("'", as.character(nlp_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.nlp_datetime')
  }

  if (!missing(term_exists)) {
    fields <- c(fields, "term_exists")
    values <- c(values, if (is.null(term_exists)) "NULL" else if (is(term_exists, "subQuery")) paste0("(", as.character(term_exists), ")") else paste0("'", as.character(term_exists), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.term_exists')
  }

  if (!missing(term_temporal)) {
    fields <- c(fields, "term_temporal")
    values <- c(values, if (is.null(term_temporal)) "NULL" else if (is(term_temporal, "subQuery")) paste0("(", as.character(term_temporal), ")") else paste0("'", as.character(term_temporal), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.term_temporal')
  }

  if (!missing(term_modifiers)) {
    fields <- c(fields, "term_modifiers")
    values <- c(values, if (is.null(term_modifiers)) "NULL" else if (is(term_modifiers, "subQuery")) paste0("(", as.character(term_modifiers), ")") else paste0("'", as.character(term_modifiers), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.term_modifiers')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "note_nlp", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_survey_conduct <- function(survey_conduct_id, person_id, survey_concept_id, survey_start_date, survey_start_datetime, survey_end_date, survey_end_datetime, provider_id, assisted_concept_id, respondent_type_concept_id, timing_concept_id, collection_method_concept_id, assisted_source_value, respondent_type_source_value, timing_source_value, collection_method_source_value, survey_source_value, survey_source_concept_id, survey_source_identifier, validated_survey_concept_id, validated_survey_source_value, survey_version_number, visit_occurrence_id, response_visit_occurrence_id) {
  fields <- c()
  values <- c()
  if (!missing(survey_conduct_id)) {
    fields <- c(fields, "survey_conduct_id")
    values <- c(values, if (is.null(survey_conduct_id)) "NULL" else if (is(survey_conduct_id, "subQuery")) paste0("(", as.character(survey_conduct_id), ")") else paste0("'", as.character(survey_conduct_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.survey_conduct_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.person_id')
  }

  if (!missing(survey_concept_id)) {
    fields <- c(fields, "survey_concept_id")
    values <- c(values, if (is.null(survey_concept_id)) "NULL" else if (is(survey_concept_id, "subQuery")) paste0("(", as.character(survey_concept_id), ")") else paste0("'", as.character(survey_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.survey_concept_id')
  }

  if (!missing(survey_start_date)) {
    fields <- c(fields, "survey_start_date")
    values <- c(values, if (is.null(survey_start_date)) "NULL" else if (is(survey_start_date, "subQuery")) paste0("(", as.character(survey_start_date), ")") else paste0("'", as.character(survey_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.survey_start_date')
  }

  if (!missing(survey_start_datetime)) {
    fields <- c(fields, "survey_start_datetime")
    values <- c(values, if (is.null(survey_start_datetime)) "NULL" else if (is(survey_start_datetime, "subQuery")) paste0("(", as.character(survey_start_datetime), ")") else paste0("'", as.character(survey_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.survey_start_datetime')
  }

  if (!missing(survey_end_date)) {
    fields <- c(fields, "survey_end_date")
    values <- c(values, if (is.null(survey_end_date)) "NULL" else if (is(survey_end_date, "subQuery")) paste0("(", as.character(survey_end_date), ")") else paste0("'", as.character(survey_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.survey_end_date')
  }

  if (!missing(survey_end_datetime)) {
    fields <- c(fields, "survey_end_datetime")
    values <- c(values, if (is.null(survey_end_datetime)) "NULL" else if (is(survey_end_datetime, "subQuery")) paste0("(", as.character(survey_end_datetime), ")") else paste0("'", as.character(survey_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.survey_end_datetime')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.provider_id')
  }

  if (!missing(assisted_concept_id)) {
    fields <- c(fields, "assisted_concept_id")
    values <- c(values, if (is.null(assisted_concept_id)) "NULL" else if (is(assisted_concept_id, "subQuery")) paste0("(", as.character(assisted_concept_id), ")") else paste0("'", as.character(assisted_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.assisted_concept_id')
  }

  if (!missing(respondent_type_concept_id)) {
    fields <- c(fields, "respondent_type_concept_id")
    values <- c(values, if (is.null(respondent_type_concept_id)) "NULL" else if (is(respondent_type_concept_id, "subQuery")) paste0("(", as.character(respondent_type_concept_id), ")") else paste0("'", as.character(respondent_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.respondent_type_concept_id')
  }

  if (!missing(timing_concept_id)) {
    fields <- c(fields, "timing_concept_id")
    values <- c(values, if (is.null(timing_concept_id)) "NULL" else if (is(timing_concept_id, "subQuery")) paste0("(", as.character(timing_concept_id), ")") else paste0("'", as.character(timing_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.timing_concept_id')
  }

  if (!missing(collection_method_concept_id)) {
    fields <- c(fields, "collection_method_concept_id")
    values <- c(values, if (is.null(collection_method_concept_id)) "NULL" else if (is(collection_method_concept_id, "subQuery")) paste0("(", as.character(collection_method_concept_id), ")") else paste0("'", as.character(collection_method_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.collection_method_concept_id')
  }

  if (!missing(assisted_source_value)) {
    fields <- c(fields, "assisted_source_value")
    values <- c(values, if (is.null(assisted_source_value)) "NULL" else if (is(assisted_source_value, "subQuery")) paste0("(", as.character(assisted_source_value), ")") else paste0("'", as.character(assisted_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.assisted_source_value')
  }

  if (!missing(respondent_type_source_value)) {
    fields <- c(fields, "respondent_type_source_value")
    values <- c(values, if (is.null(respondent_type_source_value)) "NULL" else if (is(respondent_type_source_value, "subQuery")) paste0("(", as.character(respondent_type_source_value), ")") else paste0("'", as.character(respondent_type_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.respondent_type_source_value')
  }

  if (!missing(timing_source_value)) {
    fields <- c(fields, "timing_source_value")
    values <- c(values, if (is.null(timing_source_value)) "NULL" else if (is(timing_source_value, "subQuery")) paste0("(", as.character(timing_source_value), ")") else paste0("'", as.character(timing_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.timing_source_value')
  }

  if (!missing(collection_method_source_value)) {
    fields <- c(fields, "collection_method_source_value")
    values <- c(values, if (is.null(collection_method_source_value)) "NULL" else if (is(collection_method_source_value, "subQuery")) paste0("(", as.character(collection_method_source_value), ")") else paste0("'", as.character(collection_method_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.collection_method_source_value')
  }

  if (!missing(survey_source_value)) {
    fields <- c(fields, "survey_source_value")
    values <- c(values, if (is.null(survey_source_value)) "NULL" else if (is(survey_source_value, "subQuery")) paste0("(", as.character(survey_source_value), ")") else paste0("'", as.character(survey_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.survey_source_value')
  }

  if (!missing(survey_source_concept_id)) {
    fields <- c(fields, "survey_source_concept_id")
    values <- c(values, if (is.null(survey_source_concept_id)) "NULL" else if (is(survey_source_concept_id, "subQuery")) paste0("(", as.character(survey_source_concept_id), ")") else paste0("'", as.character(survey_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.survey_source_concept_id')
  }

  if (!missing(survey_source_identifier)) {
    fields <- c(fields, "survey_source_identifier")
    values <- c(values, if (is.null(survey_source_identifier)) "NULL" else if (is(survey_source_identifier, "subQuery")) paste0("(", as.character(survey_source_identifier), ")") else paste0("'", as.character(survey_source_identifier), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.survey_source_identifier')
  }

  if (!missing(validated_survey_concept_id)) {
    fields <- c(fields, "validated_survey_concept_id")
    values <- c(values, if (is.null(validated_survey_concept_id)) "NULL" else if (is(validated_survey_concept_id, "subQuery")) paste0("(", as.character(validated_survey_concept_id), ")") else paste0("'", as.character(validated_survey_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.validated_survey_concept_id')
  }

  if (!missing(validated_survey_source_value)) {
    fields <- c(fields, "validated_survey_source_value")
    values <- c(values, if (is.null(validated_survey_source_value)) "NULL" else if (is(validated_survey_source_value, "subQuery")) paste0("(", as.character(validated_survey_source_value), ")") else paste0("'", as.character(validated_survey_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.validated_survey_source_value')
  }

  if (!missing(survey_version_number)) {
    fields <- c(fields, "survey_version_number")
    values <- c(values, if (is.null(survey_version_number)) "NULL" else if (is(survey_version_number, "subQuery")) paste0("(", as.character(survey_version_number), ")") else paste0("'", as.character(survey_version_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.survey_version_number')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.visit_occurrence_id')
  }

  if (!missing(response_visit_occurrence_id)) {
    fields <- c(fields, "response_visit_occurrence_id")
    values <- c(values, if (is.null(response_visit_occurrence_id)) "NULL" else if (is(response_visit_occurrence_id, "subQuery")) paste0("(", as.character(response_visit_occurrence_id), ")") else paste0("'", as.character(response_visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.response_visit_occurrence_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "survey_conduct", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_cost <- function(cost_id, person_id, cost_event_id, cost_event_field_concept_id, cost_concept_id, cost_type_concept_id, cost_source_concept_id, cost_source_value, currency_concept_id, cost, incurred_date, billed_date, paid_date, revenue_code_concept_id, drg_concept_id, revenue_code_source_value, drg_source_value, payer_plan_period_id) {
  fields <- c()
  values <- c()
  if (!missing(cost_id)) {
    fields <- c(fields, "cost_id")
    values <- c(values, if (is.null(cost_id)) "NULL" else if (is(cost_id, "subQuery")) paste0("(", as.character(cost_id), ")") else paste0("'", as.character(cost_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.person_id')
  }

  if (!missing(cost_event_id)) {
    fields <- c(fields, "cost_event_id")
    values <- c(values, if (is.null(cost_event_id)) "NULL" else if (is(cost_event_id, "subQuery")) paste0("(", as.character(cost_event_id), ")") else paste0("'", as.character(cost_event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_event_id')
  }

  if (!missing(cost_event_field_concept_id)) {
    fields <- c(fields, "cost_event_field_concept_id")
    values <- c(values, if (is.null(cost_event_field_concept_id)) "NULL" else if (is(cost_event_field_concept_id, "subQuery")) paste0("(", as.character(cost_event_field_concept_id), ")") else paste0("'", as.character(cost_event_field_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_event_field_concept_id')
  }

  if (!missing(cost_concept_id)) {
    fields <- c(fields, "cost_concept_id")
    values <- c(values, if (is.null(cost_concept_id)) "NULL" else if (is(cost_concept_id, "subQuery")) paste0("(", as.character(cost_concept_id), ")") else paste0("'", as.character(cost_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_concept_id')
  }

  if (!missing(cost_type_concept_id)) {
    fields <- c(fields, "cost_type_concept_id")
    values <- c(values, if (is.null(cost_type_concept_id)) "NULL" else if (is(cost_type_concept_id, "subQuery")) paste0("(", as.character(cost_type_concept_id), ")") else paste0("'", as.character(cost_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_type_concept_id')
  }

  if (!missing(cost_source_concept_id)) {
    fields <- c(fields, "cost_source_concept_id")
    values <- c(values, if (is.null(cost_source_concept_id)) "NULL" else if (is(cost_source_concept_id, "subQuery")) paste0("(", as.character(cost_source_concept_id), ")") else paste0("'", as.character(cost_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_source_concept_id')
  }

  if (!missing(cost_source_value)) {
    fields <- c(fields, "cost_source_value")
    values <- c(values, if (is.null(cost_source_value)) "NULL" else if (is(cost_source_value, "subQuery")) paste0("(", as.character(cost_source_value), ")") else paste0("'", as.character(cost_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_source_value')
  }

  if (!missing(currency_concept_id)) {
    fields <- c(fields, "currency_concept_id")
    values <- c(values, if (is.null(currency_concept_id)) "NULL" else if (is(currency_concept_id, "subQuery")) paste0("(", as.character(currency_concept_id), ")") else paste0("'", as.character(currency_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.currency_concept_id')
  }

  if (!missing(cost)) {
    fields <- c(fields, "cost")
    values <- c(values, if (is.null(cost)) "NULL" else if (is(cost, "subQuery")) paste0("(", as.character(cost), ")") else paste0("'", as.character(cost), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost')
  }

  if (!missing(incurred_date)) {
    fields <- c(fields, "incurred_date")
    values <- c(values, if (is.null(incurred_date)) "NULL" else if (is(incurred_date, "subQuery")) paste0("(", as.character(incurred_date), ")") else paste0("'", as.character(incurred_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.incurred_date')
  }

  if (!missing(billed_date)) {
    fields <- c(fields, "billed_date")
    values <- c(values, if (is.null(billed_date)) "NULL" else if (is(billed_date, "subQuery")) paste0("(", as.character(billed_date), ")") else paste0("'", as.character(billed_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.billed_date')
  }

  if (!missing(paid_date)) {
    fields <- c(fields, "paid_date")
    values <- c(values, if (is.null(paid_date)) "NULL" else if (is(paid_date, "subQuery")) paste0("(", as.character(paid_date), ")") else paste0("'", as.character(paid_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_date')
  }

  if (!missing(revenue_code_concept_id)) {
    fields <- c(fields, "revenue_code_concept_id")
    values <- c(values, if (is.null(revenue_code_concept_id)) "NULL" else if (is(revenue_code_concept_id, "subQuery")) paste0("(", as.character(revenue_code_concept_id), ")") else paste0("'", as.character(revenue_code_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.revenue_code_concept_id')
  }

  if (!missing(drg_concept_id)) {
    fields <- c(fields, "drg_concept_id")
    values <- c(values, if (is.null(drg_concept_id)) "NULL" else if (is(drg_concept_id, "subQuery")) paste0("(", as.character(drg_concept_id), ")") else paste0("'", as.character(drg_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.drg_concept_id')
  }

  if (!missing(revenue_code_source_value)) {
    fields <- c(fields, "revenue_code_source_value")
    values <- c(values, if (is.null(revenue_code_source_value)) "NULL" else if (is(revenue_code_source_value, "subQuery")) paste0("(", as.character(revenue_code_source_value), ")") else paste0("'", as.character(revenue_code_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.revenue_code_source_value')
  }

  if (!missing(drg_source_value)) {
    fields <- c(fields, "drg_source_value")
    values <- c(values, if (is.null(drg_source_value)) "NULL" else if (is(drg_source_value, "subQuery")) paste0("(", as.character(drg_source_value), ")") else paste0("'", as.character(drg_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.drg_source_value')
  }

  if (!missing(payer_plan_period_id)) {
    fields <- c(fields, "payer_plan_period_id")
    values <- c(values, if (is.null(payer_plan_period_id)) "NULL" else if (is(payer_plan_period_id, "subQuery")) paste0("(", as.character(payer_plan_period_id), ")") else paste0("'", as.character(payer_plan_period_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.payer_plan_period_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "cost", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_payer_plan_period <- function(payer_plan_period_id, person_id, contract_person_id, payer_plan_period_start_date, payer_plan_period_end_date, payer_concept_id, payer_source_value, payer_source_concept_id, plan_concept_id, plan_source_value, plan_source_concept_id, contract_concept_id, contract_source_value, contract_source_concept_id, sponsor_concept_id, sponsor_source_value, sponsor_source_concept_id, family_source_value, stop_reason_concept_id, stop_reason_source_value, stop_reason_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(payer_plan_period_id)) {
    fields <- c(fields, "payer_plan_period_id")
    values <- c(values, if (is.null(payer_plan_period_id)) "NULL" else if (is(payer_plan_period_id, "subQuery")) paste0("(", as.character(payer_plan_period_id), ")") else paste0("'", as.character(payer_plan_period_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_plan_period_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.person_id')
  }

  if (!missing(contract_person_id)) {
    fields <- c(fields, "contract_person_id")
    values <- c(values, if (is.null(contract_person_id)) "NULL" else if (is(contract_person_id, "subQuery")) paste0("(", as.character(contract_person_id), ")") else paste0("'", as.character(contract_person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.contract_person_id')
  }

  if (!missing(payer_plan_period_start_date)) {
    fields <- c(fields, "payer_plan_period_start_date")
    values <- c(values, if (is.null(payer_plan_period_start_date)) "NULL" else if (is(payer_plan_period_start_date, "subQuery")) paste0("(", as.character(payer_plan_period_start_date), ")") else paste0("'", as.character(payer_plan_period_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_plan_period_start_date')
  }

  if (!missing(payer_plan_period_end_date)) {
    fields <- c(fields, "payer_plan_period_end_date")
    values <- c(values, if (is.null(payer_plan_period_end_date)) "NULL" else if (is(payer_plan_period_end_date, "subQuery")) paste0("(", as.character(payer_plan_period_end_date), ")") else paste0("'", as.character(payer_plan_period_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_plan_period_end_date')
  }

  if (!missing(payer_concept_id)) {
    fields <- c(fields, "payer_concept_id")
    values <- c(values, if (is.null(payer_concept_id)) "NULL" else if (is(payer_concept_id, "subQuery")) paste0("(", as.character(payer_concept_id), ")") else paste0("'", as.character(payer_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_concept_id')
  }

  if (!missing(payer_source_value)) {
    fields <- c(fields, "payer_source_value")
    values <- c(values, if (is.null(payer_source_value)) "NULL" else if (is(payer_source_value, "subQuery")) paste0("(", as.character(payer_source_value), ")") else paste0("'", as.character(payer_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_source_value')
  }

  if (!missing(payer_source_concept_id)) {
    fields <- c(fields, "payer_source_concept_id")
    values <- c(values, if (is.null(payer_source_concept_id)) "NULL" else if (is(payer_source_concept_id, "subQuery")) paste0("(", as.character(payer_source_concept_id), ")") else paste0("'", as.character(payer_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_source_concept_id')
  }

  if (!missing(plan_concept_id)) {
    fields <- c(fields, "plan_concept_id")
    values <- c(values, if (is.null(plan_concept_id)) "NULL" else if (is(plan_concept_id, "subQuery")) paste0("(", as.character(plan_concept_id), ")") else paste0("'", as.character(plan_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.plan_concept_id')
  }

  if (!missing(plan_source_value)) {
    fields <- c(fields, "plan_source_value")
    values <- c(values, if (is.null(plan_source_value)) "NULL" else if (is(plan_source_value, "subQuery")) paste0("(", as.character(plan_source_value), ")") else paste0("'", as.character(plan_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.plan_source_value')
  }

  if (!missing(plan_source_concept_id)) {
    fields <- c(fields, "plan_source_concept_id")
    values <- c(values, if (is.null(plan_source_concept_id)) "NULL" else if (is(plan_source_concept_id, "subQuery")) paste0("(", as.character(plan_source_concept_id), ")") else paste0("'", as.character(plan_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.plan_source_concept_id')
  }

  if (!missing(contract_concept_id)) {
    fields <- c(fields, "contract_concept_id")
    values <- c(values, if (is.null(contract_concept_id)) "NULL" else if (is(contract_concept_id, "subQuery")) paste0("(", as.character(contract_concept_id), ")") else paste0("'", as.character(contract_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.contract_concept_id')
  }

  if (!missing(contract_source_value)) {
    fields <- c(fields, "contract_source_value")
    values <- c(values, if (is.null(contract_source_value)) "NULL" else if (is(contract_source_value, "subQuery")) paste0("(", as.character(contract_source_value), ")") else paste0("'", as.character(contract_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.contract_source_value')
  }

  if (!missing(contract_source_concept_id)) {
    fields <- c(fields, "contract_source_concept_id")
    values <- c(values, if (is.null(contract_source_concept_id)) "NULL" else if (is(contract_source_concept_id, "subQuery")) paste0("(", as.character(contract_source_concept_id), ")") else paste0("'", as.character(contract_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.contract_source_concept_id')
  }

  if (!missing(sponsor_concept_id)) {
    fields <- c(fields, "sponsor_concept_id")
    values <- c(values, if (is.null(sponsor_concept_id)) "NULL" else if (is(sponsor_concept_id, "subQuery")) paste0("(", as.character(sponsor_concept_id), ")") else paste0("'", as.character(sponsor_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.sponsor_concept_id')
  }

  if (!missing(sponsor_source_value)) {
    fields <- c(fields, "sponsor_source_value")
    values <- c(values, if (is.null(sponsor_source_value)) "NULL" else if (is(sponsor_source_value, "subQuery")) paste0("(", as.character(sponsor_source_value), ")") else paste0("'", as.character(sponsor_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.sponsor_source_value')
  }

  if (!missing(sponsor_source_concept_id)) {
    fields <- c(fields, "sponsor_source_concept_id")
    values <- c(values, if (is.null(sponsor_source_concept_id)) "NULL" else if (is(sponsor_source_concept_id, "subQuery")) paste0("(", as.character(sponsor_source_concept_id), ")") else paste0("'", as.character(sponsor_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.sponsor_source_concept_id')
  }

  if (!missing(family_source_value)) {
    fields <- c(fields, "family_source_value")
    values <- c(values, if (is.null(family_source_value)) "NULL" else if (is(family_source_value, "subQuery")) paste0("(", as.character(family_source_value), ")") else paste0("'", as.character(family_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.family_source_value')
  }

  if (!missing(stop_reason_concept_id)) {
    fields <- c(fields, "stop_reason_concept_id")
    values <- c(values, if (is.null(stop_reason_concept_id)) "NULL" else if (is(stop_reason_concept_id, "subQuery")) paste0("(", as.character(stop_reason_concept_id), ")") else paste0("'", as.character(stop_reason_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.stop_reason_concept_id')
  }

  if (!missing(stop_reason_source_value)) {
    fields <- c(fields, "stop_reason_source_value")
    values <- c(values, if (is.null(stop_reason_source_value)) "NULL" else if (is(stop_reason_source_value, "subQuery")) paste0("(", as.character(stop_reason_source_value), ")") else paste0("'", as.character(stop_reason_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.stop_reason_source_value')
  }

  if (!missing(stop_reason_source_concept_id)) {
    fields <- c(fields, "stop_reason_source_concept_id")
    values <- c(values, if (is.null(stop_reason_source_concept_id)) "NULL" else if (is(stop_reason_source_concept_id, "subQuery")) paste0("(", as.character(stop_reason_source_concept_id), ")") else paste0("'", as.character(stop_reason_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.stop_reason_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "payer_plan_period", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_drug_era <- function(drug_era_id, person_id, drug_concept_id, drug_era_start_datetime, drug_era_end_datetime, drug_exposure_count, gap_days) {
  fields <- c()
  values <- c()
  if (!missing(drug_era_id)) {
    fields <- c(fields, "drug_era_id")
    values <- c(values, if (is.null(drug_era_id)) "NULL" else if (is(drug_era_id, "subQuery")) paste0("(", as.character(drug_era_id), ")") else paste0("'", as.character(drug_era_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_era_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.person_id')
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) "NULL" else if (is(drug_concept_id, "subQuery")) paste0("(", as.character(drug_concept_id), ")") else paste0("'", as.character(drug_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_concept_id')
  }

  if (!missing(drug_era_start_datetime)) {
    fields <- c(fields, "drug_era_start_datetime")
    values <- c(values, if (is.null(drug_era_start_datetime)) "NULL" else if (is(drug_era_start_datetime, "subQuery")) paste0("(", as.character(drug_era_start_datetime), ")") else paste0("'", as.character(drug_era_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_era_start_datetime')
  }

  if (!missing(drug_era_end_datetime)) {
    fields <- c(fields, "drug_era_end_datetime")
    values <- c(values, if (is.null(drug_era_end_datetime)) "NULL" else if (is(drug_era_end_datetime, "subQuery")) paste0("(", as.character(drug_era_end_datetime), ")") else paste0("'", as.character(drug_era_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_era_end_datetime')
  }

  if (!missing(drug_exposure_count)) {
    fields <- c(fields, "drug_exposure_count")
    values <- c(values, if (is.null(drug_exposure_count)) "NULL" else if (is(drug_exposure_count, "subQuery")) paste0("(", as.character(drug_exposure_count), ")") else paste0("'", as.character(drug_exposure_count), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_exposure_count')
  }

  if (!missing(gap_days)) {
    fields <- c(fields, "gap_days")
    values <- c(values, if (is.null(gap_days)) "NULL" else if (is(gap_days, "subQuery")) paste0("(", as.character(gap_days), ")") else paste0("'", as.character(gap_days), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.gap_days')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "drug_era", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_dose_era <- function(dose_era_id, person_id, drug_concept_id, unit_concept_id, dose_value, dose_era_start_datetime, dose_era_end_datetime) {
  fields <- c()
  values <- c()
  if (!missing(dose_era_id)) {
    fields <- c(fields, "dose_era_id")
    values <- c(values, if (is.null(dose_era_id)) "NULL" else if (is(dose_era_id, "subQuery")) paste0("(", as.character(dose_era_id), ")") else paste0("'", as.character(dose_era_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_era_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.person_id')
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) "NULL" else if (is(drug_concept_id, "subQuery")) paste0("(", as.character(drug_concept_id), ")") else paste0("'", as.character(drug_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.drug_concept_id')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) "NULL" else if (is(unit_concept_id, "subQuery")) paste0("(", as.character(unit_concept_id), ")") else paste0("'", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.unit_concept_id')
  }

  if (!missing(dose_value)) {
    fields <- c(fields, "dose_value")
    values <- c(values, if (is.null(dose_value)) "NULL" else if (is(dose_value, "subQuery")) paste0("(", as.character(dose_value), ")") else paste0("'", as.character(dose_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_value')
  }

  if (!missing(dose_era_start_datetime)) {
    fields <- c(fields, "dose_era_start_datetime")
    values <- c(values, if (is.null(dose_era_start_datetime)) "NULL" else if (is(dose_era_start_datetime, "subQuery")) paste0("(", as.character(dose_era_start_datetime), ")") else paste0("'", as.character(dose_era_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_era_start_datetime')
  }

  if (!missing(dose_era_end_datetime)) {
    fields <- c(fields, "dose_era_end_datetime")
    values <- c(values, if (is.null(dose_era_end_datetime)) "NULL" else if (is(dose_era_end_datetime, "subQuery")) paste0("(", as.character(dose_era_end_datetime), ")") else paste0("'", as.character(dose_era_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_era_end_datetime')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "dose_era", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_condition_era <- function(condition_era_id, person_id, condition_concept_id, condition_era_start_datetime, condition_era_end_datetime, condition_occurrence_count) {
  fields <- c()
  values <- c()
  if (!missing(condition_era_id)) {
    fields <- c(fields, "condition_era_id")
    values <- c(values, if (is.null(condition_era_id)) "NULL" else if (is(condition_era_id, "subQuery")) paste0("(", as.character(condition_era_id), ")") else paste0("'", as.character(condition_era_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_era_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.person_id')
  }

  if (!missing(condition_concept_id)) {
    fields <- c(fields, "condition_concept_id")
    values <- c(values, if (is.null(condition_concept_id)) "NULL" else if (is(condition_concept_id, "subQuery")) paste0("(", as.character(condition_concept_id), ")") else paste0("'", as.character(condition_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_concept_id')
  }

  if (!missing(condition_era_start_datetime)) {
    fields <- c(fields, "condition_era_start_datetime")
    values <- c(values, if (is.null(condition_era_start_datetime)) "NULL" else if (is(condition_era_start_datetime, "subQuery")) paste0("(", as.character(condition_era_start_datetime), ")") else paste0("'", as.character(condition_era_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_era_start_datetime')
  }

  if (!missing(condition_era_end_datetime)) {
    fields <- c(fields, "condition_era_end_datetime")
    values <- c(values, if (is.null(condition_era_end_datetime)) "NULL" else if (is(condition_era_end_datetime, "subQuery")) paste0("(", as.character(condition_era_end_datetime), ")") else paste0("'", as.character(condition_era_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_era_end_datetime')
  }

  if (!missing(condition_occurrence_count)) {
    fields <- c(fields, "condition_occurrence_count")
    values <- c(values, if (is.null(condition_occurrence_count)) "NULL" else if (is(condition_occurrence_count, "subQuery")) paste0("(", as.character(condition_occurrence_count), ")") else paste0("'", as.character(condition_occurrence_count), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_occurrence_count')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "condition_era", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_location <- function(location_id, address_1, address_2, city, state, zip, county, country, location_source_value, latitude, longitude) {
  fields <- c()
  values <- c()
  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) "NULL" else if (is(location_id, "subQuery")) paste0("(", as.character(location_id), ")") else paste0("'", as.character(location_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.location_id')
  }

  if (!missing(address_1)) {
    fields <- c(fields, "address_1")
    values <- c(values, if (is.null(address_1)) "NULL" else if (is(address_1, "subQuery")) paste0("(", as.character(address_1), ")") else paste0("'", as.character(address_1), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.address_1')
  }

  if (!missing(address_2)) {
    fields <- c(fields, "address_2")
    values <- c(values, if (is.null(address_2)) "NULL" else if (is(address_2, "subQuery")) paste0("(", as.character(address_2), ")") else paste0("'", as.character(address_2), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.address_2')
  }

  if (!missing(city)) {
    fields <- c(fields, "city")
    values <- c(values, if (is.null(city)) "NULL" else if (is(city, "subQuery")) paste0("(", as.character(city), ")") else paste0("'", as.character(city), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.city')
  }

  if (!missing(state)) {
    fields <- c(fields, "state")
    values <- c(values, if (is.null(state)) "NULL" else if (is(state, "subQuery")) paste0("(", as.character(state), ")") else paste0("'", as.character(state), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.state')
  }

  if (!missing(zip)) {
    fields <- c(fields, "zip")
    values <- c(values, if (is.null(zip)) "NULL" else if (is(zip, "subQuery")) paste0("(", as.character(zip), ")") else paste0("'", as.character(zip), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.zip')
  }

  if (!missing(county)) {
    fields <- c(fields, "county")
    values <- c(values, if (is.null(county)) "NULL" else if (is(county, "subQuery")) paste0("(", as.character(county), ")") else paste0("'", as.character(county), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.county')
  }

  if (!missing(country)) {
    fields <- c(fields, "country")
    values <- c(values, if (is.null(country)) "NULL" else if (is(country, "subQuery")) paste0("(", as.character(country), ")") else paste0("'", as.character(country), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.country')
  }

  if (!missing(location_source_value)) {
    fields <- c(fields, "location_source_value")
    values <- c(values, if (is.null(location_source_value)) "NULL" else if (is(location_source_value, "subQuery")) paste0("(", as.character(location_source_value), ")") else paste0("'", as.character(location_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.location_source_value')
  }

  if (!missing(latitude)) {
    fields <- c(fields, "latitude")
    values <- c(values, if (is.null(latitude)) "NULL" else if (is(latitude, "subQuery")) paste0("(", as.character(latitude), ")") else paste0("'", as.character(latitude), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.latitude')
  }

  if (!missing(longitude)) {
    fields <- c(fields, "longitude")
    values <- c(values, if (is.null(longitude)) "NULL" else if (is(longitude, "subQuery")) paste0("(", as.character(longitude), ")") else paste0("'", as.character(longitude), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.longitude')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "location", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_location_history <- function(location_id, relationship_type_concept_id, domain_id, entity_id, start_date, end_date) {
  fields <- c()
  values <- c()
  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) "NULL" else if (is(location_id, "subQuery")) paste0("(", as.character(location_id), ")") else paste0("'", as.character(location_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location_history.location_id')
  }

  if (!missing(relationship_type_concept_id)) {
    fields <- c(fields, "relationship_type_concept_id")
    values <- c(values, if (is.null(relationship_type_concept_id)) "NULL" else if (is(relationship_type_concept_id, "subQuery")) paste0("(", as.character(relationship_type_concept_id), ")") else paste0("'", as.character(relationship_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location_history.relationship_type_concept_id')
  }

  if (!missing(domain_id)) {
    fields <- c(fields, "domain_id")
    values <- c(values, if (is.null(domain_id)) "NULL" else if (is(domain_id, "subQuery")) paste0("(", as.character(domain_id), ")") else paste0("'", as.character(domain_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location_history.domain_id')
  }

  if (!missing(entity_id)) {
    fields <- c(fields, "entity_id")
    values <- c(values, if (is.null(entity_id)) "NULL" else if (is(entity_id, "subQuery")) paste0("(", as.character(entity_id), ")") else paste0("'", as.character(entity_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location_history.entity_id')
  }

  if (!missing(start_date)) {
    fields <- c(fields, "start_date")
    values <- c(values, if (is.null(start_date)) "NULL" else if (is(start_date, "subQuery")) paste0("(", as.character(start_date), ")") else paste0("'", as.character(start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location_history.start_date')
  }

  if (!missing(end_date)) {
    fields <- c(fields, "end_date")
    values <- c(values, if (is.null(end_date)) "NULL" else if (is(end_date, "subQuery")) paste0("(", as.character(end_date), ")") else paste0("'", as.character(end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location_history.end_date')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "location_history", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_provider <- function(provider_id, provider_name, npi, dea, specialty_concept_id, care_site_id, year_of_birth, gender_concept_id, provider_source_value, specialty_source_value, specialty_source_concept_id, gender_source_value, gender_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.provider_id')
  }

  if (!missing(provider_name)) {
    fields <- c(fields, "provider_name")
    values <- c(values, if (is.null(provider_name)) "NULL" else if (is(provider_name, "subQuery")) paste0("(", as.character(provider_name), ")") else paste0("'", as.character(provider_name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.provider_name')
  }

  if (!missing(npi)) {
    fields <- c(fields, "npi")
    values <- c(values, if (is.null(npi)) "NULL" else if (is(npi, "subQuery")) paste0("(", as.character(npi), ")") else paste0("'", as.character(npi), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.npi')
  }

  if (!missing(dea)) {
    fields <- c(fields, "dea")
    values <- c(values, if (is.null(dea)) "NULL" else if (is(dea, "subQuery")) paste0("(", as.character(dea), ")") else paste0("'", as.character(dea), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.dea')
  }

  if (!missing(specialty_concept_id)) {
    fields <- c(fields, "specialty_concept_id")
    values <- c(values, if (is.null(specialty_concept_id)) "NULL" else if (is(specialty_concept_id, "subQuery")) paste0("(", as.character(specialty_concept_id), ")") else paste0("'", as.character(specialty_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.specialty_concept_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) "NULL" else if (is(care_site_id, "subQuery")) paste0("(", as.character(care_site_id), ")") else paste0("'", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.care_site_id')
  }

  if (!missing(year_of_birth)) {
    fields <- c(fields, "year_of_birth")
    values <- c(values, if (is.null(year_of_birth)) "NULL" else if (is(year_of_birth, "subQuery")) paste0("(", as.character(year_of_birth), ")") else paste0("'", as.character(year_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.year_of_birth')
  }

  if (!missing(gender_concept_id)) {
    fields <- c(fields, "gender_concept_id")
    values <- c(values, if (is.null(gender_concept_id)) "NULL" else if (is(gender_concept_id, "subQuery")) paste0("(", as.character(gender_concept_id), ")") else paste0("'", as.character(gender_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.gender_concept_id')
  }

  if (!missing(provider_source_value)) {
    fields <- c(fields, "provider_source_value")
    values <- c(values, if (is.null(provider_source_value)) "NULL" else if (is(provider_source_value, "subQuery")) paste0("(", as.character(provider_source_value), ")") else paste0("'", as.character(provider_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.provider_source_value')
  }

  if (!missing(specialty_source_value)) {
    fields <- c(fields, "specialty_source_value")
    values <- c(values, if (is.null(specialty_source_value)) "NULL" else if (is(specialty_source_value, "subQuery")) paste0("(", as.character(specialty_source_value), ")") else paste0("'", as.character(specialty_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.specialty_source_value')
  }

  if (!missing(specialty_source_concept_id)) {
    fields <- c(fields, "specialty_source_concept_id")
    values <- c(values, if (is.null(specialty_source_concept_id)) "NULL" else if (is(specialty_source_concept_id, "subQuery")) paste0("(", as.character(specialty_source_concept_id), ")") else paste0("'", as.character(specialty_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.specialty_source_concept_id')
  }

  if (!missing(gender_source_value)) {
    fields <- c(fields, "gender_source_value")
    values <- c(values, if (is.null(gender_source_value)) "NULL" else if (is(gender_source_value, "subQuery")) paste0("(", as.character(gender_source_value), ")") else paste0("'", as.character(gender_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.gender_source_value')
  }

  if (!missing(gender_source_concept_id)) {
    fields <- c(fields, "gender_source_concept_id")
    values <- c(values, if (is.null(gender_source_concept_id)) "NULL" else if (is(gender_source_concept_id, "subQuery")) paste0("(", as.character(gender_source_concept_id), ")") else paste0("'", as.character(gender_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.gender_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "provider", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_care_site <- function(care_site_id, care_site_name, place_of_service_concept_id, location_id, care_site_source_value, place_of_service_source_value) {
  fields <- c()
  values <- c()
  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) "NULL" else if (is(care_site_id, "subQuery")) paste0("(", as.character(care_site_id), ")") else paste0("'", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.care_site_id')
  }

  if (!missing(care_site_name)) {
    fields <- c(fields, "care_site_name")
    values <- c(values, if (is.null(care_site_name)) "NULL" else if (is(care_site_name, "subQuery")) paste0("(", as.character(care_site_name), ")") else paste0("'", as.character(care_site_name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.care_site_name')
  }

  if (!missing(place_of_service_concept_id)) {
    fields <- c(fields, "place_of_service_concept_id")
    values <- c(values, if (is.null(place_of_service_concept_id)) "NULL" else if (is(place_of_service_concept_id, "subQuery")) paste0("(", as.character(place_of_service_concept_id), ")") else paste0("'", as.character(place_of_service_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.place_of_service_concept_id')
  }

  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) "NULL" else if (is(location_id, "subQuery")) paste0("(", as.character(location_id), ")") else paste0("'", as.character(location_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.location_id')
  }

  if (!missing(care_site_source_value)) {
    fields <- c(fields, "care_site_source_value")
    values <- c(values, if (is.null(care_site_source_value)) "NULL" else if (is(care_site_source_value, "subQuery")) paste0("(", as.character(care_site_source_value), ")") else paste0("'", as.character(care_site_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.care_site_source_value')
  }

  if (!missing(place_of_service_source_value)) {
    fields <- c(fields, "place_of_service_source_value")
    values <- c(values, if (is.null(place_of_service_source_value)) "NULL" else if (is(place_of_service_source_value, "subQuery")) paste0("(", as.character(place_of_service_source_value), ")") else paste0("'", as.character(place_of_service_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.place_of_service_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "care_site", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_cdm_source <- function(cdm_source_name, cdm_source_abbreviation, cdm_holder, source_description, source_documentation_reference, cdm_etl_reference, source_release_date, cdm_release_date, cdm_version, vocabulary_version) {
  fields <- c()
  values <- c()
  if (!missing(cdm_source_name)) {
    fields <- c(fields, "cdm_source_name")
    values <- c(values, if (is.null(cdm_source_name)) "NULL" else if (is(cdm_source_name, "subQuery")) paste0("(", as.character(cdm_source_name), ")") else paste0("'", as.character(cdm_source_name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_source_name')
  }

  if (!missing(cdm_source_abbreviation)) {
    fields <- c(fields, "cdm_source_abbreviation")
    values <- c(values, if (is.null(cdm_source_abbreviation)) "NULL" else if (is(cdm_source_abbreviation, "subQuery")) paste0("(", as.character(cdm_source_abbreviation), ")") else paste0("'", as.character(cdm_source_abbreviation), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_source_abbreviation')
  }

  if (!missing(cdm_holder)) {
    fields <- c(fields, "cdm_holder")
    values <- c(values, if (is.null(cdm_holder)) "NULL" else if (is(cdm_holder, "subQuery")) paste0("(", as.character(cdm_holder), ")") else paste0("'", as.character(cdm_holder), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_holder')
  }

  if (!missing(source_description)) {
    fields <- c(fields, "source_description")
    values <- c(values, if (is.null(source_description)) "NULL" else if (is(source_description, "subQuery")) paste0("(", as.character(source_description), ")") else paste0("'", as.character(source_description), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.source_description')
  }

  if (!missing(source_documentation_reference)) {
    fields <- c(fields, "source_documentation_reference")
    values <- c(values, if (is.null(source_documentation_reference)) "NULL" else if (is(source_documentation_reference, "subQuery")) paste0("(", as.character(source_documentation_reference), ")") else paste0("'", as.character(source_documentation_reference), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.source_documentation_reference')
  }

  if (!missing(cdm_etl_reference)) {
    fields <- c(fields, "cdm_etl_reference")
    values <- c(values, if (is.null(cdm_etl_reference)) "NULL" else if (is(cdm_etl_reference, "subQuery")) paste0("(", as.character(cdm_etl_reference), ")") else paste0("'", as.character(cdm_etl_reference), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_etl_reference')
  }

  if (!missing(source_release_date)) {
    fields <- c(fields, "source_release_date")
    values <- c(values, if (is.null(source_release_date)) "NULL" else if (is(source_release_date, "subQuery")) paste0("(", as.character(source_release_date), ")") else paste0("'", as.character(source_release_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.source_release_date')
  }

  if (!missing(cdm_release_date)) {
    fields <- c(fields, "cdm_release_date")
    values <- c(values, if (is.null(cdm_release_date)) "NULL" else if (is(cdm_release_date, "subQuery")) paste0("(", as.character(cdm_release_date), ")") else paste0("'", as.character(cdm_release_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_release_date')
  }

  if (!missing(cdm_version)) {
    fields <- c(fields, "cdm_version")
    values <- c(values, if (is.null(cdm_version)) "NULL" else if (is(cdm_version, "subQuery")) paste0("(", as.character(cdm_version), ")") else paste0("'", as.character(cdm_version), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_version')
  }

  if (!missing(vocabulary_version)) {
    fields <- c(fields, "vocabulary_version")
    values <- c(values, if (is.null(vocabulary_version)) "NULL" else if (is(vocabulary_version, "subQuery")) paste0("(", as.character(vocabulary_version), ")") else paste0("'", as.character(vocabulary_version), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.vocabulary_version')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "cdm_source", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_metadata <- function(metadata_concept_id, metadata_type_concept_id, name, value_as_string, value_as_concept_id, metadata_date, metadata_datetime) {
  fields <- c()
  values <- c()
  if (!missing(metadata_concept_id)) {
    fields <- c(fields, "metadata_concept_id")
    values <- c(values, if (is.null(metadata_concept_id)) "NULL" else if (is(metadata_concept_id, "subQuery")) paste0("(", as.character(metadata_concept_id), ")") else paste0("'", as.character(metadata_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_concept_id')
  }

  if (!missing(metadata_type_concept_id)) {
    fields <- c(fields, "metadata_type_concept_id")
    values <- c(values, if (is.null(metadata_type_concept_id)) "NULL" else if (is(metadata_type_concept_id, "subQuery")) paste0("(", as.character(metadata_type_concept_id), ")") else paste0("'", as.character(metadata_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_type_concept_id')
  }

  if (!missing(name)) {
    fields <- c(fields, "name")
    values <- c(values, if (is.null(name)) "NULL" else if (is(name, "subQuery")) paste0("(", as.character(name), ")") else paste0("'", as.character(name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.name')
  }

  if (!missing(value_as_string)) {
    fields <- c(fields, "value_as_string")
    values <- c(values, if (is.null(value_as_string)) "NULL" else if (is(value_as_string, "subQuery")) paste0("(", as.character(value_as_string), ")") else paste0("'", as.character(value_as_string), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.value_as_string')
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) "NULL" else if (is(value_as_concept_id, "subQuery")) paste0("(", as.character(value_as_concept_id), ")") else paste0("'", as.character(value_as_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.value_as_concept_id')
  }

  if (!missing(metadata_date)) {
    fields <- c(fields, "[metadata date]")
    values <- c(values, if (is.null(metadata_date)) "NULL" else if (is(metadata_date, "subQuery")) paste0("(", as.character(metadata_date), ")") else paste0("'", as.character(metadata_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_date')
  }

  if (!missing(metadata_datetime)) {
    fields <- c(fields, "metadata_datetime")
    values <- c(values, if (is.null(metadata_datetime)) "NULL" else if (is(metadata_datetime, "subQuery")) paste0("(", as.character(metadata_datetime), ")") else paste0("'", as.character(metadata_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_datetime')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "metadata", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_fact_relationship <- function(domain_concept_id_1, fact_id_1, domain_concept_id_2, fact_id_2, relationship_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(domain_concept_id_1)) {
    fields <- c(fields, "domain_concept_id_1")
    values <- c(values, if (is.null(domain_concept_id_1)) "NULL" else if (is(domain_concept_id_1, "subQuery")) paste0("(", as.character(domain_concept_id_1), ")") else paste0("'", as.character(domain_concept_id_1), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.domain_concept_id_1')
  }

  if (!missing(fact_id_1)) {
    fields <- c(fields, "fact_id_1")
    values <- c(values, if (is.null(fact_id_1)) "NULL" else if (is(fact_id_1, "subQuery")) paste0("(", as.character(fact_id_1), ")") else paste0("'", as.character(fact_id_1), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.fact_id_1')
  }

  if (!missing(domain_concept_id_2)) {
    fields <- c(fields, "domain_concept_id_2")
    values <- c(values, if (is.null(domain_concept_id_2)) "NULL" else if (is(domain_concept_id_2, "subQuery")) paste0("(", as.character(domain_concept_id_2), ")") else paste0("'", as.character(domain_concept_id_2), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.domain_concept_id_2')
  }

  if (!missing(fact_id_2)) {
    fields <- c(fields, "fact_id_2")
    values <- c(values, if (is.null(fact_id_2)) "NULL" else if (is(fact_id_2, "subQuery")) paste0("(", as.character(fact_id_2), ")") else paste0("'", as.character(fact_id_2), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.fact_id_2')
  }

  if (!missing(relationship_concept_id)) {
    fields <- c(fields, "relationship_concept_id")
    values <- c(values, if (is.null(relationship_concept_id)) "NULL" else if (is(relationship_concept_id, "subQuery")) paste0("(", as.character(relationship_concept_id), ")") else paste0("'", as.character(relationship_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.relationship_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 0, table = "fact_relationship", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_person <- function(person_id, gender_concept_id, year_of_birth, month_of_birth, day_of_birth, birth_datetime, death_datetime, race_concept_id, ethnicity_concept_id, location_id, provider_id, care_site_id, person_source_value, gender_source_value, gender_source_concept_id, race_source_value, race_source_concept_id, ethnicity_source_value, ethnicity_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(gender_concept_id)) {
    fields <- c(fields, "gender_concept_id")
    values <- c(values, if (is.null(gender_concept_id)) "NULL" else if (is(gender_concept_id, "subQuery")) paste0("(", as.character(gender_concept_id), ")") else paste0("'", as.character(gender_concept_id), "'"))
  }

  if (!missing(year_of_birth)) {
    fields <- c(fields, "year_of_birth")
    values <- c(values, if (is.null(year_of_birth)) "NULL" else if (is(year_of_birth, "subQuery")) paste0("(", as.character(year_of_birth), ")") else paste0("'", as.character(year_of_birth), "'"))
  }

  if (!missing(month_of_birth)) {
    fields <- c(fields, "month_of_birth")
    values <- c(values, if (is.null(month_of_birth)) "NULL" else if (is(month_of_birth, "subQuery")) paste0("(", as.character(month_of_birth), ")") else paste0("'", as.character(month_of_birth), "'"))
  }

  if (!missing(day_of_birth)) {
    fields <- c(fields, "day_of_birth")
    values <- c(values, if (is.null(day_of_birth)) "NULL" else if (is(day_of_birth, "subQuery")) paste0("(", as.character(day_of_birth), ")") else paste0("'", as.character(day_of_birth), "'"))
  }

  if (!missing(birth_datetime)) {
    fields <- c(fields, "birth_datetime")
    values <- c(values, if (is.null(birth_datetime)) "NULL" else if (is(birth_datetime, "subQuery")) paste0("(", as.character(birth_datetime), ")") else paste0("'", as.character(birth_datetime), "'"))
  }

  if (!missing(death_datetime)) {
    fields <- c(fields, "death_datetime")
    values <- c(values, if (is.null(death_datetime)) "NULL" else if (is(death_datetime, "subQuery")) paste0("(", as.character(death_datetime), ")") else paste0("'", as.character(death_datetime), "'"))
  }

  if (!missing(race_concept_id)) {
    fields <- c(fields, "race_concept_id")
    values <- c(values, if (is.null(race_concept_id)) "NULL" else if (is(race_concept_id, "subQuery")) paste0("(", as.character(race_concept_id), ")") else paste0("'", as.character(race_concept_id), "'"))
  }

  if (!missing(ethnicity_concept_id)) {
    fields <- c(fields, "ethnicity_concept_id")
    values <- c(values, if (is.null(ethnicity_concept_id)) "NULL" else if (is(ethnicity_concept_id, "subQuery")) paste0("(", as.character(ethnicity_concept_id), ")") else paste0("'", as.character(ethnicity_concept_id), "'"))
  }

  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) "NULL" else if (is(location_id, "subQuery")) paste0("(", as.character(location_id), ")") else paste0("'", as.character(location_id), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) "NULL" else if (is(care_site_id, "subQuery")) paste0("(", as.character(care_site_id), ")") else paste0("'", as.character(care_site_id), "'"))
  }

  if (!missing(person_source_value)) {
    fields <- c(fields, "person_source_value")
    values <- c(values, if (is.null(person_source_value)) "NULL" else if (is(person_source_value, "subQuery")) paste0("(", as.character(person_source_value), ")") else paste0("'", as.character(person_source_value), "'"))
  }

  if (!missing(gender_source_value)) {
    fields <- c(fields, "gender_source_value")
    values <- c(values, if (is.null(gender_source_value)) "NULL" else if (is(gender_source_value, "subQuery")) paste0("(", as.character(gender_source_value), ")") else paste0("'", as.character(gender_source_value), "'"))
  }

  if (!missing(gender_source_concept_id)) {
    fields <- c(fields, "gender_source_concept_id")
    values <- c(values, if (is.null(gender_source_concept_id)) "NULL" else if (is(gender_source_concept_id, "subQuery")) paste0("(", as.character(gender_source_concept_id), ")") else paste0("'", as.character(gender_source_concept_id), "'"))
  }

  if (!missing(race_source_value)) {
    fields <- c(fields, "race_source_value")
    values <- c(values, if (is.null(race_source_value)) "NULL" else if (is(race_source_value, "subQuery")) paste0("(", as.character(race_source_value), ")") else paste0("'", as.character(race_source_value), "'"))
  }

  if (!missing(race_source_concept_id)) {
    fields <- c(fields, "race_source_concept_id")
    values <- c(values, if (is.null(race_source_concept_id)) "NULL" else if (is(race_source_concept_id, "subQuery")) paste0("(", as.character(race_source_concept_id), ")") else paste0("'", as.character(race_source_concept_id), "'"))
  }

  if (!missing(ethnicity_source_value)) {
    fields <- c(fields, "ethnicity_source_value")
    values <- c(values, if (is.null(ethnicity_source_value)) "NULL" else if (is(ethnicity_source_value, "subQuery")) paste0("(", as.character(ethnicity_source_value), ")") else paste0("'", as.character(ethnicity_source_value), "'"))
  }

  if (!missing(ethnicity_source_concept_id)) {
    fields <- c(fields, "ethnicity_source_concept_id")
    values <- c(values, if (is.null(ethnicity_source_concept_id)) "NULL" else if (is(ethnicity_source_concept_id, "subQuery")) paste0("(", as.character(ethnicity_source_concept_id), ")") else paste0("'", as.character(ethnicity_source_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "person", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_observation_period <- function(observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(observation_period_id)) {
    fields <- c(fields, "observation_period_id")
    values <- c(values, if (is.null(observation_period_id)) "NULL" else if (is(observation_period_id, "subQuery")) paste0("(", as.character(observation_period_id), ")") else paste0("'", as.character(observation_period_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(observation_period_start_date)) {
    fields <- c(fields, "observation_period_start_date")
    values <- c(values, if (is.null(observation_period_start_date)) "NULL" else if (is(observation_period_start_date, "subQuery")) paste0("(", as.character(observation_period_start_date), ")") else paste0("'", as.character(observation_period_start_date), "'"))
  }

  if (!missing(observation_period_end_date)) {
    fields <- c(fields, "observation_period_end_date")
    values <- c(values, if (is.null(observation_period_end_date)) "NULL" else if (is(observation_period_end_date, "subQuery")) paste0("(", as.character(observation_period_end_date), ")") else paste0("'", as.character(observation_period_end_date), "'"))
  }

  if (!missing(period_type_concept_id)) {
    fields <- c(fields, "period_type_concept_id")
    values <- c(values, if (is.null(period_type_concept_id)) "NULL" else if (is(period_type_concept_id, "subQuery")) paste0("(", as.character(period_type_concept_id), ")") else paste0("'", as.character(period_type_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "observation_period", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_visit_occurrence <- function(visit_occurrence_id, person_id, visit_concept_id, visit_start_date, visit_start_datetime, visit_end_date, visit_end_datetime, visit_type_concept_id, provider_id, care_site_id, visit_source_value, visit_source_concept_id, admitting_source_concept_id, admitting_source_value, discharge_to_concept_id, discharge_to_source_value, preceding_visit_occurrence_id) {
  fields <- c()
  values <- c()
  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(visit_concept_id)) {
    fields <- c(fields, "visit_concept_id")
    values <- c(values, if (is.null(visit_concept_id)) "NULL" else if (is(visit_concept_id, "subQuery")) paste0("(", as.character(visit_concept_id), ")") else paste0("'", as.character(visit_concept_id), "'"))
  }

  if (!missing(visit_start_date)) {
    fields <- c(fields, "visit_start_date")
    values <- c(values, if (is.null(visit_start_date)) "NULL" else if (is(visit_start_date, "subQuery")) paste0("(", as.character(visit_start_date), ")") else paste0("'", as.character(visit_start_date), "'"))
  }

  if (!missing(visit_start_datetime)) {
    fields <- c(fields, "visit_start_datetime")
    values <- c(values, if (is.null(visit_start_datetime)) "NULL" else if (is(visit_start_datetime, "subQuery")) paste0("(", as.character(visit_start_datetime), ")") else paste0("'", as.character(visit_start_datetime), "'"))
  }

  if (!missing(visit_end_date)) {
    fields <- c(fields, "visit_end_date")
    values <- c(values, if (is.null(visit_end_date)) "NULL" else if (is(visit_end_date, "subQuery")) paste0("(", as.character(visit_end_date), ")") else paste0("'", as.character(visit_end_date), "'"))
  }

  if (!missing(visit_end_datetime)) {
    fields <- c(fields, "visit_end_datetime")
    values <- c(values, if (is.null(visit_end_datetime)) "NULL" else if (is(visit_end_datetime, "subQuery")) paste0("(", as.character(visit_end_datetime), ")") else paste0("'", as.character(visit_end_datetime), "'"))
  }

  if (!missing(visit_type_concept_id)) {
    fields <- c(fields, "visit_type_concept_id")
    values <- c(values, if (is.null(visit_type_concept_id)) "NULL" else if (is(visit_type_concept_id, "subQuery")) paste0("(", as.character(visit_type_concept_id), ")") else paste0("'", as.character(visit_type_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) "NULL" else if (is(care_site_id, "subQuery")) paste0("(", as.character(care_site_id), ")") else paste0("'", as.character(care_site_id), "'"))
  }

  if (!missing(visit_source_value)) {
    fields <- c(fields, "visit_source_value")
    values <- c(values, if (is.null(visit_source_value)) "NULL" else if (is(visit_source_value, "subQuery")) paste0("(", as.character(visit_source_value), ")") else paste0("'", as.character(visit_source_value), "'"))
  }

  if (!missing(visit_source_concept_id)) {
    fields <- c(fields, "visit_source_concept_id")
    values <- c(values, if (is.null(visit_source_concept_id)) "NULL" else if (is(visit_source_concept_id, "subQuery")) paste0("(", as.character(visit_source_concept_id), ")") else paste0("'", as.character(visit_source_concept_id), "'"))
  }

  if (!missing(admitting_source_concept_id)) {
    fields <- c(fields, "admitting_source_concept_id")
    values <- c(values, if (is.null(admitting_source_concept_id)) "NULL" else if (is(admitting_source_concept_id, "subQuery")) paste0("(", as.character(admitting_source_concept_id), ")") else paste0("'", as.character(admitting_source_concept_id), "'"))
  }

  if (!missing(admitting_source_value)) {
    fields <- c(fields, "admitting_source_value")
    values <- c(values, if (is.null(admitting_source_value)) "NULL" else if (is(admitting_source_value, "subQuery")) paste0("(", as.character(admitting_source_value), ")") else paste0("'", as.character(admitting_source_value), "'"))
  }

  if (!missing(discharge_to_concept_id)) {
    fields <- c(fields, "discharge_to_concept_id")
    values <- c(values, if (is.null(discharge_to_concept_id)) "NULL" else if (is(discharge_to_concept_id, "subQuery")) paste0("(", as.character(discharge_to_concept_id), ")") else paste0("'", as.character(discharge_to_concept_id), "'"))
  }

  if (!missing(discharge_to_source_value)) {
    fields <- c(fields, "discharge_to_source_value")
    values <- c(values, if (is.null(discharge_to_source_value)) "NULL" else if (is(discharge_to_source_value, "subQuery")) paste0("(", as.character(discharge_to_source_value), ")") else paste0("'", as.character(discharge_to_source_value), "'"))
  }

  if (!missing(preceding_visit_occurrence_id)) {
    fields <- c(fields, "preceding_visit_occurrence_id")
    values <- c(values, if (is.null(preceding_visit_occurrence_id)) "NULL" else if (is(preceding_visit_occurrence_id, "subQuery")) paste0("(", as.character(preceding_visit_occurrence_id), ")") else paste0("'", as.character(preceding_visit_occurrence_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "visit_occurrence", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_visit_detail <- function(visit_detail_id, person_id, visit_detail_concept_id, visit_detail_start_date, visit_detail_start_datetime, visit_detail_end_date, visit_detail_end_datetime, visit_detail_type_concept_id, provider_id, care_site_id, visit_detail_source_value, visit_detail_source_concept_id, admitted_from_source_value, admitted_from_concept_id, discharge_to_source_value, discharge_to_concept_id, preceding_visit_detail_id, visit_detail_parent_id, visit_occurrence_id) {
  fields <- c()
  values <- c()
  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(visit_detail_concept_id)) {
    fields <- c(fields, "visit_detail_concept_id")
    values <- c(values, if (is.null(visit_detail_concept_id)) "NULL" else if (is(visit_detail_concept_id, "subQuery")) paste0("(", as.character(visit_detail_concept_id), ")") else paste0("'", as.character(visit_detail_concept_id), "'"))
  }

  if (!missing(visit_detail_start_date)) {
    fields <- c(fields, "visit_detail_start_date")
    values <- c(values, if (is.null(visit_detail_start_date)) "NULL" else if (is(visit_detail_start_date, "subQuery")) paste0("(", as.character(visit_detail_start_date), ")") else paste0("'", as.character(visit_detail_start_date), "'"))
  }

  if (!missing(visit_detail_start_datetime)) {
    fields <- c(fields, "visit_detail_start_datetime")
    values <- c(values, if (is.null(visit_detail_start_datetime)) "NULL" else if (is(visit_detail_start_datetime, "subQuery")) paste0("(", as.character(visit_detail_start_datetime), ")") else paste0("'", as.character(visit_detail_start_datetime), "'"))
  }

  if (!missing(visit_detail_end_date)) {
    fields <- c(fields, "visit_detail_end_date")
    values <- c(values, if (is.null(visit_detail_end_date)) "NULL" else if (is(visit_detail_end_date, "subQuery")) paste0("(", as.character(visit_detail_end_date), ")") else paste0("'", as.character(visit_detail_end_date), "'"))
  }

  if (!missing(visit_detail_end_datetime)) {
    fields <- c(fields, "visit_detail_end_datetime")
    values <- c(values, if (is.null(visit_detail_end_datetime)) "NULL" else if (is(visit_detail_end_datetime, "subQuery")) paste0("(", as.character(visit_detail_end_datetime), ")") else paste0("'", as.character(visit_detail_end_datetime), "'"))
  }

  if (!missing(visit_detail_type_concept_id)) {
    fields <- c(fields, "visit_detail_type_concept_id")
    values <- c(values, if (is.null(visit_detail_type_concept_id)) "NULL" else if (is(visit_detail_type_concept_id, "subQuery")) paste0("(", as.character(visit_detail_type_concept_id), ")") else paste0("'", as.character(visit_detail_type_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) "NULL" else if (is(care_site_id, "subQuery")) paste0("(", as.character(care_site_id), ")") else paste0("'", as.character(care_site_id), "'"))
  }

  if (!missing(visit_detail_source_value)) {
    fields <- c(fields, "visit_detail_source_value")
    values <- c(values, if (is.null(visit_detail_source_value)) "NULL" else if (is(visit_detail_source_value, "subQuery")) paste0("(", as.character(visit_detail_source_value), ")") else paste0("'", as.character(visit_detail_source_value), "'"))
  }

  if (!missing(visit_detail_source_concept_id)) {
    fields <- c(fields, "visit_detail_source_concept_id")
    values <- c(values, if (is.null(visit_detail_source_concept_id)) "NULL" else if (is(visit_detail_source_concept_id, "subQuery")) paste0("(", as.character(visit_detail_source_concept_id), ")") else paste0("'", as.character(visit_detail_source_concept_id), "'"))
  }

  if (!missing(admitted_from_source_value)) {
    fields <- c(fields, "admitted_from_source_value")
    values <- c(values, if (is.null(admitted_from_source_value)) "NULL" else if (is(admitted_from_source_value, "subQuery")) paste0("(", as.character(admitted_from_source_value), ")") else paste0("'", as.character(admitted_from_source_value), "'"))
  }

  if (!missing(admitted_from_concept_id)) {
    fields <- c(fields, "admitted_from_concept_id")
    values <- c(values, if (is.null(admitted_from_concept_id)) "NULL" else if (is(admitted_from_concept_id, "subQuery")) paste0("(", as.character(admitted_from_concept_id), ")") else paste0("'", as.character(admitted_from_concept_id), "'"))
  }

  if (!missing(discharge_to_source_value)) {
    fields <- c(fields, "discharge_to_source_value")
    values <- c(values, if (is.null(discharge_to_source_value)) "NULL" else if (is(discharge_to_source_value, "subQuery")) paste0("(", as.character(discharge_to_source_value), ")") else paste0("'", as.character(discharge_to_source_value), "'"))
  }

  if (!missing(discharge_to_concept_id)) {
    fields <- c(fields, "discharge_to_concept_id")
    values <- c(values, if (is.null(discharge_to_concept_id)) "NULL" else if (is(discharge_to_concept_id, "subQuery")) paste0("(", as.character(discharge_to_concept_id), ")") else paste0("'", as.character(discharge_to_concept_id), "'"))
  }

  if (!missing(preceding_visit_detail_id)) {
    fields <- c(fields, "preceding_visit_detail_id")
    values <- c(values, if (is.null(preceding_visit_detail_id)) "NULL" else if (is(preceding_visit_detail_id, "subQuery")) paste0("(", as.character(preceding_visit_detail_id), ")") else paste0("'", as.character(preceding_visit_detail_id), "'"))
  }

  if (!missing(visit_detail_parent_id)) {
    fields <- c(fields, "visit_detail_parent_id")
    values <- c(values, if (is.null(visit_detail_parent_id)) "NULL" else if (is(visit_detail_parent_id, "subQuery")) paste0("(", as.character(visit_detail_parent_id), ")") else paste0("'", as.character(visit_detail_parent_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "visit_detail", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_condition_occurrence <- function(condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_start_datetime, condition_end_date, condition_end_datetime, condition_type_concept_id, condition_status_concept_id, stop_reason, provider_id, visit_occurrence_id, visit_detail_id, condition_source_value, condition_source_concept_id, condition_status_source_value) {
  fields <- c()
  values <- c()
  if (!missing(condition_occurrence_id)) {
    fields <- c(fields, "condition_occurrence_id")
    values <- c(values, if (is.null(condition_occurrence_id)) "NULL" else if (is(condition_occurrence_id, "subQuery")) paste0("(", as.character(condition_occurrence_id), ")") else paste0("'", as.character(condition_occurrence_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(condition_concept_id)) {
    fields <- c(fields, "condition_concept_id")
    values <- c(values, if (is.null(condition_concept_id)) "NULL" else if (is(condition_concept_id, "subQuery")) paste0("(", as.character(condition_concept_id), ")") else paste0("'", as.character(condition_concept_id), "'"))
  }

  if (!missing(condition_start_date)) {
    fields <- c(fields, "condition_start_date")
    values <- c(values, if (is.null(condition_start_date)) "NULL" else if (is(condition_start_date, "subQuery")) paste0("(", as.character(condition_start_date), ")") else paste0("'", as.character(condition_start_date), "'"))
  }

  if (!missing(condition_start_datetime)) {
    fields <- c(fields, "condition_start_datetime")
    values <- c(values, if (is.null(condition_start_datetime)) "NULL" else if (is(condition_start_datetime, "subQuery")) paste0("(", as.character(condition_start_datetime), ")") else paste0("'", as.character(condition_start_datetime), "'"))
  }

  if (!missing(condition_end_date)) {
    fields <- c(fields, "condition_end_date")
    values <- c(values, if (is.null(condition_end_date)) "NULL" else if (is(condition_end_date, "subQuery")) paste0("(", as.character(condition_end_date), ")") else paste0("'", as.character(condition_end_date), "'"))
  }

  if (!missing(condition_end_datetime)) {
    fields <- c(fields, "condition_end_datetime")
    values <- c(values, if (is.null(condition_end_datetime)) "NULL" else if (is(condition_end_datetime, "subQuery")) paste0("(", as.character(condition_end_datetime), ")") else paste0("'", as.character(condition_end_datetime), "'"))
  }

  if (!missing(condition_type_concept_id)) {
    fields <- c(fields, "condition_type_concept_id")
    values <- c(values, if (is.null(condition_type_concept_id)) "NULL" else if (is(condition_type_concept_id, "subQuery")) paste0("(", as.character(condition_type_concept_id), ")") else paste0("'", as.character(condition_type_concept_id), "'"))
  }

  if (!missing(condition_status_concept_id)) {
    fields <- c(fields, "condition_status_concept_id")
    values <- c(values, if (is.null(condition_status_concept_id)) "NULL" else if (is(condition_status_concept_id, "subQuery")) paste0("(", as.character(condition_status_concept_id), ")") else paste0("'", as.character(condition_status_concept_id), "'"))
  }

  if (!missing(stop_reason)) {
    fields <- c(fields, "stop_reason")
    values <- c(values, if (is.null(stop_reason)) "NULL" else if (is(stop_reason, "subQuery")) paste0("(", as.character(stop_reason), ")") else paste0("'", as.character(stop_reason), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
  }

  if (!missing(condition_source_value)) {
    fields <- c(fields, "condition_source_value")
    values <- c(values, if (is.null(condition_source_value)) "NULL" else if (is(condition_source_value, "subQuery")) paste0("(", as.character(condition_source_value), ")") else paste0("'", as.character(condition_source_value), "'"))
  }

  if (!missing(condition_source_concept_id)) {
    fields <- c(fields, "condition_source_concept_id")
    values <- c(values, if (is.null(condition_source_concept_id)) "NULL" else if (is(condition_source_concept_id, "subQuery")) paste0("(", as.character(condition_source_concept_id), ")") else paste0("'", as.character(condition_source_concept_id), "'"))
  }

  if (!missing(condition_status_source_value)) {
    fields <- c(fields, "condition_status_source_value")
    values <- c(values, if (is.null(condition_status_source_value)) "NULL" else if (is(condition_status_source_value, "subQuery")) paste0("(", as.character(condition_status_source_value), ")") else paste0("'", as.character(condition_status_source_value), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "condition_occurrence", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_procedure_occurrence <- function(procedure_occurrence_id, person_id, procedure_concept_id, procedure_date, procedure_datetime, procedure_type_concept_id, modifier_concept_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, procedure_source_value, procedure_source_concept_id, modifier_source_value) {
  fields <- c()
  values <- c()
  if (!missing(procedure_occurrence_id)) {
    fields <- c(fields, "procedure_occurrence_id")
    values <- c(values, if (is.null(procedure_occurrence_id)) "NULL" else if (is(procedure_occurrence_id, "subQuery")) paste0("(", as.character(procedure_occurrence_id), ")") else paste0("'", as.character(procedure_occurrence_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(procedure_concept_id)) {
    fields <- c(fields, "procedure_concept_id")
    values <- c(values, if (is.null(procedure_concept_id)) "NULL" else if (is(procedure_concept_id, "subQuery")) paste0("(", as.character(procedure_concept_id), ")") else paste0("'", as.character(procedure_concept_id), "'"))
  }

  if (!missing(procedure_date)) {
    fields <- c(fields, "procedure_date")
    values <- c(values, if (is.null(procedure_date)) "NULL" else if (is(procedure_date, "subQuery")) paste0("(", as.character(procedure_date), ")") else paste0("'", as.character(procedure_date), "'"))
  }

  if (!missing(procedure_datetime)) {
    fields <- c(fields, "procedure_datetime")
    values <- c(values, if (is.null(procedure_datetime)) "NULL" else if (is(procedure_datetime, "subQuery")) paste0("(", as.character(procedure_datetime), ")") else paste0("'", as.character(procedure_datetime), "'"))
  }

  if (!missing(procedure_type_concept_id)) {
    fields <- c(fields, "procedure_type_concept_id")
    values <- c(values, if (is.null(procedure_type_concept_id)) "NULL" else if (is(procedure_type_concept_id, "subQuery")) paste0("(", as.character(procedure_type_concept_id), ")") else paste0("'", as.character(procedure_type_concept_id), "'"))
  }

  if (!missing(modifier_concept_id)) {
    fields <- c(fields, "modifier_concept_id")
    values <- c(values, if (is.null(modifier_concept_id)) "NULL" else if (is(modifier_concept_id, "subQuery")) paste0("(", as.character(modifier_concept_id), ")") else paste0("'", as.character(modifier_concept_id), "'"))
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) "NULL" else if (is(quantity, "subQuery")) paste0("(", as.character(quantity), ")") else paste0("'", as.character(quantity), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
  }

  if (!missing(procedure_source_value)) {
    fields <- c(fields, "procedure_source_value")
    values <- c(values, if (is.null(procedure_source_value)) "NULL" else if (is(procedure_source_value, "subQuery")) paste0("(", as.character(procedure_source_value), ")") else paste0("'", as.character(procedure_source_value), "'"))
  }

  if (!missing(procedure_source_concept_id)) {
    fields <- c(fields, "procedure_source_concept_id")
    values <- c(values, if (is.null(procedure_source_concept_id)) "NULL" else if (is(procedure_source_concept_id, "subQuery")) paste0("(", as.character(procedure_source_concept_id), ")") else paste0("'", as.character(procedure_source_concept_id), "'"))
  }

  if (!missing(modifier_source_value)) {
    fields <- c(fields, "modifier_source_value")
    values <- c(values, if (is.null(modifier_source_value)) "NULL" else if (is(modifier_source_value, "subQuery")) paste0("(", as.character(modifier_source_value), ")") else paste0("'", as.character(modifier_source_value), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "procedure_occurrence", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_drug_exposure <- function(drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_start_datetime, drug_exposure_end_date, drug_exposure_end_datetime, verbatim_end_date, drug_type_concept_id, stop_reason, refills, quantity, days_supply, sig, route_concept_id, lot_number, provider_id, visit_occurrence_id, visit_detail_id, drug_source_value, drug_source_concept_id, route_source_value, dose_unit_source_value) {
  fields <- c()
  values <- c()
  if (!missing(drug_exposure_id)) {
    fields <- c(fields, "drug_exposure_id")
    values <- c(values, if (is.null(drug_exposure_id)) "NULL" else if (is(drug_exposure_id, "subQuery")) paste0("(", as.character(drug_exposure_id), ")") else paste0("'", as.character(drug_exposure_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) "NULL" else if (is(drug_concept_id, "subQuery")) paste0("(", as.character(drug_concept_id), ")") else paste0("'", as.character(drug_concept_id), "'"))
  }

  if (!missing(drug_exposure_start_date)) {
    fields <- c(fields, "drug_exposure_start_date")
    values <- c(values, if (is.null(drug_exposure_start_date)) "NULL" else if (is(drug_exposure_start_date, "subQuery")) paste0("(", as.character(drug_exposure_start_date), ")") else paste0("'", as.character(drug_exposure_start_date), "'"))
  }

  if (!missing(drug_exposure_start_datetime)) {
    fields <- c(fields, "drug_exposure_start_datetime")
    values <- c(values, if (is.null(drug_exposure_start_datetime)) "NULL" else if (is(drug_exposure_start_datetime, "subQuery")) paste0("(", as.character(drug_exposure_start_datetime), ")") else paste0("'", as.character(drug_exposure_start_datetime), "'"))
  }

  if (!missing(drug_exposure_end_date)) {
    fields <- c(fields, "drug_exposure_end_date")
    values <- c(values, if (is.null(drug_exposure_end_date)) "NULL" else if (is(drug_exposure_end_date, "subQuery")) paste0("(", as.character(drug_exposure_end_date), ")") else paste0("'", as.character(drug_exposure_end_date), "'"))
  }

  if (!missing(drug_exposure_end_datetime)) {
    fields <- c(fields, "drug_exposure_end_datetime")
    values <- c(values, if (is.null(drug_exposure_end_datetime)) "NULL" else if (is(drug_exposure_end_datetime, "subQuery")) paste0("(", as.character(drug_exposure_end_datetime), ")") else paste0("'", as.character(drug_exposure_end_datetime), "'"))
  }

  if (!missing(verbatim_end_date)) {
    fields <- c(fields, "verbatim_end_date")
    values <- c(values, if (is.null(verbatim_end_date)) "NULL" else if (is(verbatim_end_date, "subQuery")) paste0("(", as.character(verbatim_end_date), ")") else paste0("'", as.character(verbatim_end_date), "'"))
  }

  if (!missing(drug_type_concept_id)) {
    fields <- c(fields, "drug_type_concept_id")
    values <- c(values, if (is.null(drug_type_concept_id)) "NULL" else if (is(drug_type_concept_id, "subQuery")) paste0("(", as.character(drug_type_concept_id), ")") else paste0("'", as.character(drug_type_concept_id), "'"))
  }

  if (!missing(stop_reason)) {
    fields <- c(fields, "stop_reason")
    values <- c(values, if (is.null(stop_reason)) "NULL" else if (is(stop_reason, "subQuery")) paste0("(", as.character(stop_reason), ")") else paste0("'", as.character(stop_reason), "'"))
  }

  if (!missing(refills)) {
    fields <- c(fields, "refills")
    values <- c(values, if (is.null(refills)) "NULL" else if (is(refills, "subQuery")) paste0("(", as.character(refills), ")") else paste0("'", as.character(refills), "'"))
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) "NULL" else if (is(quantity, "subQuery")) paste0("(", as.character(quantity), ")") else paste0("'", as.character(quantity), "'"))
  }

  if (!missing(days_supply)) {
    fields <- c(fields, "days_supply")
    values <- c(values, if (is.null(days_supply)) "NULL" else if (is(days_supply, "subQuery")) paste0("(", as.character(days_supply), ")") else paste0("'", as.character(days_supply), "'"))
  }

  if (!missing(sig)) {
    fields <- c(fields, "sig")
    values <- c(values, if (is.null(sig)) "NULL" else if (is(sig, "subQuery")) paste0("(", as.character(sig), ")") else paste0("'", as.character(sig), "'"))
  }

  if (!missing(route_concept_id)) {
    fields <- c(fields, "route_concept_id")
    values <- c(values, if (is.null(route_concept_id)) "NULL" else if (is(route_concept_id, "subQuery")) paste0("(", as.character(route_concept_id), ")") else paste0("'", as.character(route_concept_id), "'"))
  }

  if (!missing(lot_number)) {
    fields <- c(fields, "lot_number")
    values <- c(values, if (is.null(lot_number)) "NULL" else if (is(lot_number, "subQuery")) paste0("(", as.character(lot_number), ")") else paste0("'", as.character(lot_number), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
  }

  if (!missing(drug_source_value)) {
    fields <- c(fields, "drug_source_value")
    values <- c(values, if (is.null(drug_source_value)) "NULL" else if (is(drug_source_value, "subQuery")) paste0("(", as.character(drug_source_value), ")") else paste0("'", as.character(drug_source_value), "'"))
  }

  if (!missing(drug_source_concept_id)) {
    fields <- c(fields, "drug_source_concept_id")
    values <- c(values, if (is.null(drug_source_concept_id)) "NULL" else if (is(drug_source_concept_id, "subQuery")) paste0("(", as.character(drug_source_concept_id), ")") else paste0("'", as.character(drug_source_concept_id), "'"))
  }

  if (!missing(route_source_value)) {
    fields <- c(fields, "route_source_value")
    values <- c(values, if (is.null(route_source_value)) "NULL" else if (is(route_source_value, "subQuery")) paste0("(", as.character(route_source_value), ")") else paste0("'", as.character(route_source_value), "'"))
  }

  if (!missing(dose_unit_source_value)) {
    fields <- c(fields, "dose_unit_source_value")
    values <- c(values, if (is.null(dose_unit_source_value)) "NULL" else if (is(dose_unit_source_value, "subQuery")) paste0("(", as.character(dose_unit_source_value), ")") else paste0("'", as.character(dose_unit_source_value), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "drug_exposure", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_device_exposure <- function(device_exposure_id, person_id, device_concept_id, device_exposure_start_date, device_exposure_start_datetime, device_exposure_end_date, device_exposure_end_datetime, device_type_concept_id, unique_device_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, device_source_value, device_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(device_exposure_id)) {
    fields <- c(fields, "device_exposure_id")
    values <- c(values, if (is.null(device_exposure_id)) "NULL" else if (is(device_exposure_id, "subQuery")) paste0("(", as.character(device_exposure_id), ")") else paste0("'", as.character(device_exposure_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(device_concept_id)) {
    fields <- c(fields, "device_concept_id")
    values <- c(values, if (is.null(device_concept_id)) "NULL" else if (is(device_concept_id, "subQuery")) paste0("(", as.character(device_concept_id), ")") else paste0("'", as.character(device_concept_id), "'"))
  }

  if (!missing(device_exposure_start_date)) {
    fields <- c(fields, "device_exposure_start_date")
    values <- c(values, if (is.null(device_exposure_start_date)) "NULL" else if (is(device_exposure_start_date, "subQuery")) paste0("(", as.character(device_exposure_start_date), ")") else paste0("'", as.character(device_exposure_start_date), "'"))
  }

  if (!missing(device_exposure_start_datetime)) {
    fields <- c(fields, "device_exposure_start_datetime")
    values <- c(values, if (is.null(device_exposure_start_datetime)) "NULL" else if (is(device_exposure_start_datetime, "subQuery")) paste0("(", as.character(device_exposure_start_datetime), ")") else paste0("'", as.character(device_exposure_start_datetime), "'"))
  }

  if (!missing(device_exposure_end_date)) {
    fields <- c(fields, "device_exposure_end_date")
    values <- c(values, if (is.null(device_exposure_end_date)) "NULL" else if (is(device_exposure_end_date, "subQuery")) paste0("(", as.character(device_exposure_end_date), ")") else paste0("'", as.character(device_exposure_end_date), "'"))
  }

  if (!missing(device_exposure_end_datetime)) {
    fields <- c(fields, "device_exposure_end_datetime")
    values <- c(values, if (is.null(device_exposure_end_datetime)) "NULL" else if (is(device_exposure_end_datetime, "subQuery")) paste0("(", as.character(device_exposure_end_datetime), ")") else paste0("'", as.character(device_exposure_end_datetime), "'"))
  }

  if (!missing(device_type_concept_id)) {
    fields <- c(fields, "device_type_concept_id")
    values <- c(values, if (is.null(device_type_concept_id)) "NULL" else if (is(device_type_concept_id, "subQuery")) paste0("(", as.character(device_type_concept_id), ")") else paste0("'", as.character(device_type_concept_id), "'"))
  }

  if (!missing(unique_device_id)) {
    fields <- c(fields, "unique_device_id")
    values <- c(values, if (is.null(unique_device_id)) "NULL" else if (is(unique_device_id, "subQuery")) paste0("(", as.character(unique_device_id), ")") else paste0("'", as.character(unique_device_id), "'"))
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) "NULL" else if (is(quantity, "subQuery")) paste0("(", as.character(quantity), ")") else paste0("'", as.character(quantity), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
  }

  if (!missing(device_source_value)) {
    fields <- c(fields, "device_source_value")
    values <- c(values, if (is.null(device_source_value)) "NULL" else if (is(device_source_value, "subQuery")) paste0("(", as.character(device_source_value), ")") else paste0("'", as.character(device_source_value), "'"))
  }

  if (!missing(device_source_concept_id)) {
    fields <- c(fields, "device_source_concept_id")
    values <- c(values, if (is.null(device_source_concept_id)) "NULL" else if (is(device_source_concept_id, "subQuery")) paste0("(", as.character(device_source_concept_id), ")") else paste0("'", as.character(device_source_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "device_exposure", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_measurement <- function(measurement_id, person_id, measurement_concept_id, measurement_date, measurement_datetime, measurement_time, measurement_type_concept_id, operator_concept_id, value_as_number, value_as_concept_id, unit_concept_id, range_low, range_high, provider_id, visit_occurrence_id, visit_detail_id, measurement_source_value, measurement_source_concept_id, unit_source_value, value_source_value) {
  fields <- c()
  values <- c()
  if (!missing(measurement_id)) {
    fields <- c(fields, "measurement_id")
    values <- c(values, if (is.null(measurement_id)) "NULL" else if (is(measurement_id, "subQuery")) paste0("(", as.character(measurement_id), ")") else paste0("'", as.character(measurement_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(measurement_concept_id)) {
    fields <- c(fields, "measurement_concept_id")
    values <- c(values, if (is.null(measurement_concept_id)) "NULL" else if (is(measurement_concept_id, "subQuery")) paste0("(", as.character(measurement_concept_id), ")") else paste0("'", as.character(measurement_concept_id), "'"))
  }

  if (!missing(measurement_date)) {
    fields <- c(fields, "measurement_date")
    values <- c(values, if (is.null(measurement_date)) "NULL" else if (is(measurement_date, "subQuery")) paste0("(", as.character(measurement_date), ")") else paste0("'", as.character(measurement_date), "'"))
  }

  if (!missing(measurement_datetime)) {
    fields <- c(fields, "measurement_datetime")
    values <- c(values, if (is.null(measurement_datetime)) "NULL" else if (is(measurement_datetime, "subQuery")) paste0("(", as.character(measurement_datetime), ")") else paste0("'", as.character(measurement_datetime), "'"))
  }

  if (!missing(measurement_time)) {
    fields <- c(fields, "measurement_time")
    values <- c(values, if (is.null(measurement_time)) "NULL" else if (is(measurement_time, "subQuery")) paste0("(", as.character(measurement_time), ")") else paste0("'", as.character(measurement_time), "'"))
  }

  if (!missing(measurement_type_concept_id)) {
    fields <- c(fields, "measurement_type_concept_id")
    values <- c(values, if (is.null(measurement_type_concept_id)) "NULL" else if (is(measurement_type_concept_id, "subQuery")) paste0("(", as.character(measurement_type_concept_id), ")") else paste0("'", as.character(measurement_type_concept_id), "'"))
  }

  if (!missing(operator_concept_id)) {
    fields <- c(fields, "operator_concept_id")
    values <- c(values, if (is.null(operator_concept_id)) "NULL" else if (is(operator_concept_id, "subQuery")) paste0("(", as.character(operator_concept_id), ")") else paste0("'", as.character(operator_concept_id), "'"))
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) "NULL" else if (is(value_as_number, "subQuery")) paste0("(", as.character(value_as_number), ")") else paste0("'", as.character(value_as_number), "'"))
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) "NULL" else if (is(value_as_concept_id, "subQuery")) paste0("(", as.character(value_as_concept_id), ")") else paste0("'", as.character(value_as_concept_id), "'"))
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) "NULL" else if (is(unit_concept_id, "subQuery")) paste0("(", as.character(unit_concept_id), ")") else paste0("'", as.character(unit_concept_id), "'"))
  }

  if (!missing(range_low)) {
    fields <- c(fields, "range_low")
    values <- c(values, if (is.null(range_low)) "NULL" else if (is(range_low, "subQuery")) paste0("(", as.character(range_low), ")") else paste0("'", as.character(range_low), "'"))
  }

  if (!missing(range_high)) {
    fields <- c(fields, "range_high")
    values <- c(values, if (is.null(range_high)) "NULL" else if (is(range_high, "subQuery")) paste0("(", as.character(range_high), ")") else paste0("'", as.character(range_high), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
  }

  if (!missing(measurement_source_value)) {
    fields <- c(fields, "measurement_source_value")
    values <- c(values, if (is.null(measurement_source_value)) "NULL" else if (is(measurement_source_value, "subQuery")) paste0("(", as.character(measurement_source_value), ")") else paste0("'", as.character(measurement_source_value), "'"))
  }

  if (!missing(measurement_source_concept_id)) {
    fields <- c(fields, "measurement_source_concept_id")
    values <- c(values, if (is.null(measurement_source_concept_id)) "NULL" else if (is(measurement_source_concept_id, "subQuery")) paste0("(", as.character(measurement_source_concept_id), ")") else paste0("'", as.character(measurement_source_concept_id), "'"))
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) "NULL" else if (is(unit_source_value, "subQuery")) paste0("(", as.character(unit_source_value), ")") else paste0("'", as.character(unit_source_value), "'"))
  }

  if (!missing(value_source_value)) {
    fields <- c(fields, "value_source_value")
    values <- c(values, if (is.null(value_source_value)) "NULL" else if (is(value_source_value, "subQuery")) paste0("(", as.character(value_source_value), ")") else paste0("'", as.character(value_source_value), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "measurement", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_observation <- function(observation_id, person_id, observation_concept_id, observation_date, observation_datetime, observation_type_concept_id, value_as_number, value_as_string, value_as_concept_id, qualifier_concept_id, unit_concept_id, provider_id, visit_occurrence_id, visit_detail_id, observation_source_value, observation_source_concept_id, unit_source_value, qualifier_source_value, observation_event_id, obs_event_field_concept_id, value_as_datetime) {
  fields <- c()
  values <- c()
  if (!missing(observation_id)) {
    fields <- c(fields, "observation_id")
    values <- c(values, if (is.null(observation_id)) "NULL" else if (is(observation_id, "subQuery")) paste0("(", as.character(observation_id), ")") else paste0("'", as.character(observation_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(observation_concept_id)) {
    fields <- c(fields, "observation_concept_id")
    values <- c(values, if (is.null(observation_concept_id)) "NULL" else if (is(observation_concept_id, "subQuery")) paste0("(", as.character(observation_concept_id), ")") else paste0("'", as.character(observation_concept_id), "'"))
  }

  if (!missing(observation_date)) {
    fields <- c(fields, "observation_date")
    values <- c(values, if (is.null(observation_date)) "NULL" else if (is(observation_date, "subQuery")) paste0("(", as.character(observation_date), ")") else paste0("'", as.character(observation_date), "'"))
  }

  if (!missing(observation_datetime)) {
    fields <- c(fields, "observation_datetime")
    values <- c(values, if (is.null(observation_datetime)) "NULL" else if (is(observation_datetime, "subQuery")) paste0("(", as.character(observation_datetime), ")") else paste0("'", as.character(observation_datetime), "'"))
  }

  if (!missing(observation_type_concept_id)) {
    fields <- c(fields, "observation_type_concept_id")
    values <- c(values, if (is.null(observation_type_concept_id)) "NULL" else if (is(observation_type_concept_id, "subQuery")) paste0("(", as.character(observation_type_concept_id), ")") else paste0("'", as.character(observation_type_concept_id), "'"))
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) "NULL" else if (is(value_as_number, "subQuery")) paste0("(", as.character(value_as_number), ")") else paste0("'", as.character(value_as_number), "'"))
  }

  if (!missing(value_as_string)) {
    fields <- c(fields, "value_as_string")
    values <- c(values, if (is.null(value_as_string)) "NULL" else if (is(value_as_string, "subQuery")) paste0("(", as.character(value_as_string), ")") else paste0("'", as.character(value_as_string), "'"))
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) "NULL" else if (is(value_as_concept_id, "subQuery")) paste0("(", as.character(value_as_concept_id), ")") else paste0("'", as.character(value_as_concept_id), "'"))
  }

  if (!missing(qualifier_concept_id)) {
    fields <- c(fields, "qualifier_concept_id")
    values <- c(values, if (is.null(qualifier_concept_id)) "NULL" else if (is(qualifier_concept_id, "subQuery")) paste0("(", as.character(qualifier_concept_id), ")") else paste0("'", as.character(qualifier_concept_id), "'"))
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) "NULL" else if (is(unit_concept_id, "subQuery")) paste0("(", as.character(unit_concept_id), ")") else paste0("'", as.character(unit_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
  }

  if (!missing(observation_source_value)) {
    fields <- c(fields, "observation_source_value")
    values <- c(values, if (is.null(observation_source_value)) "NULL" else if (is(observation_source_value, "subQuery")) paste0("(", as.character(observation_source_value), ")") else paste0("'", as.character(observation_source_value), "'"))
  }

  if (!missing(observation_source_concept_id)) {
    fields <- c(fields, "observation_source_concept_id")
    values <- c(values, if (is.null(observation_source_concept_id)) "NULL" else if (is(observation_source_concept_id, "subQuery")) paste0("(", as.character(observation_source_concept_id), ")") else paste0("'", as.character(observation_source_concept_id), "'"))
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) "NULL" else if (is(unit_source_value, "subQuery")) paste0("(", as.character(unit_source_value), ")") else paste0("'", as.character(unit_source_value), "'"))
  }

  if (!missing(qualifier_source_value)) {
    fields <- c(fields, "qualifier_source_value")
    values <- c(values, if (is.null(qualifier_source_value)) "NULL" else if (is(qualifier_source_value, "subQuery")) paste0("(", as.character(qualifier_source_value), ")") else paste0("'", as.character(qualifier_source_value), "'"))
  }

  if (!missing(observation_event_id)) {
    fields <- c(fields, "observation_event_id")
    values <- c(values, if (is.null(observation_event_id)) "NULL" else if (is(observation_event_id, "subQuery")) paste0("(", as.character(observation_event_id), ")") else paste0("'", as.character(observation_event_id), "'"))
  }

  if (!missing(obs_event_field_concept_id)) {
    fields <- c(fields, "obs_event_field_concept_id")
    values <- c(values, if (is.null(obs_event_field_concept_id)) "NULL" else if (is(obs_event_field_concept_id, "subQuery")) paste0("(", as.character(obs_event_field_concept_id), ")") else paste0("'", as.character(obs_event_field_concept_id), "'"))
  }

  if (!missing(value_as_datetime)) {
    fields <- c(fields, "value_as_datetime")
    values <- c(values, if (is.null(value_as_datetime)) "NULL" else if (is(value_as_datetime, "subQuery")) paste0("(", as.character(value_as_datetime), ")") else paste0("'", as.character(value_as_datetime), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "observation", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_specimen <- function(specimen_id, person_id, specimen_concept_id, specimen_type_concept_id, specimen_date, specimen_datetime, quantity, unit_concept_id, anatomic_site_concept_id, disease_status_concept_id, specimen_source_id, specimen_source_value, unit_source_value, anatomic_site_source_value, disease_status_source_value) {
  fields <- c()
  values <- c()
  if (!missing(specimen_id)) {
    fields <- c(fields, "specimen_id")
    values <- c(values, if (is.null(specimen_id)) "NULL" else if (is(specimen_id, "subQuery")) paste0("(", as.character(specimen_id), ")") else paste0("'", as.character(specimen_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(specimen_concept_id)) {
    fields <- c(fields, "specimen_concept_id")
    values <- c(values, if (is.null(specimen_concept_id)) "NULL" else if (is(specimen_concept_id, "subQuery")) paste0("(", as.character(specimen_concept_id), ")") else paste0("'", as.character(specimen_concept_id), "'"))
  }

  if (!missing(specimen_type_concept_id)) {
    fields <- c(fields, "specimen_type_concept_id")
    values <- c(values, if (is.null(specimen_type_concept_id)) "NULL" else if (is(specimen_type_concept_id, "subQuery")) paste0("(", as.character(specimen_type_concept_id), ")") else paste0("'", as.character(specimen_type_concept_id), "'"))
  }

  if (!missing(specimen_date)) {
    fields <- c(fields, "specimen_date")
    values <- c(values, if (is.null(specimen_date)) "NULL" else if (is(specimen_date, "subQuery")) paste0("(", as.character(specimen_date), ")") else paste0("'", as.character(specimen_date), "'"))
  }

  if (!missing(specimen_datetime)) {
    fields <- c(fields, "specimen_datetime")
    values <- c(values, if (is.null(specimen_datetime)) "NULL" else if (is(specimen_datetime, "subQuery")) paste0("(", as.character(specimen_datetime), ")") else paste0("'", as.character(specimen_datetime), "'"))
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) "NULL" else if (is(quantity, "subQuery")) paste0("(", as.character(quantity), ")") else paste0("'", as.character(quantity), "'"))
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) "NULL" else if (is(unit_concept_id, "subQuery")) paste0("(", as.character(unit_concept_id), ")") else paste0("'", as.character(unit_concept_id), "'"))
  }

  if (!missing(anatomic_site_concept_id)) {
    fields <- c(fields, "anatomic_site_concept_id")
    values <- c(values, if (is.null(anatomic_site_concept_id)) "NULL" else if (is(anatomic_site_concept_id, "subQuery")) paste0("(", as.character(anatomic_site_concept_id), ")") else paste0("'", as.character(anatomic_site_concept_id), "'"))
  }

  if (!missing(disease_status_concept_id)) {
    fields <- c(fields, "disease_status_concept_id")
    values <- c(values, if (is.null(disease_status_concept_id)) "NULL" else if (is(disease_status_concept_id, "subQuery")) paste0("(", as.character(disease_status_concept_id), ")") else paste0("'", as.character(disease_status_concept_id), "'"))
  }

  if (!missing(specimen_source_id)) {
    fields <- c(fields, "specimen_source_id")
    values <- c(values, if (is.null(specimen_source_id)) "NULL" else if (is(specimen_source_id, "subQuery")) paste0("(", as.character(specimen_source_id), ")") else paste0("'", as.character(specimen_source_id), "'"))
  }

  if (!missing(specimen_source_value)) {
    fields <- c(fields, "specimen_source_value")
    values <- c(values, if (is.null(specimen_source_value)) "NULL" else if (is(specimen_source_value, "subQuery")) paste0("(", as.character(specimen_source_value), ")") else paste0("'", as.character(specimen_source_value), "'"))
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) "NULL" else if (is(unit_source_value, "subQuery")) paste0("(", as.character(unit_source_value), ")") else paste0("'", as.character(unit_source_value), "'"))
  }

  if (!missing(anatomic_site_source_value)) {
    fields <- c(fields, "anatomic_site_source_value")
    values <- c(values, if (is.null(anatomic_site_source_value)) "NULL" else if (is(anatomic_site_source_value, "subQuery")) paste0("(", as.character(anatomic_site_source_value), ")") else paste0("'", as.character(anatomic_site_source_value), "'"))
  }

  if (!missing(disease_status_source_value)) {
    fields <- c(fields, "disease_status_source_value")
    values <- c(values, if (is.null(disease_status_source_value)) "NULL" else if (is(disease_status_source_value, "subQuery")) paste0("(", as.character(disease_status_source_value), ")") else paste0("'", as.character(disease_status_source_value), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "specimen", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_note <- function(note_id, person_id, note_event_id, note_event_field_concept_id, note_date, note_datetime, note_type_concept_id, note_class_concept_id, note_title, note_text, encoding_concept_id, language_concept_id, provider_id, visit_occurrence_id, visit_detail_id, note_source_value) {
  fields <- c()
  values <- c()
  if (!missing(note_id)) {
    fields <- c(fields, "note_id")
    values <- c(values, if (is.null(note_id)) "NULL" else if (is(note_id, "subQuery")) paste0("(", as.character(note_id), ")") else paste0("'", as.character(note_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(note_event_id)) {
    fields <- c(fields, "note_event_id")
    values <- c(values, if (is.null(note_event_id)) "NULL" else if (is(note_event_id, "subQuery")) paste0("(", as.character(note_event_id), ")") else paste0("'", as.character(note_event_id), "'"))
  }

  if (!missing(note_event_field_concept_id)) {
    fields <- c(fields, "note_event_field_concept_id")
    values <- c(values, if (is.null(note_event_field_concept_id)) "NULL" else if (is(note_event_field_concept_id, "subQuery")) paste0("(", as.character(note_event_field_concept_id), ")") else paste0("'", as.character(note_event_field_concept_id), "'"))
  }

  if (!missing(note_date)) {
    fields <- c(fields, "note_date")
    values <- c(values, if (is.null(note_date)) "NULL" else if (is(note_date, "subQuery")) paste0("(", as.character(note_date), ")") else paste0("'", as.character(note_date), "'"))
  }

  if (!missing(note_datetime)) {
    fields <- c(fields, "note_datetime")
    values <- c(values, if (is.null(note_datetime)) "NULL" else if (is(note_datetime, "subQuery")) paste0("(", as.character(note_datetime), ")") else paste0("'", as.character(note_datetime), "'"))
  }

  if (!missing(note_type_concept_id)) {
    fields <- c(fields, "note_type_concept_id")
    values <- c(values, if (is.null(note_type_concept_id)) "NULL" else if (is(note_type_concept_id, "subQuery")) paste0("(", as.character(note_type_concept_id), ")") else paste0("'", as.character(note_type_concept_id), "'"))
  }

  if (!missing(note_class_concept_id)) {
    fields <- c(fields, "note_class_concept_id")
    values <- c(values, if (is.null(note_class_concept_id)) "NULL" else if (is(note_class_concept_id, "subQuery")) paste0("(", as.character(note_class_concept_id), ")") else paste0("'", as.character(note_class_concept_id), "'"))
  }

  if (!missing(note_title)) {
    fields <- c(fields, "note_title")
    values <- c(values, if (is.null(note_title)) "NULL" else if (is(note_title, "subQuery")) paste0("(", as.character(note_title), ")") else paste0("'", as.character(note_title), "'"))
  }

  if (!missing(note_text)) {
    fields <- c(fields, "note_text")
    values <- c(values, if (is.null(note_text)) "NULL" else if (is(note_text, "subQuery")) paste0("(", as.character(note_text), ")") else paste0("'", as.character(note_text), "'"))
  }

  if (!missing(encoding_concept_id)) {
    fields <- c(fields, "encoding_concept_id")
    values <- c(values, if (is.null(encoding_concept_id)) "NULL" else if (is(encoding_concept_id, "subQuery")) paste0("(", as.character(encoding_concept_id), ")") else paste0("'", as.character(encoding_concept_id), "'"))
  }

  if (!missing(language_concept_id)) {
    fields <- c(fields, "language_concept_id")
    values <- c(values, if (is.null(language_concept_id)) "NULL" else if (is(language_concept_id, "subQuery")) paste0("(", as.character(language_concept_id), ")") else paste0("'", as.character(language_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
  }

  if (!missing(note_source_value)) {
    fields <- c(fields, "note_source_value")
    values <- c(values, if (is.null(note_source_value)) "NULL" else if (is(note_source_value, "subQuery")) paste0("(", as.character(note_source_value), ")") else paste0("'", as.character(note_source_value), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "note", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_note_nlp <- function(note_nlp_id, note_id, section_concept_id, snippet, offset, lexical_variant, note_nlp_concept_id, note_nlp_source_concept_id, nlp_system, nlp_date, nlp_datetime, term_exists, term_temporal, term_modifiers) {
  fields <- c()
  values <- c()
  if (!missing(note_nlp_id)) {
    fields <- c(fields, "note_nlp_id")
    values <- c(values, if (is.null(note_nlp_id)) "NULL" else if (is(note_nlp_id, "subQuery")) paste0("(", as.character(note_nlp_id), ")") else paste0("'", as.character(note_nlp_id), "'"))
  }

  if (!missing(note_id)) {
    fields <- c(fields, "note_id")
    values <- c(values, if (is.null(note_id)) "NULL" else if (is(note_id, "subQuery")) paste0("(", as.character(note_id), ")") else paste0("'", as.character(note_id), "'"))
  }

  if (!missing(section_concept_id)) {
    fields <- c(fields, "section_concept_id")
    values <- c(values, if (is.null(section_concept_id)) "NULL" else if (is(section_concept_id, "subQuery")) paste0("(", as.character(section_concept_id), ")") else paste0("'", as.character(section_concept_id), "'"))
  }

  if (!missing(snippet)) {
    fields <- c(fields, "snippet")
    values <- c(values, if (is.null(snippet)) "NULL" else if (is(snippet, "subQuery")) paste0("(", as.character(snippet), ")") else paste0("'", as.character(snippet), "'"))
  }

  if (!missing(offset)) {
    fields <- c(fields, "offset")
    values <- c(values, if (is.null(offset)) "NULL" else if (is(offset, "subQuery")) paste0("(", as.character(offset), ")") else paste0("'", as.character(offset), "'"))
  }

  if (!missing(lexical_variant)) {
    fields <- c(fields, "lexical_variant")
    values <- c(values, if (is.null(lexical_variant)) "NULL" else if (is(lexical_variant, "subQuery")) paste0("(", as.character(lexical_variant), ")") else paste0("'", as.character(lexical_variant), "'"))
  }

  if (!missing(note_nlp_concept_id)) {
    fields <- c(fields, "note_nlp_concept_id")
    values <- c(values, if (is.null(note_nlp_concept_id)) "NULL" else if (is(note_nlp_concept_id, "subQuery")) paste0("(", as.character(note_nlp_concept_id), ")") else paste0("'", as.character(note_nlp_concept_id), "'"))
  }

  if (!missing(note_nlp_source_concept_id)) {
    fields <- c(fields, "note_nlp_source_concept_id")
    values <- c(values, if (is.null(note_nlp_source_concept_id)) "NULL" else if (is(note_nlp_source_concept_id, "subQuery")) paste0("(", as.character(note_nlp_source_concept_id), ")") else paste0("'", as.character(note_nlp_source_concept_id), "'"))
  }

  if (!missing(nlp_system)) {
    fields <- c(fields, "nlp_system")
    values <- c(values, if (is.null(nlp_system)) "NULL" else if (is(nlp_system, "subQuery")) paste0("(", as.character(nlp_system), ")") else paste0("'", as.character(nlp_system), "'"))
  }

  if (!missing(nlp_date)) {
    fields <- c(fields, "nlp_date")
    values <- c(values, if (is.null(nlp_date)) "NULL" else if (is(nlp_date, "subQuery")) paste0("(", as.character(nlp_date), ")") else paste0("'", as.character(nlp_date), "'"))
  }

  if (!missing(nlp_datetime)) {
    fields <- c(fields, "nlp_datetime")
    values <- c(values, if (is.null(nlp_datetime)) "NULL" else if (is(nlp_datetime, "subQuery")) paste0("(", as.character(nlp_datetime), ")") else paste0("'", as.character(nlp_datetime), "'"))
  }

  if (!missing(term_exists)) {
    fields <- c(fields, "term_exists")
    values <- c(values, if (is.null(term_exists)) "NULL" else if (is(term_exists, "subQuery")) paste0("(", as.character(term_exists), ")") else paste0("'", as.character(term_exists), "'"))
  }

  if (!missing(term_temporal)) {
    fields <- c(fields, "term_temporal")
    values <- c(values, if (is.null(term_temporal)) "NULL" else if (is(term_temporal, "subQuery")) paste0("(", as.character(term_temporal), ")") else paste0("'", as.character(term_temporal), "'"))
  }

  if (!missing(term_modifiers)) {
    fields <- c(fields, "term_modifiers")
    values <- c(values, if (is.null(term_modifiers)) "NULL" else if (is(term_modifiers, "subQuery")) paste0("(", as.character(term_modifiers), ")") else paste0("'", as.character(term_modifiers), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "note_nlp", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_survey_conduct <- function(survey_conduct_id, person_id, survey_concept_id, survey_start_date, survey_start_datetime, survey_end_date, survey_end_datetime, provider_id, assisted_concept_id, respondent_type_concept_id, timing_concept_id, collection_method_concept_id, assisted_source_value, respondent_type_source_value, timing_source_value, collection_method_source_value, survey_source_value, survey_source_concept_id, survey_source_identifier, validated_survey_concept_id, validated_survey_source_value, survey_version_number, visit_occurrence_id, response_visit_occurrence_id) {
  fields <- c()
  values <- c()
  if (!missing(survey_conduct_id)) {
    fields <- c(fields, "survey_conduct_id")
    values <- c(values, if (is.null(survey_conduct_id)) "NULL" else if (is(survey_conduct_id, "subQuery")) paste0("(", as.character(survey_conduct_id), ")") else paste0("'", as.character(survey_conduct_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(survey_concept_id)) {
    fields <- c(fields, "survey_concept_id")
    values <- c(values, if (is.null(survey_concept_id)) "NULL" else if (is(survey_concept_id, "subQuery")) paste0("(", as.character(survey_concept_id), ")") else paste0("'", as.character(survey_concept_id), "'"))
  }

  if (!missing(survey_start_date)) {
    fields <- c(fields, "survey_start_date")
    values <- c(values, if (is.null(survey_start_date)) "NULL" else if (is(survey_start_date, "subQuery")) paste0("(", as.character(survey_start_date), ")") else paste0("'", as.character(survey_start_date), "'"))
  }

  if (!missing(survey_start_datetime)) {
    fields <- c(fields, "survey_start_datetime")
    values <- c(values, if (is.null(survey_start_datetime)) "NULL" else if (is(survey_start_datetime, "subQuery")) paste0("(", as.character(survey_start_datetime), ")") else paste0("'", as.character(survey_start_datetime), "'"))
  }

  if (!missing(survey_end_date)) {
    fields <- c(fields, "survey_end_date")
    values <- c(values, if (is.null(survey_end_date)) "NULL" else if (is(survey_end_date, "subQuery")) paste0("(", as.character(survey_end_date), ")") else paste0("'", as.character(survey_end_date), "'"))
  }

  if (!missing(survey_end_datetime)) {
    fields <- c(fields, "survey_end_datetime")
    values <- c(values, if (is.null(survey_end_datetime)) "NULL" else if (is(survey_end_datetime, "subQuery")) paste0("(", as.character(survey_end_datetime), ")") else paste0("'", as.character(survey_end_datetime), "'"))
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(assisted_concept_id)) {
    fields <- c(fields, "assisted_concept_id")
    values <- c(values, if (is.null(assisted_concept_id)) "NULL" else if (is(assisted_concept_id, "subQuery")) paste0("(", as.character(assisted_concept_id), ")") else paste0("'", as.character(assisted_concept_id), "'"))
  }

  if (!missing(respondent_type_concept_id)) {
    fields <- c(fields, "respondent_type_concept_id")
    values <- c(values, if (is.null(respondent_type_concept_id)) "NULL" else if (is(respondent_type_concept_id, "subQuery")) paste0("(", as.character(respondent_type_concept_id), ")") else paste0("'", as.character(respondent_type_concept_id), "'"))
  }

  if (!missing(timing_concept_id)) {
    fields <- c(fields, "timing_concept_id")
    values <- c(values, if (is.null(timing_concept_id)) "NULL" else if (is(timing_concept_id, "subQuery")) paste0("(", as.character(timing_concept_id), ")") else paste0("'", as.character(timing_concept_id), "'"))
  }

  if (!missing(collection_method_concept_id)) {
    fields <- c(fields, "collection_method_concept_id")
    values <- c(values, if (is.null(collection_method_concept_id)) "NULL" else if (is(collection_method_concept_id, "subQuery")) paste0("(", as.character(collection_method_concept_id), ")") else paste0("'", as.character(collection_method_concept_id), "'"))
  }

  if (!missing(assisted_source_value)) {
    fields <- c(fields, "assisted_source_value")
    values <- c(values, if (is.null(assisted_source_value)) "NULL" else if (is(assisted_source_value, "subQuery")) paste0("(", as.character(assisted_source_value), ")") else paste0("'", as.character(assisted_source_value), "'"))
  }

  if (!missing(respondent_type_source_value)) {
    fields <- c(fields, "respondent_type_source_value")
    values <- c(values, if (is.null(respondent_type_source_value)) "NULL" else if (is(respondent_type_source_value, "subQuery")) paste0("(", as.character(respondent_type_source_value), ")") else paste0("'", as.character(respondent_type_source_value), "'"))
  }

  if (!missing(timing_source_value)) {
    fields <- c(fields, "timing_source_value")
    values <- c(values, if (is.null(timing_source_value)) "NULL" else if (is(timing_source_value, "subQuery")) paste0("(", as.character(timing_source_value), ")") else paste0("'", as.character(timing_source_value), "'"))
  }

  if (!missing(collection_method_source_value)) {
    fields <- c(fields, "collection_method_source_value")
    values <- c(values, if (is.null(collection_method_source_value)) "NULL" else if (is(collection_method_source_value, "subQuery")) paste0("(", as.character(collection_method_source_value), ")") else paste0("'", as.character(collection_method_source_value), "'"))
  }

  if (!missing(survey_source_value)) {
    fields <- c(fields, "survey_source_value")
    values <- c(values, if (is.null(survey_source_value)) "NULL" else if (is(survey_source_value, "subQuery")) paste0("(", as.character(survey_source_value), ")") else paste0("'", as.character(survey_source_value), "'"))
  }

  if (!missing(survey_source_concept_id)) {
    fields <- c(fields, "survey_source_concept_id")
    values <- c(values, if (is.null(survey_source_concept_id)) "NULL" else if (is(survey_source_concept_id, "subQuery")) paste0("(", as.character(survey_source_concept_id), ")") else paste0("'", as.character(survey_source_concept_id), "'"))
  }

  if (!missing(survey_source_identifier)) {
    fields <- c(fields, "survey_source_identifier")
    values <- c(values, if (is.null(survey_source_identifier)) "NULL" else if (is(survey_source_identifier, "subQuery")) paste0("(", as.character(survey_source_identifier), ")") else paste0("'", as.character(survey_source_identifier), "'"))
  }

  if (!missing(validated_survey_concept_id)) {
    fields <- c(fields, "validated_survey_concept_id")
    values <- c(values, if (is.null(validated_survey_concept_id)) "NULL" else if (is(validated_survey_concept_id, "subQuery")) paste0("(", as.character(validated_survey_concept_id), ")") else paste0("'", as.character(validated_survey_concept_id), "'"))
  }

  if (!missing(validated_survey_source_value)) {
    fields <- c(fields, "validated_survey_source_value")
    values <- c(values, if (is.null(validated_survey_source_value)) "NULL" else if (is(validated_survey_source_value, "subQuery")) paste0("(", as.character(validated_survey_source_value), ")") else paste0("'", as.character(validated_survey_source_value), "'"))
  }

  if (!missing(survey_version_number)) {
    fields <- c(fields, "survey_version_number")
    values <- c(values, if (is.null(survey_version_number)) "NULL" else if (is(survey_version_number, "subQuery")) paste0("(", as.character(survey_version_number), ")") else paste0("'", as.character(survey_version_number), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(response_visit_occurrence_id)) {
    fields <- c(fields, "response_visit_occurrence_id")
    values <- c(values, if (is.null(response_visit_occurrence_id)) "NULL" else if (is(response_visit_occurrence_id, "subQuery")) paste0("(", as.character(response_visit_occurrence_id), ")") else paste0("'", as.character(response_visit_occurrence_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "survey_conduct", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_cost <- function(cost_id, person_id, cost_event_id, cost_event_field_concept_id, cost_concept_id, cost_type_concept_id, cost_source_concept_id, cost_source_value, currency_concept_id, cost, incurred_date, billed_date, paid_date, revenue_code_concept_id, drg_concept_id, revenue_code_source_value, drg_source_value, payer_plan_period_id) {
  fields <- c()
  values <- c()
  if (!missing(cost_id)) {
    fields <- c(fields, "cost_id")
    values <- c(values, if (is.null(cost_id)) "NULL" else if (is(cost_id, "subQuery")) paste0("(", as.character(cost_id), ")") else paste0("'", as.character(cost_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(cost_event_id)) {
    fields <- c(fields, "cost_event_id")
    values <- c(values, if (is.null(cost_event_id)) "NULL" else if (is(cost_event_id, "subQuery")) paste0("(", as.character(cost_event_id), ")") else paste0("'", as.character(cost_event_id), "'"))
  }

  if (!missing(cost_event_field_concept_id)) {
    fields <- c(fields, "cost_event_field_concept_id")
    values <- c(values, if (is.null(cost_event_field_concept_id)) "NULL" else if (is(cost_event_field_concept_id, "subQuery")) paste0("(", as.character(cost_event_field_concept_id), ")") else paste0("'", as.character(cost_event_field_concept_id), "'"))
  }

  if (!missing(cost_concept_id)) {
    fields <- c(fields, "cost_concept_id")
    values <- c(values, if (is.null(cost_concept_id)) "NULL" else if (is(cost_concept_id, "subQuery")) paste0("(", as.character(cost_concept_id), ")") else paste0("'", as.character(cost_concept_id), "'"))
  }

  if (!missing(cost_type_concept_id)) {
    fields <- c(fields, "cost_type_concept_id")
    values <- c(values, if (is.null(cost_type_concept_id)) "NULL" else if (is(cost_type_concept_id, "subQuery")) paste0("(", as.character(cost_type_concept_id), ")") else paste0("'", as.character(cost_type_concept_id), "'"))
  }

  if (!missing(cost_source_concept_id)) {
    fields <- c(fields, "cost_source_concept_id")
    values <- c(values, if (is.null(cost_source_concept_id)) "NULL" else if (is(cost_source_concept_id, "subQuery")) paste0("(", as.character(cost_source_concept_id), ")") else paste0("'", as.character(cost_source_concept_id), "'"))
  }

  if (!missing(cost_source_value)) {
    fields <- c(fields, "cost_source_value")
    values <- c(values, if (is.null(cost_source_value)) "NULL" else if (is(cost_source_value, "subQuery")) paste0("(", as.character(cost_source_value), ")") else paste0("'", as.character(cost_source_value), "'"))
  }

  if (!missing(currency_concept_id)) {
    fields <- c(fields, "currency_concept_id")
    values <- c(values, if (is.null(currency_concept_id)) "NULL" else if (is(currency_concept_id, "subQuery")) paste0("(", as.character(currency_concept_id), ")") else paste0("'", as.character(currency_concept_id), "'"))
  }

  if (!missing(cost)) {
    fields <- c(fields, "cost")
    values <- c(values, if (is.null(cost)) "NULL" else if (is(cost, "subQuery")) paste0("(", as.character(cost), ")") else paste0("'", as.character(cost), "'"))
  }

  if (!missing(incurred_date)) {
    fields <- c(fields, "incurred_date")
    values <- c(values, if (is.null(incurred_date)) "NULL" else if (is(incurred_date, "subQuery")) paste0("(", as.character(incurred_date), ")") else paste0("'", as.character(incurred_date), "'"))
  }

  if (!missing(billed_date)) {
    fields <- c(fields, "billed_date")
    values <- c(values, if (is.null(billed_date)) "NULL" else if (is(billed_date, "subQuery")) paste0("(", as.character(billed_date), ")") else paste0("'", as.character(billed_date), "'"))
  }

  if (!missing(paid_date)) {
    fields <- c(fields, "paid_date")
    values <- c(values, if (is.null(paid_date)) "NULL" else if (is(paid_date, "subQuery")) paste0("(", as.character(paid_date), ")") else paste0("'", as.character(paid_date), "'"))
  }

  if (!missing(revenue_code_concept_id)) {
    fields <- c(fields, "revenue_code_concept_id")
    values <- c(values, if (is.null(revenue_code_concept_id)) "NULL" else if (is(revenue_code_concept_id, "subQuery")) paste0("(", as.character(revenue_code_concept_id), ")") else paste0("'", as.character(revenue_code_concept_id), "'"))
  }

  if (!missing(drg_concept_id)) {
    fields <- c(fields, "drg_concept_id")
    values <- c(values, if (is.null(drg_concept_id)) "NULL" else if (is(drg_concept_id, "subQuery")) paste0("(", as.character(drg_concept_id), ")") else paste0("'", as.character(drg_concept_id), "'"))
  }

  if (!missing(revenue_code_source_value)) {
    fields <- c(fields, "revenue_code_source_value")
    values <- c(values, if (is.null(revenue_code_source_value)) "NULL" else if (is(revenue_code_source_value, "subQuery")) paste0("(", as.character(revenue_code_source_value), ")") else paste0("'", as.character(revenue_code_source_value), "'"))
  }

  if (!missing(drg_source_value)) {
    fields <- c(fields, "drg_source_value")
    values <- c(values, if (is.null(drg_source_value)) "NULL" else if (is(drg_source_value, "subQuery")) paste0("(", as.character(drg_source_value), ")") else paste0("'", as.character(drg_source_value), "'"))
  }

  if (!missing(payer_plan_period_id)) {
    fields <- c(fields, "payer_plan_period_id")
    values <- c(values, if (is.null(payer_plan_period_id)) "NULL" else if (is(payer_plan_period_id, "subQuery")) paste0("(", as.character(payer_plan_period_id), ")") else paste0("'", as.character(payer_plan_period_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "cost", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_payer_plan_period <- function(payer_plan_period_id, person_id, contract_person_id, payer_plan_period_start_date, payer_plan_period_end_date, payer_concept_id, payer_source_value, payer_source_concept_id, plan_concept_id, plan_source_value, plan_source_concept_id, contract_concept_id, contract_source_value, contract_source_concept_id, sponsor_concept_id, sponsor_source_value, sponsor_source_concept_id, family_source_value, stop_reason_concept_id, stop_reason_source_value, stop_reason_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(payer_plan_period_id)) {
    fields <- c(fields, "payer_plan_period_id")
    values <- c(values, if (is.null(payer_plan_period_id)) "NULL" else if (is(payer_plan_period_id, "subQuery")) paste0("(", as.character(payer_plan_period_id), ")") else paste0("'", as.character(payer_plan_period_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(contract_person_id)) {
    fields <- c(fields, "contract_person_id")
    values <- c(values, if (is.null(contract_person_id)) "NULL" else if (is(contract_person_id, "subQuery")) paste0("(", as.character(contract_person_id), ")") else paste0("'", as.character(contract_person_id), "'"))
  }

  if (!missing(payer_plan_period_start_date)) {
    fields <- c(fields, "payer_plan_period_start_date")
    values <- c(values, if (is.null(payer_plan_period_start_date)) "NULL" else if (is(payer_plan_period_start_date, "subQuery")) paste0("(", as.character(payer_plan_period_start_date), ")") else paste0("'", as.character(payer_plan_period_start_date), "'"))
  }

  if (!missing(payer_plan_period_end_date)) {
    fields <- c(fields, "payer_plan_period_end_date")
    values <- c(values, if (is.null(payer_plan_period_end_date)) "NULL" else if (is(payer_plan_period_end_date, "subQuery")) paste0("(", as.character(payer_plan_period_end_date), ")") else paste0("'", as.character(payer_plan_period_end_date), "'"))
  }

  if (!missing(payer_concept_id)) {
    fields <- c(fields, "payer_concept_id")
    values <- c(values, if (is.null(payer_concept_id)) "NULL" else if (is(payer_concept_id, "subQuery")) paste0("(", as.character(payer_concept_id), ")") else paste0("'", as.character(payer_concept_id), "'"))
  }

  if (!missing(payer_source_value)) {
    fields <- c(fields, "payer_source_value")
    values <- c(values, if (is.null(payer_source_value)) "NULL" else if (is(payer_source_value, "subQuery")) paste0("(", as.character(payer_source_value), ")") else paste0("'", as.character(payer_source_value), "'"))
  }

  if (!missing(payer_source_concept_id)) {
    fields <- c(fields, "payer_source_concept_id")
    values <- c(values, if (is.null(payer_source_concept_id)) "NULL" else if (is(payer_source_concept_id, "subQuery")) paste0("(", as.character(payer_source_concept_id), ")") else paste0("'", as.character(payer_source_concept_id), "'"))
  }

  if (!missing(plan_concept_id)) {
    fields <- c(fields, "plan_concept_id")
    values <- c(values, if (is.null(plan_concept_id)) "NULL" else if (is(plan_concept_id, "subQuery")) paste0("(", as.character(plan_concept_id), ")") else paste0("'", as.character(plan_concept_id), "'"))
  }

  if (!missing(plan_source_value)) {
    fields <- c(fields, "plan_source_value")
    values <- c(values, if (is.null(plan_source_value)) "NULL" else if (is(plan_source_value, "subQuery")) paste0("(", as.character(plan_source_value), ")") else paste0("'", as.character(plan_source_value), "'"))
  }

  if (!missing(plan_source_concept_id)) {
    fields <- c(fields, "plan_source_concept_id")
    values <- c(values, if (is.null(plan_source_concept_id)) "NULL" else if (is(plan_source_concept_id, "subQuery")) paste0("(", as.character(plan_source_concept_id), ")") else paste0("'", as.character(plan_source_concept_id), "'"))
  }

  if (!missing(contract_concept_id)) {
    fields <- c(fields, "contract_concept_id")
    values <- c(values, if (is.null(contract_concept_id)) "NULL" else if (is(contract_concept_id, "subQuery")) paste0("(", as.character(contract_concept_id), ")") else paste0("'", as.character(contract_concept_id), "'"))
  }

  if (!missing(contract_source_value)) {
    fields <- c(fields, "contract_source_value")
    values <- c(values, if (is.null(contract_source_value)) "NULL" else if (is(contract_source_value, "subQuery")) paste0("(", as.character(contract_source_value), ")") else paste0("'", as.character(contract_source_value), "'"))
  }

  if (!missing(contract_source_concept_id)) {
    fields <- c(fields, "contract_source_concept_id")
    values <- c(values, if (is.null(contract_source_concept_id)) "NULL" else if (is(contract_source_concept_id, "subQuery")) paste0("(", as.character(contract_source_concept_id), ")") else paste0("'", as.character(contract_source_concept_id), "'"))
  }

  if (!missing(sponsor_concept_id)) {
    fields <- c(fields, "sponsor_concept_id")
    values <- c(values, if (is.null(sponsor_concept_id)) "NULL" else if (is(sponsor_concept_id, "subQuery")) paste0("(", as.character(sponsor_concept_id), ")") else paste0("'", as.character(sponsor_concept_id), "'"))
  }

  if (!missing(sponsor_source_value)) {
    fields <- c(fields, "sponsor_source_value")
    values <- c(values, if (is.null(sponsor_source_value)) "NULL" else if (is(sponsor_source_value, "subQuery")) paste0("(", as.character(sponsor_source_value), ")") else paste0("'", as.character(sponsor_source_value), "'"))
  }

  if (!missing(sponsor_source_concept_id)) {
    fields <- c(fields, "sponsor_source_concept_id")
    values <- c(values, if (is.null(sponsor_source_concept_id)) "NULL" else if (is(sponsor_source_concept_id, "subQuery")) paste0("(", as.character(sponsor_source_concept_id), ")") else paste0("'", as.character(sponsor_source_concept_id), "'"))
  }

  if (!missing(family_source_value)) {
    fields <- c(fields, "family_source_value")
    values <- c(values, if (is.null(family_source_value)) "NULL" else if (is(family_source_value, "subQuery")) paste0("(", as.character(family_source_value), ")") else paste0("'", as.character(family_source_value), "'"))
  }

  if (!missing(stop_reason_concept_id)) {
    fields <- c(fields, "stop_reason_concept_id")
    values <- c(values, if (is.null(stop_reason_concept_id)) "NULL" else if (is(stop_reason_concept_id, "subQuery")) paste0("(", as.character(stop_reason_concept_id), ")") else paste0("'", as.character(stop_reason_concept_id), "'"))
  }

  if (!missing(stop_reason_source_value)) {
    fields <- c(fields, "stop_reason_source_value")
    values <- c(values, if (is.null(stop_reason_source_value)) "NULL" else if (is(stop_reason_source_value, "subQuery")) paste0("(", as.character(stop_reason_source_value), ")") else paste0("'", as.character(stop_reason_source_value), "'"))
  }

  if (!missing(stop_reason_source_concept_id)) {
    fields <- c(fields, "stop_reason_source_concept_id")
    values <- c(values, if (is.null(stop_reason_source_concept_id)) "NULL" else if (is(stop_reason_source_concept_id, "subQuery")) paste0("(", as.character(stop_reason_source_concept_id), ")") else paste0("'", as.character(stop_reason_source_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "payer_plan_period", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_drug_era <- function(drug_era_id, person_id, drug_concept_id, drug_era_start_datetime, drug_era_end_datetime, drug_exposure_count, gap_days) {
  fields <- c()
  values <- c()
  if (!missing(drug_era_id)) {
    fields <- c(fields, "drug_era_id")
    values <- c(values, if (is.null(drug_era_id)) "NULL" else if (is(drug_era_id, "subQuery")) paste0("(", as.character(drug_era_id), ")") else paste0("'", as.character(drug_era_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) "NULL" else if (is(drug_concept_id, "subQuery")) paste0("(", as.character(drug_concept_id), ")") else paste0("'", as.character(drug_concept_id), "'"))
  }

  if (!missing(drug_era_start_datetime)) {
    fields <- c(fields, "drug_era_start_datetime")
    values <- c(values, if (is.null(drug_era_start_datetime)) "NULL" else if (is(drug_era_start_datetime, "subQuery")) paste0("(", as.character(drug_era_start_datetime), ")") else paste0("'", as.character(drug_era_start_datetime), "'"))
  }

  if (!missing(drug_era_end_datetime)) {
    fields <- c(fields, "drug_era_end_datetime")
    values <- c(values, if (is.null(drug_era_end_datetime)) "NULL" else if (is(drug_era_end_datetime, "subQuery")) paste0("(", as.character(drug_era_end_datetime), ")") else paste0("'", as.character(drug_era_end_datetime), "'"))
  }

  if (!missing(drug_exposure_count)) {
    fields <- c(fields, "drug_exposure_count")
    values <- c(values, if (is.null(drug_exposure_count)) "NULL" else if (is(drug_exposure_count, "subQuery")) paste0("(", as.character(drug_exposure_count), ")") else paste0("'", as.character(drug_exposure_count), "'"))
  }

  if (!missing(gap_days)) {
    fields <- c(fields, "gap_days")
    values <- c(values, if (is.null(gap_days)) "NULL" else if (is(gap_days, "subQuery")) paste0("(", as.character(gap_days), ")") else paste0("'", as.character(gap_days), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "drug_era", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_dose_era <- function(dose_era_id, person_id, drug_concept_id, unit_concept_id, dose_value, dose_era_start_datetime, dose_era_end_datetime) {
  fields <- c()
  values <- c()
  if (!missing(dose_era_id)) {
    fields <- c(fields, "dose_era_id")
    values <- c(values, if (is.null(dose_era_id)) "NULL" else if (is(dose_era_id, "subQuery")) paste0("(", as.character(dose_era_id), ")") else paste0("'", as.character(dose_era_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) "NULL" else if (is(drug_concept_id, "subQuery")) paste0("(", as.character(drug_concept_id), ")") else paste0("'", as.character(drug_concept_id), "'"))
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) "NULL" else if (is(unit_concept_id, "subQuery")) paste0("(", as.character(unit_concept_id), ")") else paste0("'", as.character(unit_concept_id), "'"))
  }

  if (!missing(dose_value)) {
    fields <- c(fields, "dose_value")
    values <- c(values, if (is.null(dose_value)) "NULL" else if (is(dose_value, "subQuery")) paste0("(", as.character(dose_value), ")") else paste0("'", as.character(dose_value), "'"))
  }

  if (!missing(dose_era_start_datetime)) {
    fields <- c(fields, "dose_era_start_datetime")
    values <- c(values, if (is.null(dose_era_start_datetime)) "NULL" else if (is(dose_era_start_datetime, "subQuery")) paste0("(", as.character(dose_era_start_datetime), ")") else paste0("'", as.character(dose_era_start_datetime), "'"))
  }

  if (!missing(dose_era_end_datetime)) {
    fields <- c(fields, "dose_era_end_datetime")
    values <- c(values, if (is.null(dose_era_end_datetime)) "NULL" else if (is(dose_era_end_datetime, "subQuery")) paste0("(", as.character(dose_era_end_datetime), ")") else paste0("'", as.character(dose_era_end_datetime), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "dose_era", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_condition_era <- function(condition_era_id, person_id, condition_concept_id, condition_era_start_datetime, condition_era_end_datetime, condition_occurrence_count) {
  fields <- c()
  values <- c()
  if (!missing(condition_era_id)) {
    fields <- c(fields, "condition_era_id")
    values <- c(values, if (is.null(condition_era_id)) "NULL" else if (is(condition_era_id, "subQuery")) paste0("(", as.character(condition_era_id), ")") else paste0("'", as.character(condition_era_id), "'"))
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(condition_concept_id)) {
    fields <- c(fields, "condition_concept_id")
    values <- c(values, if (is.null(condition_concept_id)) "NULL" else if (is(condition_concept_id, "subQuery")) paste0("(", as.character(condition_concept_id), ")") else paste0("'", as.character(condition_concept_id), "'"))
  }

  if (!missing(condition_era_start_datetime)) {
    fields <- c(fields, "condition_era_start_datetime")
    values <- c(values, if (is.null(condition_era_start_datetime)) "NULL" else if (is(condition_era_start_datetime, "subQuery")) paste0("(", as.character(condition_era_start_datetime), ")") else paste0("'", as.character(condition_era_start_datetime), "'"))
  }

  if (!missing(condition_era_end_datetime)) {
    fields <- c(fields, "condition_era_end_datetime")
    values <- c(values, if (is.null(condition_era_end_datetime)) "NULL" else if (is(condition_era_end_datetime, "subQuery")) paste0("(", as.character(condition_era_end_datetime), ")") else paste0("'", as.character(condition_era_end_datetime), "'"))
  }

  if (!missing(condition_occurrence_count)) {
    fields <- c(fields, "condition_occurrence_count")
    values <- c(values, if (is.null(condition_occurrence_count)) "NULL" else if (is(condition_occurrence_count, "subQuery")) paste0("(", as.character(condition_occurrence_count), ")") else paste0("'", as.character(condition_occurrence_count), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "condition_era", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_location <- function(location_id, address_1, address_2, city, state, zip, county, country, location_source_value, latitude, longitude) {
  fields <- c()
  values <- c()
  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) "NULL" else if (is(location_id, "subQuery")) paste0("(", as.character(location_id), ")") else paste0("'", as.character(location_id), "'"))
  }

  if (!missing(address_1)) {
    fields <- c(fields, "address_1")
    values <- c(values, if (is.null(address_1)) "NULL" else if (is(address_1, "subQuery")) paste0("(", as.character(address_1), ")") else paste0("'", as.character(address_1), "'"))
  }

  if (!missing(address_2)) {
    fields <- c(fields, "address_2")
    values <- c(values, if (is.null(address_2)) "NULL" else if (is(address_2, "subQuery")) paste0("(", as.character(address_2), ")") else paste0("'", as.character(address_2), "'"))
  }

  if (!missing(city)) {
    fields <- c(fields, "city")
    values <- c(values, if (is.null(city)) "NULL" else if (is(city, "subQuery")) paste0("(", as.character(city), ")") else paste0("'", as.character(city), "'"))
  }

  if (!missing(state)) {
    fields <- c(fields, "state")
    values <- c(values, if (is.null(state)) "NULL" else if (is(state, "subQuery")) paste0("(", as.character(state), ")") else paste0("'", as.character(state), "'"))
  }

  if (!missing(zip)) {
    fields <- c(fields, "zip")
    values <- c(values, if (is.null(zip)) "NULL" else if (is(zip, "subQuery")) paste0("(", as.character(zip), ")") else paste0("'", as.character(zip), "'"))
  }

  if (!missing(county)) {
    fields <- c(fields, "county")
    values <- c(values, if (is.null(county)) "NULL" else if (is(county, "subQuery")) paste0("(", as.character(county), ")") else paste0("'", as.character(county), "'"))
  }

  if (!missing(country)) {
    fields <- c(fields, "country")
    values <- c(values, if (is.null(country)) "NULL" else if (is(country, "subQuery")) paste0("(", as.character(country), ")") else paste0("'", as.character(country), "'"))
  }

  if (!missing(location_source_value)) {
    fields <- c(fields, "location_source_value")
    values <- c(values, if (is.null(location_source_value)) "NULL" else if (is(location_source_value, "subQuery")) paste0("(", as.character(location_source_value), ")") else paste0("'", as.character(location_source_value), "'"))
  }

  if (!missing(latitude)) {
    fields <- c(fields, "latitude")
    values <- c(values, if (is.null(latitude)) "NULL" else if (is(latitude, "subQuery")) paste0("(", as.character(latitude), ")") else paste0("'", as.character(latitude), "'"))
  }

  if (!missing(longitude)) {
    fields <- c(fields, "longitude")
    values <- c(values, if (is.null(longitude)) "NULL" else if (is(longitude, "subQuery")) paste0("(", as.character(longitude), ")") else paste0("'", as.character(longitude), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "location", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_location_history <- function(location_id, relationship_type_concept_id, domain_id, entity_id, start_date, end_date) {
  fields <- c()
  values <- c()
  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) "NULL" else if (is(location_id, "subQuery")) paste0("(", as.character(location_id), ")") else paste0("'", as.character(location_id), "'"))
  }

  if (!missing(relationship_type_concept_id)) {
    fields <- c(fields, "relationship_type_concept_id")
    values <- c(values, if (is.null(relationship_type_concept_id)) "NULL" else if (is(relationship_type_concept_id, "subQuery")) paste0("(", as.character(relationship_type_concept_id), ")") else paste0("'", as.character(relationship_type_concept_id), "'"))
  }

  if (!missing(domain_id)) {
    fields <- c(fields, "domain_id")
    values <- c(values, if (is.null(domain_id)) "NULL" else if (is(domain_id, "subQuery")) paste0("(", as.character(domain_id), ")") else paste0("'", as.character(domain_id), "'"))
  }

  if (!missing(entity_id)) {
    fields <- c(fields, "entity_id")
    values <- c(values, if (is.null(entity_id)) "NULL" else if (is(entity_id, "subQuery")) paste0("(", as.character(entity_id), ")") else paste0("'", as.character(entity_id), "'"))
  }

  if (!missing(start_date)) {
    fields <- c(fields, "start_date")
    values <- c(values, if (is.null(start_date)) "NULL" else if (is(start_date, "subQuery")) paste0("(", as.character(start_date), ")") else paste0("'", as.character(start_date), "'"))
  }

  if (!missing(end_date)) {
    fields <- c(fields, "end_date")
    values <- c(values, if (is.null(end_date)) "NULL" else if (is(end_date, "subQuery")) paste0("(", as.character(end_date), ")") else paste0("'", as.character(end_date), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "location_history", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_provider <- function(provider_id, provider_name, npi, dea, specialty_concept_id, care_site_id, year_of_birth, gender_concept_id, provider_source_value, specialty_source_value, specialty_source_concept_id, gender_source_value, gender_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(provider_name)) {
    fields <- c(fields, "provider_name")
    values <- c(values, if (is.null(provider_name)) "NULL" else if (is(provider_name, "subQuery")) paste0("(", as.character(provider_name), ")") else paste0("'", as.character(provider_name), "'"))
  }

  if (!missing(npi)) {
    fields <- c(fields, "npi")
    values <- c(values, if (is.null(npi)) "NULL" else if (is(npi, "subQuery")) paste0("(", as.character(npi), ")") else paste0("'", as.character(npi), "'"))
  }

  if (!missing(dea)) {
    fields <- c(fields, "dea")
    values <- c(values, if (is.null(dea)) "NULL" else if (is(dea, "subQuery")) paste0("(", as.character(dea), ")") else paste0("'", as.character(dea), "'"))
  }

  if (!missing(specialty_concept_id)) {
    fields <- c(fields, "specialty_concept_id")
    values <- c(values, if (is.null(specialty_concept_id)) "NULL" else if (is(specialty_concept_id, "subQuery")) paste0("(", as.character(specialty_concept_id), ")") else paste0("'", as.character(specialty_concept_id), "'"))
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) "NULL" else if (is(care_site_id, "subQuery")) paste0("(", as.character(care_site_id), ")") else paste0("'", as.character(care_site_id), "'"))
  }

  if (!missing(year_of_birth)) {
    fields <- c(fields, "year_of_birth")
    values <- c(values, if (is.null(year_of_birth)) "NULL" else if (is(year_of_birth, "subQuery")) paste0("(", as.character(year_of_birth), ")") else paste0("'", as.character(year_of_birth), "'"))
  }

  if (!missing(gender_concept_id)) {
    fields <- c(fields, "gender_concept_id")
    values <- c(values, if (is.null(gender_concept_id)) "NULL" else if (is(gender_concept_id, "subQuery")) paste0("(", as.character(gender_concept_id), ")") else paste0("'", as.character(gender_concept_id), "'"))
  }

  if (!missing(provider_source_value)) {
    fields <- c(fields, "provider_source_value")
    values <- c(values, if (is.null(provider_source_value)) "NULL" else if (is(provider_source_value, "subQuery")) paste0("(", as.character(provider_source_value), ")") else paste0("'", as.character(provider_source_value), "'"))
  }

  if (!missing(specialty_source_value)) {
    fields <- c(fields, "specialty_source_value")
    values <- c(values, if (is.null(specialty_source_value)) "NULL" else if (is(specialty_source_value, "subQuery")) paste0("(", as.character(specialty_source_value), ")") else paste0("'", as.character(specialty_source_value), "'"))
  }

  if (!missing(specialty_source_concept_id)) {
    fields <- c(fields, "specialty_source_concept_id")
    values <- c(values, if (is.null(specialty_source_concept_id)) "NULL" else if (is(specialty_source_concept_id, "subQuery")) paste0("(", as.character(specialty_source_concept_id), ")") else paste0("'", as.character(specialty_source_concept_id), "'"))
  }

  if (!missing(gender_source_value)) {
    fields <- c(fields, "gender_source_value")
    values <- c(values, if (is.null(gender_source_value)) "NULL" else if (is(gender_source_value, "subQuery")) paste0("(", as.character(gender_source_value), ")") else paste0("'", as.character(gender_source_value), "'"))
  }

  if (!missing(gender_source_concept_id)) {
    fields <- c(fields, "gender_source_concept_id")
    values <- c(values, if (is.null(gender_source_concept_id)) "NULL" else if (is(gender_source_concept_id, "subQuery")) paste0("(", as.character(gender_source_concept_id), ")") else paste0("'", as.character(gender_source_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "provider", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_care_site <- function(care_site_id, care_site_name, place_of_service_concept_id, location_id, care_site_source_value, place_of_service_source_value) {
  fields <- c()
  values <- c()
  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) "NULL" else if (is(care_site_id, "subQuery")) paste0("(", as.character(care_site_id), ")") else paste0("'", as.character(care_site_id), "'"))
  }

  if (!missing(care_site_name)) {
    fields <- c(fields, "care_site_name")
    values <- c(values, if (is.null(care_site_name)) "NULL" else if (is(care_site_name, "subQuery")) paste0("(", as.character(care_site_name), ")") else paste0("'", as.character(care_site_name), "'"))
  }

  if (!missing(place_of_service_concept_id)) {
    fields <- c(fields, "place_of_service_concept_id")
    values <- c(values, if (is.null(place_of_service_concept_id)) "NULL" else if (is(place_of_service_concept_id, "subQuery")) paste0("(", as.character(place_of_service_concept_id), ")") else paste0("'", as.character(place_of_service_concept_id), "'"))
  }

  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) "NULL" else if (is(location_id, "subQuery")) paste0("(", as.character(location_id), ")") else paste0("'", as.character(location_id), "'"))
  }

  if (!missing(care_site_source_value)) {
    fields <- c(fields, "care_site_source_value")
    values <- c(values, if (is.null(care_site_source_value)) "NULL" else if (is(care_site_source_value, "subQuery")) paste0("(", as.character(care_site_source_value), ")") else paste0("'", as.character(care_site_source_value), "'"))
  }

  if (!missing(place_of_service_source_value)) {
    fields <- c(fields, "place_of_service_source_value")
    values <- c(values, if (is.null(place_of_service_source_value)) "NULL" else if (is(place_of_service_source_value, "subQuery")) paste0("(", as.character(place_of_service_source_value), ")") else paste0("'", as.character(place_of_service_source_value), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "care_site", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_cdm_source <- function(cdm_source_name, cdm_source_abbreviation, cdm_holder, source_description, source_documentation_reference, cdm_etl_reference, source_release_date, cdm_release_date, cdm_version, vocabulary_version) {
  fields <- c()
  values <- c()
  if (!missing(cdm_source_name)) {
    fields <- c(fields, "cdm_source_name")
    values <- c(values, if (is.null(cdm_source_name)) "NULL" else if (is(cdm_source_name, "subQuery")) paste0("(", as.character(cdm_source_name), ")") else paste0("'", as.character(cdm_source_name), "'"))
  }

  if (!missing(cdm_source_abbreviation)) {
    fields <- c(fields, "cdm_source_abbreviation")
    values <- c(values, if (is.null(cdm_source_abbreviation)) "NULL" else if (is(cdm_source_abbreviation, "subQuery")) paste0("(", as.character(cdm_source_abbreviation), ")") else paste0("'", as.character(cdm_source_abbreviation), "'"))
  }

  if (!missing(cdm_holder)) {
    fields <- c(fields, "cdm_holder")
    values <- c(values, if (is.null(cdm_holder)) "NULL" else if (is(cdm_holder, "subQuery")) paste0("(", as.character(cdm_holder), ")") else paste0("'", as.character(cdm_holder), "'"))
  }

  if (!missing(source_description)) {
    fields <- c(fields, "source_description")
    values <- c(values, if (is.null(source_description)) "NULL" else if (is(source_description, "subQuery")) paste0("(", as.character(source_description), ")") else paste0("'", as.character(source_description), "'"))
  }

  if (!missing(source_documentation_reference)) {
    fields <- c(fields, "source_documentation_reference")
    values <- c(values, if (is.null(source_documentation_reference)) "NULL" else if (is(source_documentation_reference, "subQuery")) paste0("(", as.character(source_documentation_reference), ")") else paste0("'", as.character(source_documentation_reference), "'"))
  }

  if (!missing(cdm_etl_reference)) {
    fields <- c(fields, "cdm_etl_reference")
    values <- c(values, if (is.null(cdm_etl_reference)) "NULL" else if (is(cdm_etl_reference, "subQuery")) paste0("(", as.character(cdm_etl_reference), ")") else paste0("'", as.character(cdm_etl_reference), "'"))
  }

  if (!missing(source_release_date)) {
    fields <- c(fields, "source_release_date")
    values <- c(values, if (is.null(source_release_date)) "NULL" else if (is(source_release_date, "subQuery")) paste0("(", as.character(source_release_date), ")") else paste0("'", as.character(source_release_date), "'"))
  }

  if (!missing(cdm_release_date)) {
    fields <- c(fields, "cdm_release_date")
    values <- c(values, if (is.null(cdm_release_date)) "NULL" else if (is(cdm_release_date, "subQuery")) paste0("(", as.character(cdm_release_date), ")") else paste0("'", as.character(cdm_release_date), "'"))
  }

  if (!missing(cdm_version)) {
    fields <- c(fields, "cdm_version")
    values <- c(values, if (is.null(cdm_version)) "NULL" else if (is(cdm_version, "subQuery")) paste0("(", as.character(cdm_version), ")") else paste0("'", as.character(cdm_version), "'"))
  }

  if (!missing(vocabulary_version)) {
    fields <- c(fields, "vocabulary_version")
    values <- c(values, if (is.null(vocabulary_version)) "NULL" else if (is(vocabulary_version, "subQuery")) paste0("(", as.character(vocabulary_version), ")") else paste0("'", as.character(vocabulary_version), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "cdm_source", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_metadata <- function(metadata_concept_id, metadata_type_concept_id, name, value_as_string, value_as_concept_id, metadata_date, metadata_datetime) {
  fields <- c()
  values <- c()
  if (!missing(metadata_concept_id)) {
    fields <- c(fields, "metadata_concept_id")
    values <- c(values, if (is.null(metadata_concept_id)) "NULL" else if (is(metadata_concept_id, "subQuery")) paste0("(", as.character(metadata_concept_id), ")") else paste0("'", as.character(metadata_concept_id), "'"))
  }

  if (!missing(metadata_type_concept_id)) {
    fields <- c(fields, "metadata_type_concept_id")
    values <- c(values, if (is.null(metadata_type_concept_id)) "NULL" else if (is(metadata_type_concept_id, "subQuery")) paste0("(", as.character(metadata_type_concept_id), ")") else paste0("'", as.character(metadata_type_concept_id), "'"))
  }

  if (!missing(name)) {
    fields <- c(fields, "name")
    values <- c(values, if (is.null(name)) "NULL" else if (is(name, "subQuery")) paste0("(", as.character(name), ")") else paste0("'", as.character(name), "'"))
  }

  if (!missing(value_as_string)) {
    fields <- c(fields, "value_as_string")
    values <- c(values, if (is.null(value_as_string)) "NULL" else if (is(value_as_string, "subQuery")) paste0("(", as.character(value_as_string), ")") else paste0("'", as.character(value_as_string), "'"))
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) "NULL" else if (is(value_as_concept_id, "subQuery")) paste0("(", as.character(value_as_concept_id), ")") else paste0("'", as.character(value_as_concept_id), "'"))
  }

  if (!missing(metadata_date)) {
    fields <- c(fields, "[metadata date]")
    values <- c(values, if (is.null(metadata_date)) "NULL" else if (is(metadata_date, "subQuery")) paste0("(", as.character(metadata_date), ")") else paste0("'", as.character(metadata_date), "'"))
  }

  if (!missing(metadata_datetime)) {
    fields <- c(fields, "metadata_datetime")
    values <- c(values, if (is.null(metadata_datetime)) "NULL" else if (is(metadata_datetime, "subQuery")) paste0("(", as.character(metadata_datetime), ")") else paste0("'", as.character(metadata_datetime), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "metadata", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_no_fact_relationship <- function(domain_concept_id_1, fact_id_1, domain_concept_id_2, fact_id_2, relationship_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(domain_concept_id_1)) {
    fields <- c(fields, "domain_concept_id_1")
    values <- c(values, if (is.null(domain_concept_id_1)) "NULL" else if (is(domain_concept_id_1, "subQuery")) paste0("(", as.character(domain_concept_id_1), ")") else paste0("'", as.character(domain_concept_id_1), "'"))
  }

  if (!missing(fact_id_1)) {
    fields <- c(fields, "fact_id_1")
    values <- c(values, if (is.null(fact_id_1)) "NULL" else if (is(fact_id_1, "subQuery")) paste0("(", as.character(fact_id_1), ")") else paste0("'", as.character(fact_id_1), "'"))
  }

  if (!missing(domain_concept_id_2)) {
    fields <- c(fields, "domain_concept_id_2")
    values <- c(values, if (is.null(domain_concept_id_2)) "NULL" else if (is(domain_concept_id_2, "subQuery")) paste0("(", as.character(domain_concept_id_2), ")") else paste0("'", as.character(domain_concept_id_2), "'"))
  }

  if (!missing(fact_id_2)) {
    fields <- c(fields, "fact_id_2")
    values <- c(values, if (is.null(fact_id_2)) "NULL" else if (is(fact_id_2, "subQuery")) paste0("(", as.character(fact_id_2), ")") else paste0("'", as.character(fact_id_2), "'"))
  }

  if (!missing(relationship_concept_id)) {
    fields <- c(fields, "relationship_concept_id")
    values <- c(values, if (is.null(relationship_concept_id)) "NULL" else if (is(relationship_concept_id, "subQuery")) paste0("(", as.character(relationship_concept_id), ")") else paste0("'", as.character(relationship_concept_id), "'"))
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 1, table = "fact_relationship", fields = fields, values = values)
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_person <- function(rowCount, person_id, gender_concept_id, year_of_birth, month_of_birth, day_of_birth, birth_datetime, death_datetime, race_concept_id, ethnicity_concept_id, location_id, provider_id, care_site_id, person_source_value, gender_source_value, gender_source_concept_id, race_source_value, race_source_concept_id, ethnicity_source_value, ethnicity_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.person_id')
  }

  if (!missing(gender_concept_id)) {
    fields <- c(fields, "gender_concept_id")
    values <- c(values, if (is.null(gender_concept_id)) "NULL" else if (is(gender_concept_id, "subQuery")) paste0("(", as.character(gender_concept_id), ")") else paste0("'", as.character(gender_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.gender_concept_id')
  }

  if (!missing(year_of_birth)) {
    fields <- c(fields, "year_of_birth")
    values <- c(values, if (is.null(year_of_birth)) "NULL" else if (is(year_of_birth, "subQuery")) paste0("(", as.character(year_of_birth), ")") else paste0("'", as.character(year_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.year_of_birth')
  }

  if (!missing(month_of_birth)) {
    fields <- c(fields, "month_of_birth")
    values <- c(values, if (is.null(month_of_birth)) "NULL" else if (is(month_of_birth, "subQuery")) paste0("(", as.character(month_of_birth), ")") else paste0("'", as.character(month_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.month_of_birth')
  }

  if (!missing(day_of_birth)) {
    fields <- c(fields, "day_of_birth")
    values <- c(values, if (is.null(day_of_birth)) "NULL" else if (is(day_of_birth, "subQuery")) paste0("(", as.character(day_of_birth), ")") else paste0("'", as.character(day_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.day_of_birth')
  }

  if (!missing(birth_datetime)) {
    fields <- c(fields, "birth_datetime")
    values <- c(values, if (is.null(birth_datetime)) "NULL" else if (is(birth_datetime, "subQuery")) paste0("(", as.character(birth_datetime), ")") else paste0("'", as.character(birth_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.birth_datetime')
  }

  if (!missing(death_datetime)) {
    fields <- c(fields, "death_datetime")
    values <- c(values, if (is.null(death_datetime)) "NULL" else if (is(death_datetime, "subQuery")) paste0("(", as.character(death_datetime), ")") else paste0("'", as.character(death_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.death_datetime')
  }

  if (!missing(race_concept_id)) {
    fields <- c(fields, "race_concept_id")
    values <- c(values, if (is.null(race_concept_id)) "NULL" else if (is(race_concept_id, "subQuery")) paste0("(", as.character(race_concept_id), ")") else paste0("'", as.character(race_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.race_concept_id')
  }

  if (!missing(ethnicity_concept_id)) {
    fields <- c(fields, "ethnicity_concept_id")
    values <- c(values, if (is.null(ethnicity_concept_id)) "NULL" else if (is(ethnicity_concept_id, "subQuery")) paste0("(", as.character(ethnicity_concept_id), ")") else paste0("'", as.character(ethnicity_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.ethnicity_concept_id')
  }

  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) "NULL" else if (is(location_id, "subQuery")) paste0("(", as.character(location_id), ")") else paste0("'", as.character(location_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.location_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.provider_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) "NULL" else if (is(care_site_id, "subQuery")) paste0("(", as.character(care_site_id), ")") else paste0("'", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.care_site_id')
  }

  if (!missing(person_source_value)) {
    fields <- c(fields, "person_source_value")
    values <- c(values, if (is.null(person_source_value)) "NULL" else if (is(person_source_value, "subQuery")) paste0("(", as.character(person_source_value), ")") else paste0("'", as.character(person_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.person_source_value')
  }

  if (!missing(gender_source_value)) {
    fields <- c(fields, "gender_source_value")
    values <- c(values, if (is.null(gender_source_value)) "NULL" else if (is(gender_source_value, "subQuery")) paste0("(", as.character(gender_source_value), ")") else paste0("'", as.character(gender_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.gender_source_value')
  }

  if (!missing(gender_source_concept_id)) {
    fields <- c(fields, "gender_source_concept_id")
    values <- c(values, if (is.null(gender_source_concept_id)) "NULL" else if (is(gender_source_concept_id, "subQuery")) paste0("(", as.character(gender_source_concept_id), ")") else paste0("'", as.character(gender_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.gender_source_concept_id')
  }

  if (!missing(race_source_value)) {
    fields <- c(fields, "race_source_value")
    values <- c(values, if (is.null(race_source_value)) "NULL" else if (is(race_source_value, "subQuery")) paste0("(", as.character(race_source_value), ")") else paste0("'", as.character(race_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.race_source_value')
  }

  if (!missing(race_source_concept_id)) {
    fields <- c(fields, "race_source_concept_id")
    values <- c(values, if (is.null(race_source_concept_id)) "NULL" else if (is(race_source_concept_id, "subQuery")) paste0("(", as.character(race_source_concept_id), ")") else paste0("'", as.character(race_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.race_source_concept_id')
  }

  if (!missing(ethnicity_source_value)) {
    fields <- c(fields, "ethnicity_source_value")
    values <- c(values, if (is.null(ethnicity_source_value)) "NULL" else if (is(ethnicity_source_value, "subQuery")) paste0("(", as.character(ethnicity_source_value), ")") else paste0("'", as.character(ethnicity_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.ethnicity_source_value')
  }

  if (!missing(ethnicity_source_concept_id)) {
    fields <- c(fields, "ethnicity_source_concept_id")
    values <- c(values, if (is.null(ethnicity_source_concept_id)) "NULL" else if (is(ethnicity_source_concept_id, "subQuery")) paste0("(", as.character(ethnicity_source_concept_id), ")") else paste0("'", as.character(ethnicity_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'person.ethnicity_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "person", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_observation_period <- function(rowCount, observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(observation_period_id)) {
    fields <- c(fields, "observation_period_id")
    values <- c(values, if (is.null(observation_period_id)) "NULL" else if (is(observation_period_id, "subQuery")) paste0("(", as.character(observation_period_id), ")") else paste0("'", as.character(observation_period_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.observation_period_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.person_id')
  }

  if (!missing(observation_period_start_date)) {
    fields <- c(fields, "observation_period_start_date")
    values <- c(values, if (is.null(observation_period_start_date)) "NULL" else if (is(observation_period_start_date, "subQuery")) paste0("(", as.character(observation_period_start_date), ")") else paste0("'", as.character(observation_period_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.observation_period_start_date')
  }

  if (!missing(observation_period_end_date)) {
    fields <- c(fields, "observation_period_end_date")
    values <- c(values, if (is.null(observation_period_end_date)) "NULL" else if (is(observation_period_end_date, "subQuery")) paste0("(", as.character(observation_period_end_date), ")") else paste0("'", as.character(observation_period_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.observation_period_end_date')
  }

  if (!missing(period_type_concept_id)) {
    fields <- c(fields, "period_type_concept_id")
    values <- c(values, if (is.null(period_type_concept_id)) "NULL" else if (is(period_type_concept_id, "subQuery")) paste0("(", as.character(period_type_concept_id), ")") else paste0("'", as.character(period_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation_period.period_type_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "observation_period", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_visit_occurrence <- function(rowCount, visit_occurrence_id, person_id, visit_concept_id, visit_start_date, visit_start_datetime, visit_end_date, visit_end_datetime, visit_type_concept_id, provider_id, care_site_id, visit_source_value, visit_source_concept_id, admitting_source_concept_id, admitting_source_value, discharge_to_concept_id, discharge_to_source_value, preceding_visit_occurrence_id) {
  fields <- c()
  values <- c()
  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_occurrence_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.person_id')
  }

  if (!missing(visit_concept_id)) {
    fields <- c(fields, "visit_concept_id")
    values <- c(values, if (is.null(visit_concept_id)) "NULL" else if (is(visit_concept_id, "subQuery")) paste0("(", as.character(visit_concept_id), ")") else paste0("'", as.character(visit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_concept_id')
  }

  if (!missing(visit_start_date)) {
    fields <- c(fields, "visit_start_date")
    values <- c(values, if (is.null(visit_start_date)) "NULL" else if (is(visit_start_date, "subQuery")) paste0("(", as.character(visit_start_date), ")") else paste0("'", as.character(visit_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_start_date')
  }

  if (!missing(visit_start_datetime)) {
    fields <- c(fields, "visit_start_datetime")
    values <- c(values, if (is.null(visit_start_datetime)) "NULL" else if (is(visit_start_datetime, "subQuery")) paste0("(", as.character(visit_start_datetime), ")") else paste0("'", as.character(visit_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_start_datetime')
  }

  if (!missing(visit_end_date)) {
    fields <- c(fields, "visit_end_date")
    values <- c(values, if (is.null(visit_end_date)) "NULL" else if (is(visit_end_date, "subQuery")) paste0("(", as.character(visit_end_date), ")") else paste0("'", as.character(visit_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_end_date')
  }

  if (!missing(visit_end_datetime)) {
    fields <- c(fields, "visit_end_datetime")
    values <- c(values, if (is.null(visit_end_datetime)) "NULL" else if (is(visit_end_datetime, "subQuery")) paste0("(", as.character(visit_end_datetime), ")") else paste0("'", as.character(visit_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_end_datetime')
  }

  if (!missing(visit_type_concept_id)) {
    fields <- c(fields, "visit_type_concept_id")
    values <- c(values, if (is.null(visit_type_concept_id)) "NULL" else if (is(visit_type_concept_id, "subQuery")) paste0("(", as.character(visit_type_concept_id), ")") else paste0("'", as.character(visit_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_type_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.provider_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) "NULL" else if (is(care_site_id, "subQuery")) paste0("(", as.character(care_site_id), ")") else paste0("'", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.care_site_id')
  }

  if (!missing(visit_source_value)) {
    fields <- c(fields, "visit_source_value")
    values <- c(values, if (is.null(visit_source_value)) "NULL" else if (is(visit_source_value, "subQuery")) paste0("(", as.character(visit_source_value), ")") else paste0("'", as.character(visit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_source_value')
  }

  if (!missing(visit_source_concept_id)) {
    fields <- c(fields, "visit_source_concept_id")
    values <- c(values, if (is.null(visit_source_concept_id)) "NULL" else if (is(visit_source_concept_id, "subQuery")) paste0("(", as.character(visit_source_concept_id), ")") else paste0("'", as.character(visit_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.visit_source_concept_id')
  }

  if (!missing(admitting_source_concept_id)) {
    fields <- c(fields, "admitting_source_concept_id")
    values <- c(values, if (is.null(admitting_source_concept_id)) "NULL" else if (is(admitting_source_concept_id, "subQuery")) paste0("(", as.character(admitting_source_concept_id), ")") else paste0("'", as.character(admitting_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.admitting_source_concept_id')
  }

  if (!missing(admitting_source_value)) {
    fields <- c(fields, "admitting_source_value")
    values <- c(values, if (is.null(admitting_source_value)) "NULL" else if (is(admitting_source_value, "subQuery")) paste0("(", as.character(admitting_source_value), ")") else paste0("'", as.character(admitting_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.admitting_source_value')
  }

  if (!missing(discharge_to_concept_id)) {
    fields <- c(fields, "discharge_to_concept_id")
    values <- c(values, if (is.null(discharge_to_concept_id)) "NULL" else if (is(discharge_to_concept_id, "subQuery")) paste0("(", as.character(discharge_to_concept_id), ")") else paste0("'", as.character(discharge_to_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.discharge_to_concept_id')
  }

  if (!missing(discharge_to_source_value)) {
    fields <- c(fields, "discharge_to_source_value")
    values <- c(values, if (is.null(discharge_to_source_value)) "NULL" else if (is(discharge_to_source_value, "subQuery")) paste0("(", as.character(discharge_to_source_value), ")") else paste0("'", as.character(discharge_to_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.discharge_to_source_value')
  }

  if (!missing(preceding_visit_occurrence_id)) {
    fields <- c(fields, "preceding_visit_occurrence_id")
    values <- c(values, if (is.null(preceding_visit_occurrence_id)) "NULL" else if (is(preceding_visit_occurrence_id, "subQuery")) paste0("(", as.character(preceding_visit_occurrence_id), ")") else paste0("'", as.character(preceding_visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_occurrence.preceding_visit_occurrence_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "visit_occurrence", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_visit_detail <- function(rowCount, visit_detail_id, person_id, visit_detail_concept_id, visit_detail_start_date, visit_detail_start_datetime, visit_detail_end_date, visit_detail_end_datetime, visit_detail_type_concept_id, provider_id, care_site_id, visit_detail_source_value, visit_detail_source_concept_id, admitted_from_source_value, admitted_from_concept_id, discharge_to_source_value, discharge_to_concept_id, preceding_visit_detail_id, visit_detail_parent_id, visit_occurrence_id) {
  fields <- c()
  values <- c()
  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.person_id')
  }

  if (!missing(visit_detail_concept_id)) {
    fields <- c(fields, "visit_detail_concept_id")
    values <- c(values, if (is.null(visit_detail_concept_id)) "NULL" else if (is(visit_detail_concept_id, "subQuery")) paste0("(", as.character(visit_detail_concept_id), ")") else paste0("'", as.character(visit_detail_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_concept_id')
  }

  if (!missing(visit_detail_start_date)) {
    fields <- c(fields, "visit_detail_start_date")
    values <- c(values, if (is.null(visit_detail_start_date)) "NULL" else if (is(visit_detail_start_date, "subQuery")) paste0("(", as.character(visit_detail_start_date), ")") else paste0("'", as.character(visit_detail_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_start_date')
  }

  if (!missing(visit_detail_start_datetime)) {
    fields <- c(fields, "visit_detail_start_datetime")
    values <- c(values, if (is.null(visit_detail_start_datetime)) "NULL" else if (is(visit_detail_start_datetime, "subQuery")) paste0("(", as.character(visit_detail_start_datetime), ")") else paste0("'", as.character(visit_detail_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_start_datetime')
  }

  if (!missing(visit_detail_end_date)) {
    fields <- c(fields, "visit_detail_end_date")
    values <- c(values, if (is.null(visit_detail_end_date)) "NULL" else if (is(visit_detail_end_date, "subQuery")) paste0("(", as.character(visit_detail_end_date), ")") else paste0("'", as.character(visit_detail_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_end_date')
  }

  if (!missing(visit_detail_end_datetime)) {
    fields <- c(fields, "visit_detail_end_datetime")
    values <- c(values, if (is.null(visit_detail_end_datetime)) "NULL" else if (is(visit_detail_end_datetime, "subQuery")) paste0("(", as.character(visit_detail_end_datetime), ")") else paste0("'", as.character(visit_detail_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_end_datetime')
  }

  if (!missing(visit_detail_type_concept_id)) {
    fields <- c(fields, "visit_detail_type_concept_id")
    values <- c(values, if (is.null(visit_detail_type_concept_id)) "NULL" else if (is(visit_detail_type_concept_id, "subQuery")) paste0("(", as.character(visit_detail_type_concept_id), ")") else paste0("'", as.character(visit_detail_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_type_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.provider_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) "NULL" else if (is(care_site_id, "subQuery")) paste0("(", as.character(care_site_id), ")") else paste0("'", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.care_site_id')
  }

  if (!missing(visit_detail_source_value)) {
    fields <- c(fields, "visit_detail_source_value")
    values <- c(values, if (is.null(visit_detail_source_value)) "NULL" else if (is(visit_detail_source_value, "subQuery")) paste0("(", as.character(visit_detail_source_value), ")") else paste0("'", as.character(visit_detail_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_source_value')
  }

  if (!missing(visit_detail_source_concept_id)) {
    fields <- c(fields, "visit_detail_source_concept_id")
    values <- c(values, if (is.null(visit_detail_source_concept_id)) "NULL" else if (is(visit_detail_source_concept_id, "subQuery")) paste0("(", as.character(visit_detail_source_concept_id), ")") else paste0("'", as.character(visit_detail_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_source_concept_id')
  }

  if (!missing(admitted_from_source_value)) {
    fields <- c(fields, "admitted_from_source_value")
    values <- c(values, if (is.null(admitted_from_source_value)) "NULL" else if (is(admitted_from_source_value, "subQuery")) paste0("(", as.character(admitted_from_source_value), ")") else paste0("'", as.character(admitted_from_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.admitted_from_source_value')
  }

  if (!missing(admitted_from_concept_id)) {
    fields <- c(fields, "admitted_from_concept_id")
    values <- c(values, if (is.null(admitted_from_concept_id)) "NULL" else if (is(admitted_from_concept_id, "subQuery")) paste0("(", as.character(admitted_from_concept_id), ")") else paste0("'", as.character(admitted_from_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.admitted_from_concept_id')
  }

  if (!missing(discharge_to_source_value)) {
    fields <- c(fields, "discharge_to_source_value")
    values <- c(values, if (is.null(discharge_to_source_value)) "NULL" else if (is(discharge_to_source_value, "subQuery")) paste0("(", as.character(discharge_to_source_value), ")") else paste0("'", as.character(discharge_to_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.discharge_to_source_value')
  }

  if (!missing(discharge_to_concept_id)) {
    fields <- c(fields, "discharge_to_concept_id")
    values <- c(values, if (is.null(discharge_to_concept_id)) "NULL" else if (is(discharge_to_concept_id, "subQuery")) paste0("(", as.character(discharge_to_concept_id), ")") else paste0("'", as.character(discharge_to_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.discharge_to_concept_id')
  }

  if (!missing(preceding_visit_detail_id)) {
    fields <- c(fields, "preceding_visit_detail_id")
    values <- c(values, if (is.null(preceding_visit_detail_id)) "NULL" else if (is(preceding_visit_detail_id, "subQuery")) paste0("(", as.character(preceding_visit_detail_id), ")") else paste0("'", as.character(preceding_visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.preceding_visit_detail_id')
  }

  if (!missing(visit_detail_parent_id)) {
    fields <- c(fields, "visit_detail_parent_id")
    values <- c(values, if (is.null(visit_detail_parent_id)) "NULL" else if (is(visit_detail_parent_id, "subQuery")) paste0("(", as.character(visit_detail_parent_id), ")") else paste0("'", as.character(visit_detail_parent_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_detail_parent_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'visit_detail.visit_occurrence_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "visit_detail", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_condition_occurrence <- function(rowCount, condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_start_datetime, condition_end_date, condition_end_datetime, condition_type_concept_id, condition_status_concept_id, stop_reason, provider_id, visit_occurrence_id, visit_detail_id, condition_source_value, condition_source_concept_id, condition_status_source_value) {
  fields <- c()
  values <- c()
  if (!missing(condition_occurrence_id)) {
    fields <- c(fields, "condition_occurrence_id")
    values <- c(values, if (is.null(condition_occurrence_id)) "NULL" else if (is(condition_occurrence_id, "subQuery")) paste0("(", as.character(condition_occurrence_id), ")") else paste0("'", as.character(condition_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_occurrence_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.person_id')
  }

  if (!missing(condition_concept_id)) {
    fields <- c(fields, "condition_concept_id")
    values <- c(values, if (is.null(condition_concept_id)) "NULL" else if (is(condition_concept_id, "subQuery")) paste0("(", as.character(condition_concept_id), ")") else paste0("'", as.character(condition_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_concept_id')
  }

  if (!missing(condition_start_date)) {
    fields <- c(fields, "condition_start_date")
    values <- c(values, if (is.null(condition_start_date)) "NULL" else if (is(condition_start_date, "subQuery")) paste0("(", as.character(condition_start_date), ")") else paste0("'", as.character(condition_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_start_date')
  }

  if (!missing(condition_start_datetime)) {
    fields <- c(fields, "condition_start_datetime")
    values <- c(values, if (is.null(condition_start_datetime)) "NULL" else if (is(condition_start_datetime, "subQuery")) paste0("(", as.character(condition_start_datetime), ")") else paste0("'", as.character(condition_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_start_datetime')
  }

  if (!missing(condition_end_date)) {
    fields <- c(fields, "condition_end_date")
    values <- c(values, if (is.null(condition_end_date)) "NULL" else if (is(condition_end_date, "subQuery")) paste0("(", as.character(condition_end_date), ")") else paste0("'", as.character(condition_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_end_date')
  }

  if (!missing(condition_end_datetime)) {
    fields <- c(fields, "condition_end_datetime")
    values <- c(values, if (is.null(condition_end_datetime)) "NULL" else if (is(condition_end_datetime, "subQuery")) paste0("(", as.character(condition_end_datetime), ")") else paste0("'", as.character(condition_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_end_datetime')
  }

  if (!missing(condition_type_concept_id)) {
    fields <- c(fields, "condition_type_concept_id")
    values <- c(values, if (is.null(condition_type_concept_id)) "NULL" else if (is(condition_type_concept_id, "subQuery")) paste0("(", as.character(condition_type_concept_id), ")") else paste0("'", as.character(condition_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_type_concept_id')
  }

  if (!missing(condition_status_concept_id)) {
    fields <- c(fields, "condition_status_concept_id")
    values <- c(values, if (is.null(condition_status_concept_id)) "NULL" else if (is(condition_status_concept_id, "subQuery")) paste0("(", as.character(condition_status_concept_id), ")") else paste0("'", as.character(condition_status_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_status_concept_id')
  }

  if (!missing(stop_reason)) {
    fields <- c(fields, "stop_reason")
    values <- c(values, if (is.null(stop_reason)) "NULL" else if (is(stop_reason, "subQuery")) paste0("(", as.character(stop_reason), ")") else paste0("'", as.character(stop_reason), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.stop_reason')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.visit_detail_id')
  }

  if (!missing(condition_source_value)) {
    fields <- c(fields, "condition_source_value")
    values <- c(values, if (is.null(condition_source_value)) "NULL" else if (is(condition_source_value, "subQuery")) paste0("(", as.character(condition_source_value), ")") else paste0("'", as.character(condition_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_source_value')
  }

  if (!missing(condition_source_concept_id)) {
    fields <- c(fields, "condition_source_concept_id")
    values <- c(values, if (is.null(condition_source_concept_id)) "NULL" else if (is(condition_source_concept_id, "subQuery")) paste0("(", as.character(condition_source_concept_id), ")") else paste0("'", as.character(condition_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_source_concept_id')
  }

  if (!missing(condition_status_source_value)) {
    fields <- c(fields, "condition_status_source_value")
    values <- c(values, if (is.null(condition_status_source_value)) "NULL" else if (is(condition_status_source_value, "subQuery")) paste0("(", as.character(condition_status_source_value), ")") else paste0("'", as.character(condition_status_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_occurrence.condition_status_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "condition_occurrence", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_procedure_occurrence <- function(rowCount, procedure_occurrence_id, person_id, procedure_concept_id, procedure_date, procedure_datetime, procedure_type_concept_id, modifier_concept_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, procedure_source_value, procedure_source_concept_id, modifier_source_value) {
  fields <- c()
  values <- c()
  if (!missing(procedure_occurrence_id)) {
    fields <- c(fields, "procedure_occurrence_id")
    values <- c(values, if (is.null(procedure_occurrence_id)) "NULL" else if (is(procedure_occurrence_id, "subQuery")) paste0("(", as.character(procedure_occurrence_id), ")") else paste0("'", as.character(procedure_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_occurrence_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.person_id')
  }

  if (!missing(procedure_concept_id)) {
    fields <- c(fields, "procedure_concept_id")
    values <- c(values, if (is.null(procedure_concept_id)) "NULL" else if (is(procedure_concept_id, "subQuery")) paste0("(", as.character(procedure_concept_id), ")") else paste0("'", as.character(procedure_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_concept_id')
  }

  if (!missing(procedure_date)) {
    fields <- c(fields, "procedure_date")
    values <- c(values, if (is.null(procedure_date)) "NULL" else if (is(procedure_date, "subQuery")) paste0("(", as.character(procedure_date), ")") else paste0("'", as.character(procedure_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_date')
  }

  if (!missing(procedure_datetime)) {
    fields <- c(fields, "procedure_datetime")
    values <- c(values, if (is.null(procedure_datetime)) "NULL" else if (is(procedure_datetime, "subQuery")) paste0("(", as.character(procedure_datetime), ")") else paste0("'", as.character(procedure_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_datetime')
  }

  if (!missing(procedure_type_concept_id)) {
    fields <- c(fields, "procedure_type_concept_id")
    values <- c(values, if (is.null(procedure_type_concept_id)) "NULL" else if (is(procedure_type_concept_id, "subQuery")) paste0("(", as.character(procedure_type_concept_id), ")") else paste0("'", as.character(procedure_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_type_concept_id')
  }

  if (!missing(modifier_concept_id)) {
    fields <- c(fields, "modifier_concept_id")
    values <- c(values, if (is.null(modifier_concept_id)) "NULL" else if (is(modifier_concept_id, "subQuery")) paste0("(", as.character(modifier_concept_id), ")") else paste0("'", as.character(modifier_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.modifier_concept_id')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) "NULL" else if (is(quantity, "subQuery")) paste0("(", as.character(quantity), ")") else paste0("'", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.quantity')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.visit_detail_id')
  }

  if (!missing(procedure_source_value)) {
    fields <- c(fields, "procedure_source_value")
    values <- c(values, if (is.null(procedure_source_value)) "NULL" else if (is(procedure_source_value, "subQuery")) paste0("(", as.character(procedure_source_value), ")") else paste0("'", as.character(procedure_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_source_value')
  }

  if (!missing(procedure_source_concept_id)) {
    fields <- c(fields, "procedure_source_concept_id")
    values <- c(values, if (is.null(procedure_source_concept_id)) "NULL" else if (is(procedure_source_concept_id, "subQuery")) paste0("(", as.character(procedure_source_concept_id), ")") else paste0("'", as.character(procedure_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.procedure_source_concept_id')
  }

  if (!missing(modifier_source_value)) {
    fields <- c(fields, "modifier_source_value")
    values <- c(values, if (is.null(modifier_source_value)) "NULL" else if (is(modifier_source_value, "subQuery")) paste0("(", as.character(modifier_source_value), ")") else paste0("'", as.character(modifier_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'procedure_occurrence.modifier_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "procedure_occurrence", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_drug_exposure <- function(rowCount, drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_start_datetime, drug_exposure_end_date, drug_exposure_end_datetime, verbatim_end_date, drug_type_concept_id, stop_reason, refills, quantity, days_supply, sig, route_concept_id, lot_number, provider_id, visit_occurrence_id, visit_detail_id, drug_source_value, drug_source_concept_id, route_source_value, dose_unit_source_value) {
  fields <- c()
  values <- c()
  if (!missing(drug_exposure_id)) {
    fields <- c(fields, "drug_exposure_id")
    values <- c(values, if (is.null(drug_exposure_id)) "NULL" else if (is(drug_exposure_id, "subQuery")) paste0("(", as.character(drug_exposure_id), ")") else paste0("'", as.character(drug_exposure_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.person_id')
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) "NULL" else if (is(drug_concept_id, "subQuery")) paste0("(", as.character(drug_concept_id), ")") else paste0("'", as.character(drug_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_concept_id')
  }

  if (!missing(drug_exposure_start_date)) {
    fields <- c(fields, "drug_exposure_start_date")
    values <- c(values, if (is.null(drug_exposure_start_date)) "NULL" else if (is(drug_exposure_start_date, "subQuery")) paste0("(", as.character(drug_exposure_start_date), ")") else paste0("'", as.character(drug_exposure_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_start_date')
  }

  if (!missing(drug_exposure_start_datetime)) {
    fields <- c(fields, "drug_exposure_start_datetime")
    values <- c(values, if (is.null(drug_exposure_start_datetime)) "NULL" else if (is(drug_exposure_start_datetime, "subQuery")) paste0("(", as.character(drug_exposure_start_datetime), ")") else paste0("'", as.character(drug_exposure_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_start_datetime')
  }

  if (!missing(drug_exposure_end_date)) {
    fields <- c(fields, "drug_exposure_end_date")
    values <- c(values, if (is.null(drug_exposure_end_date)) "NULL" else if (is(drug_exposure_end_date, "subQuery")) paste0("(", as.character(drug_exposure_end_date), ")") else paste0("'", as.character(drug_exposure_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_end_date')
  }

  if (!missing(drug_exposure_end_datetime)) {
    fields <- c(fields, "drug_exposure_end_datetime")
    values <- c(values, if (is.null(drug_exposure_end_datetime)) "NULL" else if (is(drug_exposure_end_datetime, "subQuery")) paste0("(", as.character(drug_exposure_end_datetime), ")") else paste0("'", as.character(drug_exposure_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_exposure_end_datetime')
  }

  if (!missing(verbatim_end_date)) {
    fields <- c(fields, "verbatim_end_date")
    values <- c(values, if (is.null(verbatim_end_date)) "NULL" else if (is(verbatim_end_date, "subQuery")) paste0("(", as.character(verbatim_end_date), ")") else paste0("'", as.character(verbatim_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.verbatim_end_date')
  }

  if (!missing(drug_type_concept_id)) {
    fields <- c(fields, "drug_type_concept_id")
    values <- c(values, if (is.null(drug_type_concept_id)) "NULL" else if (is(drug_type_concept_id, "subQuery")) paste0("(", as.character(drug_type_concept_id), ")") else paste0("'", as.character(drug_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_type_concept_id')
  }

  if (!missing(stop_reason)) {
    fields <- c(fields, "stop_reason")
    values <- c(values, if (is.null(stop_reason)) "NULL" else if (is(stop_reason, "subQuery")) paste0("(", as.character(stop_reason), ")") else paste0("'", as.character(stop_reason), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.stop_reason')
  }

  if (!missing(refills)) {
    fields <- c(fields, "refills")
    values <- c(values, if (is.null(refills)) "NULL" else if (is(refills, "subQuery")) paste0("(", as.character(refills), ")") else paste0("'", as.character(refills), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.refills')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) "NULL" else if (is(quantity, "subQuery")) paste0("(", as.character(quantity), ")") else paste0("'", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.quantity')
  }

  if (!missing(days_supply)) {
    fields <- c(fields, "days_supply")
    values <- c(values, if (is.null(days_supply)) "NULL" else if (is(days_supply, "subQuery")) paste0("(", as.character(days_supply), ")") else paste0("'", as.character(days_supply), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.days_supply')
  }

  if (!missing(sig)) {
    fields <- c(fields, "sig")
    values <- c(values, if (is.null(sig)) "NULL" else if (is(sig, "subQuery")) paste0("(", as.character(sig), ")") else paste0("'", as.character(sig), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.sig')
  }

  if (!missing(route_concept_id)) {
    fields <- c(fields, "route_concept_id")
    values <- c(values, if (is.null(route_concept_id)) "NULL" else if (is(route_concept_id, "subQuery")) paste0("(", as.character(route_concept_id), ")") else paste0("'", as.character(route_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.route_concept_id')
  }

  if (!missing(lot_number)) {
    fields <- c(fields, "lot_number")
    values <- c(values, if (is.null(lot_number)) "NULL" else if (is(lot_number, "subQuery")) paste0("(", as.character(lot_number), ")") else paste0("'", as.character(lot_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.lot_number')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.visit_detail_id')
  }

  if (!missing(drug_source_value)) {
    fields <- c(fields, "drug_source_value")
    values <- c(values, if (is.null(drug_source_value)) "NULL" else if (is(drug_source_value, "subQuery")) paste0("(", as.character(drug_source_value), ")") else paste0("'", as.character(drug_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_source_value')
  }

  if (!missing(drug_source_concept_id)) {
    fields <- c(fields, "drug_source_concept_id")
    values <- c(values, if (is.null(drug_source_concept_id)) "NULL" else if (is(drug_source_concept_id, "subQuery")) paste0("(", as.character(drug_source_concept_id), ")") else paste0("'", as.character(drug_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.drug_source_concept_id')
  }

  if (!missing(route_source_value)) {
    fields <- c(fields, "route_source_value")
    values <- c(values, if (is.null(route_source_value)) "NULL" else if (is(route_source_value, "subQuery")) paste0("(", as.character(route_source_value), ")") else paste0("'", as.character(route_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.route_source_value')
  }

  if (!missing(dose_unit_source_value)) {
    fields <- c(fields, "dose_unit_source_value")
    values <- c(values, if (is.null(dose_unit_source_value)) "NULL" else if (is(dose_unit_source_value, "subQuery")) paste0("(", as.character(dose_unit_source_value), ")") else paste0("'", as.character(dose_unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_exposure.dose_unit_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "drug_exposure", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_device_exposure <- function(rowCount, device_exposure_id, person_id, device_concept_id, device_exposure_start_date, device_exposure_start_datetime, device_exposure_end_date, device_exposure_end_datetime, device_type_concept_id, unique_device_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, device_source_value, device_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(device_exposure_id)) {
    fields <- c(fields, "device_exposure_id")
    values <- c(values, if (is.null(device_exposure_id)) "NULL" else if (is(device_exposure_id, "subQuery")) paste0("(", as.character(device_exposure_id), ")") else paste0("'", as.character(device_exposure_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.person_id')
  }

  if (!missing(device_concept_id)) {
    fields <- c(fields, "device_concept_id")
    values <- c(values, if (is.null(device_concept_id)) "NULL" else if (is(device_concept_id, "subQuery")) paste0("(", as.character(device_concept_id), ")") else paste0("'", as.character(device_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_concept_id')
  }

  if (!missing(device_exposure_start_date)) {
    fields <- c(fields, "device_exposure_start_date")
    values <- c(values, if (is.null(device_exposure_start_date)) "NULL" else if (is(device_exposure_start_date, "subQuery")) paste0("(", as.character(device_exposure_start_date), ")") else paste0("'", as.character(device_exposure_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_start_date')
  }

  if (!missing(device_exposure_start_datetime)) {
    fields <- c(fields, "device_exposure_start_datetime")
    values <- c(values, if (is.null(device_exposure_start_datetime)) "NULL" else if (is(device_exposure_start_datetime, "subQuery")) paste0("(", as.character(device_exposure_start_datetime), ")") else paste0("'", as.character(device_exposure_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_start_datetime')
  }

  if (!missing(device_exposure_end_date)) {
    fields <- c(fields, "device_exposure_end_date")
    values <- c(values, if (is.null(device_exposure_end_date)) "NULL" else if (is(device_exposure_end_date, "subQuery")) paste0("(", as.character(device_exposure_end_date), ")") else paste0("'", as.character(device_exposure_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_end_date')
  }

  if (!missing(device_exposure_end_datetime)) {
    fields <- c(fields, "device_exposure_end_datetime")
    values <- c(values, if (is.null(device_exposure_end_datetime)) "NULL" else if (is(device_exposure_end_datetime, "subQuery")) paste0("(", as.character(device_exposure_end_datetime), ")") else paste0("'", as.character(device_exposure_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_exposure_end_datetime')
  }

  if (!missing(device_type_concept_id)) {
    fields <- c(fields, "device_type_concept_id")
    values <- c(values, if (is.null(device_type_concept_id)) "NULL" else if (is(device_type_concept_id, "subQuery")) paste0("(", as.character(device_type_concept_id), ")") else paste0("'", as.character(device_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_type_concept_id')
  }

  if (!missing(unique_device_id)) {
    fields <- c(fields, "unique_device_id")
    values <- c(values, if (is.null(unique_device_id)) "NULL" else if (is(unique_device_id, "subQuery")) paste0("(", as.character(unique_device_id), ")") else paste0("'", as.character(unique_device_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.unique_device_id')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) "NULL" else if (is(quantity, "subQuery")) paste0("(", as.character(quantity), ")") else paste0("'", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.quantity')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.visit_detail_id')
  }

  if (!missing(device_source_value)) {
    fields <- c(fields, "device_source_value")
    values <- c(values, if (is.null(device_source_value)) "NULL" else if (is(device_source_value, "subQuery")) paste0("(", as.character(device_source_value), ")") else paste0("'", as.character(device_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_source_value')
  }

  if (!missing(device_source_concept_id)) {
    fields <- c(fields, "device_source_concept_id")
    values <- c(values, if (is.null(device_source_concept_id)) "NULL" else if (is(device_source_concept_id, "subQuery")) paste0("(", as.character(device_source_concept_id), ")") else paste0("'", as.character(device_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'device_exposure.device_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "device_exposure", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_measurement <- function(rowCount, measurement_id, person_id, measurement_concept_id, measurement_date, measurement_datetime, measurement_time, measurement_type_concept_id, operator_concept_id, value_as_number, value_as_concept_id, unit_concept_id, range_low, range_high, provider_id, visit_occurrence_id, visit_detail_id, measurement_source_value, measurement_source_concept_id, unit_source_value, value_source_value) {
  fields <- c()
  values <- c()
  if (!missing(measurement_id)) {
    fields <- c(fields, "measurement_id")
    values <- c(values, if (is.null(measurement_id)) "NULL" else if (is(measurement_id, "subQuery")) paste0("(", as.character(measurement_id), ")") else paste0("'", as.character(measurement_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.person_id')
  }

  if (!missing(measurement_concept_id)) {
    fields <- c(fields, "measurement_concept_id")
    values <- c(values, if (is.null(measurement_concept_id)) "NULL" else if (is(measurement_concept_id, "subQuery")) paste0("(", as.character(measurement_concept_id), ")") else paste0("'", as.character(measurement_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_concept_id')
  }

  if (!missing(measurement_date)) {
    fields <- c(fields, "measurement_date")
    values <- c(values, if (is.null(measurement_date)) "NULL" else if (is(measurement_date, "subQuery")) paste0("(", as.character(measurement_date), ")") else paste0("'", as.character(measurement_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_date')
  }

  if (!missing(measurement_datetime)) {
    fields <- c(fields, "measurement_datetime")
    values <- c(values, if (is.null(measurement_datetime)) "NULL" else if (is(measurement_datetime, "subQuery")) paste0("(", as.character(measurement_datetime), ")") else paste0("'", as.character(measurement_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_datetime')
  }

  if (!missing(measurement_time)) {
    fields <- c(fields, "measurement_time")
    values <- c(values, if (is.null(measurement_time)) "NULL" else if (is(measurement_time, "subQuery")) paste0("(", as.character(measurement_time), ")") else paste0("'", as.character(measurement_time), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_time')
  }

  if (!missing(measurement_type_concept_id)) {
    fields <- c(fields, "measurement_type_concept_id")
    values <- c(values, if (is.null(measurement_type_concept_id)) "NULL" else if (is(measurement_type_concept_id, "subQuery")) paste0("(", as.character(measurement_type_concept_id), ")") else paste0("'", as.character(measurement_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_type_concept_id')
  }

  if (!missing(operator_concept_id)) {
    fields <- c(fields, "operator_concept_id")
    values <- c(values, if (is.null(operator_concept_id)) "NULL" else if (is(operator_concept_id, "subQuery")) paste0("(", as.character(operator_concept_id), ")") else paste0("'", as.character(operator_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.operator_concept_id')
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) "NULL" else if (is(value_as_number, "subQuery")) paste0("(", as.character(value_as_number), ")") else paste0("'", as.character(value_as_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.value_as_number')
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) "NULL" else if (is(value_as_concept_id, "subQuery")) paste0("(", as.character(value_as_concept_id), ")") else paste0("'", as.character(value_as_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.value_as_concept_id')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) "NULL" else if (is(unit_concept_id, "subQuery")) paste0("(", as.character(unit_concept_id), ")") else paste0("'", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.unit_concept_id')
  }

  if (!missing(range_low)) {
    fields <- c(fields, "range_low")
    values <- c(values, if (is.null(range_low)) "NULL" else if (is(range_low, "subQuery")) paste0("(", as.character(range_low), ")") else paste0("'", as.character(range_low), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.range_low')
  }

  if (!missing(range_high)) {
    fields <- c(fields, "range_high")
    values <- c(values, if (is.null(range_high)) "NULL" else if (is(range_high, "subQuery")) paste0("(", as.character(range_high), ")") else paste0("'", as.character(range_high), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.range_high')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.visit_detail_id')
  }

  if (!missing(measurement_source_value)) {
    fields <- c(fields, "measurement_source_value")
    values <- c(values, if (is.null(measurement_source_value)) "NULL" else if (is(measurement_source_value, "subQuery")) paste0("(", as.character(measurement_source_value), ")") else paste0("'", as.character(measurement_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_source_value')
  }

  if (!missing(measurement_source_concept_id)) {
    fields <- c(fields, "measurement_source_concept_id")
    values <- c(values, if (is.null(measurement_source_concept_id)) "NULL" else if (is(measurement_source_concept_id, "subQuery")) paste0("(", as.character(measurement_source_concept_id), ")") else paste0("'", as.character(measurement_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.measurement_source_concept_id')
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) "NULL" else if (is(unit_source_value, "subQuery")) paste0("(", as.character(unit_source_value), ")") else paste0("'", as.character(unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.unit_source_value')
  }

  if (!missing(value_source_value)) {
    fields <- c(fields, "value_source_value")
    values <- c(values, if (is.null(value_source_value)) "NULL" else if (is(value_source_value, "subQuery")) paste0("(", as.character(value_source_value), ")") else paste0("'", as.character(value_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'measurement.value_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "measurement", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_observation <- function(rowCount, observation_id, person_id, observation_concept_id, observation_date, observation_datetime, observation_type_concept_id, value_as_number, value_as_string, value_as_concept_id, qualifier_concept_id, unit_concept_id, provider_id, visit_occurrence_id, visit_detail_id, observation_source_value, observation_source_concept_id, unit_source_value, qualifier_source_value, observation_event_id, obs_event_field_concept_id, value_as_datetime) {
  fields <- c()
  values <- c()
  if (!missing(observation_id)) {
    fields <- c(fields, "observation_id")
    values <- c(values, if (is.null(observation_id)) "NULL" else if (is(observation_id, "subQuery")) paste0("(", as.character(observation_id), ")") else paste0("'", as.character(observation_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.person_id')
  }

  if (!missing(observation_concept_id)) {
    fields <- c(fields, "observation_concept_id")
    values <- c(values, if (is.null(observation_concept_id)) "NULL" else if (is(observation_concept_id, "subQuery")) paste0("(", as.character(observation_concept_id), ")") else paste0("'", as.character(observation_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_concept_id')
  }

  if (!missing(observation_date)) {
    fields <- c(fields, "observation_date")
    values <- c(values, if (is.null(observation_date)) "NULL" else if (is(observation_date, "subQuery")) paste0("(", as.character(observation_date), ")") else paste0("'", as.character(observation_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_date')
  }

  if (!missing(observation_datetime)) {
    fields <- c(fields, "observation_datetime")
    values <- c(values, if (is.null(observation_datetime)) "NULL" else if (is(observation_datetime, "subQuery")) paste0("(", as.character(observation_datetime), ")") else paste0("'", as.character(observation_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_datetime')
  }

  if (!missing(observation_type_concept_id)) {
    fields <- c(fields, "observation_type_concept_id")
    values <- c(values, if (is.null(observation_type_concept_id)) "NULL" else if (is(observation_type_concept_id, "subQuery")) paste0("(", as.character(observation_type_concept_id), ")") else paste0("'", as.character(observation_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_type_concept_id')
  }

  if (!missing(value_as_number)) {
    fields <- c(fields, "value_as_number")
    values <- c(values, if (is.null(value_as_number)) "NULL" else if (is(value_as_number, "subQuery")) paste0("(", as.character(value_as_number), ")") else paste0("'", as.character(value_as_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_as_number')
  }

  if (!missing(value_as_string)) {
    fields <- c(fields, "value_as_string")
    values <- c(values, if (is.null(value_as_string)) "NULL" else if (is(value_as_string, "subQuery")) paste0("(", as.character(value_as_string), ")") else paste0("'", as.character(value_as_string), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_as_string')
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) "NULL" else if (is(value_as_concept_id, "subQuery")) paste0("(", as.character(value_as_concept_id), ")") else paste0("'", as.character(value_as_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_as_concept_id')
  }

  if (!missing(qualifier_concept_id)) {
    fields <- c(fields, "qualifier_concept_id")
    values <- c(values, if (is.null(qualifier_concept_id)) "NULL" else if (is(qualifier_concept_id, "subQuery")) paste0("(", as.character(qualifier_concept_id), ")") else paste0("'", as.character(qualifier_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.qualifier_concept_id')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) "NULL" else if (is(unit_concept_id, "subQuery")) paste0("(", as.character(unit_concept_id), ")") else paste0("'", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.unit_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.visit_detail_id')
  }

  if (!missing(observation_source_value)) {
    fields <- c(fields, "observation_source_value")
    values <- c(values, if (is.null(observation_source_value)) "NULL" else if (is(observation_source_value, "subQuery")) paste0("(", as.character(observation_source_value), ")") else paste0("'", as.character(observation_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_source_value')
  }

  if (!missing(observation_source_concept_id)) {
    fields <- c(fields, "observation_source_concept_id")
    values <- c(values, if (is.null(observation_source_concept_id)) "NULL" else if (is(observation_source_concept_id, "subQuery")) paste0("(", as.character(observation_source_concept_id), ")") else paste0("'", as.character(observation_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_source_concept_id')
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) "NULL" else if (is(unit_source_value, "subQuery")) paste0("(", as.character(unit_source_value), ")") else paste0("'", as.character(unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.unit_source_value')
  }

  if (!missing(qualifier_source_value)) {
    fields <- c(fields, "qualifier_source_value")
    values <- c(values, if (is.null(qualifier_source_value)) "NULL" else if (is(qualifier_source_value, "subQuery")) paste0("(", as.character(qualifier_source_value), ")") else paste0("'", as.character(qualifier_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.qualifier_source_value')
  }

  if (!missing(observation_event_id)) {
    fields <- c(fields, "observation_event_id")
    values <- c(values, if (is.null(observation_event_id)) "NULL" else if (is(observation_event_id, "subQuery")) paste0("(", as.character(observation_event_id), ")") else paste0("'", as.character(observation_event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.observation_event_id')
  }

  if (!missing(obs_event_field_concept_id)) {
    fields <- c(fields, "obs_event_field_concept_id")
    values <- c(values, if (is.null(obs_event_field_concept_id)) "NULL" else if (is(obs_event_field_concept_id, "subQuery")) paste0("(", as.character(obs_event_field_concept_id), ")") else paste0("'", as.character(obs_event_field_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.obs_event_field_concept_id')
  }

  if (!missing(value_as_datetime)) {
    fields <- c(fields, "value_as_datetime")
    values <- c(values, if (is.null(value_as_datetime)) "NULL" else if (is(value_as_datetime, "subQuery")) paste0("(", as.character(value_as_datetime), ")") else paste0("'", as.character(value_as_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'observation.value_as_datetime')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "observation", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_specimen <- function(rowCount, specimen_id, person_id, specimen_concept_id, specimen_type_concept_id, specimen_date, specimen_datetime, quantity, unit_concept_id, anatomic_site_concept_id, disease_status_concept_id, specimen_source_id, specimen_source_value, unit_source_value, anatomic_site_source_value, disease_status_source_value) {
  fields <- c()
  values <- c()
  if (!missing(specimen_id)) {
    fields <- c(fields, "specimen_id")
    values <- c(values, if (is.null(specimen_id)) "NULL" else if (is(specimen_id, "subQuery")) paste0("(", as.character(specimen_id), ")") else paste0("'", as.character(specimen_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.person_id')
  }

  if (!missing(specimen_concept_id)) {
    fields <- c(fields, "specimen_concept_id")
    values <- c(values, if (is.null(specimen_concept_id)) "NULL" else if (is(specimen_concept_id, "subQuery")) paste0("(", as.character(specimen_concept_id), ")") else paste0("'", as.character(specimen_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_concept_id')
  }

  if (!missing(specimen_type_concept_id)) {
    fields <- c(fields, "specimen_type_concept_id")
    values <- c(values, if (is.null(specimen_type_concept_id)) "NULL" else if (is(specimen_type_concept_id, "subQuery")) paste0("(", as.character(specimen_type_concept_id), ")") else paste0("'", as.character(specimen_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_type_concept_id')
  }

  if (!missing(specimen_date)) {
    fields <- c(fields, "specimen_date")
    values <- c(values, if (is.null(specimen_date)) "NULL" else if (is(specimen_date, "subQuery")) paste0("(", as.character(specimen_date), ")") else paste0("'", as.character(specimen_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_date')
  }

  if (!missing(specimen_datetime)) {
    fields <- c(fields, "specimen_datetime")
    values <- c(values, if (is.null(specimen_datetime)) "NULL" else if (is(specimen_datetime, "subQuery")) paste0("(", as.character(specimen_datetime), ")") else paste0("'", as.character(specimen_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_datetime')
  }

  if (!missing(quantity)) {
    fields <- c(fields, "quantity")
    values <- c(values, if (is.null(quantity)) "NULL" else if (is(quantity, "subQuery")) paste0("(", as.character(quantity), ")") else paste0("'", as.character(quantity), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.quantity')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) "NULL" else if (is(unit_concept_id, "subQuery")) paste0("(", as.character(unit_concept_id), ")") else paste0("'", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.unit_concept_id')
  }

  if (!missing(anatomic_site_concept_id)) {
    fields <- c(fields, "anatomic_site_concept_id")
    values <- c(values, if (is.null(anatomic_site_concept_id)) "NULL" else if (is(anatomic_site_concept_id, "subQuery")) paste0("(", as.character(anatomic_site_concept_id), ")") else paste0("'", as.character(anatomic_site_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.anatomic_site_concept_id')
  }

  if (!missing(disease_status_concept_id)) {
    fields <- c(fields, "disease_status_concept_id")
    values <- c(values, if (is.null(disease_status_concept_id)) "NULL" else if (is(disease_status_concept_id, "subQuery")) paste0("(", as.character(disease_status_concept_id), ")") else paste0("'", as.character(disease_status_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.disease_status_concept_id')
  }

  if (!missing(specimen_source_id)) {
    fields <- c(fields, "specimen_source_id")
    values <- c(values, if (is.null(specimen_source_id)) "NULL" else if (is(specimen_source_id, "subQuery")) paste0("(", as.character(specimen_source_id), ")") else paste0("'", as.character(specimen_source_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_source_id')
  }

  if (!missing(specimen_source_value)) {
    fields <- c(fields, "specimen_source_value")
    values <- c(values, if (is.null(specimen_source_value)) "NULL" else if (is(specimen_source_value, "subQuery")) paste0("(", as.character(specimen_source_value), ")") else paste0("'", as.character(specimen_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.specimen_source_value')
  }

  if (!missing(unit_source_value)) {
    fields <- c(fields, "unit_source_value")
    values <- c(values, if (is.null(unit_source_value)) "NULL" else if (is(unit_source_value, "subQuery")) paste0("(", as.character(unit_source_value), ")") else paste0("'", as.character(unit_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.unit_source_value')
  }

  if (!missing(anatomic_site_source_value)) {
    fields <- c(fields, "anatomic_site_source_value")
    values <- c(values, if (is.null(anatomic_site_source_value)) "NULL" else if (is(anatomic_site_source_value, "subQuery")) paste0("(", as.character(anatomic_site_source_value), ")") else paste0("'", as.character(anatomic_site_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.anatomic_site_source_value')
  }

  if (!missing(disease_status_source_value)) {
    fields <- c(fields, "disease_status_source_value")
    values <- c(values, if (is.null(disease_status_source_value)) "NULL" else if (is(disease_status_source_value, "subQuery")) paste0("(", as.character(disease_status_source_value), ")") else paste0("'", as.character(disease_status_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'specimen.disease_status_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "specimen", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_note <- function(rowCount, note_id, person_id, note_event_id, note_event_field_concept_id, note_date, note_datetime, note_type_concept_id, note_class_concept_id, note_title, note_text, encoding_concept_id, language_concept_id, provider_id, visit_occurrence_id, visit_detail_id, note_source_value) {
  fields <- c()
  values <- c()
  if (!missing(note_id)) {
    fields <- c(fields, "note_id")
    values <- c(values, if (is.null(note_id)) "NULL" else if (is(note_id, "subQuery")) paste0("(", as.character(note_id), ")") else paste0("'", as.character(note_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.person_id')
  }

  if (!missing(note_event_id)) {
    fields <- c(fields, "note_event_id")
    values <- c(values, if (is.null(note_event_id)) "NULL" else if (is(note_event_id, "subQuery")) paste0("(", as.character(note_event_id), ")") else paste0("'", as.character(note_event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_event_id')
  }

  if (!missing(note_event_field_concept_id)) {
    fields <- c(fields, "note_event_field_concept_id")
    values <- c(values, if (is.null(note_event_field_concept_id)) "NULL" else if (is(note_event_field_concept_id, "subQuery")) paste0("(", as.character(note_event_field_concept_id), ")") else paste0("'", as.character(note_event_field_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_event_field_concept_id')
  }

  if (!missing(note_date)) {
    fields <- c(fields, "note_date")
    values <- c(values, if (is.null(note_date)) "NULL" else if (is(note_date, "subQuery")) paste0("(", as.character(note_date), ")") else paste0("'", as.character(note_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_date')
  }

  if (!missing(note_datetime)) {
    fields <- c(fields, "note_datetime")
    values <- c(values, if (is.null(note_datetime)) "NULL" else if (is(note_datetime, "subQuery")) paste0("(", as.character(note_datetime), ")") else paste0("'", as.character(note_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_datetime')
  }

  if (!missing(note_type_concept_id)) {
    fields <- c(fields, "note_type_concept_id")
    values <- c(values, if (is.null(note_type_concept_id)) "NULL" else if (is(note_type_concept_id, "subQuery")) paste0("(", as.character(note_type_concept_id), ")") else paste0("'", as.character(note_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_type_concept_id')
  }

  if (!missing(note_class_concept_id)) {
    fields <- c(fields, "note_class_concept_id")
    values <- c(values, if (is.null(note_class_concept_id)) "NULL" else if (is(note_class_concept_id, "subQuery")) paste0("(", as.character(note_class_concept_id), ")") else paste0("'", as.character(note_class_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_class_concept_id')
  }

  if (!missing(note_title)) {
    fields <- c(fields, "note_title")
    values <- c(values, if (is.null(note_title)) "NULL" else if (is(note_title, "subQuery")) paste0("(", as.character(note_title), ")") else paste0("'", as.character(note_title), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_title')
  }

  if (!missing(note_text)) {
    fields <- c(fields, "note_text")
    values <- c(values, if (is.null(note_text)) "NULL" else if (is(note_text, "subQuery")) paste0("(", as.character(note_text), ")") else paste0("'", as.character(note_text), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_text')
  }

  if (!missing(encoding_concept_id)) {
    fields <- c(fields, "encoding_concept_id")
    values <- c(values, if (is.null(encoding_concept_id)) "NULL" else if (is(encoding_concept_id, "subQuery")) paste0("(", as.character(encoding_concept_id), ")") else paste0("'", as.character(encoding_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.encoding_concept_id')
  }

  if (!missing(language_concept_id)) {
    fields <- c(fields, "language_concept_id")
    values <- c(values, if (is.null(language_concept_id)) "NULL" else if (is(language_concept_id, "subQuery")) paste0("(", as.character(language_concept_id), ")") else paste0("'", as.character(language_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.language_concept_id')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.provider_id')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.visit_occurrence_id')
  }

  if (!missing(visit_detail_id)) {
    fields <- c(fields, "visit_detail_id")
    values <- c(values, if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.visit_detail_id')
  }

  if (!missing(note_source_value)) {
    fields <- c(fields, "note_source_value")
    values <- c(values, if (is.null(note_source_value)) "NULL" else if (is(note_source_value, "subQuery")) paste0("(", as.character(note_source_value), ")") else paste0("'", as.character(note_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note.note_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "note", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_note_nlp <- function(rowCount, note_nlp_id, note_id, section_concept_id, snippet, offset, lexical_variant, note_nlp_concept_id, note_nlp_source_concept_id, nlp_system, nlp_date, nlp_datetime, term_exists, term_temporal, term_modifiers) {
  fields <- c()
  values <- c()
  if (!missing(note_nlp_id)) {
    fields <- c(fields, "note_nlp_id")
    values <- c(values, if (is.null(note_nlp_id)) "NULL" else if (is(note_nlp_id, "subQuery")) paste0("(", as.character(note_nlp_id), ")") else paste0("'", as.character(note_nlp_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_nlp_id')
  }

  if (!missing(note_id)) {
    fields <- c(fields, "note_id")
    values <- c(values, if (is.null(note_id)) "NULL" else if (is(note_id, "subQuery")) paste0("(", as.character(note_id), ")") else paste0("'", as.character(note_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_id')
  }

  if (!missing(section_concept_id)) {
    fields <- c(fields, "section_concept_id")
    values <- c(values, if (is.null(section_concept_id)) "NULL" else if (is(section_concept_id, "subQuery")) paste0("(", as.character(section_concept_id), ")") else paste0("'", as.character(section_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.section_concept_id')
  }

  if (!missing(snippet)) {
    fields <- c(fields, "snippet")
    values <- c(values, if (is.null(snippet)) "NULL" else if (is(snippet, "subQuery")) paste0("(", as.character(snippet), ")") else paste0("'", as.character(snippet), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.snippet')
  }

  if (!missing(offset)) {
    fields <- c(fields, "offset")
    values <- c(values, if (is.null(offset)) "NULL" else if (is(offset, "subQuery")) paste0("(", as.character(offset), ")") else paste0("'", as.character(offset), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.offset')
  }

  if (!missing(lexical_variant)) {
    fields <- c(fields, "lexical_variant")
    values <- c(values, if (is.null(lexical_variant)) "NULL" else if (is(lexical_variant, "subQuery")) paste0("(", as.character(lexical_variant), ")") else paste0("'", as.character(lexical_variant), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.lexical_variant')
  }

  if (!missing(note_nlp_concept_id)) {
    fields <- c(fields, "note_nlp_concept_id")
    values <- c(values, if (is.null(note_nlp_concept_id)) "NULL" else if (is(note_nlp_concept_id, "subQuery")) paste0("(", as.character(note_nlp_concept_id), ")") else paste0("'", as.character(note_nlp_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_nlp_concept_id')
  }

  if (!missing(note_nlp_source_concept_id)) {
    fields <- c(fields, "note_nlp_source_concept_id")
    values <- c(values, if (is.null(note_nlp_source_concept_id)) "NULL" else if (is(note_nlp_source_concept_id, "subQuery")) paste0("(", as.character(note_nlp_source_concept_id), ")") else paste0("'", as.character(note_nlp_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.note_nlp_source_concept_id')
  }

  if (!missing(nlp_system)) {
    fields <- c(fields, "nlp_system")
    values <- c(values, if (is.null(nlp_system)) "NULL" else if (is(nlp_system, "subQuery")) paste0("(", as.character(nlp_system), ")") else paste0("'", as.character(nlp_system), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.nlp_system')
  }

  if (!missing(nlp_date)) {
    fields <- c(fields, "nlp_date")
    values <- c(values, if (is.null(nlp_date)) "NULL" else if (is(nlp_date, "subQuery")) paste0("(", as.character(nlp_date), ")") else paste0("'", as.character(nlp_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.nlp_date')
  }

  if (!missing(nlp_datetime)) {
    fields <- c(fields, "nlp_datetime")
    values <- c(values, if (is.null(nlp_datetime)) "NULL" else if (is(nlp_datetime, "subQuery")) paste0("(", as.character(nlp_datetime), ")") else paste0("'", as.character(nlp_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.nlp_datetime')
  }

  if (!missing(term_exists)) {
    fields <- c(fields, "term_exists")
    values <- c(values, if (is.null(term_exists)) "NULL" else if (is(term_exists, "subQuery")) paste0("(", as.character(term_exists), ")") else paste0("'", as.character(term_exists), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.term_exists')
  }

  if (!missing(term_temporal)) {
    fields <- c(fields, "term_temporal")
    values <- c(values, if (is.null(term_temporal)) "NULL" else if (is(term_temporal, "subQuery")) paste0("(", as.character(term_temporal), ")") else paste0("'", as.character(term_temporal), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.term_temporal')
  }

  if (!missing(term_modifiers)) {
    fields <- c(fields, "term_modifiers")
    values <- c(values, if (is.null(term_modifiers)) "NULL" else if (is(term_modifiers, "subQuery")) paste0("(", as.character(term_modifiers), ")") else paste0("'", as.character(term_modifiers), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'note_nlp.term_modifiers')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "note_nlp", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_survey_conduct <- function(rowCount, survey_conduct_id, person_id, survey_concept_id, survey_start_date, survey_start_datetime, survey_end_date, survey_end_datetime, provider_id, assisted_concept_id, respondent_type_concept_id, timing_concept_id, collection_method_concept_id, assisted_source_value, respondent_type_source_value, timing_source_value, collection_method_source_value, survey_source_value, survey_source_concept_id, survey_source_identifier, validated_survey_concept_id, validated_survey_source_value, survey_version_number, visit_occurrence_id, response_visit_occurrence_id) {
  fields <- c()
  values <- c()
  if (!missing(survey_conduct_id)) {
    fields <- c(fields, "survey_conduct_id")
    values <- c(values, if (is.null(survey_conduct_id)) "NULL" else if (is(survey_conduct_id, "subQuery")) paste0("(", as.character(survey_conduct_id), ")") else paste0("'", as.character(survey_conduct_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.survey_conduct_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.person_id')
  }

  if (!missing(survey_concept_id)) {
    fields <- c(fields, "survey_concept_id")
    values <- c(values, if (is.null(survey_concept_id)) "NULL" else if (is(survey_concept_id, "subQuery")) paste0("(", as.character(survey_concept_id), ")") else paste0("'", as.character(survey_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.survey_concept_id')
  }

  if (!missing(survey_start_date)) {
    fields <- c(fields, "survey_start_date")
    values <- c(values, if (is.null(survey_start_date)) "NULL" else if (is(survey_start_date, "subQuery")) paste0("(", as.character(survey_start_date), ")") else paste0("'", as.character(survey_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.survey_start_date')
  }

  if (!missing(survey_start_datetime)) {
    fields <- c(fields, "survey_start_datetime")
    values <- c(values, if (is.null(survey_start_datetime)) "NULL" else if (is(survey_start_datetime, "subQuery")) paste0("(", as.character(survey_start_datetime), ")") else paste0("'", as.character(survey_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.survey_start_datetime')
  }

  if (!missing(survey_end_date)) {
    fields <- c(fields, "survey_end_date")
    values <- c(values, if (is.null(survey_end_date)) "NULL" else if (is(survey_end_date, "subQuery")) paste0("(", as.character(survey_end_date), ")") else paste0("'", as.character(survey_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.survey_end_date')
  }

  if (!missing(survey_end_datetime)) {
    fields <- c(fields, "survey_end_datetime")
    values <- c(values, if (is.null(survey_end_datetime)) "NULL" else if (is(survey_end_datetime, "subQuery")) paste0("(", as.character(survey_end_datetime), ")") else paste0("'", as.character(survey_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.survey_end_datetime')
  }

  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.provider_id')
  }

  if (!missing(assisted_concept_id)) {
    fields <- c(fields, "assisted_concept_id")
    values <- c(values, if (is.null(assisted_concept_id)) "NULL" else if (is(assisted_concept_id, "subQuery")) paste0("(", as.character(assisted_concept_id), ")") else paste0("'", as.character(assisted_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.assisted_concept_id')
  }

  if (!missing(respondent_type_concept_id)) {
    fields <- c(fields, "respondent_type_concept_id")
    values <- c(values, if (is.null(respondent_type_concept_id)) "NULL" else if (is(respondent_type_concept_id, "subQuery")) paste0("(", as.character(respondent_type_concept_id), ")") else paste0("'", as.character(respondent_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.respondent_type_concept_id')
  }

  if (!missing(timing_concept_id)) {
    fields <- c(fields, "timing_concept_id")
    values <- c(values, if (is.null(timing_concept_id)) "NULL" else if (is(timing_concept_id, "subQuery")) paste0("(", as.character(timing_concept_id), ")") else paste0("'", as.character(timing_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.timing_concept_id')
  }

  if (!missing(collection_method_concept_id)) {
    fields <- c(fields, "collection_method_concept_id")
    values <- c(values, if (is.null(collection_method_concept_id)) "NULL" else if (is(collection_method_concept_id, "subQuery")) paste0("(", as.character(collection_method_concept_id), ")") else paste0("'", as.character(collection_method_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.collection_method_concept_id')
  }

  if (!missing(assisted_source_value)) {
    fields <- c(fields, "assisted_source_value")
    values <- c(values, if (is.null(assisted_source_value)) "NULL" else if (is(assisted_source_value, "subQuery")) paste0("(", as.character(assisted_source_value), ")") else paste0("'", as.character(assisted_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.assisted_source_value')
  }

  if (!missing(respondent_type_source_value)) {
    fields <- c(fields, "respondent_type_source_value")
    values <- c(values, if (is.null(respondent_type_source_value)) "NULL" else if (is(respondent_type_source_value, "subQuery")) paste0("(", as.character(respondent_type_source_value), ")") else paste0("'", as.character(respondent_type_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.respondent_type_source_value')
  }

  if (!missing(timing_source_value)) {
    fields <- c(fields, "timing_source_value")
    values <- c(values, if (is.null(timing_source_value)) "NULL" else if (is(timing_source_value, "subQuery")) paste0("(", as.character(timing_source_value), ")") else paste0("'", as.character(timing_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.timing_source_value')
  }

  if (!missing(collection_method_source_value)) {
    fields <- c(fields, "collection_method_source_value")
    values <- c(values, if (is.null(collection_method_source_value)) "NULL" else if (is(collection_method_source_value, "subQuery")) paste0("(", as.character(collection_method_source_value), ")") else paste0("'", as.character(collection_method_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.collection_method_source_value')
  }

  if (!missing(survey_source_value)) {
    fields <- c(fields, "survey_source_value")
    values <- c(values, if (is.null(survey_source_value)) "NULL" else if (is(survey_source_value, "subQuery")) paste0("(", as.character(survey_source_value), ")") else paste0("'", as.character(survey_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.survey_source_value')
  }

  if (!missing(survey_source_concept_id)) {
    fields <- c(fields, "survey_source_concept_id")
    values <- c(values, if (is.null(survey_source_concept_id)) "NULL" else if (is(survey_source_concept_id, "subQuery")) paste0("(", as.character(survey_source_concept_id), ")") else paste0("'", as.character(survey_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.survey_source_concept_id')
  }

  if (!missing(survey_source_identifier)) {
    fields <- c(fields, "survey_source_identifier")
    values <- c(values, if (is.null(survey_source_identifier)) "NULL" else if (is(survey_source_identifier, "subQuery")) paste0("(", as.character(survey_source_identifier), ")") else paste0("'", as.character(survey_source_identifier), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.survey_source_identifier')
  }

  if (!missing(validated_survey_concept_id)) {
    fields <- c(fields, "validated_survey_concept_id")
    values <- c(values, if (is.null(validated_survey_concept_id)) "NULL" else if (is(validated_survey_concept_id, "subQuery")) paste0("(", as.character(validated_survey_concept_id), ")") else paste0("'", as.character(validated_survey_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.validated_survey_concept_id')
  }

  if (!missing(validated_survey_source_value)) {
    fields <- c(fields, "validated_survey_source_value")
    values <- c(values, if (is.null(validated_survey_source_value)) "NULL" else if (is(validated_survey_source_value, "subQuery")) paste0("(", as.character(validated_survey_source_value), ")") else paste0("'", as.character(validated_survey_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.validated_survey_source_value')
  }

  if (!missing(survey_version_number)) {
    fields <- c(fields, "survey_version_number")
    values <- c(values, if (is.null(survey_version_number)) "NULL" else if (is(survey_version_number, "subQuery")) paste0("(", as.character(survey_version_number), ")") else paste0("'", as.character(survey_version_number), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.survey_version_number')
  }

  if (!missing(visit_occurrence_id)) {
    fields <- c(fields, "visit_occurrence_id")
    values <- c(values, if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.visit_occurrence_id')
  }

  if (!missing(response_visit_occurrence_id)) {
    fields <- c(fields, "response_visit_occurrence_id")
    values <- c(values, if (is.null(response_visit_occurrence_id)) "NULL" else if (is(response_visit_occurrence_id, "subQuery")) paste0("(", as.character(response_visit_occurrence_id), ")") else paste0("'", as.character(response_visit_occurrence_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'survey_conduct.response_visit_occurrence_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "survey_conduct", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_cost <- function(rowCount, cost_id, person_id, cost_event_id, cost_event_field_concept_id, cost_concept_id, cost_type_concept_id, cost_source_concept_id, cost_source_value, currency_concept_id, cost, incurred_date, billed_date, paid_date, revenue_code_concept_id, drg_concept_id, revenue_code_source_value, drg_source_value, payer_plan_period_id) {
  fields <- c()
  values <- c()
  if (!missing(cost_id)) {
    fields <- c(fields, "cost_id")
    values <- c(values, if (is.null(cost_id)) "NULL" else if (is(cost_id, "subQuery")) paste0("(", as.character(cost_id), ")") else paste0("'", as.character(cost_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.person_id')
  }

  if (!missing(cost_event_id)) {
    fields <- c(fields, "cost_event_id")
    values <- c(values, if (is.null(cost_event_id)) "NULL" else if (is(cost_event_id, "subQuery")) paste0("(", as.character(cost_event_id), ")") else paste0("'", as.character(cost_event_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_event_id')
  }

  if (!missing(cost_event_field_concept_id)) {
    fields <- c(fields, "cost_event_field_concept_id")
    values <- c(values, if (is.null(cost_event_field_concept_id)) "NULL" else if (is(cost_event_field_concept_id, "subQuery")) paste0("(", as.character(cost_event_field_concept_id), ")") else paste0("'", as.character(cost_event_field_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_event_field_concept_id')
  }

  if (!missing(cost_concept_id)) {
    fields <- c(fields, "cost_concept_id")
    values <- c(values, if (is.null(cost_concept_id)) "NULL" else if (is(cost_concept_id, "subQuery")) paste0("(", as.character(cost_concept_id), ")") else paste0("'", as.character(cost_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_concept_id')
  }

  if (!missing(cost_type_concept_id)) {
    fields <- c(fields, "cost_type_concept_id")
    values <- c(values, if (is.null(cost_type_concept_id)) "NULL" else if (is(cost_type_concept_id, "subQuery")) paste0("(", as.character(cost_type_concept_id), ")") else paste0("'", as.character(cost_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_type_concept_id')
  }

  if (!missing(cost_source_concept_id)) {
    fields <- c(fields, "cost_source_concept_id")
    values <- c(values, if (is.null(cost_source_concept_id)) "NULL" else if (is(cost_source_concept_id, "subQuery")) paste0("(", as.character(cost_source_concept_id), ")") else paste0("'", as.character(cost_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_source_concept_id')
  }

  if (!missing(cost_source_value)) {
    fields <- c(fields, "cost_source_value")
    values <- c(values, if (is.null(cost_source_value)) "NULL" else if (is(cost_source_value, "subQuery")) paste0("(", as.character(cost_source_value), ")") else paste0("'", as.character(cost_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost_source_value')
  }

  if (!missing(currency_concept_id)) {
    fields <- c(fields, "currency_concept_id")
    values <- c(values, if (is.null(currency_concept_id)) "NULL" else if (is(currency_concept_id, "subQuery")) paste0("(", as.character(currency_concept_id), ")") else paste0("'", as.character(currency_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.currency_concept_id')
  }

  if (!missing(cost)) {
    fields <- c(fields, "cost")
    values <- c(values, if (is.null(cost)) "NULL" else if (is(cost, "subQuery")) paste0("(", as.character(cost), ")") else paste0("'", as.character(cost), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.cost')
  }

  if (!missing(incurred_date)) {
    fields <- c(fields, "incurred_date")
    values <- c(values, if (is.null(incurred_date)) "NULL" else if (is(incurred_date, "subQuery")) paste0("(", as.character(incurred_date), ")") else paste0("'", as.character(incurred_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.incurred_date')
  }

  if (!missing(billed_date)) {
    fields <- c(fields, "billed_date")
    values <- c(values, if (is.null(billed_date)) "NULL" else if (is(billed_date, "subQuery")) paste0("(", as.character(billed_date), ")") else paste0("'", as.character(billed_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.billed_date')
  }

  if (!missing(paid_date)) {
    fields <- c(fields, "paid_date")
    values <- c(values, if (is.null(paid_date)) "NULL" else if (is(paid_date, "subQuery")) paste0("(", as.character(paid_date), ")") else paste0("'", as.character(paid_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.paid_date')
  }

  if (!missing(revenue_code_concept_id)) {
    fields <- c(fields, "revenue_code_concept_id")
    values <- c(values, if (is.null(revenue_code_concept_id)) "NULL" else if (is(revenue_code_concept_id, "subQuery")) paste0("(", as.character(revenue_code_concept_id), ")") else paste0("'", as.character(revenue_code_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.revenue_code_concept_id')
  }

  if (!missing(drg_concept_id)) {
    fields <- c(fields, "drg_concept_id")
    values <- c(values, if (is.null(drg_concept_id)) "NULL" else if (is(drg_concept_id, "subQuery")) paste0("(", as.character(drg_concept_id), ")") else paste0("'", as.character(drg_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.drg_concept_id')
  }

  if (!missing(revenue_code_source_value)) {
    fields <- c(fields, "revenue_code_source_value")
    values <- c(values, if (is.null(revenue_code_source_value)) "NULL" else if (is(revenue_code_source_value, "subQuery")) paste0("(", as.character(revenue_code_source_value), ")") else paste0("'", as.character(revenue_code_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.revenue_code_source_value')
  }

  if (!missing(drg_source_value)) {
    fields <- c(fields, "drg_source_value")
    values <- c(values, if (is.null(drg_source_value)) "NULL" else if (is(drg_source_value, "subQuery")) paste0("(", as.character(drg_source_value), ")") else paste0("'", as.character(drg_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.drg_source_value')
  }

  if (!missing(payer_plan_period_id)) {
    fields <- c(fields, "payer_plan_period_id")
    values <- c(values, if (is.null(payer_plan_period_id)) "NULL" else if (is(payer_plan_period_id, "subQuery")) paste0("(", as.character(payer_plan_period_id), ")") else paste0("'", as.character(payer_plan_period_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cost.payer_plan_period_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "cost", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_payer_plan_period <- function(rowCount, payer_plan_period_id, person_id, contract_person_id, payer_plan_period_start_date, payer_plan_period_end_date, payer_concept_id, payer_source_value, payer_source_concept_id, plan_concept_id, plan_source_value, plan_source_concept_id, contract_concept_id, contract_source_value, contract_source_concept_id, sponsor_concept_id, sponsor_source_value, sponsor_source_concept_id, family_source_value, stop_reason_concept_id, stop_reason_source_value, stop_reason_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(payer_plan_period_id)) {
    fields <- c(fields, "payer_plan_period_id")
    values <- c(values, if (is.null(payer_plan_period_id)) "NULL" else if (is(payer_plan_period_id, "subQuery")) paste0("(", as.character(payer_plan_period_id), ")") else paste0("'", as.character(payer_plan_period_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_plan_period_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.person_id')
  }

  if (!missing(contract_person_id)) {
    fields <- c(fields, "contract_person_id")
    values <- c(values, if (is.null(contract_person_id)) "NULL" else if (is(contract_person_id, "subQuery")) paste0("(", as.character(contract_person_id), ")") else paste0("'", as.character(contract_person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.contract_person_id')
  }

  if (!missing(payer_plan_period_start_date)) {
    fields <- c(fields, "payer_plan_period_start_date")
    values <- c(values, if (is.null(payer_plan_period_start_date)) "NULL" else if (is(payer_plan_period_start_date, "subQuery")) paste0("(", as.character(payer_plan_period_start_date), ")") else paste0("'", as.character(payer_plan_period_start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_plan_period_start_date')
  }

  if (!missing(payer_plan_period_end_date)) {
    fields <- c(fields, "payer_plan_period_end_date")
    values <- c(values, if (is.null(payer_plan_period_end_date)) "NULL" else if (is(payer_plan_period_end_date, "subQuery")) paste0("(", as.character(payer_plan_period_end_date), ")") else paste0("'", as.character(payer_plan_period_end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_plan_period_end_date')
  }

  if (!missing(payer_concept_id)) {
    fields <- c(fields, "payer_concept_id")
    values <- c(values, if (is.null(payer_concept_id)) "NULL" else if (is(payer_concept_id, "subQuery")) paste0("(", as.character(payer_concept_id), ")") else paste0("'", as.character(payer_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_concept_id')
  }

  if (!missing(payer_source_value)) {
    fields <- c(fields, "payer_source_value")
    values <- c(values, if (is.null(payer_source_value)) "NULL" else if (is(payer_source_value, "subQuery")) paste0("(", as.character(payer_source_value), ")") else paste0("'", as.character(payer_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_source_value')
  }

  if (!missing(payer_source_concept_id)) {
    fields <- c(fields, "payer_source_concept_id")
    values <- c(values, if (is.null(payer_source_concept_id)) "NULL" else if (is(payer_source_concept_id, "subQuery")) paste0("(", as.character(payer_source_concept_id), ")") else paste0("'", as.character(payer_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.payer_source_concept_id')
  }

  if (!missing(plan_concept_id)) {
    fields <- c(fields, "plan_concept_id")
    values <- c(values, if (is.null(plan_concept_id)) "NULL" else if (is(plan_concept_id, "subQuery")) paste0("(", as.character(plan_concept_id), ")") else paste0("'", as.character(plan_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.plan_concept_id')
  }

  if (!missing(plan_source_value)) {
    fields <- c(fields, "plan_source_value")
    values <- c(values, if (is.null(plan_source_value)) "NULL" else if (is(plan_source_value, "subQuery")) paste0("(", as.character(plan_source_value), ")") else paste0("'", as.character(plan_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.plan_source_value')
  }

  if (!missing(plan_source_concept_id)) {
    fields <- c(fields, "plan_source_concept_id")
    values <- c(values, if (is.null(plan_source_concept_id)) "NULL" else if (is(plan_source_concept_id, "subQuery")) paste0("(", as.character(plan_source_concept_id), ")") else paste0("'", as.character(plan_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.plan_source_concept_id')
  }

  if (!missing(contract_concept_id)) {
    fields <- c(fields, "contract_concept_id")
    values <- c(values, if (is.null(contract_concept_id)) "NULL" else if (is(contract_concept_id, "subQuery")) paste0("(", as.character(contract_concept_id), ")") else paste0("'", as.character(contract_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.contract_concept_id')
  }

  if (!missing(contract_source_value)) {
    fields <- c(fields, "contract_source_value")
    values <- c(values, if (is.null(contract_source_value)) "NULL" else if (is(contract_source_value, "subQuery")) paste0("(", as.character(contract_source_value), ")") else paste0("'", as.character(contract_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.contract_source_value')
  }

  if (!missing(contract_source_concept_id)) {
    fields <- c(fields, "contract_source_concept_id")
    values <- c(values, if (is.null(contract_source_concept_id)) "NULL" else if (is(contract_source_concept_id, "subQuery")) paste0("(", as.character(contract_source_concept_id), ")") else paste0("'", as.character(contract_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.contract_source_concept_id')
  }

  if (!missing(sponsor_concept_id)) {
    fields <- c(fields, "sponsor_concept_id")
    values <- c(values, if (is.null(sponsor_concept_id)) "NULL" else if (is(sponsor_concept_id, "subQuery")) paste0("(", as.character(sponsor_concept_id), ")") else paste0("'", as.character(sponsor_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.sponsor_concept_id')
  }

  if (!missing(sponsor_source_value)) {
    fields <- c(fields, "sponsor_source_value")
    values <- c(values, if (is.null(sponsor_source_value)) "NULL" else if (is(sponsor_source_value, "subQuery")) paste0("(", as.character(sponsor_source_value), ")") else paste0("'", as.character(sponsor_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.sponsor_source_value')
  }

  if (!missing(sponsor_source_concept_id)) {
    fields <- c(fields, "sponsor_source_concept_id")
    values <- c(values, if (is.null(sponsor_source_concept_id)) "NULL" else if (is(sponsor_source_concept_id, "subQuery")) paste0("(", as.character(sponsor_source_concept_id), ")") else paste0("'", as.character(sponsor_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.sponsor_source_concept_id')
  }

  if (!missing(family_source_value)) {
    fields <- c(fields, "family_source_value")
    values <- c(values, if (is.null(family_source_value)) "NULL" else if (is(family_source_value, "subQuery")) paste0("(", as.character(family_source_value), ")") else paste0("'", as.character(family_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.family_source_value')
  }

  if (!missing(stop_reason_concept_id)) {
    fields <- c(fields, "stop_reason_concept_id")
    values <- c(values, if (is.null(stop_reason_concept_id)) "NULL" else if (is(stop_reason_concept_id, "subQuery")) paste0("(", as.character(stop_reason_concept_id), ")") else paste0("'", as.character(stop_reason_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.stop_reason_concept_id')
  }

  if (!missing(stop_reason_source_value)) {
    fields <- c(fields, "stop_reason_source_value")
    values <- c(values, if (is.null(stop_reason_source_value)) "NULL" else if (is(stop_reason_source_value, "subQuery")) paste0("(", as.character(stop_reason_source_value), ")") else paste0("'", as.character(stop_reason_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.stop_reason_source_value')
  }

  if (!missing(stop_reason_source_concept_id)) {
    fields <- c(fields, "stop_reason_source_concept_id")
    values <- c(values, if (is.null(stop_reason_source_concept_id)) "NULL" else if (is(stop_reason_source_concept_id, "subQuery")) paste0("(", as.character(stop_reason_source_concept_id), ")") else paste0("'", as.character(stop_reason_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'payer_plan_period.stop_reason_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "payer_plan_period", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_drug_era <- function(rowCount, drug_era_id, person_id, drug_concept_id, drug_era_start_datetime, drug_era_end_datetime, drug_exposure_count, gap_days) {
  fields <- c()
  values <- c()
  if (!missing(drug_era_id)) {
    fields <- c(fields, "drug_era_id")
    values <- c(values, if (is.null(drug_era_id)) "NULL" else if (is(drug_era_id, "subQuery")) paste0("(", as.character(drug_era_id), ")") else paste0("'", as.character(drug_era_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_era_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.person_id')
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) "NULL" else if (is(drug_concept_id, "subQuery")) paste0("(", as.character(drug_concept_id), ")") else paste0("'", as.character(drug_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_concept_id')
  }

  if (!missing(drug_era_start_datetime)) {
    fields <- c(fields, "drug_era_start_datetime")
    values <- c(values, if (is.null(drug_era_start_datetime)) "NULL" else if (is(drug_era_start_datetime, "subQuery")) paste0("(", as.character(drug_era_start_datetime), ")") else paste0("'", as.character(drug_era_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_era_start_datetime')
  }

  if (!missing(drug_era_end_datetime)) {
    fields <- c(fields, "drug_era_end_datetime")
    values <- c(values, if (is.null(drug_era_end_datetime)) "NULL" else if (is(drug_era_end_datetime, "subQuery")) paste0("(", as.character(drug_era_end_datetime), ")") else paste0("'", as.character(drug_era_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_era_end_datetime')
  }

  if (!missing(drug_exposure_count)) {
    fields <- c(fields, "drug_exposure_count")
    values <- c(values, if (is.null(drug_exposure_count)) "NULL" else if (is(drug_exposure_count, "subQuery")) paste0("(", as.character(drug_exposure_count), ")") else paste0("'", as.character(drug_exposure_count), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.drug_exposure_count')
  }

  if (!missing(gap_days)) {
    fields <- c(fields, "gap_days")
    values <- c(values, if (is.null(gap_days)) "NULL" else if (is(gap_days, "subQuery")) paste0("(", as.character(gap_days), ")") else paste0("'", as.character(gap_days), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'drug_era.gap_days')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "drug_era", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_dose_era <- function(rowCount, dose_era_id, person_id, drug_concept_id, unit_concept_id, dose_value, dose_era_start_datetime, dose_era_end_datetime) {
  fields <- c()
  values <- c()
  if (!missing(dose_era_id)) {
    fields <- c(fields, "dose_era_id")
    values <- c(values, if (is.null(dose_era_id)) "NULL" else if (is(dose_era_id, "subQuery")) paste0("(", as.character(dose_era_id), ")") else paste0("'", as.character(dose_era_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_era_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.person_id')
  }

  if (!missing(drug_concept_id)) {
    fields <- c(fields, "drug_concept_id")
    values <- c(values, if (is.null(drug_concept_id)) "NULL" else if (is(drug_concept_id, "subQuery")) paste0("(", as.character(drug_concept_id), ")") else paste0("'", as.character(drug_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.drug_concept_id')
  }

  if (!missing(unit_concept_id)) {
    fields <- c(fields, "unit_concept_id")
    values <- c(values, if (is.null(unit_concept_id)) "NULL" else if (is(unit_concept_id, "subQuery")) paste0("(", as.character(unit_concept_id), ")") else paste0("'", as.character(unit_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.unit_concept_id')
  }

  if (!missing(dose_value)) {
    fields <- c(fields, "dose_value")
    values <- c(values, if (is.null(dose_value)) "NULL" else if (is(dose_value, "subQuery")) paste0("(", as.character(dose_value), ")") else paste0("'", as.character(dose_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_value')
  }

  if (!missing(dose_era_start_datetime)) {
    fields <- c(fields, "dose_era_start_datetime")
    values <- c(values, if (is.null(dose_era_start_datetime)) "NULL" else if (is(dose_era_start_datetime, "subQuery")) paste0("(", as.character(dose_era_start_datetime), ")") else paste0("'", as.character(dose_era_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_era_start_datetime')
  }

  if (!missing(dose_era_end_datetime)) {
    fields <- c(fields, "dose_era_end_datetime")
    values <- c(values, if (is.null(dose_era_end_datetime)) "NULL" else if (is(dose_era_end_datetime, "subQuery")) paste0("(", as.character(dose_era_end_datetime), ")") else paste0("'", as.character(dose_era_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'dose_era.dose_era_end_datetime')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "dose_era", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_condition_era <- function(rowCount, condition_era_id, person_id, condition_concept_id, condition_era_start_datetime, condition_era_end_datetime, condition_occurrence_count) {
  fields <- c()
  values <- c()
  if (!missing(condition_era_id)) {
    fields <- c(fields, "condition_era_id")
    values <- c(values, if (is.null(condition_era_id)) "NULL" else if (is(condition_era_id, "subQuery")) paste0("(", as.character(condition_era_id), ")") else paste0("'", as.character(condition_era_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_era_id')
  }

  if (!missing(person_id)) {
    fields <- c(fields, "person_id")
    values <- c(values, if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.person_id')
  }

  if (!missing(condition_concept_id)) {
    fields <- c(fields, "condition_concept_id")
    values <- c(values, if (is.null(condition_concept_id)) "NULL" else if (is(condition_concept_id, "subQuery")) paste0("(", as.character(condition_concept_id), ")") else paste0("'", as.character(condition_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_concept_id')
  }

  if (!missing(condition_era_start_datetime)) {
    fields <- c(fields, "condition_era_start_datetime")
    values <- c(values, if (is.null(condition_era_start_datetime)) "NULL" else if (is(condition_era_start_datetime, "subQuery")) paste0("(", as.character(condition_era_start_datetime), ")") else paste0("'", as.character(condition_era_start_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_era_start_datetime')
  }

  if (!missing(condition_era_end_datetime)) {
    fields <- c(fields, "condition_era_end_datetime")
    values <- c(values, if (is.null(condition_era_end_datetime)) "NULL" else if (is(condition_era_end_datetime, "subQuery")) paste0("(", as.character(condition_era_end_datetime), ")") else paste0("'", as.character(condition_era_end_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_era_end_datetime')
  }

  if (!missing(condition_occurrence_count)) {
    fields <- c(fields, "condition_occurrence_count")
    values <- c(values, if (is.null(condition_occurrence_count)) "NULL" else if (is(condition_occurrence_count, "subQuery")) paste0("(", as.character(condition_occurrence_count), ")") else paste0("'", as.character(condition_occurrence_count), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'condition_era.condition_occurrence_count')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "condition_era", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_location <- function(rowCount, location_id, address_1, address_2, city, state, zip, county, country, location_source_value, latitude, longitude) {
  fields <- c()
  values <- c()
  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) "NULL" else if (is(location_id, "subQuery")) paste0("(", as.character(location_id), ")") else paste0("'", as.character(location_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.location_id')
  }

  if (!missing(address_1)) {
    fields <- c(fields, "address_1")
    values <- c(values, if (is.null(address_1)) "NULL" else if (is(address_1, "subQuery")) paste0("(", as.character(address_1), ")") else paste0("'", as.character(address_1), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.address_1')
  }

  if (!missing(address_2)) {
    fields <- c(fields, "address_2")
    values <- c(values, if (is.null(address_2)) "NULL" else if (is(address_2, "subQuery")) paste0("(", as.character(address_2), ")") else paste0("'", as.character(address_2), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.address_2')
  }

  if (!missing(city)) {
    fields <- c(fields, "city")
    values <- c(values, if (is.null(city)) "NULL" else if (is(city, "subQuery")) paste0("(", as.character(city), ")") else paste0("'", as.character(city), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.city')
  }

  if (!missing(state)) {
    fields <- c(fields, "state")
    values <- c(values, if (is.null(state)) "NULL" else if (is(state, "subQuery")) paste0("(", as.character(state), ")") else paste0("'", as.character(state), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.state')
  }

  if (!missing(zip)) {
    fields <- c(fields, "zip")
    values <- c(values, if (is.null(zip)) "NULL" else if (is(zip, "subQuery")) paste0("(", as.character(zip), ")") else paste0("'", as.character(zip), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.zip')
  }

  if (!missing(county)) {
    fields <- c(fields, "county")
    values <- c(values, if (is.null(county)) "NULL" else if (is(county, "subQuery")) paste0("(", as.character(county), ")") else paste0("'", as.character(county), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.county')
  }

  if (!missing(country)) {
    fields <- c(fields, "country")
    values <- c(values, if (is.null(country)) "NULL" else if (is(country, "subQuery")) paste0("(", as.character(country), ")") else paste0("'", as.character(country), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.country')
  }

  if (!missing(location_source_value)) {
    fields <- c(fields, "location_source_value")
    values <- c(values, if (is.null(location_source_value)) "NULL" else if (is(location_source_value, "subQuery")) paste0("(", as.character(location_source_value), ")") else paste0("'", as.character(location_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.location_source_value')
  }

  if (!missing(latitude)) {
    fields <- c(fields, "latitude")
    values <- c(values, if (is.null(latitude)) "NULL" else if (is(latitude, "subQuery")) paste0("(", as.character(latitude), ")") else paste0("'", as.character(latitude), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.latitude')
  }

  if (!missing(longitude)) {
    fields <- c(fields, "longitude")
    values <- c(values, if (is.null(longitude)) "NULL" else if (is(longitude, "subQuery")) paste0("(", as.character(longitude), ")") else paste0("'", as.character(longitude), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location.longitude')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "location", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_location_history <- function(rowCount, location_id, relationship_type_concept_id, domain_id, entity_id, start_date, end_date) {
  fields <- c()
  values <- c()
  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) "NULL" else if (is(location_id, "subQuery")) paste0("(", as.character(location_id), ")") else paste0("'", as.character(location_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location_history.location_id')
  }

  if (!missing(relationship_type_concept_id)) {
    fields <- c(fields, "relationship_type_concept_id")
    values <- c(values, if (is.null(relationship_type_concept_id)) "NULL" else if (is(relationship_type_concept_id, "subQuery")) paste0("(", as.character(relationship_type_concept_id), ")") else paste0("'", as.character(relationship_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location_history.relationship_type_concept_id')
  }

  if (!missing(domain_id)) {
    fields <- c(fields, "domain_id")
    values <- c(values, if (is.null(domain_id)) "NULL" else if (is(domain_id, "subQuery")) paste0("(", as.character(domain_id), ")") else paste0("'", as.character(domain_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location_history.domain_id')
  }

  if (!missing(entity_id)) {
    fields <- c(fields, "entity_id")
    values <- c(values, if (is.null(entity_id)) "NULL" else if (is(entity_id, "subQuery")) paste0("(", as.character(entity_id), ")") else paste0("'", as.character(entity_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location_history.entity_id')
  }

  if (!missing(start_date)) {
    fields <- c(fields, "start_date")
    values <- c(values, if (is.null(start_date)) "NULL" else if (is(start_date, "subQuery")) paste0("(", as.character(start_date), ")") else paste0("'", as.character(start_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location_history.start_date')
  }

  if (!missing(end_date)) {
    fields <- c(fields, "end_date")
    values <- c(values, if (is.null(end_date)) "NULL" else if (is(end_date, "subQuery")) paste0("(", as.character(end_date), ")") else paste0("'", as.character(end_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'location_history.end_date')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "location_history", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_provider <- function(rowCount, provider_id, provider_name, npi, dea, specialty_concept_id, care_site_id, year_of_birth, gender_concept_id, provider_source_value, specialty_source_value, specialty_source_concept_id, gender_source_value, gender_source_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(provider_id)) {
    fields <- c(fields, "provider_id")
    values <- c(values, if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.provider_id')
  }

  if (!missing(provider_name)) {
    fields <- c(fields, "provider_name")
    values <- c(values, if (is.null(provider_name)) "NULL" else if (is(provider_name, "subQuery")) paste0("(", as.character(provider_name), ")") else paste0("'", as.character(provider_name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.provider_name')
  }

  if (!missing(npi)) {
    fields <- c(fields, "npi")
    values <- c(values, if (is.null(npi)) "NULL" else if (is(npi, "subQuery")) paste0("(", as.character(npi), ")") else paste0("'", as.character(npi), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.npi')
  }

  if (!missing(dea)) {
    fields <- c(fields, "dea")
    values <- c(values, if (is.null(dea)) "NULL" else if (is(dea, "subQuery")) paste0("(", as.character(dea), ")") else paste0("'", as.character(dea), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.dea')
  }

  if (!missing(specialty_concept_id)) {
    fields <- c(fields, "specialty_concept_id")
    values <- c(values, if (is.null(specialty_concept_id)) "NULL" else if (is(specialty_concept_id, "subQuery")) paste0("(", as.character(specialty_concept_id), ")") else paste0("'", as.character(specialty_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.specialty_concept_id')
  }

  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) "NULL" else if (is(care_site_id, "subQuery")) paste0("(", as.character(care_site_id), ")") else paste0("'", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.care_site_id')
  }

  if (!missing(year_of_birth)) {
    fields <- c(fields, "year_of_birth")
    values <- c(values, if (is.null(year_of_birth)) "NULL" else if (is(year_of_birth, "subQuery")) paste0("(", as.character(year_of_birth), ")") else paste0("'", as.character(year_of_birth), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.year_of_birth')
  }

  if (!missing(gender_concept_id)) {
    fields <- c(fields, "gender_concept_id")
    values <- c(values, if (is.null(gender_concept_id)) "NULL" else if (is(gender_concept_id, "subQuery")) paste0("(", as.character(gender_concept_id), ")") else paste0("'", as.character(gender_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.gender_concept_id')
  }

  if (!missing(provider_source_value)) {
    fields <- c(fields, "provider_source_value")
    values <- c(values, if (is.null(provider_source_value)) "NULL" else if (is(provider_source_value, "subQuery")) paste0("(", as.character(provider_source_value), ")") else paste0("'", as.character(provider_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.provider_source_value')
  }

  if (!missing(specialty_source_value)) {
    fields <- c(fields, "specialty_source_value")
    values <- c(values, if (is.null(specialty_source_value)) "NULL" else if (is(specialty_source_value, "subQuery")) paste0("(", as.character(specialty_source_value), ")") else paste0("'", as.character(specialty_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.specialty_source_value')
  }

  if (!missing(specialty_source_concept_id)) {
    fields <- c(fields, "specialty_source_concept_id")
    values <- c(values, if (is.null(specialty_source_concept_id)) "NULL" else if (is(specialty_source_concept_id, "subQuery")) paste0("(", as.character(specialty_source_concept_id), ")") else paste0("'", as.character(specialty_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.specialty_source_concept_id')
  }

  if (!missing(gender_source_value)) {
    fields <- c(fields, "gender_source_value")
    values <- c(values, if (is.null(gender_source_value)) "NULL" else if (is(gender_source_value, "subQuery")) paste0("(", as.character(gender_source_value), ")") else paste0("'", as.character(gender_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.gender_source_value')
  }

  if (!missing(gender_source_concept_id)) {
    fields <- c(fields, "gender_source_concept_id")
    values <- c(values, if (is.null(gender_source_concept_id)) "NULL" else if (is(gender_source_concept_id, "subQuery")) paste0("(", as.character(gender_source_concept_id), ")") else paste0("'", as.character(gender_source_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'provider.gender_source_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "provider", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_care_site <- function(rowCount, care_site_id, care_site_name, place_of_service_concept_id, location_id, care_site_source_value, place_of_service_source_value) {
  fields <- c()
  values <- c()
  if (!missing(care_site_id)) {
    fields <- c(fields, "care_site_id")
    values <- c(values, if (is.null(care_site_id)) "NULL" else if (is(care_site_id, "subQuery")) paste0("(", as.character(care_site_id), ")") else paste0("'", as.character(care_site_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.care_site_id')
  }

  if (!missing(care_site_name)) {
    fields <- c(fields, "care_site_name")
    values <- c(values, if (is.null(care_site_name)) "NULL" else if (is(care_site_name, "subQuery")) paste0("(", as.character(care_site_name), ")") else paste0("'", as.character(care_site_name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.care_site_name')
  }

  if (!missing(place_of_service_concept_id)) {
    fields <- c(fields, "place_of_service_concept_id")
    values <- c(values, if (is.null(place_of_service_concept_id)) "NULL" else if (is(place_of_service_concept_id, "subQuery")) paste0("(", as.character(place_of_service_concept_id), ")") else paste0("'", as.character(place_of_service_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.place_of_service_concept_id')
  }

  if (!missing(location_id)) {
    fields <- c(fields, "location_id")
    values <- c(values, if (is.null(location_id)) "NULL" else if (is(location_id, "subQuery")) paste0("(", as.character(location_id), ")") else paste0("'", as.character(location_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.location_id')
  }

  if (!missing(care_site_source_value)) {
    fields <- c(fields, "care_site_source_value")
    values <- c(values, if (is.null(care_site_source_value)) "NULL" else if (is(care_site_source_value, "subQuery")) paste0("(", as.character(care_site_source_value), ")") else paste0("'", as.character(care_site_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.care_site_source_value')
  }

  if (!missing(place_of_service_source_value)) {
    fields <- c(fields, "place_of_service_source_value")
    values <- c(values, if (is.null(place_of_service_source_value)) "NULL" else if (is(place_of_service_source_value, "subQuery")) paste0("(", as.character(place_of_service_source_value), ")") else paste0("'", as.character(place_of_service_source_value), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'care_site.place_of_service_source_value')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "care_site", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_cdm_source <- function(rowCount, cdm_source_name, cdm_source_abbreviation, cdm_holder, source_description, source_documentation_reference, cdm_etl_reference, source_release_date, cdm_release_date, cdm_version, vocabulary_version) {
  fields <- c()
  values <- c()
  if (!missing(cdm_source_name)) {
    fields <- c(fields, "cdm_source_name")
    values <- c(values, if (is.null(cdm_source_name)) "NULL" else if (is(cdm_source_name, "subQuery")) paste0("(", as.character(cdm_source_name), ")") else paste0("'", as.character(cdm_source_name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_source_name')
  }

  if (!missing(cdm_source_abbreviation)) {
    fields <- c(fields, "cdm_source_abbreviation")
    values <- c(values, if (is.null(cdm_source_abbreviation)) "NULL" else if (is(cdm_source_abbreviation, "subQuery")) paste0("(", as.character(cdm_source_abbreviation), ")") else paste0("'", as.character(cdm_source_abbreviation), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_source_abbreviation')
  }

  if (!missing(cdm_holder)) {
    fields <- c(fields, "cdm_holder")
    values <- c(values, if (is.null(cdm_holder)) "NULL" else if (is(cdm_holder, "subQuery")) paste0("(", as.character(cdm_holder), ")") else paste0("'", as.character(cdm_holder), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_holder')
  }

  if (!missing(source_description)) {
    fields <- c(fields, "source_description")
    values <- c(values, if (is.null(source_description)) "NULL" else if (is(source_description, "subQuery")) paste0("(", as.character(source_description), ")") else paste0("'", as.character(source_description), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.source_description')
  }

  if (!missing(source_documentation_reference)) {
    fields <- c(fields, "source_documentation_reference")
    values <- c(values, if (is.null(source_documentation_reference)) "NULL" else if (is(source_documentation_reference, "subQuery")) paste0("(", as.character(source_documentation_reference), ")") else paste0("'", as.character(source_documentation_reference), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.source_documentation_reference')
  }

  if (!missing(cdm_etl_reference)) {
    fields <- c(fields, "cdm_etl_reference")
    values <- c(values, if (is.null(cdm_etl_reference)) "NULL" else if (is(cdm_etl_reference, "subQuery")) paste0("(", as.character(cdm_etl_reference), ")") else paste0("'", as.character(cdm_etl_reference), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_etl_reference')
  }

  if (!missing(source_release_date)) {
    fields <- c(fields, "source_release_date")
    values <- c(values, if (is.null(source_release_date)) "NULL" else if (is(source_release_date, "subQuery")) paste0("(", as.character(source_release_date), ")") else paste0("'", as.character(source_release_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.source_release_date')
  }

  if (!missing(cdm_release_date)) {
    fields <- c(fields, "cdm_release_date")
    values <- c(values, if (is.null(cdm_release_date)) "NULL" else if (is(cdm_release_date, "subQuery")) paste0("(", as.character(cdm_release_date), ")") else paste0("'", as.character(cdm_release_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_release_date')
  }

  if (!missing(cdm_version)) {
    fields <- c(fields, "cdm_version")
    values <- c(values, if (is.null(cdm_version)) "NULL" else if (is(cdm_version, "subQuery")) paste0("(", as.character(cdm_version), ")") else paste0("'", as.character(cdm_version), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.cdm_version')
  }

  if (!missing(vocabulary_version)) {
    fields <- c(fields, "vocabulary_version")
    values <- c(values, if (is.null(vocabulary_version)) "NULL" else if (is(vocabulary_version, "subQuery")) paste0("(", as.character(vocabulary_version), ")") else paste0("'", as.character(vocabulary_version), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'cdm_source.vocabulary_version')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "cdm_source", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_metadata <- function(rowCount, metadata_concept_id, metadata_type_concept_id, name, value_as_string, value_as_concept_id, metadata_date, metadata_datetime) {
  fields <- c()
  values <- c()
  if (!missing(metadata_concept_id)) {
    fields <- c(fields, "metadata_concept_id")
    values <- c(values, if (is.null(metadata_concept_id)) "NULL" else if (is(metadata_concept_id, "subQuery")) paste0("(", as.character(metadata_concept_id), ")") else paste0("'", as.character(metadata_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_concept_id')
  }

  if (!missing(metadata_type_concept_id)) {
    fields <- c(fields, "metadata_type_concept_id")
    values <- c(values, if (is.null(metadata_type_concept_id)) "NULL" else if (is(metadata_type_concept_id, "subQuery")) paste0("(", as.character(metadata_type_concept_id), ")") else paste0("'", as.character(metadata_type_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_type_concept_id')
  }

  if (!missing(name)) {
    fields <- c(fields, "name")
    values <- c(values, if (is.null(name)) "NULL" else if (is(name, "subQuery")) paste0("(", as.character(name), ")") else paste0("'", as.character(name), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.name')
  }

  if (!missing(value_as_string)) {
    fields <- c(fields, "value_as_string")
    values <- c(values, if (is.null(value_as_string)) "NULL" else if (is(value_as_string, "subQuery")) paste0("(", as.character(value_as_string), ")") else paste0("'", as.character(value_as_string), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.value_as_string')
  }

  if (!missing(value_as_concept_id)) {
    fields <- c(fields, "value_as_concept_id")
    values <- c(values, if (is.null(value_as_concept_id)) "NULL" else if (is(value_as_concept_id, "subQuery")) paste0("(", as.character(value_as_concept_id), ")") else paste0("'", as.character(value_as_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.value_as_concept_id')
  }

  if (!missing(metadata_date)) {
    fields <- c(fields, "[metadata date]")
    values <- c(values, if (is.null(metadata_date)) "NULL" else if (is(metadata_date, "subQuery")) paste0("(", as.character(metadata_date), ")") else paste0("'", as.character(metadata_date), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_date')
  }

  if (!missing(metadata_datetime)) {
    fields <- c(fields, "metadata_datetime")
    values <- c(values, if (is.null(metadata_datetime)) "NULL" else if (is(metadata_datetime, "subQuery")) paste0("(", as.character(metadata_datetime), ")") else paste0("'", as.character(metadata_datetime), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'metadata.metadata_datetime')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "metadata", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

expect_count_fact_relationship <- function(rowCount, domain_concept_id_1, fact_id_1, domain_concept_id_2, fact_id_2, relationship_concept_id) {
  fields <- c()
  values <- c()
  if (!missing(domain_concept_id_1)) {
    fields <- c(fields, "domain_concept_id_1")
    values <- c(values, if (is.null(domain_concept_id_1)) "NULL" else if (is(domain_concept_id_1, "subQuery")) paste0("(", as.character(domain_concept_id_1), ")") else paste0("'", as.character(domain_concept_id_1), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.domain_concept_id_1')
  }

  if (!missing(fact_id_1)) {
    fields <- c(fields, "fact_id_1")
    values <- c(values, if (is.null(fact_id_1)) "NULL" else if (is(fact_id_1, "subQuery")) paste0("(", as.character(fact_id_1), ")") else paste0("'", as.character(fact_id_1), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.fact_id_1')
  }

  if (!missing(domain_concept_id_2)) {
    fields <- c(fields, "domain_concept_id_2")
    values <- c(values, if (is.null(domain_concept_id_2)) "NULL" else if (is(domain_concept_id_2, "subQuery")) paste0("(", as.character(domain_concept_id_2), ")") else paste0("'", as.character(domain_concept_id_2), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.domain_concept_id_2')
  }

  if (!missing(fact_id_2)) {
    fields <- c(fields, "fact_id_2")
    values <- c(values, if (is.null(fact_id_2)) "NULL" else if (is(fact_id_2, "subQuery")) paste0("(", as.character(fact_id_2), ")") else paste0("'", as.character(fact_id_2), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.fact_id_2')
  }

  if (!missing(relationship_concept_id)) {
    fields <- c(fields, "relationship_concept_id")
    values <- c(values, if (is.null(relationship_concept_id)) "NULL" else if (is(relationship_concept_id, "subQuery")) paste0("(", as.character(relationship_concept_id), ")") else paste0("'", as.character(relationship_concept_id), "'"))
    frameworkContext$targetFieldsTested <- c(frameworkContext$targetFieldsTested, 'fact_relationship.relationship_concept_id')
  }

  expects <- list(testId = frameworkContext$testId, testDescription = frameworkContext$testDescription, type = 2, table = "fact_relationship", fields = fields, values = values)
  expects$rowCount = rowCount
  frameworkContext$expects[[length(frameworkContext$expects) + 1]] <- expects
  invisible(NULL)
}

lookup_person <- function(fetchField, person_id, gender_concept_id, year_of_birth, month_of_birth, day_of_birth, birth_datetime, death_datetime, race_concept_id, ethnicity_concept_id, location_id, provider_id, care_site_id, person_source_value, gender_source_value, gender_source_concept_id, race_source_value, race_source_concept_id, ethnicity_source_value, ethnicity_source_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.person WHERE')
  first <- TRUE
  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id = ", if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(gender_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " gender_concept_id = ", if (is.null(gender_concept_id)) "NULL" else if (is(gender_concept_id, "subQuery")) paste0("(", as.character(gender_concept_id), ")") else paste0("'", as.character(gender_concept_id), "'"))
  }

  if (!missing(year_of_birth)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " year_of_birth = ", if (is.null(year_of_birth)) "NULL" else if (is(year_of_birth, "subQuery")) paste0("(", as.character(year_of_birth), ")") else paste0("'", as.character(year_of_birth), "'"))
  }

  if (!missing(month_of_birth)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " month_of_birth = ", if (is.null(month_of_birth)) "NULL" else if (is(month_of_birth, "subQuery")) paste0("(", as.character(month_of_birth), ")") else paste0("'", as.character(month_of_birth), "'"))
  }

  if (!missing(day_of_birth)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " day_of_birth = ", if (is.null(day_of_birth)) "NULL" else if (is(day_of_birth, "subQuery")) paste0("(", as.character(day_of_birth), ")") else paste0("'", as.character(day_of_birth), "'"))
  }

  if (!missing(birth_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " birth_datetime = ", if (is.null(birth_datetime)) "NULL" else if (is(birth_datetime, "subQuery")) paste0("(", as.character(birth_datetime), ")") else paste0("'", as.character(birth_datetime), "'"))
  }

  if (!missing(death_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " death_datetime = ", if (is.null(death_datetime)) "NULL" else if (is(death_datetime, "subQuery")) paste0("(", as.character(death_datetime), ")") else paste0("'", as.character(death_datetime), "'"))
  }

  if (!missing(race_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " race_concept_id = ", if (is.null(race_concept_id)) "NULL" else if (is(race_concept_id, "subQuery")) paste0("(", as.character(race_concept_id), ")") else paste0("'", as.character(race_concept_id), "'"))
  }

  if (!missing(ethnicity_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " ethnicity_concept_id = ", if (is.null(ethnicity_concept_id)) "NULL" else if (is(ethnicity_concept_id, "subQuery")) paste0("(", as.character(ethnicity_concept_id), ")") else paste0("'", as.character(ethnicity_concept_id), "'"))
  }

  if (!missing(location_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " location_id = ", if (is.null(location_id)) "NULL" else if (is(location_id, "subQuery")) paste0("(", as.character(location_id), ")") else paste0("'", as.character(location_id), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id = ", if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(care_site_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " care_site_id = ", if (is.null(care_site_id)) "NULL" else if (is(care_site_id, "subQuery")) paste0("(", as.character(care_site_id), ")") else paste0("'", as.character(care_site_id), "'"))
  }

  if (!missing(person_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_source_value = ", if (is.null(person_source_value)) "NULL" else if (is(person_source_value, "subQuery")) paste0("(", as.character(person_source_value), ")") else paste0("'", as.character(person_source_value), "'"))
  }

  if (!missing(gender_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " gender_source_value = ", if (is.null(gender_source_value)) "NULL" else if (is(gender_source_value, "subQuery")) paste0("(", as.character(gender_source_value), ")") else paste0("'", as.character(gender_source_value), "'"))
  }

  if (!missing(gender_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " gender_source_concept_id = ", if (is.null(gender_source_concept_id)) "NULL" else if (is(gender_source_concept_id, "subQuery")) paste0("(", as.character(gender_source_concept_id), ")") else paste0("'", as.character(gender_source_concept_id), "'"))
  }

  if (!missing(race_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " race_source_value = ", if (is.null(race_source_value)) "NULL" else if (is(race_source_value, "subQuery")) paste0("(", as.character(race_source_value), ")") else paste0("'", as.character(race_source_value), "'"))
  }

  if (!missing(race_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " race_source_concept_id = ", if (is.null(race_source_concept_id)) "NULL" else if (is(race_source_concept_id, "subQuery")) paste0("(", as.character(race_source_concept_id), ")") else paste0("'", as.character(race_source_concept_id), "'"))
  }

  if (!missing(ethnicity_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " ethnicity_source_value = ", if (is.null(ethnicity_source_value)) "NULL" else if (is(ethnicity_source_value, "subQuery")) paste0("(", as.character(ethnicity_source_value), ")") else paste0("'", as.character(ethnicity_source_value), "'"))
  }

  if (!missing(ethnicity_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " ethnicity_source_concept_id = ", if (is.null(ethnicity_source_concept_id)) "NULL" else if (is(ethnicity_source_concept_id, "subQuery")) paste0("(", as.character(ethnicity_source_concept_id), ")") else paste0("'", as.character(ethnicity_source_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_observation_period <- function(fetchField, observation_period_id, person_id, observation_period_start_date, observation_period_end_date, period_type_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.observation_period WHERE')
  first <- TRUE
  if (!missing(observation_period_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_period_id = ", if (is.null(observation_period_id)) "NULL" else if (is(observation_period_id, "subQuery")) paste0("(", as.character(observation_period_id), ")") else paste0("'", as.character(observation_period_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id = ", if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(observation_period_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_period_start_date = ", if (is.null(observation_period_start_date)) "NULL" else if (is(observation_period_start_date, "subQuery")) paste0("(", as.character(observation_period_start_date), ")") else paste0("'", as.character(observation_period_start_date), "'"))
  }

  if (!missing(observation_period_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_period_end_date = ", if (is.null(observation_period_end_date)) "NULL" else if (is(observation_period_end_date, "subQuery")) paste0("(", as.character(observation_period_end_date), ")") else paste0("'", as.character(observation_period_end_date), "'"))
  }

  if (!missing(period_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " period_type_concept_id = ", if (is.null(period_type_concept_id)) "NULL" else if (is(period_type_concept_id, "subQuery")) paste0("(", as.character(period_type_concept_id), ")") else paste0("'", as.character(period_type_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_visit_occurrence <- function(fetchField, visit_occurrence_id, person_id, visit_concept_id, visit_start_date, visit_start_datetime, visit_end_date, visit_end_datetime, visit_type_concept_id, provider_id, care_site_id, visit_source_value, visit_source_concept_id, admitting_source_concept_id, admitting_source_value, discharge_to_concept_id, discharge_to_source_value, preceding_visit_occurrence_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.visit_occurrence WHERE')
  first <- TRUE
  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id = ", if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id = ", if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(visit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_concept_id = ", if (is.null(visit_concept_id)) "NULL" else if (is(visit_concept_id, "subQuery")) paste0("(", as.character(visit_concept_id), ")") else paste0("'", as.character(visit_concept_id), "'"))
  }

  if (!missing(visit_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_start_date = ", if (is.null(visit_start_date)) "NULL" else if (is(visit_start_date, "subQuery")) paste0("(", as.character(visit_start_date), ")") else paste0("'", as.character(visit_start_date), "'"))
  }

  if (!missing(visit_start_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_start_datetime = ", if (is.null(visit_start_datetime)) "NULL" else if (is(visit_start_datetime, "subQuery")) paste0("(", as.character(visit_start_datetime), ")") else paste0("'", as.character(visit_start_datetime), "'"))
  }

  if (!missing(visit_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_end_date = ", if (is.null(visit_end_date)) "NULL" else if (is(visit_end_date, "subQuery")) paste0("(", as.character(visit_end_date), ")") else paste0("'", as.character(visit_end_date), "'"))
  }

  if (!missing(visit_end_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_end_datetime = ", if (is.null(visit_end_datetime)) "NULL" else if (is(visit_end_datetime, "subQuery")) paste0("(", as.character(visit_end_datetime), ")") else paste0("'", as.character(visit_end_datetime), "'"))
  }

  if (!missing(visit_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_type_concept_id = ", if (is.null(visit_type_concept_id)) "NULL" else if (is(visit_type_concept_id, "subQuery")) paste0("(", as.character(visit_type_concept_id), ")") else paste0("'", as.character(visit_type_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id = ", if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(care_site_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " care_site_id = ", if (is.null(care_site_id)) "NULL" else if (is(care_site_id, "subQuery")) paste0("(", as.character(care_site_id), ")") else paste0("'", as.character(care_site_id), "'"))
  }

  if (!missing(visit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_source_value = ", if (is.null(visit_source_value)) "NULL" else if (is(visit_source_value, "subQuery")) paste0("(", as.character(visit_source_value), ")") else paste0("'", as.character(visit_source_value), "'"))
  }

  if (!missing(visit_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_source_concept_id = ", if (is.null(visit_source_concept_id)) "NULL" else if (is(visit_source_concept_id, "subQuery")) paste0("(", as.character(visit_source_concept_id), ")") else paste0("'", as.character(visit_source_concept_id), "'"))
  }

  if (!missing(admitting_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " admitting_source_concept_id = ", if (is.null(admitting_source_concept_id)) "NULL" else if (is(admitting_source_concept_id, "subQuery")) paste0("(", as.character(admitting_source_concept_id), ")") else paste0("'", as.character(admitting_source_concept_id), "'"))
  }

  if (!missing(admitting_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " admitting_source_value = ", if (is.null(admitting_source_value)) "NULL" else if (is(admitting_source_value, "subQuery")) paste0("(", as.character(admitting_source_value), ")") else paste0("'", as.character(admitting_source_value), "'"))
  }

  if (!missing(discharge_to_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " discharge_to_concept_id = ", if (is.null(discharge_to_concept_id)) "NULL" else if (is(discharge_to_concept_id, "subQuery")) paste0("(", as.character(discharge_to_concept_id), ")") else paste0("'", as.character(discharge_to_concept_id), "'"))
  }

  if (!missing(discharge_to_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " discharge_to_source_value = ", if (is.null(discharge_to_source_value)) "NULL" else if (is(discharge_to_source_value, "subQuery")) paste0("(", as.character(discharge_to_source_value), ")") else paste0("'", as.character(discharge_to_source_value), "'"))
  }

  if (!missing(preceding_visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " preceding_visit_occurrence_id = ", if (is.null(preceding_visit_occurrence_id)) "NULL" else if (is(preceding_visit_occurrence_id, "subQuery")) paste0("(", as.character(preceding_visit_occurrence_id), ")") else paste0("'", as.character(preceding_visit_occurrence_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_visit_detail <- function(fetchField, visit_detail_id, person_id, visit_detail_concept_id, visit_detail_start_date, visit_detail_start_datetime, visit_detail_end_date, visit_detail_end_datetime, visit_detail_type_concept_id, provider_id, care_site_id, visit_detail_source_value, visit_detail_source_concept_id, admitted_from_source_value, admitted_from_concept_id, discharge_to_source_value, discharge_to_concept_id, preceding_visit_detail_id, visit_detail_parent_id, visit_occurrence_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.visit_detail WHERE')
  first <- TRUE
  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id = ", if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id = ", if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(visit_detail_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_concept_id = ", if (is.null(visit_detail_concept_id)) "NULL" else if (is(visit_detail_concept_id, "subQuery")) paste0("(", as.character(visit_detail_concept_id), ")") else paste0("'", as.character(visit_detail_concept_id), "'"))
  }

  if (!missing(visit_detail_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_start_date = ", if (is.null(visit_detail_start_date)) "NULL" else if (is(visit_detail_start_date, "subQuery")) paste0("(", as.character(visit_detail_start_date), ")") else paste0("'", as.character(visit_detail_start_date), "'"))
  }

  if (!missing(visit_detail_start_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_start_datetime = ", if (is.null(visit_detail_start_datetime)) "NULL" else if (is(visit_detail_start_datetime, "subQuery")) paste0("(", as.character(visit_detail_start_datetime), ")") else paste0("'", as.character(visit_detail_start_datetime), "'"))
  }

  if (!missing(visit_detail_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_end_date = ", if (is.null(visit_detail_end_date)) "NULL" else if (is(visit_detail_end_date, "subQuery")) paste0("(", as.character(visit_detail_end_date), ")") else paste0("'", as.character(visit_detail_end_date), "'"))
  }

  if (!missing(visit_detail_end_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_end_datetime = ", if (is.null(visit_detail_end_datetime)) "NULL" else if (is(visit_detail_end_datetime, "subQuery")) paste0("(", as.character(visit_detail_end_datetime), ")") else paste0("'", as.character(visit_detail_end_datetime), "'"))
  }

  if (!missing(visit_detail_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_type_concept_id = ", if (is.null(visit_detail_type_concept_id)) "NULL" else if (is(visit_detail_type_concept_id, "subQuery")) paste0("(", as.character(visit_detail_type_concept_id), ")") else paste0("'", as.character(visit_detail_type_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id = ", if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(care_site_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " care_site_id = ", if (is.null(care_site_id)) "NULL" else if (is(care_site_id, "subQuery")) paste0("(", as.character(care_site_id), ")") else paste0("'", as.character(care_site_id), "'"))
  }

  if (!missing(visit_detail_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_source_value = ", if (is.null(visit_detail_source_value)) "NULL" else if (is(visit_detail_source_value, "subQuery")) paste0("(", as.character(visit_detail_source_value), ")") else paste0("'", as.character(visit_detail_source_value), "'"))
  }

  if (!missing(visit_detail_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_source_concept_id = ", if (is.null(visit_detail_source_concept_id)) "NULL" else if (is(visit_detail_source_concept_id, "subQuery")) paste0("(", as.character(visit_detail_source_concept_id), ")") else paste0("'", as.character(visit_detail_source_concept_id), "'"))
  }

  if (!missing(admitted_from_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " admitted_from_source_value = ", if (is.null(admitted_from_source_value)) "NULL" else if (is(admitted_from_source_value, "subQuery")) paste0("(", as.character(admitted_from_source_value), ")") else paste0("'", as.character(admitted_from_source_value), "'"))
  }

  if (!missing(admitted_from_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " admitted_from_concept_id = ", if (is.null(admitted_from_concept_id)) "NULL" else if (is(admitted_from_concept_id, "subQuery")) paste0("(", as.character(admitted_from_concept_id), ")") else paste0("'", as.character(admitted_from_concept_id), "'"))
  }

  if (!missing(discharge_to_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " discharge_to_source_value = ", if (is.null(discharge_to_source_value)) "NULL" else if (is(discharge_to_source_value, "subQuery")) paste0("(", as.character(discharge_to_source_value), ")") else paste0("'", as.character(discharge_to_source_value), "'"))
  }

  if (!missing(discharge_to_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " discharge_to_concept_id = ", if (is.null(discharge_to_concept_id)) "NULL" else if (is(discharge_to_concept_id, "subQuery")) paste0("(", as.character(discharge_to_concept_id), ")") else paste0("'", as.character(discharge_to_concept_id), "'"))
  }

  if (!missing(preceding_visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " preceding_visit_detail_id = ", if (is.null(preceding_visit_detail_id)) "NULL" else if (is(preceding_visit_detail_id, "subQuery")) paste0("(", as.character(preceding_visit_detail_id), ")") else paste0("'", as.character(preceding_visit_detail_id), "'"))
  }

  if (!missing(visit_detail_parent_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_parent_id = ", if (is.null(visit_detail_parent_id)) "NULL" else if (is(visit_detail_parent_id, "subQuery")) paste0("(", as.character(visit_detail_parent_id), ")") else paste0("'", as.character(visit_detail_parent_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id = ", if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_condition_occurrence <- function(fetchField, condition_occurrence_id, person_id, condition_concept_id, condition_start_date, condition_start_datetime, condition_end_date, condition_end_datetime, condition_type_concept_id, condition_status_concept_id, stop_reason, provider_id, visit_occurrence_id, visit_detail_id, condition_source_value, condition_source_concept_id, condition_status_source_value) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.condition_occurrence WHERE')
  first <- TRUE
  if (!missing(condition_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_occurrence_id = ", if (is.null(condition_occurrence_id)) "NULL" else if (is(condition_occurrence_id, "subQuery")) paste0("(", as.character(condition_occurrence_id), ")") else paste0("'", as.character(condition_occurrence_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id = ", if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(condition_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_concept_id = ", if (is.null(condition_concept_id)) "NULL" else if (is(condition_concept_id, "subQuery")) paste0("(", as.character(condition_concept_id), ")") else paste0("'", as.character(condition_concept_id), "'"))
  }

  if (!missing(condition_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_start_date = ", if (is.null(condition_start_date)) "NULL" else if (is(condition_start_date, "subQuery")) paste0("(", as.character(condition_start_date), ")") else paste0("'", as.character(condition_start_date), "'"))
  }

  if (!missing(condition_start_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_start_datetime = ", if (is.null(condition_start_datetime)) "NULL" else if (is(condition_start_datetime, "subQuery")) paste0("(", as.character(condition_start_datetime), ")") else paste0("'", as.character(condition_start_datetime), "'"))
  }

  if (!missing(condition_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_end_date = ", if (is.null(condition_end_date)) "NULL" else if (is(condition_end_date, "subQuery")) paste0("(", as.character(condition_end_date), ")") else paste0("'", as.character(condition_end_date), "'"))
  }

  if (!missing(condition_end_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_end_datetime = ", if (is.null(condition_end_datetime)) "NULL" else if (is(condition_end_datetime, "subQuery")) paste0("(", as.character(condition_end_datetime), ")") else paste0("'", as.character(condition_end_datetime), "'"))
  }

  if (!missing(condition_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_type_concept_id = ", if (is.null(condition_type_concept_id)) "NULL" else if (is(condition_type_concept_id, "subQuery")) paste0("(", as.character(condition_type_concept_id), ")") else paste0("'", as.character(condition_type_concept_id), "'"))
  }

  if (!missing(condition_status_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_status_concept_id = ", if (is.null(condition_status_concept_id)) "NULL" else if (is(condition_status_concept_id, "subQuery")) paste0("(", as.character(condition_status_concept_id), ")") else paste0("'", as.character(condition_status_concept_id), "'"))
  }

  if (!missing(stop_reason)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " stop_reason = ", if (is.null(stop_reason)) "NULL" else if (is(stop_reason, "subQuery")) paste0("(", as.character(stop_reason), ")") else paste0("'", as.character(stop_reason), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id = ", if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id = ", if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id = ", if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
  }

  if (!missing(condition_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_source_value = ", if (is.null(condition_source_value)) "NULL" else if (is(condition_source_value, "subQuery")) paste0("(", as.character(condition_source_value), ")") else paste0("'", as.character(condition_source_value), "'"))
  }

  if (!missing(condition_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_source_concept_id = ", if (is.null(condition_source_concept_id)) "NULL" else if (is(condition_source_concept_id, "subQuery")) paste0("(", as.character(condition_source_concept_id), ")") else paste0("'", as.character(condition_source_concept_id), "'"))
  }

  if (!missing(condition_status_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_status_source_value = ", if (is.null(condition_status_source_value)) "NULL" else if (is(condition_status_source_value, "subQuery")) paste0("(", as.character(condition_status_source_value), ")") else paste0("'", as.character(condition_status_source_value), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_procedure_occurrence <- function(fetchField, procedure_occurrence_id, person_id, procedure_concept_id, procedure_date, procedure_datetime, procedure_type_concept_id, modifier_concept_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, procedure_source_value, procedure_source_concept_id, modifier_source_value) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.procedure_occurrence WHERE')
  first <- TRUE
  if (!missing(procedure_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_occurrence_id = ", if (is.null(procedure_occurrence_id)) "NULL" else if (is(procedure_occurrence_id, "subQuery")) paste0("(", as.character(procedure_occurrence_id), ")") else paste0("'", as.character(procedure_occurrence_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id = ", if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(procedure_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_concept_id = ", if (is.null(procedure_concept_id)) "NULL" else if (is(procedure_concept_id, "subQuery")) paste0("(", as.character(procedure_concept_id), ")") else paste0("'", as.character(procedure_concept_id), "'"))
  }

  if (!missing(procedure_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_date = ", if (is.null(procedure_date)) "NULL" else if (is(procedure_date, "subQuery")) paste0("(", as.character(procedure_date), ")") else paste0("'", as.character(procedure_date), "'"))
  }

  if (!missing(procedure_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_datetime = ", if (is.null(procedure_datetime)) "NULL" else if (is(procedure_datetime, "subQuery")) paste0("(", as.character(procedure_datetime), ")") else paste0("'", as.character(procedure_datetime), "'"))
  }

  if (!missing(procedure_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_type_concept_id = ", if (is.null(procedure_type_concept_id)) "NULL" else if (is(procedure_type_concept_id, "subQuery")) paste0("(", as.character(procedure_type_concept_id), ")") else paste0("'", as.character(procedure_type_concept_id), "'"))
  }

  if (!missing(modifier_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " modifier_concept_id = ", if (is.null(modifier_concept_id)) "NULL" else if (is(modifier_concept_id, "subQuery")) paste0("(", as.character(modifier_concept_id), ")") else paste0("'", as.character(modifier_concept_id), "'"))
  }

  if (!missing(quantity)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " quantity = ", if (is.null(quantity)) "NULL" else if (is(quantity, "subQuery")) paste0("(", as.character(quantity), ")") else paste0("'", as.character(quantity), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id = ", if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id = ", if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id = ", if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
  }

  if (!missing(procedure_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_source_value = ", if (is.null(procedure_source_value)) "NULL" else if (is(procedure_source_value, "subQuery")) paste0("(", as.character(procedure_source_value), ")") else paste0("'", as.character(procedure_source_value), "'"))
  }

  if (!missing(procedure_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " procedure_source_concept_id = ", if (is.null(procedure_source_concept_id)) "NULL" else if (is(procedure_source_concept_id, "subQuery")) paste0("(", as.character(procedure_source_concept_id), ")") else paste0("'", as.character(procedure_source_concept_id), "'"))
  }

  if (!missing(modifier_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " modifier_source_value = ", if (is.null(modifier_source_value)) "NULL" else if (is(modifier_source_value, "subQuery")) paste0("(", as.character(modifier_source_value), ")") else paste0("'", as.character(modifier_source_value), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_drug_exposure <- function(fetchField, drug_exposure_id, person_id, drug_concept_id, drug_exposure_start_date, drug_exposure_start_datetime, drug_exposure_end_date, drug_exposure_end_datetime, verbatim_end_date, drug_type_concept_id, stop_reason, refills, quantity, days_supply, sig, route_concept_id, lot_number, provider_id, visit_occurrence_id, visit_detail_id, drug_source_value, drug_source_concept_id, route_source_value, dose_unit_source_value) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.drug_exposure WHERE')
  first <- TRUE
  if (!missing(drug_exposure_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_exposure_id = ", if (is.null(drug_exposure_id)) "NULL" else if (is(drug_exposure_id, "subQuery")) paste0("(", as.character(drug_exposure_id), ")") else paste0("'", as.character(drug_exposure_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id = ", if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(drug_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_concept_id = ", if (is.null(drug_concept_id)) "NULL" else if (is(drug_concept_id, "subQuery")) paste0("(", as.character(drug_concept_id), ")") else paste0("'", as.character(drug_concept_id), "'"))
  }

  if (!missing(drug_exposure_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_exposure_start_date = ", if (is.null(drug_exposure_start_date)) "NULL" else if (is(drug_exposure_start_date, "subQuery")) paste0("(", as.character(drug_exposure_start_date), ")") else paste0("'", as.character(drug_exposure_start_date), "'"))
  }

  if (!missing(drug_exposure_start_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_exposure_start_datetime = ", if (is.null(drug_exposure_start_datetime)) "NULL" else if (is(drug_exposure_start_datetime, "subQuery")) paste0("(", as.character(drug_exposure_start_datetime), ")") else paste0("'", as.character(drug_exposure_start_datetime), "'"))
  }

  if (!missing(drug_exposure_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_exposure_end_date = ", if (is.null(drug_exposure_end_date)) "NULL" else if (is(drug_exposure_end_date, "subQuery")) paste0("(", as.character(drug_exposure_end_date), ")") else paste0("'", as.character(drug_exposure_end_date), "'"))
  }

  if (!missing(drug_exposure_end_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_exposure_end_datetime = ", if (is.null(drug_exposure_end_datetime)) "NULL" else if (is(drug_exposure_end_datetime, "subQuery")) paste0("(", as.character(drug_exposure_end_datetime), ")") else paste0("'", as.character(drug_exposure_end_datetime), "'"))
  }

  if (!missing(verbatim_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " verbatim_end_date = ", if (is.null(verbatim_end_date)) "NULL" else if (is(verbatim_end_date, "subQuery")) paste0("(", as.character(verbatim_end_date), ")") else paste0("'", as.character(verbatim_end_date), "'"))
  }

  if (!missing(drug_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_type_concept_id = ", if (is.null(drug_type_concept_id)) "NULL" else if (is(drug_type_concept_id, "subQuery")) paste0("(", as.character(drug_type_concept_id), ")") else paste0("'", as.character(drug_type_concept_id), "'"))
  }

  if (!missing(stop_reason)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " stop_reason = ", if (is.null(stop_reason)) "NULL" else if (is(stop_reason, "subQuery")) paste0("(", as.character(stop_reason), ")") else paste0("'", as.character(stop_reason), "'"))
  }

  if (!missing(refills)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " refills = ", if (is.null(refills)) "NULL" else if (is(refills, "subQuery")) paste0("(", as.character(refills), ")") else paste0("'", as.character(refills), "'"))
  }

  if (!missing(quantity)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " quantity = ", if (is.null(quantity)) "NULL" else if (is(quantity, "subQuery")) paste0("(", as.character(quantity), ")") else paste0("'", as.character(quantity), "'"))
  }

  if (!missing(days_supply)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " days_supply = ", if (is.null(days_supply)) "NULL" else if (is(days_supply, "subQuery")) paste0("(", as.character(days_supply), ")") else paste0("'", as.character(days_supply), "'"))
  }

  if (!missing(sig)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " sig = ", if (is.null(sig)) "NULL" else if (is(sig, "subQuery")) paste0("(", as.character(sig), ")") else paste0("'", as.character(sig), "'"))
  }

  if (!missing(route_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " route_concept_id = ", if (is.null(route_concept_id)) "NULL" else if (is(route_concept_id, "subQuery")) paste0("(", as.character(route_concept_id), ")") else paste0("'", as.character(route_concept_id), "'"))
  }

  if (!missing(lot_number)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " lot_number = ", if (is.null(lot_number)) "NULL" else if (is(lot_number, "subQuery")) paste0("(", as.character(lot_number), ")") else paste0("'", as.character(lot_number), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id = ", if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id = ", if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id = ", if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
  }

  if (!missing(drug_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_source_value = ", if (is.null(drug_source_value)) "NULL" else if (is(drug_source_value, "subQuery")) paste0("(", as.character(drug_source_value), ")") else paste0("'", as.character(drug_source_value), "'"))
  }

  if (!missing(drug_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_source_concept_id = ", if (is.null(drug_source_concept_id)) "NULL" else if (is(drug_source_concept_id, "subQuery")) paste0("(", as.character(drug_source_concept_id), ")") else paste0("'", as.character(drug_source_concept_id), "'"))
  }

  if (!missing(route_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " route_source_value = ", if (is.null(route_source_value)) "NULL" else if (is(route_source_value, "subQuery")) paste0("(", as.character(route_source_value), ")") else paste0("'", as.character(route_source_value), "'"))
  }

  if (!missing(dose_unit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " dose_unit_source_value = ", if (is.null(dose_unit_source_value)) "NULL" else if (is(dose_unit_source_value, "subQuery")) paste0("(", as.character(dose_unit_source_value), ")") else paste0("'", as.character(dose_unit_source_value), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_device_exposure <- function(fetchField, device_exposure_id, person_id, device_concept_id, device_exposure_start_date, device_exposure_start_datetime, device_exposure_end_date, device_exposure_end_datetime, device_type_concept_id, unique_device_id, quantity, provider_id, visit_occurrence_id, visit_detail_id, device_source_value, device_source_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.device_exposure WHERE')
  first <- TRUE
  if (!missing(device_exposure_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_exposure_id = ", if (is.null(device_exposure_id)) "NULL" else if (is(device_exposure_id, "subQuery")) paste0("(", as.character(device_exposure_id), ")") else paste0("'", as.character(device_exposure_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id = ", if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(device_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_concept_id = ", if (is.null(device_concept_id)) "NULL" else if (is(device_concept_id, "subQuery")) paste0("(", as.character(device_concept_id), ")") else paste0("'", as.character(device_concept_id), "'"))
  }

  if (!missing(device_exposure_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_exposure_start_date = ", if (is.null(device_exposure_start_date)) "NULL" else if (is(device_exposure_start_date, "subQuery")) paste0("(", as.character(device_exposure_start_date), ")") else paste0("'", as.character(device_exposure_start_date), "'"))
  }

  if (!missing(device_exposure_start_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_exposure_start_datetime = ", if (is.null(device_exposure_start_datetime)) "NULL" else if (is(device_exposure_start_datetime, "subQuery")) paste0("(", as.character(device_exposure_start_datetime), ")") else paste0("'", as.character(device_exposure_start_datetime), "'"))
  }

  if (!missing(device_exposure_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_exposure_end_date = ", if (is.null(device_exposure_end_date)) "NULL" else if (is(device_exposure_end_date, "subQuery")) paste0("(", as.character(device_exposure_end_date), ")") else paste0("'", as.character(device_exposure_end_date), "'"))
  }

  if (!missing(device_exposure_end_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_exposure_end_datetime = ", if (is.null(device_exposure_end_datetime)) "NULL" else if (is(device_exposure_end_datetime, "subQuery")) paste0("(", as.character(device_exposure_end_datetime), ")") else paste0("'", as.character(device_exposure_end_datetime), "'"))
  }

  if (!missing(device_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_type_concept_id = ", if (is.null(device_type_concept_id)) "NULL" else if (is(device_type_concept_id, "subQuery")) paste0("(", as.character(device_type_concept_id), ")") else paste0("'", as.character(device_type_concept_id), "'"))
  }

  if (!missing(unique_device_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unique_device_id = ", if (is.null(unique_device_id)) "NULL" else if (is(unique_device_id, "subQuery")) paste0("(", as.character(unique_device_id), ")") else paste0("'", as.character(unique_device_id), "'"))
  }

  if (!missing(quantity)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " quantity = ", if (is.null(quantity)) "NULL" else if (is(quantity, "subQuery")) paste0("(", as.character(quantity), ")") else paste0("'", as.character(quantity), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id = ", if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id = ", if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id = ", if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
  }

  if (!missing(device_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_source_value = ", if (is.null(device_source_value)) "NULL" else if (is(device_source_value, "subQuery")) paste0("(", as.character(device_source_value), ")") else paste0("'", as.character(device_source_value), "'"))
  }

  if (!missing(device_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " device_source_concept_id = ", if (is.null(device_source_concept_id)) "NULL" else if (is(device_source_concept_id, "subQuery")) paste0("(", as.character(device_source_concept_id), ")") else paste0("'", as.character(device_source_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_measurement <- function(fetchField, measurement_id, person_id, measurement_concept_id, measurement_date, measurement_datetime, measurement_time, measurement_type_concept_id, operator_concept_id, value_as_number, value_as_concept_id, unit_concept_id, range_low, range_high, provider_id, visit_occurrence_id, visit_detail_id, measurement_source_value, measurement_source_concept_id, unit_source_value, value_source_value) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.measurement WHERE')
  first <- TRUE
  if (!missing(measurement_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_id = ", if (is.null(measurement_id)) "NULL" else if (is(measurement_id, "subQuery")) paste0("(", as.character(measurement_id), ")") else paste0("'", as.character(measurement_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id = ", if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(measurement_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_concept_id = ", if (is.null(measurement_concept_id)) "NULL" else if (is(measurement_concept_id, "subQuery")) paste0("(", as.character(measurement_concept_id), ")") else paste0("'", as.character(measurement_concept_id), "'"))
  }

  if (!missing(measurement_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_date = ", if (is.null(measurement_date)) "NULL" else if (is(measurement_date, "subQuery")) paste0("(", as.character(measurement_date), ")") else paste0("'", as.character(measurement_date), "'"))
  }

  if (!missing(measurement_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_datetime = ", if (is.null(measurement_datetime)) "NULL" else if (is(measurement_datetime, "subQuery")) paste0("(", as.character(measurement_datetime), ")") else paste0("'", as.character(measurement_datetime), "'"))
  }

  if (!missing(measurement_time)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_time = ", if (is.null(measurement_time)) "NULL" else if (is(measurement_time, "subQuery")) paste0("(", as.character(measurement_time), ")") else paste0("'", as.character(measurement_time), "'"))
  }

  if (!missing(measurement_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_type_concept_id = ", if (is.null(measurement_type_concept_id)) "NULL" else if (is(measurement_type_concept_id, "subQuery")) paste0("(", as.character(measurement_type_concept_id), ")") else paste0("'", as.character(measurement_type_concept_id), "'"))
  }

  if (!missing(operator_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " operator_concept_id = ", if (is.null(operator_concept_id)) "NULL" else if (is(operator_concept_id, "subQuery")) paste0("(", as.character(operator_concept_id), ")") else paste0("'", as.character(operator_concept_id), "'"))
  }

  if (!missing(value_as_number)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_number = ", if (is.null(value_as_number)) "NULL" else if (is(value_as_number, "subQuery")) paste0("(", as.character(value_as_number), ")") else paste0("'", as.character(value_as_number), "'"))
  }

  if (!missing(value_as_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_concept_id = ", if (is.null(value_as_concept_id)) "NULL" else if (is(value_as_concept_id, "subQuery")) paste0("(", as.character(value_as_concept_id), ")") else paste0("'", as.character(value_as_concept_id), "'"))
  }

  if (!missing(unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_concept_id = ", if (is.null(unit_concept_id)) "NULL" else if (is(unit_concept_id, "subQuery")) paste0("(", as.character(unit_concept_id), ")") else paste0("'", as.character(unit_concept_id), "'"))
  }

  if (!missing(range_low)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " range_low = ", if (is.null(range_low)) "NULL" else if (is(range_low, "subQuery")) paste0("(", as.character(range_low), ")") else paste0("'", as.character(range_low), "'"))
  }

  if (!missing(range_high)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " range_high = ", if (is.null(range_high)) "NULL" else if (is(range_high, "subQuery")) paste0("(", as.character(range_high), ")") else paste0("'", as.character(range_high), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id = ", if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id = ", if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id = ", if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
  }

  if (!missing(measurement_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_source_value = ", if (is.null(measurement_source_value)) "NULL" else if (is(measurement_source_value, "subQuery")) paste0("(", as.character(measurement_source_value), ")") else paste0("'", as.character(measurement_source_value), "'"))
  }

  if (!missing(measurement_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " measurement_source_concept_id = ", if (is.null(measurement_source_concept_id)) "NULL" else if (is(measurement_source_concept_id, "subQuery")) paste0("(", as.character(measurement_source_concept_id), ")") else paste0("'", as.character(measurement_source_concept_id), "'"))
  }

  if (!missing(unit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_source_value = ", if (is.null(unit_source_value)) "NULL" else if (is(unit_source_value, "subQuery")) paste0("(", as.character(unit_source_value), ")") else paste0("'", as.character(unit_source_value), "'"))
  }

  if (!missing(value_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_source_value = ", if (is.null(value_source_value)) "NULL" else if (is(value_source_value, "subQuery")) paste0("(", as.character(value_source_value), ")") else paste0("'", as.character(value_source_value), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_observation <- function(fetchField, observation_id, person_id, observation_concept_id, observation_date, observation_datetime, observation_type_concept_id, value_as_number, value_as_string, value_as_concept_id, qualifier_concept_id, unit_concept_id, provider_id, visit_occurrence_id, visit_detail_id, observation_source_value, observation_source_concept_id, unit_source_value, qualifier_source_value, observation_event_id, obs_event_field_concept_id, value_as_datetime) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.observation WHERE')
  first <- TRUE
  if (!missing(observation_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_id = ", if (is.null(observation_id)) "NULL" else if (is(observation_id, "subQuery")) paste0("(", as.character(observation_id), ")") else paste0("'", as.character(observation_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id = ", if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(observation_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_concept_id = ", if (is.null(observation_concept_id)) "NULL" else if (is(observation_concept_id, "subQuery")) paste0("(", as.character(observation_concept_id), ")") else paste0("'", as.character(observation_concept_id), "'"))
  }

  if (!missing(observation_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_date = ", if (is.null(observation_date)) "NULL" else if (is(observation_date, "subQuery")) paste0("(", as.character(observation_date), ")") else paste0("'", as.character(observation_date), "'"))
  }

  if (!missing(observation_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_datetime = ", if (is.null(observation_datetime)) "NULL" else if (is(observation_datetime, "subQuery")) paste0("(", as.character(observation_datetime), ")") else paste0("'", as.character(observation_datetime), "'"))
  }

  if (!missing(observation_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_type_concept_id = ", if (is.null(observation_type_concept_id)) "NULL" else if (is(observation_type_concept_id, "subQuery")) paste0("(", as.character(observation_type_concept_id), ")") else paste0("'", as.character(observation_type_concept_id), "'"))
  }

  if (!missing(value_as_number)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_number = ", if (is.null(value_as_number)) "NULL" else if (is(value_as_number, "subQuery")) paste0("(", as.character(value_as_number), ")") else paste0("'", as.character(value_as_number), "'"))
  }

  if (!missing(value_as_string)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_string = ", if (is.null(value_as_string)) "NULL" else if (is(value_as_string, "subQuery")) paste0("(", as.character(value_as_string), ")") else paste0("'", as.character(value_as_string), "'"))
  }

  if (!missing(value_as_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_concept_id = ", if (is.null(value_as_concept_id)) "NULL" else if (is(value_as_concept_id, "subQuery")) paste0("(", as.character(value_as_concept_id), ")") else paste0("'", as.character(value_as_concept_id), "'"))
  }

  if (!missing(qualifier_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " qualifier_concept_id = ", if (is.null(qualifier_concept_id)) "NULL" else if (is(qualifier_concept_id, "subQuery")) paste0("(", as.character(qualifier_concept_id), ")") else paste0("'", as.character(qualifier_concept_id), "'"))
  }

  if (!missing(unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_concept_id = ", if (is.null(unit_concept_id)) "NULL" else if (is(unit_concept_id, "subQuery")) paste0("(", as.character(unit_concept_id), ")") else paste0("'", as.character(unit_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id = ", if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id = ", if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id = ", if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
  }

  if (!missing(observation_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_source_value = ", if (is.null(observation_source_value)) "NULL" else if (is(observation_source_value, "subQuery")) paste0("(", as.character(observation_source_value), ")") else paste0("'", as.character(observation_source_value), "'"))
  }

  if (!missing(observation_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_source_concept_id = ", if (is.null(observation_source_concept_id)) "NULL" else if (is(observation_source_concept_id, "subQuery")) paste0("(", as.character(observation_source_concept_id), ")") else paste0("'", as.character(observation_source_concept_id), "'"))
  }

  if (!missing(unit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_source_value = ", if (is.null(unit_source_value)) "NULL" else if (is(unit_source_value, "subQuery")) paste0("(", as.character(unit_source_value), ")") else paste0("'", as.character(unit_source_value), "'"))
  }

  if (!missing(qualifier_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " qualifier_source_value = ", if (is.null(qualifier_source_value)) "NULL" else if (is(qualifier_source_value, "subQuery")) paste0("(", as.character(qualifier_source_value), ")") else paste0("'", as.character(qualifier_source_value), "'"))
  }

  if (!missing(observation_event_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " observation_event_id = ", if (is.null(observation_event_id)) "NULL" else if (is(observation_event_id, "subQuery")) paste0("(", as.character(observation_event_id), ")") else paste0("'", as.character(observation_event_id), "'"))
  }

  if (!missing(obs_event_field_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " obs_event_field_concept_id = ", if (is.null(obs_event_field_concept_id)) "NULL" else if (is(obs_event_field_concept_id, "subQuery")) paste0("(", as.character(obs_event_field_concept_id), ")") else paste0("'", as.character(obs_event_field_concept_id), "'"))
  }

  if (!missing(value_as_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_datetime = ", if (is.null(value_as_datetime)) "NULL" else if (is(value_as_datetime, "subQuery")) paste0("(", as.character(value_as_datetime), ")") else paste0("'", as.character(value_as_datetime), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_specimen <- function(fetchField, specimen_id, person_id, specimen_concept_id, specimen_type_concept_id, specimen_date, specimen_datetime, quantity, unit_concept_id, anatomic_site_concept_id, disease_status_concept_id, specimen_source_id, specimen_source_value, unit_source_value, anatomic_site_source_value, disease_status_source_value) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.specimen WHERE')
  first <- TRUE
  if (!missing(specimen_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specimen_id = ", if (is.null(specimen_id)) "NULL" else if (is(specimen_id, "subQuery")) paste0("(", as.character(specimen_id), ")") else paste0("'", as.character(specimen_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id = ", if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(specimen_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specimen_concept_id = ", if (is.null(specimen_concept_id)) "NULL" else if (is(specimen_concept_id, "subQuery")) paste0("(", as.character(specimen_concept_id), ")") else paste0("'", as.character(specimen_concept_id), "'"))
  }

  if (!missing(specimen_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specimen_type_concept_id = ", if (is.null(specimen_type_concept_id)) "NULL" else if (is(specimen_type_concept_id, "subQuery")) paste0("(", as.character(specimen_type_concept_id), ")") else paste0("'", as.character(specimen_type_concept_id), "'"))
  }

  if (!missing(specimen_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specimen_date = ", if (is.null(specimen_date)) "NULL" else if (is(specimen_date, "subQuery")) paste0("(", as.character(specimen_date), ")") else paste0("'", as.character(specimen_date), "'"))
  }

  if (!missing(specimen_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specimen_datetime = ", if (is.null(specimen_datetime)) "NULL" else if (is(specimen_datetime, "subQuery")) paste0("(", as.character(specimen_datetime), ")") else paste0("'", as.character(specimen_datetime), "'"))
  }

  if (!missing(quantity)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " quantity = ", if (is.null(quantity)) "NULL" else if (is(quantity, "subQuery")) paste0("(", as.character(quantity), ")") else paste0("'", as.character(quantity), "'"))
  }

  if (!missing(unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_concept_id = ", if (is.null(unit_concept_id)) "NULL" else if (is(unit_concept_id, "subQuery")) paste0("(", as.character(unit_concept_id), ")") else paste0("'", as.character(unit_concept_id), "'"))
  }

  if (!missing(anatomic_site_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " anatomic_site_concept_id = ", if (is.null(anatomic_site_concept_id)) "NULL" else if (is(anatomic_site_concept_id, "subQuery")) paste0("(", as.character(anatomic_site_concept_id), ")") else paste0("'", as.character(anatomic_site_concept_id), "'"))
  }

  if (!missing(disease_status_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " disease_status_concept_id = ", if (is.null(disease_status_concept_id)) "NULL" else if (is(disease_status_concept_id, "subQuery")) paste0("(", as.character(disease_status_concept_id), ")") else paste0("'", as.character(disease_status_concept_id), "'"))
  }

  if (!missing(specimen_source_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specimen_source_id = ", if (is.null(specimen_source_id)) "NULL" else if (is(specimen_source_id, "subQuery")) paste0("(", as.character(specimen_source_id), ")") else paste0("'", as.character(specimen_source_id), "'"))
  }

  if (!missing(specimen_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specimen_source_value = ", if (is.null(specimen_source_value)) "NULL" else if (is(specimen_source_value, "subQuery")) paste0("(", as.character(specimen_source_value), ")") else paste0("'", as.character(specimen_source_value), "'"))
  }

  if (!missing(unit_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_source_value = ", if (is.null(unit_source_value)) "NULL" else if (is(unit_source_value, "subQuery")) paste0("(", as.character(unit_source_value), ")") else paste0("'", as.character(unit_source_value), "'"))
  }

  if (!missing(anatomic_site_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " anatomic_site_source_value = ", if (is.null(anatomic_site_source_value)) "NULL" else if (is(anatomic_site_source_value, "subQuery")) paste0("(", as.character(anatomic_site_source_value), ")") else paste0("'", as.character(anatomic_site_source_value), "'"))
  }

  if (!missing(disease_status_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " disease_status_source_value = ", if (is.null(disease_status_source_value)) "NULL" else if (is(disease_status_source_value, "subQuery")) paste0("(", as.character(disease_status_source_value), ")") else paste0("'", as.character(disease_status_source_value), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_note <- function(fetchField, note_id, person_id, note_event_id, note_event_field_concept_id, note_date, note_datetime, note_type_concept_id, note_class_concept_id, note_title, note_text, encoding_concept_id, language_concept_id, provider_id, visit_occurrence_id, visit_detail_id, note_source_value) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.note WHERE')
  first <- TRUE
  if (!missing(note_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_id = ", if (is.null(note_id)) "NULL" else if (is(note_id, "subQuery")) paste0("(", as.character(note_id), ")") else paste0("'", as.character(note_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id = ", if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(note_event_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_event_id = ", if (is.null(note_event_id)) "NULL" else if (is(note_event_id, "subQuery")) paste0("(", as.character(note_event_id), ")") else paste0("'", as.character(note_event_id), "'"))
  }

  if (!missing(note_event_field_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_event_field_concept_id = ", if (is.null(note_event_field_concept_id)) "NULL" else if (is(note_event_field_concept_id, "subQuery")) paste0("(", as.character(note_event_field_concept_id), ")") else paste0("'", as.character(note_event_field_concept_id), "'"))
  }

  if (!missing(note_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_date = ", if (is.null(note_date)) "NULL" else if (is(note_date, "subQuery")) paste0("(", as.character(note_date), ")") else paste0("'", as.character(note_date), "'"))
  }

  if (!missing(note_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_datetime = ", if (is.null(note_datetime)) "NULL" else if (is(note_datetime, "subQuery")) paste0("(", as.character(note_datetime), ")") else paste0("'", as.character(note_datetime), "'"))
  }

  if (!missing(note_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_type_concept_id = ", if (is.null(note_type_concept_id)) "NULL" else if (is(note_type_concept_id, "subQuery")) paste0("(", as.character(note_type_concept_id), ")") else paste0("'", as.character(note_type_concept_id), "'"))
  }

  if (!missing(note_class_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_class_concept_id = ", if (is.null(note_class_concept_id)) "NULL" else if (is(note_class_concept_id, "subQuery")) paste0("(", as.character(note_class_concept_id), ")") else paste0("'", as.character(note_class_concept_id), "'"))
  }

  if (!missing(note_title)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_title = ", if (is.null(note_title)) "NULL" else if (is(note_title, "subQuery")) paste0("(", as.character(note_title), ")") else paste0("'", as.character(note_title), "'"))
  }

  if (!missing(note_text)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_text = ", if (is.null(note_text)) "NULL" else if (is(note_text, "subQuery")) paste0("(", as.character(note_text), ")") else paste0("'", as.character(note_text), "'"))
  }

  if (!missing(encoding_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " encoding_concept_id = ", if (is.null(encoding_concept_id)) "NULL" else if (is(encoding_concept_id, "subQuery")) paste0("(", as.character(encoding_concept_id), ")") else paste0("'", as.character(encoding_concept_id), "'"))
  }

  if (!missing(language_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " language_concept_id = ", if (is.null(language_concept_id)) "NULL" else if (is(language_concept_id, "subQuery")) paste0("(", as.character(language_concept_id), ")") else paste0("'", as.character(language_concept_id), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id = ", if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id = ", if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(visit_detail_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_detail_id = ", if (is.null(visit_detail_id)) "NULL" else if (is(visit_detail_id, "subQuery")) paste0("(", as.character(visit_detail_id), ")") else paste0("'", as.character(visit_detail_id), "'"))
  }

  if (!missing(note_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_source_value = ", if (is.null(note_source_value)) "NULL" else if (is(note_source_value, "subQuery")) paste0("(", as.character(note_source_value), ")") else paste0("'", as.character(note_source_value), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_note_nlp <- function(fetchField, note_nlp_id, note_id, section_concept_id, snippet, offset, lexical_variant, note_nlp_concept_id, note_nlp_source_concept_id, nlp_system, nlp_date, nlp_datetime, term_exists, term_temporal, term_modifiers) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.note_nlp WHERE')
  first <- TRUE
  if (!missing(note_nlp_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_nlp_id = ", if (is.null(note_nlp_id)) "NULL" else if (is(note_nlp_id, "subQuery")) paste0("(", as.character(note_nlp_id), ")") else paste0("'", as.character(note_nlp_id), "'"))
  }

  if (!missing(note_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_id = ", if (is.null(note_id)) "NULL" else if (is(note_id, "subQuery")) paste0("(", as.character(note_id), ")") else paste0("'", as.character(note_id), "'"))
  }

  if (!missing(section_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " section_concept_id = ", if (is.null(section_concept_id)) "NULL" else if (is(section_concept_id, "subQuery")) paste0("(", as.character(section_concept_id), ")") else paste0("'", as.character(section_concept_id), "'"))
  }

  if (!missing(snippet)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " snippet = ", if (is.null(snippet)) "NULL" else if (is(snippet, "subQuery")) paste0("(", as.character(snippet), ")") else paste0("'", as.character(snippet), "'"))
  }

  if (!missing(offset)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " offset = ", if (is.null(offset)) "NULL" else if (is(offset, "subQuery")) paste0("(", as.character(offset), ")") else paste0("'", as.character(offset), "'"))
  }

  if (!missing(lexical_variant)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " lexical_variant = ", if (is.null(lexical_variant)) "NULL" else if (is(lexical_variant, "subQuery")) paste0("(", as.character(lexical_variant), ")") else paste0("'", as.character(lexical_variant), "'"))
  }

  if (!missing(note_nlp_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_nlp_concept_id = ", if (is.null(note_nlp_concept_id)) "NULL" else if (is(note_nlp_concept_id, "subQuery")) paste0("(", as.character(note_nlp_concept_id), ")") else paste0("'", as.character(note_nlp_concept_id), "'"))
  }

  if (!missing(note_nlp_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " note_nlp_source_concept_id = ", if (is.null(note_nlp_source_concept_id)) "NULL" else if (is(note_nlp_source_concept_id, "subQuery")) paste0("(", as.character(note_nlp_source_concept_id), ")") else paste0("'", as.character(note_nlp_source_concept_id), "'"))
  }

  if (!missing(nlp_system)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " nlp_system = ", if (is.null(nlp_system)) "NULL" else if (is(nlp_system, "subQuery")) paste0("(", as.character(nlp_system), ")") else paste0("'", as.character(nlp_system), "'"))
  }

  if (!missing(nlp_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " nlp_date = ", if (is.null(nlp_date)) "NULL" else if (is(nlp_date, "subQuery")) paste0("(", as.character(nlp_date), ")") else paste0("'", as.character(nlp_date), "'"))
  }

  if (!missing(nlp_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " nlp_datetime = ", if (is.null(nlp_datetime)) "NULL" else if (is(nlp_datetime, "subQuery")) paste0("(", as.character(nlp_datetime), ")") else paste0("'", as.character(nlp_datetime), "'"))
  }

  if (!missing(term_exists)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " term_exists = ", if (is.null(term_exists)) "NULL" else if (is(term_exists, "subQuery")) paste0("(", as.character(term_exists), ")") else paste0("'", as.character(term_exists), "'"))
  }

  if (!missing(term_temporal)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " term_temporal = ", if (is.null(term_temporal)) "NULL" else if (is(term_temporal, "subQuery")) paste0("(", as.character(term_temporal), ")") else paste0("'", as.character(term_temporal), "'"))
  }

  if (!missing(term_modifiers)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " term_modifiers = ", if (is.null(term_modifiers)) "NULL" else if (is(term_modifiers, "subQuery")) paste0("(", as.character(term_modifiers), ")") else paste0("'", as.character(term_modifiers), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_survey_conduct <- function(fetchField, survey_conduct_id, person_id, survey_concept_id, survey_start_date, survey_start_datetime, survey_end_date, survey_end_datetime, provider_id, assisted_concept_id, respondent_type_concept_id, timing_concept_id, collection_method_concept_id, assisted_source_value, respondent_type_source_value, timing_source_value, collection_method_source_value, survey_source_value, survey_source_concept_id, survey_source_identifier, validated_survey_concept_id, validated_survey_source_value, survey_version_number, visit_occurrence_id, response_visit_occurrence_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.survey_conduct WHERE')
  first <- TRUE
  if (!missing(survey_conduct_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " survey_conduct_id = ", if (is.null(survey_conduct_id)) "NULL" else if (is(survey_conduct_id, "subQuery")) paste0("(", as.character(survey_conduct_id), ")") else paste0("'", as.character(survey_conduct_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id = ", if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(survey_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " survey_concept_id = ", if (is.null(survey_concept_id)) "NULL" else if (is(survey_concept_id, "subQuery")) paste0("(", as.character(survey_concept_id), ")") else paste0("'", as.character(survey_concept_id), "'"))
  }

  if (!missing(survey_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " survey_start_date = ", if (is.null(survey_start_date)) "NULL" else if (is(survey_start_date, "subQuery")) paste0("(", as.character(survey_start_date), ")") else paste0("'", as.character(survey_start_date), "'"))
  }

  if (!missing(survey_start_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " survey_start_datetime = ", if (is.null(survey_start_datetime)) "NULL" else if (is(survey_start_datetime, "subQuery")) paste0("(", as.character(survey_start_datetime), ")") else paste0("'", as.character(survey_start_datetime), "'"))
  }

  if (!missing(survey_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " survey_end_date = ", if (is.null(survey_end_date)) "NULL" else if (is(survey_end_date, "subQuery")) paste0("(", as.character(survey_end_date), ")") else paste0("'", as.character(survey_end_date), "'"))
  }

  if (!missing(survey_end_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " survey_end_datetime = ", if (is.null(survey_end_datetime)) "NULL" else if (is(survey_end_datetime, "subQuery")) paste0("(", as.character(survey_end_datetime), ")") else paste0("'", as.character(survey_end_datetime), "'"))
  }

  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id = ", if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(assisted_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " assisted_concept_id = ", if (is.null(assisted_concept_id)) "NULL" else if (is(assisted_concept_id, "subQuery")) paste0("(", as.character(assisted_concept_id), ")") else paste0("'", as.character(assisted_concept_id), "'"))
  }

  if (!missing(respondent_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " respondent_type_concept_id = ", if (is.null(respondent_type_concept_id)) "NULL" else if (is(respondent_type_concept_id, "subQuery")) paste0("(", as.character(respondent_type_concept_id), ")") else paste0("'", as.character(respondent_type_concept_id), "'"))
  }

  if (!missing(timing_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " timing_concept_id = ", if (is.null(timing_concept_id)) "NULL" else if (is(timing_concept_id, "subQuery")) paste0("(", as.character(timing_concept_id), ")") else paste0("'", as.character(timing_concept_id), "'"))
  }

  if (!missing(collection_method_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " collection_method_concept_id = ", if (is.null(collection_method_concept_id)) "NULL" else if (is(collection_method_concept_id, "subQuery")) paste0("(", as.character(collection_method_concept_id), ")") else paste0("'", as.character(collection_method_concept_id), "'"))
  }

  if (!missing(assisted_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " assisted_source_value = ", if (is.null(assisted_source_value)) "NULL" else if (is(assisted_source_value, "subQuery")) paste0("(", as.character(assisted_source_value), ")") else paste0("'", as.character(assisted_source_value), "'"))
  }

  if (!missing(respondent_type_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " respondent_type_source_value = ", if (is.null(respondent_type_source_value)) "NULL" else if (is(respondent_type_source_value, "subQuery")) paste0("(", as.character(respondent_type_source_value), ")") else paste0("'", as.character(respondent_type_source_value), "'"))
  }

  if (!missing(timing_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " timing_source_value = ", if (is.null(timing_source_value)) "NULL" else if (is(timing_source_value, "subQuery")) paste0("(", as.character(timing_source_value), ")") else paste0("'", as.character(timing_source_value), "'"))
  }

  if (!missing(collection_method_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " collection_method_source_value = ", if (is.null(collection_method_source_value)) "NULL" else if (is(collection_method_source_value, "subQuery")) paste0("(", as.character(collection_method_source_value), ")") else paste0("'", as.character(collection_method_source_value), "'"))
  }

  if (!missing(survey_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " survey_source_value = ", if (is.null(survey_source_value)) "NULL" else if (is(survey_source_value, "subQuery")) paste0("(", as.character(survey_source_value), ")") else paste0("'", as.character(survey_source_value), "'"))
  }

  if (!missing(survey_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " survey_source_concept_id = ", if (is.null(survey_source_concept_id)) "NULL" else if (is(survey_source_concept_id, "subQuery")) paste0("(", as.character(survey_source_concept_id), ")") else paste0("'", as.character(survey_source_concept_id), "'"))
  }

  if (!missing(survey_source_identifier)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " survey_source_identifier = ", if (is.null(survey_source_identifier)) "NULL" else if (is(survey_source_identifier, "subQuery")) paste0("(", as.character(survey_source_identifier), ")") else paste0("'", as.character(survey_source_identifier), "'"))
  }

  if (!missing(validated_survey_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " validated_survey_concept_id = ", if (is.null(validated_survey_concept_id)) "NULL" else if (is(validated_survey_concept_id, "subQuery")) paste0("(", as.character(validated_survey_concept_id), ")") else paste0("'", as.character(validated_survey_concept_id), "'"))
  }

  if (!missing(validated_survey_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " validated_survey_source_value = ", if (is.null(validated_survey_source_value)) "NULL" else if (is(validated_survey_source_value, "subQuery")) paste0("(", as.character(validated_survey_source_value), ")") else paste0("'", as.character(validated_survey_source_value), "'"))
  }

  if (!missing(survey_version_number)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " survey_version_number = ", if (is.null(survey_version_number)) "NULL" else if (is(survey_version_number, "subQuery")) paste0("(", as.character(survey_version_number), ")") else paste0("'", as.character(survey_version_number), "'"))
  }

  if (!missing(visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " visit_occurrence_id = ", if (is.null(visit_occurrence_id)) "NULL" else if (is(visit_occurrence_id, "subQuery")) paste0("(", as.character(visit_occurrence_id), ")") else paste0("'", as.character(visit_occurrence_id), "'"))
  }

  if (!missing(response_visit_occurrence_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " response_visit_occurrence_id = ", if (is.null(response_visit_occurrence_id)) "NULL" else if (is(response_visit_occurrence_id, "subQuery")) paste0("(", as.character(response_visit_occurrence_id), ")") else paste0("'", as.character(response_visit_occurrence_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_cost <- function(fetchField, cost_id, person_id, cost_event_id, cost_event_field_concept_id, cost_concept_id, cost_type_concept_id, cost_source_concept_id, cost_source_value, currency_concept_id, cost, incurred_date, billed_date, paid_date, revenue_code_concept_id, drg_concept_id, revenue_code_source_value, drg_source_value, payer_plan_period_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.cost WHERE')
  first <- TRUE
  if (!missing(cost_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cost_id = ", if (is.null(cost_id)) "NULL" else if (is(cost_id, "subQuery")) paste0("(", as.character(cost_id), ")") else paste0("'", as.character(cost_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id = ", if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(cost_event_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cost_event_id = ", if (is.null(cost_event_id)) "NULL" else if (is(cost_event_id, "subQuery")) paste0("(", as.character(cost_event_id), ")") else paste0("'", as.character(cost_event_id), "'"))
  }

  if (!missing(cost_event_field_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cost_event_field_concept_id = ", if (is.null(cost_event_field_concept_id)) "NULL" else if (is(cost_event_field_concept_id, "subQuery")) paste0("(", as.character(cost_event_field_concept_id), ")") else paste0("'", as.character(cost_event_field_concept_id), "'"))
  }

  if (!missing(cost_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cost_concept_id = ", if (is.null(cost_concept_id)) "NULL" else if (is(cost_concept_id, "subQuery")) paste0("(", as.character(cost_concept_id), ")") else paste0("'", as.character(cost_concept_id), "'"))
  }

  if (!missing(cost_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cost_type_concept_id = ", if (is.null(cost_type_concept_id)) "NULL" else if (is(cost_type_concept_id, "subQuery")) paste0("(", as.character(cost_type_concept_id), ")") else paste0("'", as.character(cost_type_concept_id), "'"))
  }

  if (!missing(cost_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cost_source_concept_id = ", if (is.null(cost_source_concept_id)) "NULL" else if (is(cost_source_concept_id, "subQuery")) paste0("(", as.character(cost_source_concept_id), ")") else paste0("'", as.character(cost_source_concept_id), "'"))
  }

  if (!missing(cost_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cost_source_value = ", if (is.null(cost_source_value)) "NULL" else if (is(cost_source_value, "subQuery")) paste0("(", as.character(cost_source_value), ")") else paste0("'", as.character(cost_source_value), "'"))
  }

  if (!missing(currency_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " currency_concept_id = ", if (is.null(currency_concept_id)) "NULL" else if (is(currency_concept_id, "subQuery")) paste0("(", as.character(currency_concept_id), ")") else paste0("'", as.character(currency_concept_id), "'"))
  }

  if (!missing(cost)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cost = ", if (is.null(cost)) "NULL" else if (is(cost, "subQuery")) paste0("(", as.character(cost), ")") else paste0("'", as.character(cost), "'"))
  }

  if (!missing(incurred_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " incurred_date = ", if (is.null(incurred_date)) "NULL" else if (is(incurred_date, "subQuery")) paste0("(", as.character(incurred_date), ")") else paste0("'", as.character(incurred_date), "'"))
  }

  if (!missing(billed_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " billed_date = ", if (is.null(billed_date)) "NULL" else if (is(billed_date, "subQuery")) paste0("(", as.character(billed_date), ")") else paste0("'", as.character(billed_date), "'"))
  }

  if (!missing(paid_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " paid_date = ", if (is.null(paid_date)) "NULL" else if (is(paid_date, "subQuery")) paste0("(", as.character(paid_date), ")") else paste0("'", as.character(paid_date), "'"))
  }

  if (!missing(revenue_code_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " revenue_code_concept_id = ", if (is.null(revenue_code_concept_id)) "NULL" else if (is(revenue_code_concept_id, "subQuery")) paste0("(", as.character(revenue_code_concept_id), ")") else paste0("'", as.character(revenue_code_concept_id), "'"))
  }

  if (!missing(drg_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drg_concept_id = ", if (is.null(drg_concept_id)) "NULL" else if (is(drg_concept_id, "subQuery")) paste0("(", as.character(drg_concept_id), ")") else paste0("'", as.character(drg_concept_id), "'"))
  }

  if (!missing(revenue_code_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " revenue_code_source_value = ", if (is.null(revenue_code_source_value)) "NULL" else if (is(revenue_code_source_value, "subQuery")) paste0("(", as.character(revenue_code_source_value), ")") else paste0("'", as.character(revenue_code_source_value), "'"))
  }

  if (!missing(drg_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drg_source_value = ", if (is.null(drg_source_value)) "NULL" else if (is(drg_source_value, "subQuery")) paste0("(", as.character(drg_source_value), ")") else paste0("'", as.character(drg_source_value), "'"))
  }

  if (!missing(payer_plan_period_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " payer_plan_period_id = ", if (is.null(payer_plan_period_id)) "NULL" else if (is(payer_plan_period_id, "subQuery")) paste0("(", as.character(payer_plan_period_id), ")") else paste0("'", as.character(payer_plan_period_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_payer_plan_period <- function(fetchField, payer_plan_period_id, person_id, contract_person_id, payer_plan_period_start_date, payer_plan_period_end_date, payer_concept_id, payer_source_value, payer_source_concept_id, plan_concept_id, plan_source_value, plan_source_concept_id, contract_concept_id, contract_source_value, contract_source_concept_id, sponsor_concept_id, sponsor_source_value, sponsor_source_concept_id, family_source_value, stop_reason_concept_id, stop_reason_source_value, stop_reason_source_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.payer_plan_period WHERE')
  first <- TRUE
  if (!missing(payer_plan_period_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " payer_plan_period_id = ", if (is.null(payer_plan_period_id)) "NULL" else if (is(payer_plan_period_id, "subQuery")) paste0("(", as.character(payer_plan_period_id), ")") else paste0("'", as.character(payer_plan_period_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id = ", if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(contract_person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " contract_person_id = ", if (is.null(contract_person_id)) "NULL" else if (is(contract_person_id, "subQuery")) paste0("(", as.character(contract_person_id), ")") else paste0("'", as.character(contract_person_id), "'"))
  }

  if (!missing(payer_plan_period_start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " payer_plan_period_start_date = ", if (is.null(payer_plan_period_start_date)) "NULL" else if (is(payer_plan_period_start_date, "subQuery")) paste0("(", as.character(payer_plan_period_start_date), ")") else paste0("'", as.character(payer_plan_period_start_date), "'"))
  }

  if (!missing(payer_plan_period_end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " payer_plan_period_end_date = ", if (is.null(payer_plan_period_end_date)) "NULL" else if (is(payer_plan_period_end_date, "subQuery")) paste0("(", as.character(payer_plan_period_end_date), ")") else paste0("'", as.character(payer_plan_period_end_date), "'"))
  }

  if (!missing(payer_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " payer_concept_id = ", if (is.null(payer_concept_id)) "NULL" else if (is(payer_concept_id, "subQuery")) paste0("(", as.character(payer_concept_id), ")") else paste0("'", as.character(payer_concept_id), "'"))
  }

  if (!missing(payer_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " payer_source_value = ", if (is.null(payer_source_value)) "NULL" else if (is(payer_source_value, "subQuery")) paste0("(", as.character(payer_source_value), ")") else paste0("'", as.character(payer_source_value), "'"))
  }

  if (!missing(payer_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " payer_source_concept_id = ", if (is.null(payer_source_concept_id)) "NULL" else if (is(payer_source_concept_id, "subQuery")) paste0("(", as.character(payer_source_concept_id), ")") else paste0("'", as.character(payer_source_concept_id), "'"))
  }

  if (!missing(plan_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " plan_concept_id = ", if (is.null(plan_concept_id)) "NULL" else if (is(plan_concept_id, "subQuery")) paste0("(", as.character(plan_concept_id), ")") else paste0("'", as.character(plan_concept_id), "'"))
  }

  if (!missing(plan_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " plan_source_value = ", if (is.null(plan_source_value)) "NULL" else if (is(plan_source_value, "subQuery")) paste0("(", as.character(plan_source_value), ")") else paste0("'", as.character(plan_source_value), "'"))
  }

  if (!missing(plan_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " plan_source_concept_id = ", if (is.null(plan_source_concept_id)) "NULL" else if (is(plan_source_concept_id, "subQuery")) paste0("(", as.character(plan_source_concept_id), ")") else paste0("'", as.character(plan_source_concept_id), "'"))
  }

  if (!missing(contract_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " contract_concept_id = ", if (is.null(contract_concept_id)) "NULL" else if (is(contract_concept_id, "subQuery")) paste0("(", as.character(contract_concept_id), ")") else paste0("'", as.character(contract_concept_id), "'"))
  }

  if (!missing(contract_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " contract_source_value = ", if (is.null(contract_source_value)) "NULL" else if (is(contract_source_value, "subQuery")) paste0("(", as.character(contract_source_value), ")") else paste0("'", as.character(contract_source_value), "'"))
  }

  if (!missing(contract_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " contract_source_concept_id = ", if (is.null(contract_source_concept_id)) "NULL" else if (is(contract_source_concept_id, "subQuery")) paste0("(", as.character(contract_source_concept_id), ")") else paste0("'", as.character(contract_source_concept_id), "'"))
  }

  if (!missing(sponsor_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " sponsor_concept_id = ", if (is.null(sponsor_concept_id)) "NULL" else if (is(sponsor_concept_id, "subQuery")) paste0("(", as.character(sponsor_concept_id), ")") else paste0("'", as.character(sponsor_concept_id), "'"))
  }

  if (!missing(sponsor_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " sponsor_source_value = ", if (is.null(sponsor_source_value)) "NULL" else if (is(sponsor_source_value, "subQuery")) paste0("(", as.character(sponsor_source_value), ")") else paste0("'", as.character(sponsor_source_value), "'"))
  }

  if (!missing(sponsor_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " sponsor_source_concept_id = ", if (is.null(sponsor_source_concept_id)) "NULL" else if (is(sponsor_source_concept_id, "subQuery")) paste0("(", as.character(sponsor_source_concept_id), ")") else paste0("'", as.character(sponsor_source_concept_id), "'"))
  }

  if (!missing(family_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " family_source_value = ", if (is.null(family_source_value)) "NULL" else if (is(family_source_value, "subQuery")) paste0("(", as.character(family_source_value), ")") else paste0("'", as.character(family_source_value), "'"))
  }

  if (!missing(stop_reason_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " stop_reason_concept_id = ", if (is.null(stop_reason_concept_id)) "NULL" else if (is(stop_reason_concept_id, "subQuery")) paste0("(", as.character(stop_reason_concept_id), ")") else paste0("'", as.character(stop_reason_concept_id), "'"))
  }

  if (!missing(stop_reason_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " stop_reason_source_value = ", if (is.null(stop_reason_source_value)) "NULL" else if (is(stop_reason_source_value, "subQuery")) paste0("(", as.character(stop_reason_source_value), ")") else paste0("'", as.character(stop_reason_source_value), "'"))
  }

  if (!missing(stop_reason_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " stop_reason_source_concept_id = ", if (is.null(stop_reason_source_concept_id)) "NULL" else if (is(stop_reason_source_concept_id, "subQuery")) paste0("(", as.character(stop_reason_source_concept_id), ")") else paste0("'", as.character(stop_reason_source_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_drug_era <- function(fetchField, drug_era_id, person_id, drug_concept_id, drug_era_start_datetime, drug_era_end_datetime, drug_exposure_count, gap_days) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.drug_era WHERE')
  first <- TRUE
  if (!missing(drug_era_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_era_id = ", if (is.null(drug_era_id)) "NULL" else if (is(drug_era_id, "subQuery")) paste0("(", as.character(drug_era_id), ")") else paste0("'", as.character(drug_era_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id = ", if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(drug_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_concept_id = ", if (is.null(drug_concept_id)) "NULL" else if (is(drug_concept_id, "subQuery")) paste0("(", as.character(drug_concept_id), ")") else paste0("'", as.character(drug_concept_id), "'"))
  }

  if (!missing(drug_era_start_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_era_start_datetime = ", if (is.null(drug_era_start_datetime)) "NULL" else if (is(drug_era_start_datetime, "subQuery")) paste0("(", as.character(drug_era_start_datetime), ")") else paste0("'", as.character(drug_era_start_datetime), "'"))
  }

  if (!missing(drug_era_end_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_era_end_datetime = ", if (is.null(drug_era_end_datetime)) "NULL" else if (is(drug_era_end_datetime, "subQuery")) paste0("(", as.character(drug_era_end_datetime), ")") else paste0("'", as.character(drug_era_end_datetime), "'"))
  }

  if (!missing(drug_exposure_count)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_exposure_count = ", if (is.null(drug_exposure_count)) "NULL" else if (is(drug_exposure_count, "subQuery")) paste0("(", as.character(drug_exposure_count), ")") else paste0("'", as.character(drug_exposure_count), "'"))
  }

  if (!missing(gap_days)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " gap_days = ", if (is.null(gap_days)) "NULL" else if (is(gap_days, "subQuery")) paste0("(", as.character(gap_days), ")") else paste0("'", as.character(gap_days), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_dose_era <- function(fetchField, dose_era_id, person_id, drug_concept_id, unit_concept_id, dose_value, dose_era_start_datetime, dose_era_end_datetime) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.dose_era WHERE')
  first <- TRUE
  if (!missing(dose_era_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " dose_era_id = ", if (is.null(dose_era_id)) "NULL" else if (is(dose_era_id, "subQuery")) paste0("(", as.character(dose_era_id), ")") else paste0("'", as.character(dose_era_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id = ", if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(drug_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " drug_concept_id = ", if (is.null(drug_concept_id)) "NULL" else if (is(drug_concept_id, "subQuery")) paste0("(", as.character(drug_concept_id), ")") else paste0("'", as.character(drug_concept_id), "'"))
  }

  if (!missing(unit_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " unit_concept_id = ", if (is.null(unit_concept_id)) "NULL" else if (is(unit_concept_id, "subQuery")) paste0("(", as.character(unit_concept_id), ")") else paste0("'", as.character(unit_concept_id), "'"))
  }

  if (!missing(dose_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " dose_value = ", if (is.null(dose_value)) "NULL" else if (is(dose_value, "subQuery")) paste0("(", as.character(dose_value), ")") else paste0("'", as.character(dose_value), "'"))
  }

  if (!missing(dose_era_start_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " dose_era_start_datetime = ", if (is.null(dose_era_start_datetime)) "NULL" else if (is(dose_era_start_datetime, "subQuery")) paste0("(", as.character(dose_era_start_datetime), ")") else paste0("'", as.character(dose_era_start_datetime), "'"))
  }

  if (!missing(dose_era_end_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " dose_era_end_datetime = ", if (is.null(dose_era_end_datetime)) "NULL" else if (is(dose_era_end_datetime, "subQuery")) paste0("(", as.character(dose_era_end_datetime), ")") else paste0("'", as.character(dose_era_end_datetime), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_condition_era <- function(fetchField, condition_era_id, person_id, condition_concept_id, condition_era_start_datetime, condition_era_end_datetime, condition_occurrence_count) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.condition_era WHERE')
  first <- TRUE
  if (!missing(condition_era_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_era_id = ", if (is.null(condition_era_id)) "NULL" else if (is(condition_era_id, "subQuery")) paste0("(", as.character(condition_era_id), ")") else paste0("'", as.character(condition_era_id), "'"))
  }

  if (!missing(person_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " person_id = ", if (is.null(person_id)) "NULL" else if (is(person_id, "subQuery")) paste0("(", as.character(person_id), ")") else paste0("'", as.character(person_id), "'"))
  }

  if (!missing(condition_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_concept_id = ", if (is.null(condition_concept_id)) "NULL" else if (is(condition_concept_id, "subQuery")) paste0("(", as.character(condition_concept_id), ")") else paste0("'", as.character(condition_concept_id), "'"))
  }

  if (!missing(condition_era_start_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_era_start_datetime = ", if (is.null(condition_era_start_datetime)) "NULL" else if (is(condition_era_start_datetime, "subQuery")) paste0("(", as.character(condition_era_start_datetime), ")") else paste0("'", as.character(condition_era_start_datetime), "'"))
  }

  if (!missing(condition_era_end_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_era_end_datetime = ", if (is.null(condition_era_end_datetime)) "NULL" else if (is(condition_era_end_datetime, "subQuery")) paste0("(", as.character(condition_era_end_datetime), ")") else paste0("'", as.character(condition_era_end_datetime), "'"))
  }

  if (!missing(condition_occurrence_count)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " condition_occurrence_count = ", if (is.null(condition_occurrence_count)) "NULL" else if (is(condition_occurrence_count, "subQuery")) paste0("(", as.character(condition_occurrence_count), ")") else paste0("'", as.character(condition_occurrence_count), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_location <- function(fetchField, location_id, address_1, address_2, city, state, zip, county, country, location_source_value, latitude, longitude) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.location WHERE')
  first <- TRUE
  if (!missing(location_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " location_id = ", if (is.null(location_id)) "NULL" else if (is(location_id, "subQuery")) paste0("(", as.character(location_id), ")") else paste0("'", as.character(location_id), "'"))
  }

  if (!missing(address_1)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " address_1 = ", if (is.null(address_1)) "NULL" else if (is(address_1, "subQuery")) paste0("(", as.character(address_1), ")") else paste0("'", as.character(address_1), "'"))
  }

  if (!missing(address_2)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " address_2 = ", if (is.null(address_2)) "NULL" else if (is(address_2, "subQuery")) paste0("(", as.character(address_2), ")") else paste0("'", as.character(address_2), "'"))
  }

  if (!missing(city)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " city = ", if (is.null(city)) "NULL" else if (is(city, "subQuery")) paste0("(", as.character(city), ")") else paste0("'", as.character(city), "'"))
  }

  if (!missing(state)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " state = ", if (is.null(state)) "NULL" else if (is(state, "subQuery")) paste0("(", as.character(state), ")") else paste0("'", as.character(state), "'"))
  }

  if (!missing(zip)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " zip = ", if (is.null(zip)) "NULL" else if (is(zip, "subQuery")) paste0("(", as.character(zip), ")") else paste0("'", as.character(zip), "'"))
  }

  if (!missing(county)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " county = ", if (is.null(county)) "NULL" else if (is(county, "subQuery")) paste0("(", as.character(county), ")") else paste0("'", as.character(county), "'"))
  }

  if (!missing(country)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " country = ", if (is.null(country)) "NULL" else if (is(country, "subQuery")) paste0("(", as.character(country), ")") else paste0("'", as.character(country), "'"))
  }

  if (!missing(location_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " location_source_value = ", if (is.null(location_source_value)) "NULL" else if (is(location_source_value, "subQuery")) paste0("(", as.character(location_source_value), ")") else paste0("'", as.character(location_source_value), "'"))
  }

  if (!missing(latitude)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " latitude = ", if (is.null(latitude)) "NULL" else if (is(latitude, "subQuery")) paste0("(", as.character(latitude), ")") else paste0("'", as.character(latitude), "'"))
  }

  if (!missing(longitude)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " longitude = ", if (is.null(longitude)) "NULL" else if (is(longitude, "subQuery")) paste0("(", as.character(longitude), ")") else paste0("'", as.character(longitude), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_location_history <- function(fetchField, location_id, relationship_type_concept_id, domain_id, entity_id, start_date, end_date) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.location_history WHERE')
  first <- TRUE
  if (!missing(location_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " location_id = ", if (is.null(location_id)) "NULL" else if (is(location_id, "subQuery")) paste0("(", as.character(location_id), ")") else paste0("'", as.character(location_id), "'"))
  }

  if (!missing(relationship_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " relationship_type_concept_id = ", if (is.null(relationship_type_concept_id)) "NULL" else if (is(relationship_type_concept_id, "subQuery")) paste0("(", as.character(relationship_type_concept_id), ")") else paste0("'", as.character(relationship_type_concept_id), "'"))
  }

  if (!missing(domain_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " domain_id = ", if (is.null(domain_id)) "NULL" else if (is(domain_id, "subQuery")) paste0("(", as.character(domain_id), ")") else paste0("'", as.character(domain_id), "'"))
  }

  if (!missing(entity_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " entity_id = ", if (is.null(entity_id)) "NULL" else if (is(entity_id, "subQuery")) paste0("(", as.character(entity_id), ")") else paste0("'", as.character(entity_id), "'"))
  }

  if (!missing(start_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " start_date = ", if (is.null(start_date)) "NULL" else if (is(start_date, "subQuery")) paste0("(", as.character(start_date), ")") else paste0("'", as.character(start_date), "'"))
  }

  if (!missing(end_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " end_date = ", if (is.null(end_date)) "NULL" else if (is(end_date, "subQuery")) paste0("(", as.character(end_date), ")") else paste0("'", as.character(end_date), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_provider <- function(fetchField, provider_id, provider_name, npi, dea, specialty_concept_id, care_site_id, year_of_birth, gender_concept_id, provider_source_value, specialty_source_value, specialty_source_concept_id, gender_source_value, gender_source_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.provider WHERE')
  first <- TRUE
  if (!missing(provider_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_id = ", if (is.null(provider_id)) "NULL" else if (is(provider_id, "subQuery")) paste0("(", as.character(provider_id), ")") else paste0("'", as.character(provider_id), "'"))
  }

  if (!missing(provider_name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_name = ", if (is.null(provider_name)) "NULL" else if (is(provider_name, "subQuery")) paste0("(", as.character(provider_name), ")") else paste0("'", as.character(provider_name), "'"))
  }

  if (!missing(npi)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " npi = ", if (is.null(npi)) "NULL" else if (is(npi, "subQuery")) paste0("(", as.character(npi), ")") else paste0("'", as.character(npi), "'"))
  }

  if (!missing(dea)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " dea = ", if (is.null(dea)) "NULL" else if (is(dea, "subQuery")) paste0("(", as.character(dea), ")") else paste0("'", as.character(dea), "'"))
  }

  if (!missing(specialty_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specialty_concept_id = ", if (is.null(specialty_concept_id)) "NULL" else if (is(specialty_concept_id, "subQuery")) paste0("(", as.character(specialty_concept_id), ")") else paste0("'", as.character(specialty_concept_id), "'"))
  }

  if (!missing(care_site_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " care_site_id = ", if (is.null(care_site_id)) "NULL" else if (is(care_site_id, "subQuery")) paste0("(", as.character(care_site_id), ")") else paste0("'", as.character(care_site_id), "'"))
  }

  if (!missing(year_of_birth)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " year_of_birth = ", if (is.null(year_of_birth)) "NULL" else if (is(year_of_birth, "subQuery")) paste0("(", as.character(year_of_birth), ")") else paste0("'", as.character(year_of_birth), "'"))
  }

  if (!missing(gender_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " gender_concept_id = ", if (is.null(gender_concept_id)) "NULL" else if (is(gender_concept_id, "subQuery")) paste0("(", as.character(gender_concept_id), ")") else paste0("'", as.character(gender_concept_id), "'"))
  }

  if (!missing(provider_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " provider_source_value = ", if (is.null(provider_source_value)) "NULL" else if (is(provider_source_value, "subQuery")) paste0("(", as.character(provider_source_value), ")") else paste0("'", as.character(provider_source_value), "'"))
  }

  if (!missing(specialty_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specialty_source_value = ", if (is.null(specialty_source_value)) "NULL" else if (is(specialty_source_value, "subQuery")) paste0("(", as.character(specialty_source_value), ")") else paste0("'", as.character(specialty_source_value), "'"))
  }

  if (!missing(specialty_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " specialty_source_concept_id = ", if (is.null(specialty_source_concept_id)) "NULL" else if (is(specialty_source_concept_id, "subQuery")) paste0("(", as.character(specialty_source_concept_id), ")") else paste0("'", as.character(specialty_source_concept_id), "'"))
  }

  if (!missing(gender_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " gender_source_value = ", if (is.null(gender_source_value)) "NULL" else if (is(gender_source_value, "subQuery")) paste0("(", as.character(gender_source_value), ")") else paste0("'", as.character(gender_source_value), "'"))
  }

  if (!missing(gender_source_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " gender_source_concept_id = ", if (is.null(gender_source_concept_id)) "NULL" else if (is(gender_source_concept_id, "subQuery")) paste0("(", as.character(gender_source_concept_id), ")") else paste0("'", as.character(gender_source_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_care_site <- function(fetchField, care_site_id, care_site_name, place_of_service_concept_id, location_id, care_site_source_value, place_of_service_source_value) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.care_site WHERE')
  first <- TRUE
  if (!missing(care_site_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " care_site_id = ", if (is.null(care_site_id)) "NULL" else if (is(care_site_id, "subQuery")) paste0("(", as.character(care_site_id), ")") else paste0("'", as.character(care_site_id), "'"))
  }

  if (!missing(care_site_name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " care_site_name = ", if (is.null(care_site_name)) "NULL" else if (is(care_site_name, "subQuery")) paste0("(", as.character(care_site_name), ")") else paste0("'", as.character(care_site_name), "'"))
  }

  if (!missing(place_of_service_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " place_of_service_concept_id = ", if (is.null(place_of_service_concept_id)) "NULL" else if (is(place_of_service_concept_id, "subQuery")) paste0("(", as.character(place_of_service_concept_id), ")") else paste0("'", as.character(place_of_service_concept_id), "'"))
  }

  if (!missing(location_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " location_id = ", if (is.null(location_id)) "NULL" else if (is(location_id, "subQuery")) paste0("(", as.character(location_id), ")") else paste0("'", as.character(location_id), "'"))
  }

  if (!missing(care_site_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " care_site_source_value = ", if (is.null(care_site_source_value)) "NULL" else if (is(care_site_source_value, "subQuery")) paste0("(", as.character(care_site_source_value), ")") else paste0("'", as.character(care_site_source_value), "'"))
  }

  if (!missing(place_of_service_source_value)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " place_of_service_source_value = ", if (is.null(place_of_service_source_value)) "NULL" else if (is(place_of_service_source_value, "subQuery")) paste0("(", as.character(place_of_service_source_value), ")") else paste0("'", as.character(place_of_service_source_value), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_cdm_source <- function(fetchField, cdm_source_name, cdm_source_abbreviation, cdm_holder, source_description, source_documentation_reference, cdm_etl_reference, source_release_date, cdm_release_date, cdm_version, vocabulary_version) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.cdm_source WHERE')
  first <- TRUE
  if (!missing(cdm_source_name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cdm_source_name = ", if (is.null(cdm_source_name)) "NULL" else if (is(cdm_source_name, "subQuery")) paste0("(", as.character(cdm_source_name), ")") else paste0("'", as.character(cdm_source_name), "'"))
  }

  if (!missing(cdm_source_abbreviation)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cdm_source_abbreviation = ", if (is.null(cdm_source_abbreviation)) "NULL" else if (is(cdm_source_abbreviation, "subQuery")) paste0("(", as.character(cdm_source_abbreviation), ")") else paste0("'", as.character(cdm_source_abbreviation), "'"))
  }

  if (!missing(cdm_holder)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cdm_holder = ", if (is.null(cdm_holder)) "NULL" else if (is(cdm_holder, "subQuery")) paste0("(", as.character(cdm_holder), ")") else paste0("'", as.character(cdm_holder), "'"))
  }

  if (!missing(source_description)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " source_description = ", if (is.null(source_description)) "NULL" else if (is(source_description, "subQuery")) paste0("(", as.character(source_description), ")") else paste0("'", as.character(source_description), "'"))
  }

  if (!missing(source_documentation_reference)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " source_documentation_reference = ", if (is.null(source_documentation_reference)) "NULL" else if (is(source_documentation_reference, "subQuery")) paste0("(", as.character(source_documentation_reference), ")") else paste0("'", as.character(source_documentation_reference), "'"))
  }

  if (!missing(cdm_etl_reference)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cdm_etl_reference = ", if (is.null(cdm_etl_reference)) "NULL" else if (is(cdm_etl_reference, "subQuery")) paste0("(", as.character(cdm_etl_reference), ")") else paste0("'", as.character(cdm_etl_reference), "'"))
  }

  if (!missing(source_release_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " source_release_date = ", if (is.null(source_release_date)) "NULL" else if (is(source_release_date, "subQuery")) paste0("(", as.character(source_release_date), ")") else paste0("'", as.character(source_release_date), "'"))
  }

  if (!missing(cdm_release_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cdm_release_date = ", if (is.null(cdm_release_date)) "NULL" else if (is(cdm_release_date, "subQuery")) paste0("(", as.character(cdm_release_date), ")") else paste0("'", as.character(cdm_release_date), "'"))
  }

  if (!missing(cdm_version)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " cdm_version = ", if (is.null(cdm_version)) "NULL" else if (is(cdm_version, "subQuery")) paste0("(", as.character(cdm_version), ")") else paste0("'", as.character(cdm_version), "'"))
  }

  if (!missing(vocabulary_version)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " vocabulary_version = ", if (is.null(vocabulary_version)) "NULL" else if (is(vocabulary_version, "subQuery")) paste0("(", as.character(vocabulary_version), ")") else paste0("'", as.character(vocabulary_version), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_metadata <- function(fetchField, metadata_concept_id, metadata_type_concept_id, name, value_as_string, value_as_concept_id, metadata_date, metadata_datetime) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.metadata WHERE')
  first <- TRUE
  if (!missing(metadata_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " metadata_concept_id = ", if (is.null(metadata_concept_id)) "NULL" else if (is(metadata_concept_id, "subQuery")) paste0("(", as.character(metadata_concept_id), ")") else paste0("'", as.character(metadata_concept_id), "'"))
  }

  if (!missing(metadata_type_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " metadata_type_concept_id = ", if (is.null(metadata_type_concept_id)) "NULL" else if (is(metadata_type_concept_id, "subQuery")) paste0("(", as.character(metadata_type_concept_id), ")") else paste0("'", as.character(metadata_type_concept_id), "'"))
  }

  if (!missing(name)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " name = ", if (is.null(name)) "NULL" else if (is(name, "subQuery")) paste0("(", as.character(name), ")") else paste0("'", as.character(name), "'"))
  }

  if (!missing(value_as_string)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_string = ", if (is.null(value_as_string)) "NULL" else if (is(value_as_string, "subQuery")) paste0("(", as.character(value_as_string), ")") else paste0("'", as.character(value_as_string), "'"))
  }

  if (!missing(value_as_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " value_as_concept_id = ", if (is.null(value_as_concept_id)) "NULL" else if (is(value_as_concept_id, "subQuery")) paste0("(", as.character(value_as_concept_id), ")") else paste0("'", as.character(value_as_concept_id), "'"))
  }

  if (!missing(metadata_date)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " [metadata date] = ", if (is.null(metadata_date)) "NULL" else if (is(metadata_date, "subQuery")) paste0("(", as.character(metadata_date), ")") else paste0("'", as.character(metadata_date), "'"))
  }

  if (!missing(metadata_datetime)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " metadata_datetime = ", if (is.null(metadata_datetime)) "NULL" else if (is(metadata_datetime, "subQuery")) paste0("(", as.character(metadata_datetime), ")") else paste0("'", as.character(metadata_datetime), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

lookup_fact_relationship <- function(fetchField, domain_concept_id_1, fact_id_1, domain_concept_id_2, fact_id_2, relationship_concept_id) {
  statement <- paste0('SELECT ', fetchField , ' FROM @cdm_database_schema.fact_relationship WHERE')
  first <- TRUE
  if (!missing(domain_concept_id_1)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " domain_concept_id_1 = ", if (is.null(domain_concept_id_1)) "NULL" else if (is(domain_concept_id_1, "subQuery")) paste0("(", as.character(domain_concept_id_1), ")") else paste0("'", as.character(domain_concept_id_1), "'"))
  }

  if (!missing(fact_id_1)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " fact_id_1 = ", if (is.null(fact_id_1)) "NULL" else if (is(fact_id_1, "subQuery")) paste0("(", as.character(fact_id_1), ")") else paste0("'", as.character(fact_id_1), "'"))
  }

  if (!missing(domain_concept_id_2)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " domain_concept_id_2 = ", if (is.null(domain_concept_id_2)) "NULL" else if (is(domain_concept_id_2, "subQuery")) paste0("(", as.character(domain_concept_id_2), ")") else paste0("'", as.character(domain_concept_id_2), "'"))
  }

  if (!missing(fact_id_2)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " fact_id_2 = ", if (is.null(fact_id_2)) "NULL" else if (is(fact_id_2, "subQuery")) paste0("(", as.character(fact_id_2), ")") else paste0("'", as.character(fact_id_2), "'"))
  }

  if (!missing(relationship_concept_id)) {
    if (first) {
      first <- FALSE
    } else {
      statement <- paste0(statement, " AND")
    }
    statement <- paste0(statement, " relationship_concept_id = ", if (is.null(relationship_concept_id)) "NULL" else if (is(relationship_concept_id, "subQuery")) paste0("(", as.character(relationship_concept_id), ")") else paste0("'", as.character(relationship_concept_id), "'"))
  }

  class(statement) <- 'subQuery'
  return(statement)
}

generateInsertSql <- function(databaseSchema = NULL) {
  insertSql <- c()
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.gp_clinical;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.gp_registrations;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.hesin_oper;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.hesin;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.death_cause;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.covid;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.hesin_diag;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.gp_prescriptions;")
  insertSql <- c(insertSql, "TRUNCATE TABLE @cdm_database_schema.death;")
  createInsertStatement <- function(insert, env) {
    s <- c()
    if (env$testId != insert$testId) {
      s <- c(s, paste0('-- ', insert$testId, ': ', insert$testDescription))
      env$testId <- insert$testId
    }
    s <- c(s, paste0("INSERT INTO @cdm_database_schema.",
                     insert$table,
                     "(",
                     paste(insert$fields, collapse = ", "),
                     ") VALUES (",
                     paste(insert$values, collapse = ", "), 
                     ");"))
    return(s)
  }
  env <- new.env()
  env$testId <- -1
  insertSql <- c(insertSql, do.call(c, lapply(frameworkContext$inserts, createInsertStatement, env)))
  if (is.null(databaseSchema)) {
  	insertSql <- gsub('@cdm_database_schema.', '', insertSql)
  } else {
  	insertSql <- gsub('@cdm_database_schema', databaseSchema, insertSql)
  }
  return(insertSql)
}

writeSourceCsv <- function(directory = NULL, separator = ',') {
  clean_value <- function(x) {
    if (x == 'NULL') {
      return('')
    }
    value <- substring(x, 2, nchar(x)-1)
    value <- gsub('"', '""', value)
    if (grepl(separator, value)) {
      return(paste0('"', value, '"'))
    }
    return(value)
  }

  clean_fields <- function(x) {
    if (grepl("^\\[.+?\\]$", x)) {
      return(substring(x, 2, nchar(x)-1))
    }
    return(x)
  }
  dir.create(directory, showWarnings = F)
  
  seen_tables <- c()
  for (insert in frameworkContext$inserts) {
    filename <- file.path(directory, paste0(insert$table, '.csv'))
    if (!(insert$table %in% seen_tables)) {
      write(paste(sapply(insert$fields, clean_fields), collapse = separator), filename, append=F)
      seen_tables <- c(seen_tables, insert$table)
    }
    write(paste(sapply(insert$values, clean_value), collapse = separator), filename, append=T)
  }

  writeBaselineToCsv(file.path(directory, 'baseline.csv'), separator)
  seen_tables <- c(seen_tables, 'baseline')
  
  for (table_name in names(frameworkContext$defaultValues)) {
    if (!(table_name %in% seen_tables)) {
      filename <- file.path(directory, paste0(table_name, '.csv'))
      write(paste(names(frameworkContext$defaultValues[[table_name]]), collapse = separator), filename, append=F)
    }
  }
}

writeBaselineToCsv <- function(filename = NULL, separator = ',') {
  # Note: outputs additional column without header
  # TODO: escaping of comma's and quotes
  # Header
  cat("", file=filename)
  for (name in frameworkContext$baseline_names) {
    cat(name, file=filename, append=TRUE)
    cat(",", file=filename, append=TRUE)
  }

  # Content. If name does not exist in data, outputs empty cell
  for (row in frameworkContext$baseline) {
    cat("\n", file=filename, append=TRUE)
    for (name in frameworkContext$baseline_names) {
      cat(row[[name]], file=filename, append=TRUE)
      cat(",", file=filename, append=TRUE)
    }
  }
}

extractTestTypeString <- function(x) {
  if (x$type == 0) {
    return('Expect')
  } else if (x$type==1) {
    return('Expect No')
  } else if (x$type==2) {
    return(paste('Expect', x$rowCount))
  }
}

generateTestSql <- function(databaseSchema = NULL) {
  testSql <- c()
  testSql <- c(testSql, "IF OBJECT_ID('@cdm_database_schema.test_results', 'U') IS NOT NULL DROP TABLE @cdm_database_schema.test_results;")
  testSql <- c(testSql, "CREATE TABLE @cdm_database_schema.test_results (id INT, description VARCHAR(512), test VARCHAR(256), status VARCHAR(5));")
  createExpectStatement <- function(expect, env) {
    s <- c()
    if (env$testId != expect$testId) {
      s <- c(s, paste0('-- ', expect$testId, ': ', expect$testDescription))
      env$testId <- expect$testId
    }
    operators <- rep("=", length(expect$fields))
    operators[expect$values == "NULL"] <- rep("IS", sum(expect$values == "NULL"))
    s <- c(s, paste0("INSERT INTO @cdm_database_schema.test_results SELECT ",
                     expect$testId,
                     " AS id, '",
                     expect$testDescription,
                     "' AS description, '",
                     extractTestTypeString(expect), " ", expect$table,
                     "' AS test, CASE WHEN (SELECT COUNT(*) FROM @cdm_database_schema.",
                     expect$table,
                     " WHERE ",
                     paste(paste(expect$fields, operators, expect$values), collapse = " AND "),
                     ") ",
                     if (expect$type == 0) "= 0" else if (expect$type == 1) "!= 0" else paste("!=", expect$rowCount),
                     " THEN 'FAIL' ELSE 'PASS' END AS status;"))
    return(s)
  }
  env <- new.env()
  env$testId <- -1
  testSql <- c(testSql, do.call(c, lapply(frameworkContext$expects, createExpectStatement, env)))
  if (is.null(databaseSchema)) {
  	testSql <- gsub('@cdm_database_schema.', '', testSql)
  } else {
  	testSql <- gsub('@cdm_database_schema', databaseSchema, testSql)
  }
  return(testSql)
}

getTestsOverview <- function() {
  df <- data.frame(
    testId = sapply(frameworkContext$expects, function(x) x$testId),
    testDescription = sapply(frameworkContext$expects, function(x) x$testDescription),
    testType = sapply(frameworkContext$expects, extractTestTypeString),
    testTable = sapply(frameworkContext$expects, function(x) x$table)
  )
  return(df)
}

exportTestsOverviewToFile <- function(filename) {
  df <- getTestsOverview()
  write.csv(unique(df), filename, row.names=F)
}

summary.frameworkContext <- function(object, ...) {
  nSourceFieldsTested <- length(intersect(object$sourceFieldsMapped, object$sourceFieldsTested))
  nTargetFieldsTested <- length(intersect(object$targetFieldsMapped, object$targetFieldsTested))
  nTotalSourceFields <- length(object$sourceFieldsMapped)
  nTotalTargetFields <- length(object$targetFieldsMapped)
  summary <- c(
    length(object$expects),
    length(unique(sapply(object$expects, function(x) x$testId))),
    nSourceFieldsTested,
    nTotalSourceFields,
    round(100*nSourceFieldsTested/nTotalSourceFields, 2),
    nTargetFieldsTested,
    nTotalTargetFields,
    round(100*nTargetFieldsTested/nTotalTargetFields, 2)
  )
  names(summary) <- c('n_tests', 'n_cases', 'n_source_fields_tested', 'n_source_fields_mapped_from', 'source_coverage (%)', 'n_target_fields_tested', 'n_target_fields_mapped_to', 'target_coverage (%)')
  return(as.data.frame(summary))
}

summaryTestFramework <- function() {
  return(summary(frameworkContext));
}

getUntestedSourceFields <- function() {
  sort(setdiff(frameworkContext$sourceFieldsMapped, frameworkContext$sourceFieldsTested))
}

getUntestedTargetFields <- function() {
  sort(setdiff(frameworkContext$targetFieldsMapped, frameworkContext$targetFieldsTested))
}

outputTestResultsSummary <- function(connection, databaseSchema = NULL) {
  suppressWarnings(require(DatabaseConnector, quietly = TRUE))
  query = 'SELECT * FROM @cdm_database_schema.test_results;'
  if (is.null(databaseSchema)) {
    query <- gsub('@cdm_database_schema.', '', query)
  } else {
    query <- gsub('@cdm_database_schema', databaseSchema, query)
  }
  df_results <- DatabaseConnector::querySql(connection, query)
  n_tests <- nrow(df_results)
  n_failed_tests <- sum(df_results$'STATUS' == 'FAIL')
  if (n_failed_tests > 0) {
    write(sprintf('FAILED unit tests: %d/%d (%.1f%%)', n_failed_tests, n_tests, n_failed_tests/n_tests * 100), file='')
    print(df_results[df_results$'STATUS' == 'FAIL',])
  } else {
    write(sprintf('All %d tests PASSED', n_tests), file='')
  }
}

