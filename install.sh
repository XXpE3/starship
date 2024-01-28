#!/bin/bash

curl -sS https://raw.githubusercontent.com/XXpE3/starship/master/starship.toml -o ~/.config/starship.toml

if ! grep -Fxq 'eval "$(starship init zsh)"' ~/.zshrc
then
    echo -e '#Starship\n'"eval \"\$(starship init zsh)\"" >> ~/.zshrc
fi