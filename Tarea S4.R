#######################################
#####     TAREA DE  S4   ##############
#######################################

#Cargar paquetes

library(maptools)
library(rgeos)
library(nnclust)
library(shapefiles)


# Ejercicios 1. Â¿Que hace el objeto graph_mst? comente cada componente de la funciÃ³n

graph_mst <- function (l) {                                    ####se creo la funcion l que permite la asignacion de 2 objetos y su graficación
  distrib<-l@lines[[1]]@Lines[1][[1]]@coords                    #### para el objeto distrib se le asigna tres slots o objetos dentro de la clase
  mst<-mst(l@lines[[1]]@Lines[1][[1]]@coords)                     #### igualmente para el objeto mst se le asigna 3 slots
  plot(l, col="white");title("MST")                                ####se utiliza plot para graficar la clase l en color blanco y con la etiqueta "MST"
  segments(distrib[mst$from,1], distrib[mst$from,2], distrib[mst$to,1],distrib[mst$to,2],col="red")
}s                                                                    #### finalmente se dibujo segmentos de lineas con color rojo         


# Ejercicios 2. Crear un objeto s4 en donde incluya 30 letras y 30 observaciones aleatorias de una distribucion normal. 

setClass("letra",                                   #####se definio inicialmente la clase con su respectivo nombre y la serie de elementos
         representation(
         lyrics = "character", 
         observations = "numeric"))

letra<- new("letras", lyrics = c( "a", "b", "c", "ch", "d", "e", "f", "g", "h", "i", "j", "k", "l",      #### se creo un objeto para asignar la clase y respectivos valores delos elementos
            "ll", "m", "n", "ñ", "o", "p", "q", "r", "rr", "s", "t", "u", "v", "w", "x", "y", "z"), 
            observations = rnorm(30,0,1))

letra
typeof(letra)                                         ####se verifico que el objeto s4 se hubiera creado correctamente                                  

# Ejercicios 3. Usando setGeneric() y setMethod(), escribir dos funciones para extraer los datos del objeto creado en el punto 2 y graficarlos.


setGeneric("lyrics", function(x) standardGeneric("lyrics"))
setGeneric("lyrics<-", function(x, value) standardGeneric("lyrics<-"))

setMethod("lyrics", "letras", function(x) x@lyrics)
setMethod("lyrics<-", "letras", function(x, value) {
  x@lyrics<-value
  x
})

setGeneric("observations", function(x) standardGeneric("observations"))
setGeneric("observations<-", function(x, value) standardGeneric("observations<-"))
         
setMethod("observations", "letras", function(x) letra@observations)
setMethod("observations<-", "letras", function(x, value){
  letra@observations<-value
})

# Ejercicios 4. Sin ejecutar que pasa en cada una de laa asignaciones y Â¿por quÃ©? comente errores de cÃ³digo y la correciÃ³n que le realizÃ³

rm(list=ls())


setClass("angelito",                                       ####en esta asignación ocurre un error debido a que  existe un doble elemento asignado a un caracter "numeric" dentro de la clase                           
         representation(nombre="character",
                        apellido="character",
                        peso=altura="numeric")              ####peso="numeric"
)                                                            ####altura="numeric"



setClass("angelito",                                           ##### esta asignacion de clase correra bien debido a que el operador "<-" cumple la misma funcion del operador "=" que es asignar
         representation(nombre="character",
                        apellido="character",
                        peso  <- "numeric",
                        altura="numeric")
)


setClass("angelito",
         representation(nombre="character",
                        apellido="character",
                        peso="numeric",
                        altura="numeric")
)

yo  <- new("angelito",                                          ####dara error debido a que el operador "<-" no permitira crear los objetos dentro de los elementos de la clase                                                           
           nombre  <- "Daniel",
           apellido  <- "Miranda")                              #### "=" la solución seria cambiar el operador de asignacion


yo  <- new("angelito",
           nombre  = "Daniel",
           apellido  = "Miranda")


yo

setClass("estudiante",
         representation(
           identidad="angelito",
           semestre="numeric",
           grado="logical")
)


yoReal  <- new("estudiante")                    #### al asignar un nuevo objeto "estudiante" apareceran los elementos de la clase "angelito" asignado anteriormente, dedbido a que el elemento "identidad=angelito"

yoReal                                          #### al observar el contenido de la clase se observan los elementos de la clase "estudiante"y de la clase "angelito"

yoReal$angelito                                 #### el simbolo "$" no permite extraer elementos de objetos S4      

yo@nombre                                        ####no puede extraer nada debido a que "yo" no pertenece a una clase existente

yoReal@identidad<-yo                              #### no es valido el comando debido a que "<-yo" es una operacion invalida

yoReal

yo@nombre                                         ####no puede extraer nada debido a que "yo" no pertenece a una clase existente

yoReal@nombre                                    #### No puede extraer "nombre" de su clase debido a que pertenece a la "clase" identidad

yoReal@identidad@nombre                          ####al llamar el elemento "nombre" en orden @permite extraer correctamente el objeto 

ls()

