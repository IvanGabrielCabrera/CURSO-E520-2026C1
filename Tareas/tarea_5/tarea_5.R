
# Librerias y datasets ---------------------------------------------------------------

library(tidyverse)
#Importar vuelos
vuelos19<-read_csv2("C:/Users/Ivan/Desktop/Ciencia de Datos para Economía y Negocios/Datos/tarea 5/201912-informe-ministerio-actualizado-dic-final.csv")
vuelos20<-read_csv2("C:/Users/Ivan/Desktop/Ciencia de Datos para Economía y Negocios/Datos/tarea 5/202012-informe-ministerio-actualizado-dic-final.csv")
vuelos21<-read_csv2("C:/Users/Ivan/Desktop/Ciencia de Datos para Economía y Negocios/Datos/tarea 5/202112-informe-ministerio-actualizado-dic-final.csv")
vuelos22<-read_csv2("C:/Users/Ivan/Desktop/Ciencia de Datos para Economía y Negocios/Datos/tarea 5/202212-informe-ministerio-actualizado-dic-final.csv")
vuelos23<-read_csv2("C:/Users/Ivan/Desktop/Ciencia de Datos para Economía y Negocios/Datos/tarea 5/202312-informe-ministerio-actualizado-dic.csv")
vuelos24<-read_csv2("C:/Users/Ivan/Desktop/Ciencia de Datos para Economía y Negocios/Datos/tarea 5/202412-informe-ministerio-actualizado-dic-final.csv")
vuelos25<-read_csv2("C:/Users/Ivan/Desktop/Ciencia de Datos para Economía y Negocios/Datos/tarea 5/202512-informe-ministerio-actualizado-dic-final.csv")
vuelos26<-read_csv2("C:/Users/Ivan/Desktop/Ciencia de Datos para Economía y Negocios/Datos/tarea 5/202602-informe-ministerio.csv")
#Solucionar el data mismatch entre Aereonave de cada tabla
vuelos19_26 <- list(vuelos19, vuelos20, vuelos21, vuelos22, vuelos23, vuelos24, vuelos25, vuelos26) |> 
  map(\(df) mutate(df, Aeronave = as.character(Aeronave))) |> #Unificacion de tipo de dato en la variable Aereonave
  list_rbind() #Unificacion de los componentes de la lista


# Efectos de la pandemia --------------------------------------------------

vuelos19_26.1<-vuelos19_26 |> 
  mutate(fecha = floor_date(dmy(`Fecha UTC`), "month")) |> #Datos continuos por mes
  count(fecha) #Cuenta de vuelos por mes

ggplot(vuelos19_26.1,aes(x=fecha,y=n)) +
  geom_line()+
  labs(title = 'Vuelos mensuales en Argentina', x='Meses',y='Vuelos')
#De 50000 vuelos hay una caída a menos de 5000, un 90% menos
#Aproximadamente en principios de 2023 graficamente puede verse la recuperacion total

# Patrones de vuelo -------------------------------------------------------
vuelos19_26.2<-vuelos19_26 |> 
  mutate(mes = floor_date(dmy(`Fecha UTC`), "month")) |> #Uso del formato fecha continuo
  count(mes, `Clasificación Vuelo`)|> #Conteo de vuelos por clasificacion de vuelo
  mutate(`Clasificación Vuelo` = if_else(
    `Clasificación Vuelo` == "Domestico", "Doméstico", `Clasificación Vuelo`)) #Unificar nomenclatura a 'Doméstico'

ggplot(vuelos19_26.2,aes(x = mes, y = n, color = `Clasificación Vuelo`)) + 
  geom_line() +
  labs(x = "Meses", y = "Vuelos totales", color='Tipo de vuelo')
#Pareciera que los vuelos internacionales post covid se encuentran en crecimiento constante,
#Mientras que los domesticos encontraron una estabilizacion.
