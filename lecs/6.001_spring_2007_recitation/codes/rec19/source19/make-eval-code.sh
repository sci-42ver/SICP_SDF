#!/bin/bash
enscript --columns=2 -r -A 2 -Escheme --word-wrap -fCourier7 evalcode.scm -o evalcode.ps
ps2pdf evalcode.ps
