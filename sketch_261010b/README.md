# Colisiones entre esferas - Del rebote al spin

## 1. Modelo inicial: movimiento lineal

Cada esfera tiene:

- Posición $\mathbf x$.
- Velocidad lineal $\mathbf v$.
- Masa $m$.
- Radio $R$.

Dos esferas están en contacto o superpuestas cuando:

$$
\|\mathbf x_B-\mathbf x_A\|\leq R_A+R_B
$$

La normal del contacto, **desde A hacia B**, es:

$$
\mathbf n=
\frac{\mathbf x_B-\mathbf x_A}
{\|\mathbf x_B-\mathbf x_A\|}
$$

Si los centros coinciden, esta normal no está definida y debe tratarse como un caso especial.

### Velocidad relativa normal

Sin considerar giro:

$$
u_n=(\mathbf v_B-\mathbf v_A)\cdot\mathbf n
$$

- $u_n<0$: las esferas se acercan.
- $u_n>0$: se separan.
- $u_n=0$: no hay acercamiento normal.

El impulso de impacto se aplica únicamente cuando se acercan.

## 2. Restitución y rebote

El coeficiente de restitución $e$ relaciona las velocidades relativas normales antes y después del choque:

$$
u_n'=-e\,u_n
$$

Para un contacto pasivo:

$$
0\leq e\leq1
$$

- $e=1$: rebote normal perfectamente elástico.
- $e=0$: velocidad relativa normal final nula.
- Valores intermedios: parte de la energía mecánica se disipa.

> $e$ no es el porcentaje de energía conservada. En el movimiento relativo normal, la energía se escala con $e^2$.

El impulso normal es:

$$
j_n=
-\frac{(1+e)u_n}
{\frac{1}{m_A}+\frac{1}{m_B}}
$$

Sin fricción, las velocidades finales son:

$$
\mathbf v_A'=\mathbf v_A-\frac{j_n\mathbf n}{m_A}
$$

$$
\mathbf v_B'=\mathbf v_B+\frac{j_n\mathbf n}{m_B}
$$

Este es el modelo de rebote lineal inicial.

## 3. Incorporar el spin

Para representar el giro añadimos:

- Velocidad angular $\boldsymbol\omega$: vector 3D.
- Momento de inercia $I$.
- Orientación: cuaternión o matriz de rotación.

La dirección de $\boldsymbol\omega$ indica el eje de giro, según la regla de la mano derecha; su magnitud indica la rapidez angular en radianes por segundo.

Para una **esfera maciza uniforme**:

$$
I=\frac{2}{5}mR^2
$$

Su energía cinética incluye traslación y rotación:

$$
E=\frac12m\|\mathbf v\|^2+\frac12I\|\boldsymbol\omega\|^2
$$

**Añadir spin no basta para intercambiar energía con el movimiento lineal:** debe existir un impulso tangencial, producido por la fricción durante el contacto.

## 4. Velocidad en el punto de contacto

La velocidad de un punto del cuerpo situado a un vector $\mathbf r$ del centro es:

$$
\mathbf v_{\text{contacto}}
=\mathbf v+\boldsymbol\omega\times\mathbf r
$$

Para las dos esferas:

$$
\mathbf r_A=R_A\mathbf n,
\qquad
\mathbf r_B=-R_B\mathbf n
$$

Por tanto:

$$
\mathbf v_{A,c}
=\mathbf v_A+R_A(\boldsymbol\omega_A\times\mathbf n)
$$

$$
\mathbf v_{B,c}
=\mathbf v_B-R_B(\boldsymbol\omega_B\times\mathbf n)
$$

La velocidad relativa de las superficies es:

$$
\mathbf u=\mathbf v_{B,c}-\mathbf v_{A,c}
$$

Se divide en una parte normal y otra tangencial:

$$
u_n=\mathbf u\cdot\mathbf n
$$

$$
\mathbf u_t=\mathbf u-u_n\mathbf n
$$

El giro no contribuye a $u_n$ para esferas ideales, pero sí puede contribuir al deslizamiento tangencial $\mathbf u_t$.

## 5. Impulso tangencial y fricción

El impulso necesario para eliminar el deslizamiento sería:

$$
\mathbf J_t^*
=
-\frac{\mathbf u_t}
{
\frac{1}{m_A}+\frac{1}{m_B}
+\frac{R_A^2}{I_A}+\frac{R_B^2}{I_B}
}
$$

Sin embargo, la fricción limita su magnitud:

$$
\|\mathbf J_t\|\leq\mu j_n
$$

Aquí, $\mu$ es el coeficiente de fricción. En este modelo sencillo:

$$
\mathbf J_t=
\begin{cases}
\mathbf 0,
& \|\mathbf J_t^*\|=0 \\[6pt]
\mathbf J_t^*
\min\left(
1,\frac{\mu j_n}{\|\mathbf J_t^*\|}
\right),
& \|\mathbf J_t^*\|>0
\end{cases}
$$

Interpretación:

- Si la fricción alcanza, se elimina el deslizamiento.
- Si no alcanza, se aplica el impulso máximo permitido y queda deslizamiento.
- Si $\mu=0$, no hay transferencia entre giro y traslación.

## 6. Actualización del movimiento

El impulso total es:

$$
\mathbf J=j_n\mathbf n+\mathbf J_t
$$

### Velocidades lineales

$$
\mathbf v_A'=\mathbf v_A-\frac{\mathbf J}{m_A}
$$

$$
\mathbf v_B'=\mathbf v_B+\frac{\mathbf J}{m_B}
$$

### Velocidades angulares

$$
\boldsymbol\omega_A'
=
\boldsymbol\omega_A
-\frac{R_A}{I_A}
(\mathbf n\times\mathbf J_t)
$$

$$
\boldsymbol\omega_B'
=
\boldsymbol\omega_B
-\frac{R_B}{I_B}
(\mathbf n\times\mathbf J_t)
$$

Ambos cambios angulares tienen el mismo signo porque los impulsos son opuestos y actúan en lados opuestos de las esferas.

El impulso normal no genera giro: su línea de acción pasa por los centros.

> Este procedimiento reemplaza al cálculo anterior de velocidades: ya incluye el rebote normal y el efecto tangencial. No deben aplicarse ambos métodos al mismo choque.

## 7. Diferencia entre restitución y fricción

| Parámetro | Controla                         | No representa                               |
| --------- | -------------------------------- | ------------------------------------------- |
| $e$       | El rebote normal                 | Un porcentaje directo de energía conservada |
| $\mu$     | El límite del impulso tangencial | Un porcentaje de energía transferida        |

Pueden tener el mismo valor numérico, pero son propiedades independientes.

**Transferir energía no es lo mismo que disiparla:**

- **Transferencia:** energía que pasa entre esferas o entre giro y traslación.
- **Disipación:** energía mecánica que se transforma en calor, sonido o deformación interna.

Con este modelo, $e=1$ y $\mu=0$ conserva la energía cinética total. Con fricción y deslizamiento puede haber disipación **aunque $e=1$**.

## 8. Evolución entre choques

Sin fuerzas ni torques externos:

$$
\mathbf x(t+\Delta t)
=
\mathbf x(t)+\mathbf v\,\Delta t
$$

$$
\boldsymbol\omega(t+\Delta t)=\boldsymbol\omega(t)
$$

La orientación se actualiza mediante una rotación de ángulo:

$$
\Delta\theta=\|\boldsymbol\omega\|\Delta t
$$

Alrededor del eje:

$$
\hat{\mathbf a}
=
\frac{\boldsymbol\omega}{\|\boldsymbol\omega\|}
$$

Si $\boldsymbol\omega=\mathbf0$, no hay rotación.

En 3D, conviene acumular estas rotaciones con una **matriz o un cuaternión**, no sumando directamente las componentes del spin a ángulos Euler.

## 9. Comprobaciones de implementación

- Usar siempre la misma convención: normal de A hacia B.
- Aplicar el impacto solo si $u_n<0$.
- Guardar las nuevas velocidades lineales y angulares.
- Corregir superposiciones por separado; el impulso no corrige posiciones.
- Usar unidades coherentes y el mismo $\Delta t$.
- Verificar que, sin fuentes externas, la energía total no aumente:

$$
E_{\text{total}}
=
\sum_i
\left(
\frac12m_i\|\mathbf v_i\|^2
+
\frac12I_i\|\boldsymbol\omega_i\|^2
\right)
$$
