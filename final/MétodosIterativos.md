# Métodos Iterativos

## Motivación

Sean $A \in \mathbb{R}^{n \times n}$ y $b \in \mathbb{R}^n$. Buscamos $x \in \mathbb{R}^n$ tal que $Ax = b$.

A diferencia de los métodos exactos que en un número finito de pasos obtienen una solución al sistema (Eliminación Gaussiana, LU, QR), los métodos iterativos llegan a una solución a través de una sucesión $\{x^{(k)}\}$ que converge hacia la solución del sistema.

Este enfoque es especialmente útil cuando la matriz del sistema es muy grande. Intentar obtener una solución exacta puede ser prohibitivo computacionalmente. Si el problema admite soluciones con un cierto margen de error, los métodos  iterativos permiten obtener una solución mucho más rápido.

## Esquema básico

Dado un $x^{(0)} \in \mathbb{R}^n$ inicial queremos iterativamente ir refinando este vector hasta obtener una solución al sistema $Ax = b$. Para esto planteamos una sucesión $\{x^{(k)}\}$ definida con el siguiente esquema:

$$
x^{(k+1)} = T x^{(k)} + c
$$

En donde $T \in \mathbb{R}^{n \times n}$ es la **matriz de iteración** y $c \in \mathbb{R}^n$ algún vector constante.

## Convergencia

Si $x^\ast \in \mathbb{R}^n$ es la solución del sistema $Ax = b$, decimos que el método converge si:

$$
\lim_{k \rightarrow \infty} x^{(k)} = x^\ast
$$

¿Cómo podemos determinar la convergencia a partir de la matriz de iteración $T$? Por suerte tenemos el siguiente resultado principal:

$$
\{x^{(k)}\} \text{ converge para cualquier } x^{(0)} \text{ inicial } \iff \rho(T) < 1
$$

Recordemos que el radio espectral está definido como $\rho(T) =\max\{ |\lambda| : \lambda \text{ autovalor de } T \}$. Si por alguna razón ya estábamos calculando los autovalores de $T$ o tenemos alguna otra propiedad de $T$ que nos permita acotar el máximo autovalor entonces resultaría trivial verificar la convergencia.

Otra opción para determinar si el método converge es utilizar la siguiente propiedad: $\rho(T) < ||T||$ donde $||\cdot||$ es cualquier norma matricial inducida. Notemos que las normas $||\cdot||_\infty$ y $||\cdot||_1$ se pueden calcular sumando filas o columnas lo cual tiene un costo muy bajo. Combinando los 2 teoremas:

$$
||T|| < 1 \text{ para alguna norma inducida} \implies \{x^{(k)}\} \text{ converge para cualquier } x^{(0)}
$$

## Cota del error

Como mencionamos antes, tenemos una forma de acotar el error para una determinada cantidad de iteraciones del método. Esto nos permite determinar la cantidad de iteraciones que vamos a realizar en una implementación para garantizar que la solución es lo suficientemente buena para el contexto de uso.

Sea $T \in \mathbb{R}^{n \times n}$ la matriz de iteración del método tal que $||T|| < 1$ para alguna norma inducida. El error de la solución obtenida está acotada por:

$$
|| x - x^{(k)} || \leq \frac{||T||^k}{1 - ||T||} (x^{(1)} - x^{(0)})
$$

## Métodos clásicos

Existen 2 métodos clásicos llamados método de **Jacobi** y método de **Gauss-Seidel**. Ambos se construyen a partir de la siguiente descomposición.

Sea $A \in \mathbb{R}^{n \times n}$ tal que $a_{ii} \neq 0$ para todo $i = 1 \dots n$. Descomponemos $A = D - L - U$ donde:

- $D \in \mathbb{R}^{n \times n}$ es una matriz diagonal que contiene todos los elementos de la diagonal de $A$. Notemos que al pedir que $A$ no tenga elementos nulos en su diagonal la matriz $D$ resulta inversible.

- $L \in \mathbb{R}^{n \times n}$ es una matriz estrictamente triangular inferior (su diagonal son todos ceros) que contiene todos los elementos de $A$ que están **debajo** de la diagonal y con el signo opuesto.

- $U \in \mathbb{R}^{n \times n}$ es una matriz análoga a $L$ pero estrictamente triangular superior que contiene todos los elementos de $A$ que están **arriba** de la diagonal y con el signo opuesto.

En cada iteración ambos métodos van refinando cada coordenada de la solución una por una. La diferencia es que Jacobi refina todas las coordenadas utilizando exclusivamente los valores calculados en el paso anterior, mientras que Gauss-Seidel utiliza las coordenadas ya calculadas en el mismo paso.

Utilizando la descomposición $A = D - L - U$ cada método plantea un esquema de iteración distinto. Veamos las particularidades.

### Jacobi

La coordenada $i$-ésima de la solución en el paso $k+1$ de iteración se define de la siguiente manera:

$$
x_i^{(k+1)} = \frac{1}{a_{ii}} \Big( b_i - \sum_{\substack{j=1 \\ j \neq i}}^n a_{ij} x_j^{(k)} \Big)
$$

Si llevamos esta expresión a una forma matricial obtenemos el esquema iterativo de Jacobi:

$$
\begin{aligned}
x^{(k+1)} &= D^{-1} (b + (L+U) x^{(k)})
\\
x^{(k+1)} &= \underbrace{D^{-1} (L+U)}_{T_j} x^{(k)} + \underbrace{D^{-1} b}_{c_j}
\end{aligned}
$$

Recordemos que pedimos que $A$ no tenga elementos nulos en su diagonal, luego $D$ resulta inversible. A su vez $L+U$ son todos los elementos de $A$ sin la diagonal y con el signo opuesto.

Si el método converge entonces $\lim_{k \rightarrow \infty} x^{(k)} = x^\ast$. Veamos si este esquema efectivamente obtiene una solución al sistema $Ax = b$.

$$\begin{aligned}
x^\ast &= D^{-1} (b + (L+U) x^\ast)
\\
D x^\ast &= b + (L+U) x^\ast
\\
D x^\ast - (L+U) x^\ast &= b
\\
(D-L-U) x^\ast &= b
\\
A x^\ast &= b
\end{aligned}$$

### Gauss-Seidel

La coordenada $i$-ésima de la solución en el paso $k+1$ de iteración se define de la siguiente manera:

$$
x_i^{(k+1)} = \frac{1}{a_{ii}} \Big(
    b_i
    -
    \sum_{j=1}^{i-1} a_{ij} \stackrel{\mathclap{\substack{\text{coordenadas de este paso} \hspace{3em} \\ \big\uparrow}}}{x_j^{(k+1)}}
    -
    \sum_{j=i+1}^n a_{ij} \stackrel{\mathclap{\substack{\hspace{3em} \text{coordenadas del paso anterior} \\ \big\uparrow}}}{x_j^{(k)}}
\Big)
$$

Si llevamos esta expresión a una forma matricial obtenemos el esquema iterativo de Gauss-Seidel:

$$
\begin{aligned}
x^{(k+1)} &= D^{-1} (b + L x^{(k+1)} + U x^{(k)})
\\
D x^{(k+1)} &= b + L x^{(k+1)} + U x^{(k)}
\\
D x^{(k+1)} - L x^{(k+1)} &= b + U x^{(k)}
\\
(D-L) x^{(k+1)} &= b + U x^{(k)}
\\
x^{(k+1)} &= (D-L)^{-1} (b + U x^{(k)})
\\
x^{(k+1)} &= \underbrace{(D-L)^{-1} U}_{T_{gs}} x^{(k)} + \underbrace{(D-L)^{-1} b}_{c_{gs}}
\end{aligned}
$$

Recordemos que pedimos que $A$ no tenga elementos nulos en su diagonal, luego $D - L$ resulta inversible.

Si el método converge entonces $\lim_{k \rightarrow \infty} x^{(k)} = x^\ast$. Veamos si este esquema efectivamente obtiene una solución al sistema $Ax = b$.

$$
\begin{aligned}
x^\ast &= (D-L)^{-1} U x^\ast + (D-L)^{-1} b
\\
(D-L) x^\ast &= U x^\ast + b
\\
(D-L) x^\ast - U x^\ast &= b
\\
(D-L-U) x^\ast &= b
\\
A x^\ast &= b
\end{aligned}
$$

## Matrices particulares

Si bien ambos métodos (Jacobi y Gauss-Seidel) son parecidos, la convergencia de uno no implica la del otro. Sin embargo, si tenemos hipótesis adicionales sobre la matriz del sistema $A \in \mathbb{R}^{n \times n}$ podemos afirmar la convergencia de forma directa.

- Si $A$ es estrictamente diagonal dominante (EDD) entonces Jacobi converge.
- Si $A$ es estrictamente diagonal dominante (EDD) entonces Gauss-Seidel converge.
- Si $A$ es simétrica definida positiva (SDP) entonces Gauss-Seidel converge.

Si además $a_{ii} > 0$ para todo $i = 1 \dots n$ y $a_{ij} < 0$ para todo $i \neq j$ se cumple una sola de las siguientes propiedades:

- $\rho(T_{gs}) < \rho(T_j) < 1$
- $\rho(T_{gs}) = \rho(T_j) = 0$
- $\rho(T_{gs}) > \rho(T_j) > 1$
- $\rho(T_{gs}) = \rho(T_j) = 1$

Lo cual nos dice o que ambos métodos convergen (y Gauss-Seidel lo hace más rápido) o que ninguno converge.
