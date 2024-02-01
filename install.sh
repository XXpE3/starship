#!/bin/bash

download_and_update_config() {
    local url="https://raw.githubusercontent.com/XXpE3/starship/master/starship.toml"
    local config_dir="${HOME}/.config"
    local config_file="${config_dir}/starship.toml"

    mkdir -p "${config_dir}"
    if ! curl -o "${config_file}" "${url}"; then
        printf "Error: Failed to download starship.toml from %s\n" "${url}" >&2
        return 1
    fi
}

update_zshrc() {
    local zshrc="${HOME}/.zshrc"
    local starship_cmd='eval "$(starship init zsh)"'

    if ! grep -qF -- "${starship_cmd}" "${zshrc}"; then
        printf "\n# Starship\n%s\n" "${starship_cmd}" >> "${zshrc}"
    fi
}

main() {
    download_and_update_config || return 1
    update_zshrc
}

main

