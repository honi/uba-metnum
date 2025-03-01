# CML

## Introducción

Dado un conjunto de pares ordenados $(x_i, y_i)$ para $i = 1 \dots m$ buscamos una función $f(x)$ perteneciente a una familia de funciones $\mathcal{F}$ tal que mejor aproxime los datos.

Ahora nuestra matriz ya no representa necesariamente una transformación lineal, si no que podría ser un dataset de observaciones. Los valores de $y_i$ podrían representar alguna medición y su $x_i$ asociado el tiempo de dicha medición.

A diferencia de los métodos de interpolación, CML no garantiza que $f(x)$ pase por todos los puntos $x_1 \dots x_m$. En cambio buscamos una función que en su comportamiento general se ajuste lo mejor posible a los datos, con la intención de poder evaluar la función en datos desconocidos y obtener una predicción lo más acertada posible.

## ¿Cómo podemos medir qué tan bien $f(x)$ aproxima los datos?

Como métrica base siempre consideramos el error cometido por la función al evaluarla en los puntos conocidos: $|f(x_i) - y_i|$, es decir la diferencia absoluta entre $f(x_i)$ y el valor real observado $y_i$.

**Tomamos la función que minimice el máximo error.**

$$\min_{f \in \mathcal{F}} \max_{i = 1 \dots m} |f(x_i) - y_i|$$

El problema de esta métrica es que la solución es muy sensible a datos atípicos (outliers).

**Tomamos la función que minimice la suma de las diferencias.**

$$\min_{f \in \mathcal{F}} \sum_{i = 1}^m |f(x_i) - y_i|$$

**Tomamos la función que minimice la suma de las diferencias al cuadrado.**

$$\min_{f \in \mathcal{F}} \sum_{i = 1}^m (f(x_i) - y_i)^2$$

Este es el método de cuadrados mínimos y el que vamos a utilizar ya que posee propiedades prácticas que facilitan obtener la solución.

## Definición

Dado un conjunto de funciones $\{ \phi_1 \dots \phi_n \}$ **linealmente independientes** definimos la familia de funciones como:

$$
\mathcal{F} = \{ f(x) = \sum_{j=1}^n c_j \phi_j(x) \}
$$

El problema de cuadrados mínimos lineales consiste en encontrar los coeficientes $c_1 \dots c_n$ tales que $f(x)$ mejor aproxime los datos:

$$
\min_{f \in \mathcal{F}} \sum_{i = 1}^m (f(x_i) - y_i)^2
= \min_{c_1 \dots c_n} \sum_{i = 1}^m (\sum_{j=1}^n c_j \phi_j(x_i) - y_i)^2
$$

Notemos que podemos reescribir el problema de forma matricial. Sean $A \in \mathbb{R}^{m \times n}$, $x \in \mathbb{R}^n$ y $b \in \mathbb{R}^m$ tales que:

$$
A = \begin{bmatrix}
\phi_1(x_1) & \phi_2(x_1) & \dots & \phi_n(x_1) \\
\vdots & \vdots & \vdots & \vdots \\
\phi_1(x_m) & \phi_2(x_m) & \dots & \phi_n(x_m) \\
\end{bmatrix}
\hspace{2em}
x = \begin{bmatrix}
c_1 \\
\vdots \\
c_n
\end{bmatrix}
\hspace{2em}
b = \begin{bmatrix}
y_1 \\
\vdots \\
y_m
\end{bmatrix}
$$

$$
Ax - b = \begin{bmatrix}
\sum_{j=1}^n c_j \phi_j(x_1) - y_1 \\
\vdots \\
\sum_{j=1}^n c_j \phi_j(x_m) - y_m
\end{bmatrix}
$$

$$
||Ax - b||^2_2 = \sum_{i = 1}^m (\sum_{j=1}^n c_j \phi_j(x_i) - y_i)^2
$$

Luego el problema de CML consiste en buscar $x$ tal que:

$$
\min_{x \in \mathbb{R}^n} ||Ax - b||^2_2
$$

## Existencia de la solución

Para encontrar la solución nos apoyamos en que $Im(A) \oplus Nu(A^t) = \mathbb{R}^m$. Esto significa que cualquier vector de $\mathbb{R}^m$ podemos escribirlo como una suma directa de 2 vectores, uno de $Im(A)$ y otro de $Nu(A^t)$. En particular vamos a descomponer el vector $b \in \mathbb{R}^m$ como $b = b^1 + b^2$, donde $b^1 \in Im(A)$ y $b^2 \in Nu(A^t)$.

$$
\min_{x \in \mathbb{R}^n} ||Ax - b||^2_2
=
\min_{x \in \mathbb{R}^n} ||Ax - b^1 - b^2||^2_2
$$

$Ax - b^1 \in Im(A)$ mientras que $b^2 \in Nu(A^t) = Im(A)^\perp$. Entonces $(Ax - b^1) \perp b^2$ y por Pitágoras tenemos que:

$$
\min_{x \in \mathbb{R}^n} ||Ax - b^1 - b^2||^2_2
=
\min_{x \in \mathbb{R}^n} ( ||Ax - b^1||^2_2 + ||b^2||^2_2 )
$$

Notemos que $||b^2||^2_2$ es constante, por lo tanto el problema se reduce a buscar $x$ tal que:

$$
\min_{x \in \mathbb{R}^n} ||Ax - b^1||^2_2
$$

Como $b^1 \in Im(A)$ podemos asegurar que **siempre** existe $x^\ast \in \mathbb{R}^n$ tal que $Ax^\ast = b^1$. Y en efecto $x^\ast$ minimiza la norma pues $||Ax^\ast - b^1||^2_2 = 0$ es lo mínimo que puede valor una norma.

Luego $x^\ast$ es la solución al problema de CML. Recordemos que $x^\ast = (c_1 \dots c_n)$ contiene los coeficientes de la función $f(x) = c_1 \phi_1(x) + \dots + c_n \phi_n(x)$ que planteamos para ajustarse a los datos.

## Interpretación geométrica

La noción de buscar una función que se ajuste a los datos se interpreta como buscar la **proyección ortogonal** de $b$ sobre el subespacio $Im(A) \subseteq \mathbb{R}^m$. La proyección ortogonal tiene la mínima distancia euclideana entre $b$ y algún punto de $Im(A)$. No queremos el punto que está en $Im(A)$ sino su pre-imagen, es decir el vector $x^\ast \in \mathbb{R}^n$ que genera el punto $A x^\ast$ (pueden haber varios). De esta forma encontramos los coeficientes $x^\ast$ que nos dan una función que mejor se ajusta a los datos pues $A x^\ast$ es lo más cerca que podemos llegar de $b$ (las observaciones de nuestro dataset).

## Unicidad

Concluimos que $Ax^\ast = b^1$ es la solución al problema de CML. Como estamos escribiendo a $b^1$ como una combinación lineal de las columnas de $A$, la solución es única sii $A$ tiene rango máximo, o equivalentemente, las columnas de $A$ son linealmente independientes.

## Ecuaciones normales

Si bien logramos caracterizar la solución al problema de CML, nos gustaría poder plantearlo en términos de los datos originales $A$ y $b$.

Recordemos que $b = b^1 + b^2$ con $b^1 \in Im(A)$ y $b^2 \in Nu(A^t)$.

$$
b = b^1 + b^2 \iff b^1 = b - b^2
$$

Sea $x^\ast$ solución al problema de CML.

$$
A x^\ast = b^1 \iff A x^\ast = b - b^2 \iff b^2 = b - A x^\ast
$$

Como $b^2 \in Nu(A^t)$ tenemos que:

$$
A^t b^2 = A^t (b - A x^\ast) = 0 \iff \underbrace{A^t A x^\ast = A^t b}_{\text{ecuaciones normales}}
$$

De esta forma logramos caracterizar el problema en función de los datos originales. Notemos que la matriz $A^t A$ es simétrica semi definida positiva, o definida positiva si $A$ tiene rango máximo. Podemos resolver el sistema planteado con cualquiera de las técnicas vistas como la factorización de Cholesky.

No obstante, la matriz $A^t A$ puede estar mal condicionada y generar soluciones inestables. Pequeños cambios en $b$ producen grandes cambios en la solución $x^\ast$. Para intentar remediar esto podemos buscar otra formulación de la solución mediante la factorización $QR$ o $SVD$ en donde no necesitemos usar la matriz $A^t A$.

## Error

## Resolución usando $QR$

## Resolución usando $SVD$
