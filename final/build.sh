#!/bin/bash

pandoc \
    -H <(echo '\usepackage{mathtools}') \
    -V geometry:margin=1in \
    -o MetNumFinal.pdf \
    SistemasLineales.md \
    LU.md \
    Normas.md \
    SDP.md \
    QR.md \
    Autovalores.md \
    SVD.md \
    CML.md \
    MétodosIterativos.md \
    Interpolación.md
