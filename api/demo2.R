#
# This is a Plumber API. You can run the API by clicking
# the 'Run API' button above.
#
# Find out more about building APIs with Plumber here:
#
#    https://www.rplumber.io/
#

library(plumber)

#* @apiTitle Plumber Example API

#* Return top 5 of the "iris data-set
#* @get /iris_top_5
function(){
  return(head(iris, 5))  
}

#* Return top 5 of the "iris data-set in csv format
#* @serializer csv
#* @get /iris_file
function(){
  return(head(iris, 5))  
}

#* Return top 5 of the "iris data-set in html format
#* @serializer html
#* @get /iris_html
#* @param nRow total row of "iris" to be returned
function(nRow){
  body = paste(apply(iris[seq(as.integer(nRow)), ], 1, function(row){
    paste("<tr>", paste(sapply(row, function(e) paste("<td>", e, "</td>")), collapse = ""), "</tr>", sep = '')
  }), collapse = '')
  return( paste("<html><body><table border = TRUE>", body, "</table></body></html>") )
}

#* Log some information about the incoming request
#* @filter logger
function(req){
  cat(as.character(Sys.time()), "-",
      req$REQUEST_METHOD, req$PATH_INFO, "-",
      req$HTTP_USER_AGENT, "@", req$REMOTE_ADDR, "\n")
  plumber::forward()
}

#* Echo back the input
#* @param msg The message to echo
#* @get /echo
function(msg = "") {
    list(msg = paste0("The message is: '", msg, "'"))
}

#* Plot a histogram
#* @serializer png
#* @get /plot
function() {
    rand <- rnorm(100)
    hist(rand)
}

#* Return the sum of two numbers
#* @param a The first number to add
#* @param b The second number to add
#* @post /sum
function(a, b) {
    as.numeric(a) + as.numeric(b)
}
