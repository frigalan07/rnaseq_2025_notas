## ----first_rse------------------------------------------------
## Lets build our first SummarizedExperiment object
library("SummarizedExperiment")
## ?SummarizedExperiment ## Comando para ver la documetación de la función

## De los ejemplos en la ayuda oficial

## Creamos los datos para nuestro objeto de tipo SummarizedExperiment
## para 200 genes a lo largo de 6 muestras
nrows <- 200
ncols <- 6

## Paso a realizar para simular datos de RNA-seq 
## Números al azar de cuentas 
set.seed(20210223) ## Se fija la semilla para asegurar reproducibilidad
counts <- matrix(runif(nrows * ncols, 1, 1e4), nrows) # Matriz de 200 genes por 6 muestras 
## Información de nuestros genes
rowRanges <- GRanges(
  rep(c("chr1", "chr2"), c(50, 150)),
  IRanges(floor(runif(200, 1e5, 1e6)), width = 100), #Posiciones genómicas aleatorias
  strand = sample(c("+", "-"), 200, TRUE), # Hebra aleatoria
  feature_id = sprintf("ID%03d", 1:200) # IDs únicos para cada gen
)
names(rowRanges) <- paste0("gene_", seq_len(length(rowRanges))) # Nombres de los genes 
## Información de nuestras muestras
colData <- DataFrame(
  Treatment = rep(c("ChIP", "Input"), 3),
  row.names = LETTERS[1:6]
)
## Juntamos ahora toda la información en un solo objeto de R
rse <- SummarizedExperiment(
  assays = SimpleList(counts = counts),
  rowRanges = rowRanges,
  colData = colData
)

## Exploremos el objeto resultante
rse

## Número de genes y muestras
dim(rse)

## IDs de nuestros genes y muestras
dimnames(rse)

## Nombres de tablas de cuentas que tenemos (RPKM, CPM, counts, logcounts, etc)
assayNames(rse)

## El inicio de nuestra tabla de cuentas
head(assay(rse))

## Información de los genes en un objeto de Bioconductor
rowRanges(rse)

## Tabla con información de los genes
rowData(rse) # es idéntico a 'mcols(rowRanges(rse))'

## Tabla con información de las muestras
colData(rse)


## ----rse_exercise---------------------------------------------
## Comando 1
rse[1:2, ]
## Comando 2
rse[, c("A", "D", "F")]


## ----isee_basic, eval = FALSE---------------------------------
# ## Explora el objeto rse de forma interactiva
# library("iSEE")
# iSEE::iSEE(rse)


## ----download_sce_layer---------------------------------------
## Descarguemos unos datos de spatialLIBD
sce_layer <- spatialLIBD::fetch_data("sce_layer")
sce_layer

## Revisemos el tamaño de este objeto
lobstr::obj_size(sce_layer)


## ----explore_sce_layer, eval = FALSE--------------------------
# iSEE::iSEE(sce_layer)

