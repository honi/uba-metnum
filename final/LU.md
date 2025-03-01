# Factorización LU

## Motivación

Supongamos que necesitamos resolver el sistema $Ax = b$ varias veces, es decir, para distintos términos independientes $b$. Usando Eliminación Gaussiana nos cuesta $O(n^3)$ **cada vez**, ya que al triangular la matriz del sistema también modificamos el término independiente. Si cambiamos $b$, hay que volver a triangular, por más que sea la misma matriz $A$.

Nos gustaría de alguna forma preservar la secuencia de operaciones que afectan al término independiente $b$ durante la Eliminación Gaussiana para poder reaplicarlas sobre otro término independiente nuevo, y así reutilizar el sistema previamente triangulado.

## Definición

Sean $A \in \mathbb{R}^{n \times n}$, $L \in \mathbb{R}^{n \times n}$ matriz triangular inferior y $U \in \mathbb{R}^{n \times n}$ matriz triangular superior tal que $A = LU$.

$$
Ax = b \iff LUx = b
$$

Con la factorización LU podemos resolver el sistema en 2 etapas:

$$
Ly = b \\
Ux = y
$$

Como $L$ y $U$ son triangulares (inferior/superior), resolver cada uno de esos sistemas solo cuesta $O(n^2)$ usando backwards/forward substitution.


## Procedimiento

Sea $A \in \mathbb{R}^{n \times n}$ la matriz del sistema. Llamamos $A^k$ con $k = 0 \dots n-1$ a la matriz resultante después del paso $k$-ésimo de la Eliminación Gaussiana. Asumimos que $a^{i-1}_{ii} \neq 0$ para todo $i = 1 \dots n-1$.

En cada paso de la Eliminación Gaussiana colocamos ceros debajo de la diagonal en una columna en particular. Busquemos representar un paso de la Eliminación Gaussiana como una multiplicación de matrices.

Sea $M^1 \in \mathbb{R}^{n \times n}$ la matriz que codifica el paso 1 de la Eliminación Gaussiana. Esta matriz tiene unos en la diagonal y debajo de ella en la columna 1 tiene los multiplicadores necesarios tal que $M^1 A^0 = A^1$.

$$
M^1 = \begin{bmatrix}
1 & 0 & 0 & \dots & 0
\\
-m_{21} & 1 & 0 & \dots & 0
\\
-m_{31} & 0 & 1 & \dots & 0
\\
\vdots & \vdots & \vdots & \ddots & \vdots
\\
-m_{n1} & 0 & 0 & \dots & 1
\end{bmatrix}
$$

$$
M^1 A^0 =
\begin{bmatrix}
a^0_{11} & \dots & a^0_{1n}
\\
a^0_{21} - m_{21} a^0_{11} & \dots & a^0_{2n} - m_{21} a^0_{1n}
\\
\vdots & \vdots & \vdots
\\
a^0_{n1} - m_{n1} a^0_{11} & \dots & a^0_{nn} - m_{n1} a^0_{1n}
\end{bmatrix}
= A^1
$$

Notemos que $fila_i(A^1) = fila_i(A^0) - m_{i1} fila_1(A^0)$ para todo $i = 2 \dots n$. Basta tomar $m_{i1} = a^0_{i1} / a^0_{11}$ para colocar ceros debajo de la diagonal en la columna 1 de $A^1$.

$$
A^1 = \begin{bmatrix}
a^0_{11} & \dots & a^0_{1n}
\\
0 & \dots & a^0_{2n} - m_{21} a^0_{1n}
\\
\vdots & \vdots & \vdots
\\
0 & \dots & a^0_{nn} - m_{n1} a^0_{1n}
\end{bmatrix}
$$

En el caso general del paso $i$-ésimo de la Eliminación Gaussiana tenemos $M^i$ tal que $M^i A^{i-1} = A^i$.

$$
M^i = \begin{bmatrix}
1 & \dots & 0 & 0 & \dots & 0
\\
\vdots & \ddots & \vdots & \vdots & \vdots & \vdots
\\
0 & \dots & 1 & 0 & \dots & 0
\\
0 & \dots & -m_{i+1i} & 1 & \dots & 0
\\
\vdots & \vdots & \vdots & \vdots & \ddots & \vdots
\\
0 & \dots & \underbrace{-m_{ni}}_{\text{columna } i} & 0 & \dots & 1
\end{bmatrix}
$$

Donde $m_{ji} = a^{i-1}_{ji} / a^{i-1}_{ii}$ con $i = 1 \dots n-1$ (la columna donde estamos poniendo los ceros) y $j = i+1 \dots n$.

Todo el método de la Eliminación Gaussiana se codifica como el siguiente producto matricial entre la matriz original $A$ y todas las $M^i$, dando como resultado $U \in \mathbb{R}^{n \times n}$ triangular superior.

$$
M^{n-1} M^{n-2} \dots M^1 A = U
$$

### Propiedades de $M^i$

La matriz $M^i$ la podemos representar de la siguiente forma.

$$
M^i = I - m_i e^t_i
$$

Donde el vector $m_i \in \mathbb{R}^n$ contiene los multiplicadores del paso $i$-ésimo de la Eliminación Gaussiana y $e_i$ es el $i$-ésimo vector canónico.

$$
\begin{aligned}
m_i &= \begin{bmatrix}
0 & \dots & 0 & 0 & m_{i+1i} & \dots & m_{ni}
\end{bmatrix}
\\
e_i &= \begin{bmatrix}
0 & \dots & 0 & 1 & 0 & \dots & 0
\end{bmatrix}
\end{aligned}
$$

$M^i$ es triangular inferior por construcción. Su determinante es $1$ ya que es el producto de su diagonal, que son todos unos. Luego $M^i$ es inversible. ¿Quién es su inversa?

$$
M^i (M^i)^{-1} = (I - m_i e^t_i) (I + m_i e^t_i) = I + m_i e^t_i - m_i e^t_i - m_i e^t_i m_i e^t_i = I - m_i \underbrace{e^t_i m_i}_{= 0} e^t_i = I
$$

Entonces $(M^i)^{-1} = I + m_i e^t_i$.

### ¿Quién es L?

$$
M^{n-1} M^{n-2} \dots M^1 A = U
\\
A = (M^1)^{-1} (M^2)^{-1} \dots (M^{n-1})^{-1} U
\\
A = (I + m_1 e^t_1) (I + m_2 e^t_2) \dots (I + m_{n-1} e^t_{n-1}) U
$$

Observando que $m_i e^t_i m_j e^t_j = 0$ si $j > i$ obtenemos:

$$
A = (I + m_1 e^t_1 + m_2 e^t_2 + \dots + m_{n-1} e^t_{n-1}) U
$$

Definimos entonces $L = I + m_1 e^t_1 + m_2 e^t_2 + \dots + m_{n-1} e^t_{n-1}$ matriz triangular inferior con unos en la diagonal y todos los multiplicadores usados durante la triangulación de $A$. Así obtenemos la factorización $LU$ de $A$.

$$
A = LU
$$

### Complejidad

Obtener la factorización $LU$ cuesta $O(n^3)$ operaciones elementales. En esencia es la misma complejidad que la Eliminación Gaussiana.

## Propiedades

Sea $A \in \mathbb{R}^{n \times n}$.

- Si $A$ es inversible y tiene factorización $LU$, entonces es única.

- Si todas las submatrices principales de $A$ son inversibles, entonces tiene factorización $LU$.

- Si $A$ es estrictamente diagonal dominante, entonces tiene factorización $LU$.

- No toda matriz tiene factorización $LU$.

# Factorización PLU

Si existe algún $a^{i-1}_{ii} = 0$ la Eliminación Gaussiana puede continuar permutando filas. Dado que queremos encontrar una factorización que codifique los pasos de la Eliminación Gaussiana para poder resolver el mismo sistema con otros términos independientes de forma más eficiente que repitiendo toda la Eliminación Gaussiana otra vez, necesitamos guardar ahora las permutaciones realizadas.

Partiendo de una matriz de permutación $P = I$ que no permuta ninguna fila, buscamos la factorización $PLU$ tal que:

$$
PA = LU
$$

En cada paso, si necesitamos permutar alguna fila actualizamos la matriz $P$ con la permutación necesaria. Luego resolver un sistema $Ax = b$ es similar al caso sin permutación:

$$
Ax = b \iff PLUx = b \iff LUx = P^{-1} b
$$

Notemos que $P^{-1} b$ aplica las permutaciones realizadas durante la Eliminación Gaussiana al término independiente $b$ para que se correspondan las coordenadas de $b$ con las ecuaciones permutadas.

Observación: $P^{-1} = P$ por ser matriz de permutación.
