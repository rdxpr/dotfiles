#!/bin/bash
# execute from parent
echo "Stowing from: $(pwd)"
Fruits=('zsh' 'nvim' 'lf')
for f in "${Fruits[@]}"; do
    stow -v $f
done
