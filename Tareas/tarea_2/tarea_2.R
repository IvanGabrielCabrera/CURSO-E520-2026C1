# Tipos de Datos ----------------------------------------------------------
#Asignacion de variable
pi<-3.14
planetas<-8L
raiz_unitaria<-1 + 1i
nombre<-'Jose'
gravedad<-TRUE
#Clases de dato
class(pi) #numero
class(planetas) #numero entero
class(raiz_unitaria) #numero complejo
class(nombre) #texto
class(gravedad) #estado logico

# Numeros -----------------------------------------------------------------

x<-10
y<-15.5
class(x)
class(y) #Al no especificar con L, son numeros comunes

x<-10L
class(x) #Ahora es entero
y<- 15.5 + 3i
class(y) #Ahora es complejo
#Usando el comando as.----() se cambia el tipo de numero
as.numeric(x)
as.integer(y) #No aplica en imaginarios
y<-67.7
as.integer(y) #Elimina los decimales, sin redondeo

# Strings -----------------------------------------------------------------

'hello' #Imprimir y almacenar texto
msg<-'buenas'
msg

msg <- 'Buenas tardes, 
que se le ofrece el dia de hoy?' #Multiples palabras
msg
cat(msg) #Elimina el \n
nchar(msg) #Cantidad de caracteres
grepl('de',msg)
grepl('DE',msg) #Busca dato exacto

msg2<-'Me gustaria ofrecerle algo'
cat(paste(msg,msg2)) #Union de ambos string

# Caracter de huida -------------------------------------------------------

msg3<-'Que es 'eso'?' #Tira error
msg3<-'Que es \'eso\'?'
msg3 #Usar caracter de escape \ te permite hacerlo

# Booleanos ---------------------------------------------------------------

22>9
15<3
6==6 #Operadores logicos
a<-6
b<-10
a<b #Puede hacerse entre variables

if (b > a) {
  print ("b is greater than a")
} else {
  print("b is not greater than a")
} #Tambien en condicionales

# Operadores --------------------------------------------------------------
#Matematicos
a+b
a-b
a*b
a/b
a^b
a%%b #Resto de division
a%/%b # Division entre enteros
#Booleanos
a==b
a!=b
a>=b
#Logicos
a==b | b>a #OR
a<b & b!=a #AND
!(a==b) #NOT
#Miscelaneo
2:21 #Serie [2:21]

# Funcion IF y ELSE -------------------------------------------------------
#Operador en ejecucion por satisfacer pruebas logicas

if (a!=b){
  print('a no es igual a b')
}
#Usos de else y else if
if (b<a){
  print('b es menor a a')
} else if (b>a){
  print('b es mayor a a')
} else {
  print('b es igual a a')
}
#Nesting
a<-13
if(a>10){
  print('a es mayor a 10')
  if (a>15){
    print('y mayor a 15')
  } else {
    print('pero menor a 15')
  }
} else {
  print('a no es mayor a 10')
}

# Funcion While -----------------------------------------------------------
#Loop simple
i<-1
while (i<8){
  print(i)
  i=i*2
}
#Frenar el loop al cumplirse una condicion
i<-1
while (i<10){
  print(i)
  i=i+2
  if (i==9){
    break
  }
}
#Saltear un valor
i<-1
while (i<10){
  i=i+2
  if (i==5){
    next
  }
  print(i)
}

# Vectores ----------------------------------------------------------------

vector_ej<-c('auto','sol','mar','lava','luna')
vector_ej
#Con secuencias
vector_ej2<-5.3:11.3
vector_ej2
length(vector_ej)#Cantidad de componentes
sort(vector_ej) #Ordenador
vector_ej2[c(2,3)] #Extraccion especifica
vector_ej2[c(-1)]
vector_ej[2]<-'Sahara'

# Listas ------------------------------------------------------------------
#Tiene muchos tipos de datos
lista_ej<-list('numero',45,70L,FALSE)
#Idem con lo anterior aplica a las listas
45 %in% lista_ej #Chequear si tal item esta en la lista
append(lista_ej,'Ernesto', after =3) #Insertar item
lista_ej[-2] #Sacar item
lista_ej2<-5:7
lista_ej3<-c(lista_ej,lista_ej2) #Juntar listas

# Matrices ----------------------------------------------------------------
#2D
matrizgenerica <- matrix(c(1,2,3,4,5,6), nrow = 3, ncol = 2) #Matriz 2D
matrizgenerica[2,2]
matrizgenerica[2,]
matrizgenerica[c(1),] #Filas
matriz2<-c('Monster','electrodomestico','Quilmes')
cbind(matrizgenerica,matriz2)


# Arrays ------------------------------------------------------------------
#n dimensionales
array_ej<-array(c(1:10),dim = c(2,2,3))
array_ej #2x2x3
array_ej[2,1,2]#Idem con metodos de extraccion de datos de matrices
2 %in% array_ej
dim(array_ej)
length(array_ej)

# Data Frames -------------------------------------------------------------
dataframe<-data.frame(
  autos=c('BMW','Audi','Toyota'),
  velocidadmax=c(280L,255L,240L),
  origen=c('Aleman','Aleman','Japones'),
  combustible=c('Naftero','Gasolero','Naftero')
) #Variables en primera fila y observaciones en las subsiguientes
str(dataframe)
summary(dataframe) #Datos resumidos
dataframe$velocidadmax
dataframefil<-rbind(dataframe,c('Ford',244L,'Estadounidense','Gasolero')) #Agregar fila
dim(dataframe) #Observaciones y variables
dataframe[c(-1),c(-2)] #Eliminacion de columanas y filas

# Factores ----------------------------------------------------------------
generos_peliculas<-factor(c('drama','accion','aventura','suspenso','terror',
                            'drama','drama','drama','terror','terror'))
generos_peliculas
levels(generos_peliculas) #No imprime categorias repetidas
generos_peliculas<-factor(c('drama','accion','aventura','suspenso','terror',
                            'drama','drama','drama','terror','terror'), 
                          levels = c(levels(generos_peliculas),'historico'))
generos_peliculas[5]<-'historico'#No pueden agregarse valores que no se encuentran especifidados en factores

