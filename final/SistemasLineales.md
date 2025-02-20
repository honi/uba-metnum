# Sistemas lineales

Un sistema de $n \times n$ consiste de $n$ ecuaciones lineales con $n$ incógnitas.

$$
\begin{cases}
a_{11} x_1 + a_{12} x_2 + \dots + a_{1n} x_n &= b_1 \\
& \hspace{0.25em} \vdots \\
a_{n1} x_1 + a_{n2} x_2 + \dots + a_{nn} x_n &= b_n
\end{cases}
$$

También se puede expresar en forma matricial como $Ax = b$ donde:

$$
A = \begin{bmatrix}
a_{11} & a_{12} & \dots & a_{1n} \\
\vdots & \vdots & \ddots & \vdots \\
a_{n1} & a_{n2} & \dots & a_{nn}
\end{bmatrix} \in \mathbb{R}^{n \times n}
\hspace{2em}
x = \begin{bmatrix}
x_1 \\ x_2 \\ \vdots \\ x_n
\end{bmatrix} \in \mathbb{R}^n
\hspace{2em}
b = \begin{bmatrix}
b_1 \\ b_2 \\ \vdots \\ b_n
\end{bmatrix} \in \mathbb{R}^n
$$

Dados los coeficientes $A$ y el término independiente $b$ nos interesa encontrar la solución al sistema, es decir todos los $x \in \mathbb{R}^n$ tal que $Ax = b$ (puede no haber solución).

## Imagen

Definimos la imagen de $A \in \mathbb{R}^{n \times n}$ como:

$$
Im(A) = \{ y \in \mathbb{R}^n \mid \exists x \in \mathbb{R}^n, Ax = y \}
$$

La $Im(A)$ son todas las posibles combinaciones lineales de las columnas de $A$.

## Cuándo hay solución?

Si interpretamos el sistema de ecuaciones de manera geométrica, por ejemplo con $n=2$, tenemos 2 ecuaciones donde cada una define una recta. Lo que buscamos al resolver el sistema es encontrar todos los puntos donde se intersecan dichas rectas. Con esta interpretación, definimos:

- **Sistema incompatible**: no hay solución (las rectas son paralelas sin intersección).
- **Sistema compatible determinado**: hay una única solución (las rectas intersecan en un único punto).
- **Sistema compatible indeterminado**: hay infinitas soluciones (las rectas intersecan en infinitos puntos, son la misma recta).

Esta interpretación se extiende a $\mathbb{R}^n$ donde las ecuaciones definen hiper-planos.

Para un sistema $Ax = b$ cualquiera:

- Si $b \not\in Im(A)$ entonces el sistema **no** tiene solución.
- Si $b \in Im(A)$ entonces el sistema tiene solución. La solución es única sii las columnas de $A$ son linealmente independientes. En ese caso, la matriz $A$ resulta inversible y por lo tanto $Ax = b \iff x = A^{-1} b$. Hay una biyección entre $x$ y $b$, necesariamente hay un único $x$ tal que $Ax = b$.

## Sistemas equivalentes

Sean $A \in \mathbb{R}^{n \times n}$, $b \in \mathbb{R}^n$, $B \in \mathbb{R}^{n \times n}$, $c \in \mathbb{R}^n$. Dados 2 sistemas lineales $Ax = b$ y $Bx = c$, decimos que son equivalentes sii tienen el mismo conjunto de soluciones. Es decir, para todo $x \in \mathbb{R}^n$, $Ax = b \iff Bx = c$.

Nos interesan los sistemas equivalentes porque muchas veces resolver el sistema original es muy difícil, pero quizás podemos encontrar otro sistema equivalente y más fácil de resolver.

# Sistemas fáciles

A continuación vemos algunos sistemas de ecuaciones que son fáciles de resolver por la naturaleza misma de los sistemas.

## Matriz diagonal

Supongamos que $D \in \mathbb{R}^{n \times n}$ es la matriz **diagonal** asociada al sistema de ecuaciones y queremos encontrar $x \in \mathbb{R}^n$ tal que $Dx = b$ para algún $b \in \mathbb{R}^n$. Como $D$ es diagonal, cada ecuación tiene una única incógnita.

$$
\begin{cases}
d_{11} x_1 &= b_1 \\
& \hspace{0.25em} \vdots \\
d_{nn} x_n &= b_n
\end{cases}
$$

Hay 2 casos:

- Si $d_{ii} \neq 0$ para todo $i = 1 \dots n$, entonces **existe solución y es única**. \
$x_i = b_i / d_{ii}$ para todo $i = 1 \dots n$. \
Obtenemos la solución en $O(n)$ operaciones elementales.

- Si existe algún $d_{ii} = 0$ el sistema puede o no tener solución. Esto depende del valor de $b_i$.

    - Si $d_{ii} = 0$ y $b_i = 0$ entonces **hay infinitas soluciones** ya que podemos elegir cualquier valor para $x_i$ tal que $d_{ii} x_i = b_i$ pues $0 * x_i = 0$ se cumple para cualquier $x_i$.

    - Si $d_{ii} = 0$ y $b_i \neq 0$ entonces **no hay solución**.

## Matriz triangular (backwards substitution)

Supongamos que $U \in \mathbb{R}^{n \times n}$ es la matriz **triangular superior** asociada al sistema de ecuaciones y queremos encontrar $x \in \mathbb{R}^n$ tal que $Ux = b$ para algún $b \in \mathbb{R}^n$.

### Caso $u_{ii} \neq 0$ para todo $i = 1 \dots n$

Como $U$ es una matriz triangular, si $u_{ii} \neq 0$ para todo $i = 1 \dots n$ podemos despejar cada coordenada de $x$ empezando desde la última hasta la primera, utilizando los resultados previos en cada paso. En este caso **siempre existe solución y es única**. Esto se conoce como **backwards substitution** (sustitución hacia atrás).

Para calcular $x_n$ podemos despejar de forma directa: $x_n = b_n / u_{nn}$.

Yendo hacia arriba, si miramos la ecuación $n-1$ tenemos:

$$
u_{n-1 n-1} x_{n-1} + u_{n-1 n} x_n = b_{n-1}
$$

Dado que ya calculamos $x_n$ en el primer paso, podemos despejar $x_{n-1}$ de la siguiente manera:

$$
x_{n-1} = (b_{n-1} - u_{n-1 n} x_n) / u_{n-1 n-1}
$$

El caso general para $x_i$ utiliza todos los valores ya calculados previamente para $x_{i+1}, \dots, x_n$.

$$
x_i = (b_i - \sum_{j=i+1}^{n} u_{ij} x_j) / u_{ii}
$$

Finalmente obtenemos $x_1$ con la misma estrategia:

$$
x_1 = (b_1 - \sum_{j=2}^{n} u_{1j} x_j) / u_{11}
$$

Recordemos que todas estas operaciones están bien definidas ya que $u_{ii} \neq 0$ para todo $i = 1 \dots n$. Así obtenemos $x \in \mathbb{R}^n$ solución al sistema $Ux = b$ en $O(n^2)$ operaciones elementales.

### ¿Qué pasa si algún $u_{ii} = 0$?

En este caso **puede o no haber solución**. Supongamos que existe algún $i \in [1, n]$ tal que $u_{ii} = 0$. En el paso $i$-ésimo del backwards substitution tenemos que despejar $x_i$. No podemos pasar dividiendo $u_{ii} = 0$ por lo tanto nos queda:

$$
0 = x_i u_{ii} = b_i - \sum_{j=i+1}^{n} u_{ij} x_j
$$

Solo hay solución si se cumple:

$$
b_i - \sum_{j=i+1}^{n} u_{ij} x_j = 0
$$

Y en tal caso hay **infinitas** soluciones ya que podemos elegir cualquier valor para $x_i$. Caso contrario el sistema no tiene solución.

### Forward substitution

Si en vez de $U$ matriz triangular superior tuviésemos una matriz $L$ triangular inferior, se puede aplicar la misma estrategia (con las mismas consideraciones sobre $l_{ii}$) realizando un **forward substitution** (sustitución hacia adelante), que consiste en primero despejar $x_1$ e ir avanzando hasta llegar a $x_n$, utilizando las coordenadas previamente calculadas en cada paso.

# Sistemas generales

En el caso general, si la matriz asociada al sistema no es uno de los casos fáciles, nos gustaría tener un procedimiento que permita encontrar otro sistema equivalente que sí sea fácil de resolver.

Para esto podemos aplicar el método de **Eliminación Gaussiana** que consiste en sumar/restar ecuaciones (filas), multiplicarlas por un escalar y permutarlas para triangular la matriz del sistema y luego obtener una solución (si existe) con backwards substitution.
