#' List database info.
#'
#' @export
#' @param cushion A cushion name
#' @param dbname Database name
#' @param as (character) One of list (default) or json
#' @param ... Curl args passed on to \code{\link[httr]{GET}}
#' @examples \donttest{
#' # local databasees
#' dbinfo(dbname="sofadb")
#' dbinfo(dbname="sofadb", as='json')
#'
#' # a database on cloudant or iriscouch
#' dbinfo("cloudant", "gaugesdb_ro")
#' dbinfo("iriscouch", "helloworld")
#' }

dbinfo <- function(cushion="localhost", dbname, as='list', ...)
{
  cushion <- get_cushion(cushion)
  if(cushion$type=="localhost"){
    sofa_GET(sprintf("http://127.0.0.1:%s/%s", cushion$port, dbname), NULL, as, ...)
  } else if(cushion$type %in% c("cloudant",'iriscouch')){
    sofa_GET(remote_url(cushion, dbname), NULL, as, content_type_json(), ...)
  }
}
