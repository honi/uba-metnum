# Interpolación

## Motivación

Dado un conjunto de datos compuesto de pares ordenados $\{ (x_0, y_0), \dots, (x_n, y_n) \}$ buscamos un polinomio $P(x)$ tal que:

$$
P(x_i) = y_i \hspace{2em} \text{para todo } i = 0 \dots n
$$

Decimos que el polinomio **interpola** los datos porque pasa por todos los puntos de nuestro conjunto. Si éstos describen algún fenómeno, nos gustaría utilizar el polinomio para predecir puntos desconocidos.

## Polinomio interpolante

Definimos $n+1$ polinomios de grado $n$ de la siguiente manera:

$$
L_{nk} = \prod_{\substack{i=0 \\ i \neq k}}^n \frac{x - x_i}{x_k - x_i}
$$

Observemos que cada $L_{nk}$ tiene un comportamiento particular al ser evaluado en los puntos del dataset:

- $L_{nk}(x_i) = 0$ para todo $i = 0 \dots n, i \neq k$

- $L_{nk}(x_k) = 1$

Luego definimos el polinomio interpolante de grado $\leq n$ como:

$$
P(x) = \sum_{k=0}^n y_k L_{nk}(x)
$$

Al evaluar $P(x_i)$ para algún $i = 0 \dots n$ lo que sucede es que $y_i L_{ni}(x_i) = y_i * 1 = y_i$. Todos los otros $n$ términos de la sumatoria se anulan pues $L_{nk}(x_i) = 0$ si $i \neq k$.

$$
P(x_i) = y_i \hspace{2em} \text{para todo } i = 0 \dots n
$$

Luego $P(x)$ es el polinomio interpolante y siempre existe.

## Error

Sean $f \in C^{n+1}[a,b]$ una función definida en el intervalo $[a,b]$ y el conjunto de pares ordenados $\{ (x_i, f(x_i)) : x_i \in [a,b] \text{ para todo } i = 0 \dots n \}$. Sabemos que existe un polinomio interpolante $P(x)$.


Queremos conocer el error producido al aproximar una función $f$ a partir de un polinomio interpolante $P$ en $n+1$ puntos $\{ (x_0, f(x_0)), \dots, (x_n, f(x_n)) \}$


Podemos acotar el error del polinomio interpolante para el intervalo que contiene a todos los puntos del dataset.

## Unicidad

## Métodos para obtener el polinomio interpolante

¿Cómo podemos actualizar el polinomio interporlante si se agregan nuevos puntos al dataset?

### Diferencias divididas

### Proceso recursivo (Neville)

## Interpolación segmentaria

Explicar el problema del polinomio interpolante.

### Interpolación lineal segmentaria

### Interpolación cuadrática segmentaria

### Interpolación cúbica segmentaria (splines)
