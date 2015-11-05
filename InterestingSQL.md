### toZoomedPixelCoords in MySQL ###

```
select floor(((1 << 0)*256) * (ABS(((LN(TAN(RADIANS(latitude)) + SQRT(1 + POW(TAN(RADIANS(latitude)),2))))/PI()/2) - 0.5))) as y,
floor (((1 << 0)*256) *((longitude/360)+0.5)) as x;
```