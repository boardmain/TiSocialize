#!/bin/bash
for file in *.xib
do
  echo "Converto $file"
  ibtool $file --compile  ${file%%.*}.nib --output-format binary1
done
