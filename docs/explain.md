
C 点为 `a*i + b*j + c*k`.
P 点为 `x*i + y*j + z*k`.

空间向量的垂直关系(视频配图), 可以列方程,

计算得到 `OQ` 相比 `OC` 的倍率:

```c
float r = (a*x + b*y + c*z) / sumSquares3(a, b, c);
```

通过计算外积的方式(视频配图),
通过 `OC` 和 `(0, 1, 0)` 计算得到, 屏幕上的 `x` 方向单元:

```c
(-c*i + a*k) / 长度
```

屏幕上的 `y` 单位向量:

```c
(-a*b*i + (a^2 + b^2)*j - b*c*j) / 长度
```

计算最终相对屏幕上的位置:

```c
float q = (s + 1.0) / (r + s);
float l1 = sqrt((a*a*b*b) + square(sumSquares2(a,c)) + (b*b*c*c));

float y_next = (q*y + b*q*s - b*s - b) / sumSquares2(a, c) * l1;
float x_next = (((q*x + a*q*s - a*s - a) - (y_next * (-a * b) / l1)) / -c) * sqrt(sumSquares2(a,c));

// 区分深度使用
float z_next = -r;

vec3(x_next, y_next / viewportRatio, z_next);
```