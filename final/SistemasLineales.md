# Sistemas lineales

Un sistema lineal de $n \times n$ consiste de $n$ ecuaciones con $n$ incógnitas.

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

Sean $A \in \mathbb{R}^{n \times n}$, $a \in \mathbb{R}^n$, $B \in \mathbb{R}^{n \times n}$, $b \in \mathbb{R}^n$. Dados 2 sistemas lineales $Ax = a$ y $Bx = b$, decimos que son equivalentes sii tienen el mismo conjunto de soluciones. Es decir, para todo $x \in \mathbb{R}^n$, $Ax = a \iff Bx = b$.

Nos interesan los sistemas equivalentes porque muchas veces resolver el sistema original es muy costoso computacionalmente. Pero quizás podemos encontrar otro sistema equivalente y más fácil de resolver.

# Sistemas fáciles

A continuación vemos algunos sistemas de ecuaciones que son fáciles de resolver por la estructura de la matriz asociada al sistema.

## Matriz diagonal

Supongamos que $D \in \mathbb{R}^{n \times n}$ es la matriz **diagonal** asociada al sistema de ecuaciones y queremos encontrar $x \in \mathbb{R}^n$ tal que $Dx = b$ para algún $b \in \mathbb{R}^n$. Como $D$ es diagonal, cada ecuación tiene una única incógnita.

$$
\begin{cases}
d_{11} x_1 &= b_1 \\
& \hspace{0.25em} \vdots \\
d_{nn} x_n &= b_n
\end{cases}
$$

### Caso $d_{ii} \neq 0$ para todo $i = 1 \dots n$

Si $d_{ii} \neq 0$ para todo $i = 1 \dots n$, entonces **existe solución y es única**. Podemos despejar unívocamente cada $x_i$ de la siguiente manera:

$x_i = b_i / d_{ii}$ para todo $i = 1 \dots n$.

Obtenemos la solución en $O(n)$ operaciones elementales.

### Caso existe algún $d_{ii} = 0$

Si existe algún $d_{ii} = 0$ el sistema puede o no tener solución. Esto depende del valor de $b_i$.

- Si $d_{ii} = 0$ y $b_i = 0$ entonces **hay infinitas soluciones** ya que podemos elegir cualquier valor para $x_i$ tal que $d_{ii} x_i = b_i$ pues $0 * x_i = 0$ se cumple para cualquier $x_i$.

- Si $d_{ii} = 0$ y $b_i \neq 0$ entonces **no hay solución**.

## Matriz triangular superior (backwards substitution)

Supongamos que $U \in \mathbb{R}^{n \times n}$ es la matriz **triangular superior** asociada al sistema de ecuaciones y queremos encontrar $x \in \mathbb{R}^n$ tal que $Ux = b$ para algún $b \in \mathbb{R}^n$.

### Caso $u_{ii} \neq 0$ para todo $i = 1 \dots n$

Como $U$ es una matriz triangular, si $u_{ii} \neq 0$ para todo $i = 1 \dots n$ podemos despejar cada coordenada de $x$ empezando desde la última hasta la primera, utilizando los resultados previos en cada paso. En este caso **siempre existe solución y es única**. Esto se conoce como **backwards substitution** (sustitución hacia atrás).

Para calcular $x_n$ podemos despejar de forma directa: $x_n = b_n / u_{nn}$.

Yendo hacia atrás, si miramos la ecuación $n-1$ tenemos:

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

Finalmente obtenemos $x_1$ con la misma estrategia, utilizando todas las coordenadas ya calculados de $x$ desde $2$ hasta $n$:

$$
x_1 = (b_1 - \sum_{j=2}^{n} u_{1j} x_j) / u_{11}
$$

Recordemos que todas estas operaciones están bien definidas ya que $u_{ii} \neq 0$ para todo $i = 1 \dots n$. Así obtenemos $x \in \mathbb{R}^n$ solución al sistema $Ux = b$ en $O(n^2)$ operaciones elementales.

### Caso existe algún $u_{ii} = 0$

En este caso **puede o no haber solución**. Supongamos que existe algún $i \in [1, n]$ tal que $u_{ii} = 0$. En el paso $i$-ésimo del backwards substitution tenemos que despejar $x_i$. No podemos dividir por $u_{ii} = 0$ por lo tanto nos queda:

$$
0 = x_i u_{ii} = b_i - \sum_{j=i+1}^{n} u_{ij} x_j
$$

Solo hay solución si se cumple:

$$
b_i - \sum_{j=i+1}^{n} u_{ij} x_j = 0
$$

Y en tal caso hay **infinitas** soluciones ya que podemos elegir cualquier valor para $x_i$. Caso contrario el sistema no tiene solución.

## Matriz triangular inferior (forward substitution)

Si en vez de $U$ matriz triangular superior tuviésemos una matriz $L$ **triangular inferior**, se puede aplicar la misma estrategia (con las mismas consideraciones sobre $l_{ii}$) realizando un **forward substitution** (sustitución hacia adelante). Consiste en primero despejar $x_1$ e ir avanzando hasta llegar a $x_n$, utilizando las coordenadas previamente calculadas en cada paso.

# Sistemas generales

En el caso general, si la matriz asociada al sistema no es uno de los casos fáciles, nos gustaría tener un procedimiento que permita encontrar otro sistema equivalente que sí sea fácil de resolver.

## Eliminación Gaussiana

Para esto podemos aplicar el método de **Eliminación Gaussiana** que consiste en sumar/restar ecuaciones (filas), multiplicarlas por un escalar y permutarlas. El objetivo es triangular la matriz del sistema y luego obtener una solución (si existe) con backwards substitution.

Este procedimiento también afecta al término independiente, ya que las transformaciones que realizamos para triangular la matriz tiene que generar un nuevo sistema equivalente al original.

Sean $A \in \mathbb{R}^{n \times n}$ y $b \in \mathbb{R}^n$. Extendemos la matriz $A$ agregando $b$ como la última columna. Llamamos $A^k$ con $k=0 \dots n-1$ a la matriz extendida en el paso $k$ de la Eliminación Gaussiana.

$$
A^0 = \begin{bmatrix}
a_{11} & a_{12} & \dots & a_{1n} & b_1 \\
a_{21} & a_{22} & \dots & a_{2n} & b_2 \\
\vdots & \vdots & \vdots & \vdots & \vdots \\
a_{n1} & a_{n2} & \dots & a_{nn} & b_n
\end{bmatrix} \in \mathbb{R}^{n \times (n+1)}
$$

En el primer paso utilizamos $a^0_{11}$ como pivote para colocar ceros en la primer columna debajo de la diagonal principal.

$$
A^0 =
\begin{bmatrix}
a^0_{11} & a^0_{12} & \dots & a^0_{1n} & b^0_1 \\
a^0_{21} & a^0_{22} & \dots & a^0_{2n} & b^0_2 \\
\vdots & \vdots & \vdots & \vdots & \vdots \\
a^0_{i1} & a^0_{i2} & \dots & a^0_{in} & b^0_i \\
\vdots & \vdots & \vdots & \vdots & \vdots \\
a^0_{n1} & a^0_{n2} & \dots & a^0_{nn} & b^0_n
\end{bmatrix}
\rightarrow
\begin{matrix}
\\
F_2 - (a^0_{21} / a^0_{11}) F_1 \\
\vdots \\
F_i - (a^0_{i1} / a^0_{11}) F_1 \\
\vdots \\
F_n - (a^0_{n1} / a^0_{11}) F_1 \\
\end{matrix}
\rightarrow
\begin{bmatrix}
a^1_{11} & a^1_{12} & \dots & a^1_{1n} & b^1_1 \\
0 & a^1_{22} & \dots & a^1_{2n} & b^1_2 \\
\vdots & \vdots & \vdots & \vdots & \vdots \\
0 & a^1_{i2} & \dots & a^1_{in} & b^1_i \\
\vdots & \vdots & \vdots & \vdots & \vdots \\
0 & a^1_{n2} & \dots & a^1_{nn} & b^1_n
\end{bmatrix}
= A^1
$$

En el paso $i$-ésimo ya "triangulamos" (pusimos ceros debajo de la diagonal) las columnas $1$ a $i-1$. Ahora repetimos el mismo procedimiento para la columna $i$, utilizando como pivote $a^{i-1}_{ii}$. Notemos que en cada paso $i$ usamos la matriz $A^{i-1}$ del paso anterior.

$$
A^{i-1} =
\begin{bmatrix}
a^{i-1}_{11} & a^{i-1}_{12} & \dots & a^{i-1}_{1i} & \dots & a^{i-1}_{1n} & b^{i-1}_1 \\
0 & a^{i-1}_{22} & \dots & a^{i-1}_{2i} & \dots & a^{i-1}_{2n} & b^{i-1}_2 \\
\vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots \\
0 & 0 & \dots & a^{i-1}_{ii} & \dots & a^{i-1}_{in} & b^{i-1}_i \\
\vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots \\
0 & 0 & \dots & a^{i-1}_{ni} & \dots & a^{i-1}_{nn} & b^{i-1}_n
\end{bmatrix}
\hspace{1em}
\overrightarrow{
\begin{matrix}
\\
F_{i+1} - (a^{i-1}_{i+1i} / a^{i-1}_{ii}) F_i \\
\vdots \\
F_n - (a^{i-1}_{ni} / a^{i-1}_{ii}) F_i \\
\end{matrix}
}
$$

$$
\begin{bmatrix}
a^i_{11} & a^i_{12} & \dots & a^i_{1i} & a^i_{1i+1} & \dots & a^i_{1n} & b^i_1 \\
0 & a^i_{22} & \dots & a^i_{2i} & a^i_{2i+1} & \dots & a^i_{2n} & b^i_2 \\
\vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots \\
0 & 0 & \dots & a^i_{ii} & a^i_{ii+1} & \dots & a^i_{in} & b^i_i \\
0 & 0 & \dots & 0 & a^i_{i+1i+1} & \dots & a^i_{i+1n} & b^i_{i+1} \\
\vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots & \vdots \\
0 & 0 & \dots & 0 & a^i_{ni+1} & \dots & a^i_{nn} & b^i_n
\end{bmatrix}
= A^i
$$

Al concluir los $n-1$ pasos, obtenemos la matriz $A^{n-1}$ que contiene un sistema equivalente al original y además la matriz del sistema es una matriz triangular superior.

$$
A^{n-1} =
\begin{bmatrix}
a^{n-1}_{11} & a^{n-1}_{12} & \dots & a^{n-1}_{1i} & \dots & a^{n-1}_{1n} & b^{n-1}_1 \\
0 & a^{n-1}_{22} & \dots & a^{n-1}_{2i} & \dots & a^{n-1}_{2n} & b^{n-1}_2 \\
\vdots & \vdots & \ddots & \vdots & \ddots & \vdots & \vdots \\
0 & 0 & \dots & a^{n-1}_{ii} & \dots & a^{n-1}_{in} & b^{n-1}_i \\
\vdots & \vdots & \ddots & \vdots & \ddots & \vdots & \vdots \\
0 & 0 & \dots & 0 & \dots & a^{n-1}_{nn} & b^{n-1}_n
\end{bmatrix}
$$

### Condición necesaria

**La Eliminación Gaussiana requiere que $a^{i-1}_{ii} \neq 0$ para todo $i = 1 \dots n-1$.** Notar que **no** es suficiente que $A^0$ (la matriz original) tenga la diagonal sin ceros, esta condición pide que en cada paso $i$ de la Eliminación Gaussiana, el pivote $a^{i-1}_{ii} \neq 0$. Puede suceder que la matriz original no tenga ceros en la diagonal pero que aparezcan luego de algunos pasos.

Si en el paso $i$-ésimo sucede que $a^{i-1}_{ii} = 0$ quizás podemos continuar con la Eliminación Gaussiana.

- Si la columna $i$ ya tiene todo ceros debajo de la diagonal, es decir $a^{i-1}_{ji} = 0$ para todo $j = i+1 \dots n$, entonces no hace falta operar con las filas y podemos avanzar al siguiente paso.
- Caso contrario, si existe algún $a^{i-1}_{ji} \neq 0$ con $j > i$ podemos permutar la fila $i$ con la $j$ y continuar con la Eliminación Gaussiana.

### Pivoteo

Las estrategias de pivoteo no solo permiten realizar la Eliminación Gaussiana cuando el pivote es nulo, si no que también se puede utilizar para minimizar los errores numéricos al trabajar con aritmética finita. Notemos que en cada paso estamos diviendo por $a^{i-1}_{ii}$. Para minimizar los errores numéricos conviene siempre dividir por el mayor número posible. En cada paso de la Eliminación Gaussiana podemos intercambiar filas y/o columnas de tal forma que $|a^{i-1}_{ii}|$ sea lo más grande posible.

- Pivoteo parcial (por filas): En el paso $i$-ésimo elegimos como pivote el mayor $|a^{i-1}_{ji}|$ con $j \in [i, n]$. Tenemos que permutamos la fila $j$ con la $i$.

- Pivoteo completo (por filas y columnas): En el paso $i$-ésimo elegimos como pivote el mayor $|a^{i-1}_{jk}|$ con $j, k \in [i, n]$. Es decir miramos ahora toda la submatriz aún no triangulada para elegir el pivote. Luego tenemos que realizar las permutaciones necesarias para colocar el elemento $a^{i-1}_{jk}$ en la posición $i,i$.

### Complejidad

El método de Eliminación Gaussiana tiene una complejidad de $O(n^3)$ operaciones elementales. Dado que triangulamos la matriz del sistema junto al término independiente, si ahora queremos reutilizar la misma matriz pero con otro término independiente necesitamos volver a pagar el mismo costo cúbico.

Cuando tenemos un sistema que vamos a necesitar resolverlo muchas veces para distintos términos independientes, es más eficiente encontrar una descomposición de la matriz, como por ejemplo la descomposición [LU](./LU.md) or [QR](./QR.md).
