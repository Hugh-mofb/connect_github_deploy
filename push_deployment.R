# Save current working directory
current_wd = getwd()

# Change working directory to directory of this script
try(setwd(dirname(rstudioapi::getActiveDocumentContext()$path)))

# Setup rsconnect info for programmatic deployment
rs_user = Sys.getenv("rs_user")
rs_server = Sys.getenv("rs_server")
rs_api = Sys.getenv("rs_api")
rs_url = Sys.getenv("rs_url")

rsconnect::addServer(url = rs_url, name = rs_server)
rsconnect::connectApiUser(account = rs_user, server = rs_server, apiKey = rs_api)

selected_files = c("github_deploy.Rmd",
                   "data1/data1.Rmd",
                   "data2/data2.Rmd",
                   "plots/plots.Rmd",
                   "data1/data1.html",
                   "data2/data2.html")


rsconnect::writeManifest()

rsconnect::deployApp(appDir = getwd(), appFiles = selected_files, forceUpdate = TRUE,
                     appName = "github_deploy",
                     appTitle = "Testing Github Deployment")


# Reset working directory back to original
try(setwd(current_wd))
