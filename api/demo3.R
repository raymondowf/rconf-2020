#
# This is a Plumber API. You can run the API by clicking
# the 'Run API' button above.
#
# Find out more about building APIs with Plumber here:
#
#    https://www.rplumber.io/
#

library(plumber)
library(randomForest)

#* @apiTitle Plumber Example API for R Conference Malaysia 2020

#* To predict the species of iris based on the following parameters (in numeric).
#* @param sepal_length sepal length
#* @param sepal_width sepal width
#* @param petal_length petal length
#* @param petal_width petal width
#* @post /predict
function(sepal_length, sepal_width, petal_length, petal_width)
{
  model <- readRDS('model.rds')
  label <- predict(model, newdata = data.frame(Sepal.Length = as.numeric(sepal_length),
                                               Sepal.Width = as.numeric(sepal_width),
                                               Petal.Length = as.numeric(petal_length),
                                               Petal.Width = as.numeric(petal_width)
  ))
  return(as.character(label))
}

#* Index Page
#* @serializer html
#* @get /
function(){
  index_page = "<html><body>
  <div style = 'text-align:center'>
  <h1>Demo</h1>
  <h2>Deploying Models as Web Service using Plumber</h2>
  <h4><i>A walkthrough with RStudio, Heroku and Amazon Web Services</i></h4>
  <h5>R Conference Malaysia 2020</h5>
  </div>
  </body></html>
  "
  return(index_page)  
}

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
