
# Librerias y datasets ----------------------------------------------------
library(tidyverse)
library(nycflights13)
library(dplyr)
flights
# Ejercicios 3.3.5 --------------------------------------------------------
# Ejercicio 1 -------------------------------------------------------------
# 1 In a single pipeline for each condition, find all flights that meet the condition:
# 1.1 Had an arrival delay of two or more hours
# 1.2 Flew to Houston (IAH or HOU)
# 1.3 Were operated by United, American, or Delta
# 1.4 Departed in summer (July, August, and September)
# 1.5 Arrived more than two hours late but didn’t leave late
# 1.6 Were delayed by at least an hour, but made up over 30 minutes in flight


# 1.1 
flight.1.1<-flights |> 
  filter(arr_delay >= 120) # Al ser en minutos, 2h = 120m
min(flight.1.1$arr_delay) #Cumple el objetivo

#1.2
flight.1.2<-flights |>
  filter(dest == 'IAH' | dest == 'HOU') #Filtro por localizacion directa
flight.1.2$dest #Chequeo

#1.3
airlines #Obtengo codigo de carrier
flight.1.3<-flights |>
  filter(carrier %in% c(airlines$carrier[12],airlines$carrier[2], 
                         airlines$carrier[5])) #Lo uso como prueba
flight.1.3$carrier #Compruebo que funciono

#1.4
flights$month #1 al 12
flight.1.4<-flights |>
  filter(month %in% c(7,8,9))
min(flight.1.4$month)
max(flight.1.4$month) #Funciono

#1.5
flight1.5<-flights|>
  filter(dep_delay==0 & arr_delay>120) #Ambas condiciones
min(flight1.5$arr_delay) 
mean(flight1.5$dep_delay) #Chequeo

#1.6
flight.1.6<-flights|>
  filter(dep_delay<=60 & (dep_delay - arr_delay) > 30) #Quiero creer que es asi
# Ejercicio 2 -------------------------------------------------------------
# Sort flights to find the flights with the longest departure delays.
# Find the flights that left earliest in the morning.
flights |> arrange(desc(dep_delay))
flights |> arrange(dep_time)

# Ejercicio 3 -------------------------------------------------------------
# Sort flights to find the fastest flights.
# (Hint: Try including a math calculation inside of your function.)
flights |> arrange(desc(distance / air_time)) # Integrado a la tabla

# Ejercicio 4 -------------------------------------------------------------
# Was there a flight on every day of 2013?
vuelos_dia<-flights|>
  group_by(day)
summarize(vuelos_dia) #365 filas, sí

# Ejercicio 5 -------------------------------------------------------------

# Which flights traveled the farthest distance?
# Which traveled the least distance? 
flights |> arrange(desc(distance)) #Más distancia
flights |> arrange(distance) #Menor distancia

# Ejercicio 6 -------------------------------------------------------------
# Does it matter what order you used filter() and arrange()
# if you’re using both? Why/why not?
# Think about the results and how much work
# the functions would have to do.
#Supongo que no. El reordenamiento de datos de mmenor a mayor es
#un proceso distinto que no altera los datos absolutos filtrables
#por filter

# Ejercicios 19.2.4  ------------------------------------------------------

# Ejercicio 1 -------------------------------------------------------------

# We forgot to draw the relationship between
# weather and airports in Figure 19.1.
# What is the relationship and how should it appear in the diagram?

airports$faa
weather$origin
#Airports usa de primary key los codigos de aereopuertos y weather
#al depender de estos para el clima se la considera foreing key.

# Ejercicio 2 -------------------------------------------------------------
# weather only contains information for the three origin airports in NYC.
# If it contained weather records for all airports in the USA,
# what additional connection would it make to flights?
#Al tener info de aereopuertos de despegue y llegada seria una
# foreing key relacionada con la variable de destino y origen

# Ejercicio 3 -------------------------------------------------------------

# The year, month, day, hour, 
# and origin variables almost form a compound key for weather,
# but there’s one hour that has duplicate observations
# . Can you figure out what’s special about that hour?

# No respondo

# Ejercicio 4 -------------------------------------------------------------

# We know that some days of the year are special and 
# fewer people than usual fly on them 
# (e.g., Christmas eve and Christmas day). 
# How might you represent that data as a data frame? 
# What would be the primary key? How would it connect to the existing data frames?

# Una nueva tabla que contenga todos los datos de Flight pero sólo para fechas festivas, 
# haciendo estos su primary key y el resto de datos de las variables en Flights foreign.

# Ejercicio 5 -------------------------------------------------------------

# Draw a diagram illustrating the connections between the Batting, People, and Salaries 
# data frames in the Lahman package. 
# Draw another diagram that shows the relationship between People, Managers, AwardsManagers. 
# How would you characterize the relationship between the Batting, Pitching,
# and Fielding data frames?

#No respondo


# Ejercicios 19.3.4 -------------------------------------------------------

# Ejercicio 1 -------------------------------------------------------------

# Find the 48 hours (over the course of the whole year) that have the worst delays. 
# Cross-reference it with the weather data. Can you see any patterns?
#No resuelvo
  
# Ejercicio 2 -------------------------------------------------------------
# Imagine you’ve found the top 10 most popular destinations using this code:
top_dest <- flights |>
  count(dest, sort = TRUE) |>
  head(10)
# How can you find all flights to those destinations?
semi_join(flights,top_dest) #Unir las dos condiciones

# Ejercicio 3 -------------------------------------------------------------

# Does every departing flight have corresponding weather data for that hour?
 
nrow(semi_join(flights,weather))==nrow(flights) #No ocurre, hay observaciones faltantes de clima.

# Ejercicio 4 -------------------------------------------------------------

# What do the tail numbers that don’t have a matching record in planes have in common? 
# (Hint: one variable explains ~90% of the problems.)

#No resuelvo

# Ejercicio 5 -------------------------------------------------------------

# Add a column to planes that lists every carrier that has flown that plane.
# You might expect that there’s an implicit relationship between plane and airline, 
# because each plane is flown by a single airline.
# Confirm or reject this hypothesis using the tools you’ve learned in previous chapters.

#No resuelvo

# Ejercicio 6 -------------------------------------------------------------
# Add the latitude and the longitude of the origin and destination airport to flights.

coordenadas_aereop <- select(airports, faa, lat, lon) #Obtener coordenadas
coordenadas_orig <- rename(coordenadas_aereop, origin_lat = lat, origin_lon = lon) #Cambio de nombre
vuelo_origen <- left_join(flights, coordenadas_orig, join_by(origin == faa)) #Union con tabla principal
coord_dest <- rename(coordenadas_aereop, dest_lat = lat, dest_lon = lon)
union_vuelos <- left_join(vuelo_origen, dest_coords, join_by(dest == faa)) #Union final

# Ejercicio 7 -------------------------------------------------------------
# Compute the average delay by destination,
# then join on the airports data frame so you can show the spatial distribution of delays.
# Here’s an easy way to draw a map of the United States:
  
  airports |>
  semi_join(flights, join_by(faa == dest)) |>
  ggplot(aes(x = lon, y = lat)) +
  borders("state") +
  geom_point() +
  coord_quickmap()

# You might want to use the size or color of the points to display the average delay for each airport.

#No resuelvo


# Ejercicio 8 -------------------------------------------------------------

# What happened on June 13 2013? Draw a map of the delays,
# and then use Google to cross-reference with the weather.

#No resuelvo


  