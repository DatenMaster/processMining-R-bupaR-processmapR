# Homeverzeichnis setzen
setwd("~/Desktop")

# Datenimport
data <- read.csv('ProzessDaten.csv', sep=";")

# Datenvorverarbeitung (Spalte ergänzen, Datentypen umwandeln)
data$Time <- as.POSIXct(data$Time, origin = "2019-07-05 00:00:00", tz="GMT")

# Datentransformation (Konvertierung: datatable zu events)
eventlog <- bupaR::activities_to_eventlog(data,
                                          case_id = 'CaseID', 
                                          activity_id = 'Activity',
                                          timestamp = c('Time', 'Time'),
                                          resource_id = 'Resource'
)

eventlog %>%
  summary

# Datenvisualisierung
#frequency: absolute, absolute_case, relative, relative_case
print(process_map(eventlog, type=frequency("absolute")))
#performance: median/mean, "years"/"semesters"/"quarters"/"months"/"weeks"/"days"/"hours"/"mins"/"secs"
print(process_map(eventlog, type=performance(median,"secs")))

resource_map(eventlog, type=frequency("absolute"))
resource_map(eventlog, type=performance(median,"secs"))