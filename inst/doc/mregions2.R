## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.path = "man/figures/mregions2-",
  out.width = "100%",
  cache = TRUE
)

options(rdf_print_format = "turtle")
options(rmarkdown.html_vignette.check_title = FALSE)

## ----setup, results='hide', message=FALSE-------------------------------------
library(mregions2)

# To use the pipe operator `%>%`
library(magrittr) 

# For illustrative purposes
library(sf) 
library(dplyr) 

## -----------------------------------------------------------------------------
gaz_search("North Sea")

## -----------------------------------------------------------------------------
gaz_search("Noordzee", language = "nl")

## -----------------------------------------------------------------------------
gaz_search("Noordzee", language = "nl", like = FALSE, fuzzy = FALSE)

## -----------------------------------------------------------------------------
gaz_search(3293)

## -----------------------------------------------------------------------------
gaz_search(x = 2.927, y = 51.21551)

## -----------------------------------------------------------------------------
pt <- st_point(c(x = 2.927, y = 51.21551))
pt

gaz_search(pt)

## -----------------------------------------------------------------------------
gaz_types()

## -----------------------------------------------------------------------------
gaz_search("Oostende", typeid = 1)

## -----------------------------------------------------------------------------
# With text
gaz_search_by_type("Town")

# With the place type ID
gaz_search_by_type(1)

## -----------------------------------------------------------------------------
# List sources
gaz_sources()

## -----------------------------------------------------------------------------
# With text
gaz_search_by_source("Flanders Marine Institute (VLIZ)")

# With source ID
gaz_search_by_source(695) 

## -----------------------------------------------------------------------------
gaz_search(3293) %>% gaz_geometry()

## -----------------------------------------------------------------------------
# By MRGID
gaz_geometry(3293)

## -----------------------------------------------------------------------------
gaz_geometry(3293, format = "wkt")

## -----------------------------------------------------------------------------
gaz_geometry(3293, format = "rdf")

## -----------------------------------------------------------------------------
gaz_geometry(3293, format = "sf")

## -----------------------------------------------------------------------------
# With gaz_search()
gaz_search(3293) %>% gaz_relations()

# With MRGID
gaz_relations(3293)

## -----------------------------------------------------------------------------
gaz_relations(3293, direction = "upper", type = "partof")

## -----------------------------------------------------------------------------
gaz_search(3293, rdf = TRUE)

gaz_geometry(3293, format = "rdf")

## -----------------------------------------------------------------------------
# See the full list of data products
mrp_list

# Get the Extended Continental Shelves
mrp_get("ecs")

## ----eval=FALSE---------------------------------------------------------------
# mrp_view("ecs")

## -----------------------------------------------------------------------------
# One more time! Get the Extended Continental Shelves
ecs <- mrp_get("ecs")

## ----eval = FALSE-------------------------------------------------------------
# ecs <- mrp_get("ecs", path = "path/to/data")

## ----eval = FALSE-------------------------------------------------------------
# options("mregions2.download_path" = "path/to/data")
# ecs <- mrp_get("ecs")

## ----eval = FALSE-------------------------------------------------------------
# ecs <- mrp_get("ecs") %>% filter(sovereign1 == "Portugal")

## ----eval = FALSE-------------------------------------------------------------
# ecs <- mrp_get("ecs", cql_filter = "sovereign1 = 'Portugal'")

## -----------------------------------------------------------------------------
# Columns of the Extended Continental Shelves data product
mrp_colnames("ecs")

# Unique values of the column pol_type
mrp_col_unique("ecs", "pol_type")

# Get all the Overlapping claims
mrp_get("ecs", cql_filter = "pol_type = 'ECS Overlapping claim'")

## -----------------------------------------------------------------------------
mrp_ontology

## ----prod5--------------------------------------------------------------------
# Get only one feature
mrp_get("ecs", count = 1)

## ----eval=FALSE---------------------------------------------------------------
# # View all Joint submissions, recommendations of deposit to DOALOS with an area larger than 1M square kilometers
# verbose <- "
#   pol_type IN (
#     'ECS Joint CLCS Recommendation',
#     'ECS Joint CLCS Submission',
#     'ECS Joint DOALOS Deposit'
#   )
#   AND area_km2 > 1000000
# "
# mrp_view("ecs", cql_filter = verbose)

## ----eval=FALSE---------------------------------------------------------------
# # View the Extended Continental Shelf of Portugal
# verbose <- "
#   <Filter>
#   	<PropertyIsEqualTo>
#   		<PropertyName>sovereign1</PropertyName>
#   		<Literal>Portugal</Literal>
#   	</PropertyIsEqualTo>
#   </Filter>
# "
# mrp_view("ecs", filter = verbose)

