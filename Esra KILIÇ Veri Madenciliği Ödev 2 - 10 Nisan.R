# ESRA KILIÇ ÖDEV 2
#ÖDEV 2 TEMEL  FONKSIYONLAR

install.packages("dplyr")
library(dplyr)

# 1) Veri oluşturma

set.seed(123)
n <- 50

df <- data.frame(
  yas       = sample(22:55, n, replace = TRUE),
  kidem     = sample(1:20, n, replace = TRUE),
  maas      = round(rnorm(n, mean = 5000, sd = 1000), 0),
  departman = sample(c("IT", "HR", "Finans"), n, replace = TRUE)
)

head(df)
str(df)
summary(df)


# 2) Değişken adı değiştirme

names(df)[names(df) == "maas"] <- "aylik_maas"
names(df)


# 3) Filtreleme ve yeni değişken

# 35 yas üstü çalışanlar
yaslilar <- df[df$yas > 35, ]
nrow(yaslilar)

# yıllık maaş hesaplama
df$yillik_maas <- df$aylik_maas * 12
head(df)


# 4) Gruplama yapma 

df %>%
  group_by(departman) %>%
  summarise(ort_maas = mean(aylik_maas), kisi = n())


# 5) Görselleştirme yapma

hist(df$aylik_maas, main = "Maas Dagilimi", xlab = "Maas", col = "lightblue")

boxplot(aylik_maas ~ departman, data = df,
        main = "Departmana Gore Maas", col = "lightyellow")


# 6) HTTP ile veri çekme

veri <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data",
                 header = FALSE,
                 col.names = c("sepal_length", "sepal_width",
                               "petal_length", "petal_width", "tur"))

head(veri)
str(veri)
summary(veri)

# Değişken adı 
names(veri)[names(veri) == "tur"] <- "species"

# Filtreleme yapma
uzun <- filter(veri, sepal_length > 6)
nrow(uzun)

# Gruplama yapma
veri %>%
  group_by(species) %>%
  summarise(ort_sepal = mean(sepal_length), ort_petal = mean(petal_length))

# Görselleştirme yapma
hist(veri$sepal_length, main = "Sepal Length Dagilimi", col = "lightgreen")

boxplot(petal_length ~ species, data = veri,
        main = "Ture Gore Petal Length",
        col = c("lightblue", "lightyellow", "lightpink"))

