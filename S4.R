##Generalidades de objetos S4
##Con base a:

## Matloff, Norman S.The art of R programming : tour of statistical software design

## http://www.stat.umn.edu/geyer/3701/notes/generic.html

## https://adv-r.hadley.nz/s4.html


#
# un objeto S4
#

#Un objeto s4 es un sistema riguroso y formal, que surge de la reescritura de objetos s3, introducido por Chambers (1998). Este tipo de objeto lleva a pensar cuidadosamente su dise?o, ya que est? particularmente adecuado para construir grandes sistemas que evolucionan con el tiempo y que posiblemente recibir?n contribuciones de muchos programadores. A pesar de que s4 requiere m?s trabajo que S3, este objeto proporciona m?s garant?as y una mayor encapsulaci?n. 


## Un ejemplo de objeto s4

rm(list=ls())                 #limpiar el ambiente global



setClass("Car",representation=representation(               #Definicion de la clase
  price = "numeric",                                        #Serie de elementos dentro de la clase
  numberDoors="numeric",
  typeEngine="character",
  mileage="numeric"
))

ls()                                                        #objetos en el ambiente global

aCar <- new("Car",price=20000,numberDoors=4,typeEngine="V6",mileage=143)


ls()
class(aCar)                                                 #evidenciar la clase del objeto "aCar"

## Un objeto s4 trabaja similar que un objeto s3, Los objetos s4 tienen una clase formal definida, la cual descrine la representaci?n y herencia de cada clase. Adicionalmente, los objetos s4 tiene funciones auxiliares especiales para definir gen?ricos y m?todos. S4 tambi?n tiene distribuci?n m?ltiple, lo que significa que las funciones gen?ricas pueden elegir m?todos basados en la clase de cualquier n?mero de argumentos.

#### Instalar y cargar el paquete stats4 y pryr 

## S4 se implementa en el paquete de m?todos b?sicos, que siempre se instala con R.

#install.packages("stats4") #Instalar paquete
library(stats4)#Cargar paquete

#install.packages("pryr")#Instalar paquete
library(pryr)#Cargar paquete

#install.packages("sloop")#Instalar paquete
library(sloop)#Cargar paquete

## sloop proporciona ayudas como  sloop :: otype (), esto facilita descubrir el sistema OOP (object-oriented programming) utilizado por un objeto. 

##############################################


### Las ideas subyacentes de los objetos s4 son similares a S3, sin embargo, la implementaci?n es mucho m?s estricta y hace uso de funciones especializadas para crear clases: setClass (), gen?ricos: setGeneric () y m?todos: setMethod ().


### setClass: 
#### Para definir una clase S4 llame a setClass () con el nombre de la clase y una definición de sus slots.

setClass("Person",                                                        #definicion de la clase "person"
         slots = list(name = "character", age = "numeric"))
setClass("Employee",                                                      #definiccion de la clase "Employee"
         slots = list(boss = "Person"),
         contains = "Person")

### para construir objetos dentro de la clase ya definida use new() con el nombre de la clase y valores para los slots.
alice <- new("Person", name = "Alice", age = 40)
john <- new("Employee", name = "John", age = 20, boss = alice)
juan <- new("Employee", name = "Juan", age = 21)

juan


class(juan)
class(alice) 

newPerson <- c(alice,  john)
str(newPerson)                           #estructura de los nuevos objetos asignados 
ls()
class(newPerson)

otype(juan)
otype(newPerson)

## Un importante componente de S4 son los slots @ (ranura en espa?ol). 

alice@age                                #los slots nos permiten extraer o asignar nuevos elementos a la clase

#> [1] 40
newPerson
newPerson@age

slot(john, "boss")

### slot new person age??

#> Un objeto de clase "Person"
#> Slot "name":
#> [1] "Alice"
#> 
#> Slot "age":
#> [1] 40

#### 

john@boss@name                   #@ nos permite extraer los elementos de la clase, en este caso en el orden del comando
### ???


## Ejemplo 2


setClass("employee",
         representation(
           name="character",
           salary="numeric",
           union="logical")
)

#####

Daniel <- new("employee",name="pedro",salary= 344)     


#Que hace falta?                           #Definir los elementos que integran la clase

## ejercicio 
### Al objeto Daniel, definir un nuevo empleado con nombre Daniel y asignarle un salario de 55000 

ls()
Daniel <- new("employee",name="Daniel",salary= 55000)


############

### EL empleado Joe tiene un salario igual que Daniel 

joe <- new("employee", name="joe", salary=55000)

joe
Daniel

#####

joe@salary                      #@ nos permite observar explicitamente el salario de "joe"

slot(joe,"salary")               #la funci�n "slot" cumple la misma funcionabilidad de @

show(joe)                         #nos permite mirar el metodo asignado a joe

ls()

##


##Ejemplo 3

setClass("RangedNumeric",
         contains = "numeric",
         slots = list(min = "numeric", max = "numeric"))
rn <- new("RangedNumeric", 1:10, min = 1, max = 10)

class(rn)
otype(rn)
rn@min
#> [1] 1
rn@.Data
juan@.Data


#>  [1]  1  2  3  4  5  6  7  8  9 10
rn

#########################################################################3
############## setGeneric y setMethod
### setGeneric realiza el env�?o del método 
setGeneric("union")
#> [1] "union"

##setMethod: define el m?todo de lo que pretende hacer (funciones)
setMethod("union",
          c(x = "data.frame", y = "data.frame"),
          function(x, y) {
            unique(rbind(x, y))
          }
)
#> [1] "union"

#####################

#solo setMethod 
ls()

### Crear un empleado con su nonbre y que su salario sea 55000

empleado<- new("employee",name = "Carlos",salary=55000) 

show(empleado)

### que hace show?                   #permite mirar el metodo asigndo en la clase

setMethod("show", "employee",        #definir el metodo para la clase
          function(object) {
            inorout <- ifelse(object@union,"is","is not")
            cat(object@name,"has a salary of",object@salary,
                "and",inorout, "in the union", "\n")
          }
)


show(cinthy)



### Ejemplo 4 

setGeneric("myGeneric", function(x) {
  standardGeneric("myGeneric")
})
#> [1] "myGeneric"
class(myGeneric)
otype(myGeneric)

################################################
### ejercicio 2
####################################

#parte 1
setClass("Person", 
         slots = c(
           name = "character", 
           age = "numeric"
         )
)

#### crear un persona llamada john Smith, sin embargo no se conoce la edad de jhon
###como asignaria NA a age si es numeric ???

john <- new("Person", name= "john Smith", age=0)


john@name

slot(john, "age")




## Crear un setter y getter para el slot (age) creando genericos con setGeneric()


setGeneric("age", function(x) standardGeneric("age"))                       #realizando el envio del metodo
setGeneric("age<-", function(x, value) standardGeneric("age<-"))

## Despues definir metodos con setMethod():

setMethod("age", "Person", function(x) x@age)                             #definicion del metodo
setMethod("age<-", "Person", function(x, value) {
  x@age <- value
  x
})

john

john@age <- 12

john


#parte 2
setClass("Person", 
         slots = c(
           name = "character", 
           age = "numeric"
         ), 
         prototype = list(
           name = NA_character_,
           age = NA_real_
         )
)

me <- new("Person", name = "Hadley")
str(me)


#########################################################
###Ejercicio 2

######################################################
## Evaluates the effect of Ramer - Douglas - Peucker on simpliying tracks  
##
## DRME nov 04 - 2012
## dmiranda(at)uis(dot)edu(dot)co

########Cargar paquetes
## libraries
##

library(maptools)
library(rgeos)
library(nnclust)
library(shapefiles)

##

## functions
##¿Que hace el objeto graph_mst?


graph_mst <- function (l) {
  distrib<-l@lines[[1]]@Lines[1][[1]]@coords
  mst<-mst(l@lines[[1]]@Lines[1][[1]]@coords)
  plot(l, col="white");title("MST")
  segments(distrib[mst$from,1], distrib[mst$from,2], distrib[mst$to,1],distrib[mst$to,2],col="red")
}

# Si quiere llevar los objetos s4 a la práctica, Existen dos retos: No hay referencias que responda a todas sus preguntas sobre S4 y la documentación incorporada de # R en ocasiones es contradictoria.



######################################
############################ Actividades #############################################



# 1.Crear un objeto s4 en donde incluya 30 letras y 30 observaciones aleatorias de una distribucion normal. 
# 2.Usando setGeneric() y setMethod(),escribir dos funciones para extraer los datos del objeto creado en el punto 1 y graficarlos.


######################################
############################# Literatura recomendada #############################################

# 1.Chambers, John M. 1998. Programming with Data: A Guide to the S Language. Springer. 

#2.http://heather.cs.ucdavis.edu/~matloff/132/NSPpart.pdf

#3.https://adv-r.hadley.nz/s4.html

#4.Chambers, John M. 2014. "Object-Oriented Programming, Functional Programming and R." Statistical Science 29 (2). Institute of Mathematical Statistics:167-80. https://projecteuclid.org/download/pdfview_1/euclid.ss/1408368569.



