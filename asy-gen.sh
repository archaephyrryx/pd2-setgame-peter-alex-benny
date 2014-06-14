#!/bin/bash
for ((i = 0; i < 81; ++i));
do let s=i/9; let c=i; let n=i/3; let f=i/27;
printf "import setcards;\ngenerate($s,$c,$n,$f);\n" >"$i.asy";
done

