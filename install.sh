#!/bin/bash

set -e

check_and_install_starship() {
  if ! command -v starship &>/dev/null; then
    echo "Starship not found, installing..."
    curl -sS https://starship.rs/install.sh | sh
    echo "Starship 安装完毕"
  fi
}

download_and_update_config() {
    local url="https://raw.githubusercontent.com/XXpE3/starship/master/starship.toml"
    local config_dir="${HOME}/.config"
    local config_file="${config_dir}/starship.toml"

    mkdir -p "${config_dir}"
    if [ ! -f "${config_file}" ]; then
        if ! curl -s -o "${config_file}" "${url}"; then
            printf "Error: Failed to download starship.toml from %s\n" "${url}" >&2
            return 1
        fi
        echo "Starship 安装完毕"
    else
        if ! curl -s -o "${config_file}" "${url}"; then
            printf "Error: Failed to download starship.toml from %s\n" "${url}" >&2
            return 1
        fi
        echo "Starship 配置更新完毕"
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
    check_and_install_starship
    download_and_update_config
    update_zshrc
}

main
