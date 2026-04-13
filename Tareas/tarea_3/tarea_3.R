
# Paquetes ----------------------------------------------------------------
library(tidyverse)
library(palmerpenguins)
library(ggthemes)

# Ejercicio 1 -------------------------------------------------------------
# How many rows are in penguins? How many columns?
nrow(penguins) #344
ncol(penguins) #8

# Ejercicio 2 -------------------------------------------------------------
# What does the bill_depth_mm variable in the penguins data frame describe?
# Read the help for ?penguins to find out.
?penguins
#Altura del pico

# Ejercicio 3 -------------------------------------------------------------
# Make a scatterplot of bill_depth_mm vs. bill_length_mm.
# That is, make a scatterplot with bill_depth_mm on the y-axis and 
# bill_length_mm on the x-axis. Describe the relationship between these two variables.
ggplot(
  data = penguins,
  mapping = aes(x = bill_length_mm, y = bill_depth_mm, color = species)
) + geom_point()
#Pareciera diferenciar 3 especies de pinguino, dos donde exceso de una compensa
#la otra y una donde hay abundancia en ambas caracteristicas.

# Ejercicio 4 -------------------------------------------------------------
# What happens if you make a scatterplot of species vs. bill_depth_mm?
# What might be a better choice of geom?
ggplot(
  data = penguins,
  mapping = aes(x = species, y = bill_depth_mm, color = species)
) + geom_boxplot()
#Hace lineas rectas. Un boxplot marca las variaciones de alto de pico entre especie.

# Ejercicio 5 -------------------------------------------------------------
# Why does the following give an error and how would you fix it?
ggplot(data = penguins) + 
  geom_point()
#Falta el seteo de ejes y a que corresponden
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm, y = body_mass_g, color = species)) + 
  geom_point()

# Ejercicio 6 -------------------------------------------------------------
# What does the na.rm argument do in geom_point()?
# What is the default value of the argument?
# Create a scatterplot where you successfully use this argument set to TRUE.
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm, y = body_mass_g, color = species)) + 
  geom_point(na.rm = TRUE)
#No envia mensajes acerca de la eliminacion de las observaciones incompletas

# Ejercicio 7 -------------------------------------------------------------
# Add the following caption to the plot you made in the previous exercise:
# “Data come from the palmerpenguins package.” 
# Hint: Take a look at the documentation for labs().
?labs
ggplot(data = penguins,
       mapping = aes(x = bill_depth_mm, y = body_mass_g, color = species)) + 
  geom_point(na.rm = TRUE)+
  labs(
  caption='Data come from the palmerpenguins package'
)

# Ejercicio 8 -------------------------------------------------------------
# Recreate the following visualization. What aesthetic should bill_depth_mm be mapped to?
# And should it be mapped at the global level or at the geom level?
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g, z=bill_depth_mm)) + 
  geom_point(aes(color = bill_depth_mm))+
  geom_smooth(method = lm) #Darle color a la variable z

 # Ejercicio 9 -------------------------------------------------------------
# Run this code in your head and predict what the output will look like.
# Then, run the code in R and check your predictions.
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)
) +
  geom_point() +
  geom_smooth(se = FALSE) #No se parece a lo que pense

# Ejercicio 10 ------------------------------------------------------------
# 
# Will these two graphs look different? Why/why not?
ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point() +
  geom_smooth()

ggplot() +
  geom_point(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  ) +
  geom_smooth(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g)
  )
#Son iguales. En lugar de guardar todo en ggplot global lo repite por funcion




