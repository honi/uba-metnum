# SDP (simétrica definida positiva)

## Definición

Una matriz $A \in \mathbb{R}^{n \times n}$ es **simétrica definida positiva** (SDP) si se cumplen 2 condiciones:

1. $A$ es simétrica. \
    $A = A^t$

2. $A$ es definida positiva. \
    $x^t A x > 0$ para todo $x \in \mathbb{R}^n$, $x \neq 0$

## Propiedades

Las matrices SDP tienen varias propiedades muy convenientes.

- A es inversible. \
    Si $A$ no fuese inversible entonces existe $x \in \mathbb{R}^n$, $x \neq 0$ tal que $Ax = 0$. Luego $x^t A x = x^t 0 = 0 \not > 0$. \
    Absurdo pues $A$ es SDP.

- $a_{ii} > 0$ para todo $i = 1 \dots n$. \
    Como $A$ es SDP, en particular $e^t_i A e_i = a_{ii} > 0$ para todo $i = 1 \dots n$.

- Toda submatriz principal también es SDP. \
    Sea $A^k$ la submatriz de orden $k = 1 \dots n$. Es fácil ver que $A^k$ es simétrica ya que es un "recorte" de la matriz original $A$ que es simétrica. Supongamos que $A^k$ no es definida positiva. Entonces existe $x \in \mathbb{R}^k$, $x \neq 0$ tal que $x^t A^k x \leq 0$. Sea $\overline{x} = (x, 0) \in \mathbb{R}^n$ la extensión de $x$ a $\mathbb{R}^n$. Notemos que $\overline{x} \neq 0$, entonces $\overline{x}^t A \overline{x} > 0$ porque $A$ es definida positiva. Si planteamos el producto matricial por bloques vemos que $\overline{x}^t A \overline{x} = x^t A^k x > 0$. Llegamos a una contradicción, luego $A^k$ también es definida positiva.

- $A$ es SDP sii $B^t A B$ es SDP con $B$ inversible. \
    La simetría se ve fácil verificando que $B^t A B = (B^t A B)^t$. Para ver que es definida positiva planteamos $x^t B^t A B x$ y usando que $B$ es inversible hacemos un cambio de variable $Bx = y$. Luego se verifica que $y^t A y > 0$ pues $A$ es SDP.

- La submatriz conformada por las filas y columnas $2$ a $n$ después del primer paso de la Eliminación Gaussiana es SDP. \
    Usando la propiedad anterior vemos que $M_1 A M^t_1$ es SDP y necesariamente la submatriz mencionada es también SDP.

- Se puede realizar el método de Eliminación Gaussiana sin necesidad de permutar filas. \
    Aplicando la propiedad anterior recursivamente podemos afirmar esta propiedad.

- Existe factorización $LU$. \
    Corolario de las propiedades anteriores.

## Factorización Cholesky

La Factorización de Cholesky es otra manera de descomponer una matriz para poder resolver sistemas de ecuaciones lineales de manera fácil.

Sea $A \in \mathbb{R}^{n \times n}$ una matriz SDP, entonces existe factorización $A = LU$. Como $A$ es simétrica y $L$ inversible por ser triangular inferior con unos en la diagonal:

$$
A = A^t \iff LU = (LU)^t \iff LU = U^t L^t \Rightarrow U (L^t)^{-1} = L^{-1} U^t
$$

$U (L^t)^{-1}$ es triangular superior por ser producto de triangulares superiores. $L^{-1} U^t$ es triangular inferior por ser producto de triangulares inferiores.

$$
U (L^t)^{-1} = L^{-1} U^t = D \Rightarrow U = D L^t
$$

Donde $D$ es una matriz diagonal. Volviendo a la factorización $LU$ de $A$ tenemos:

$$
A = LU = LDL^t
$$

$A$ es SDP y además $L^t$ es inversible. Entonces existe $x \in \mathbb{R}^n$, $x \neq 0$ tal que $L^t x = e_i$ para todo $i = 1 \dots n$.

$$
0 < x^t A x = x^t L D L^t x = (L^t x)^t D (L^t x) = e^t_i D e_i = d_{ii}
$$

Como todos los elementos de la diagonal $D$ son positivos, podemos descomponer $D$ como el producto de dos matrices diagonales (que son iguales) donde tomamos la raíz cuadrada a toda la diagonal.

$$
D = \sqrt{D} \sqrt{D}
$$

Donde $(\sqrt{D})_{ii} = \sqrt{d_{ii}}$ para todo $i = 1 \dots n$.

Finalmente encontramos la factorización de Cholesky de $A$.

$$
A = L \sqrt{D} \sqrt{D} L^t = L \sqrt{D} \sqrt{D}^t L^t = (L \sqrt{D}) (L \sqrt{D})^t = \tilde{L} \tilde{L}^t
$$

Donde $\tilde{L} = L \sqrt{D}$.

### Unicidad

Sea $A \in \mathbb{R}^{n \times n}$. $A$ es SDP sii tiene factorización de Cholesky: $A = \tilde{L} \tilde{L}^t$. Si además fijamos el signo de la diagonal de $\tilde{L}$, esta factorización es única.

Se puede probar por el absurdo suponiendo que existen 2 factorizaciones distintas. Finalmente se llega a una relación entre ambas factorizaciones donde quedan igualadas a $I$. De ahí se concluye que necesariamente comparten el mismo signo en la diagonal.

### Algoritmo

Si bien toda matriz SDP tiene factorización $LU$, y desde ahí podemos obtener la factorización de Cholesky, también existe un algoritmo para encontrar la factorización de Cholesky de forma directa.

Sea $A \in \mathbb{R}^{n \times n}$ y $A = \tilde{L} \tilde{L}^t$ su factorización de Cholesky. En líneas generales el algoritmo consiste en plantear el producto matricial $\tilde{L} \tilde{L}^t$ e igualar cada elemento con los de $A$. Luego vamos despejando los elementos de $\tilde{L}$ uno por uno, utilizando los valores previamente despejados (similar al backwards substitution).

### Complejidad

En general obtener la factorización de Cholesky tiene un costo de $O(n^3)$ operaciones elementales. No obstante, posee una mejor constante respecto a la factorización $LU$.

Cholesky es $O(n^3/3)$ mientras que $LU$ es $O(2n^3/3)$.
