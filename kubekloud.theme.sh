#!/usr/bin/env bash

# Cores
BLUE="\[\033[1;94m\]"
CYAN="\[\033[1;96m\]"
GREEN="\[\033[1;92m\]"
RED="\[\033[1;91m\]"
PURPLE="\[\033[1;95m\]"
YELLOW="\[\033[1;93m\]"
RESET="\[\033[0m\]"

# Função para obter a branch git
function parse_git_branch() {
    git branch 2> /dev/null | sed -n '/\* /s///p'
}

# Função para configurar o prompt
function prompt_command() {
    local EXIT="$?"
    local GIT_BRANCH=$(parse_git_branch)

    # Se o comando anterior falhou, seta a cor da seta para vermelha
    local ARROW_COLOR="$GREEN"
    if [ $EXIT -ne 0 ]; then
        ARROW_COLOR="$RED"
    fi

    # Configura o PS1 (Prompt String 1)
    PS1="${BLUE}\h ${CYAN}\w"
    if [ -n "$GIT_BRANCH" ]; then
        PS1+=" ${BLUE}git:(${PURPLE}${GIT_BRANCH}${BLUE})"
    fi
    PS1+=" ${ARROW_COLOR}➜ ${RESET}"
}

# Define o comando de prompt para ser executado antes de mostrar o prompt
PROMPT_COMMAND=prompt_command

