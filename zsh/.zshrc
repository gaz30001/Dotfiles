#!/usr/bin/env zsh
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx &> /dev/null
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export FZF_DEFAULT_OPTS='
--color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1
--color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1
--color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
--color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'


export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git z zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -Uz compinit && compinit
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
 typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
# if command -v hyfetch &>/dev/null; then
  # hyfetch
# else
  # echo "🛰️  Neofetch не найден, установить: sudo pacman -S hyfetch"
# fi

# echo -e "\033[1;32mNASA Terminal Control Online.\033[0m"
echo -e "\033[1;36m Добро пожаловать, капитан $USER.\033[0m"

# rsyncnv - копирование туда/обратно через rsync+ssh
rsyncnv() {
  local mode="$1"
  local src="$2"
  local dest="$3"
  local remote_user="oleg"
  local remote_host="45.88.67.190"
  local remote_port="16040"

  if [[ "$mode" == "get" ]]; then
    rsync -avz -e "ssh -p $remote_port" "$remote_user@$remote_host:${src:-~/.config/nvim}" "${dest:-.}"
  elif [[ "$mode" == "put" ]]; then
    rsync -avz -e "ssh -p $remote_port" "${src:-.}" "$remote_user@$remote_host:${dest:-~}"
  else
    echo "❌ Использование: rsyncnv [get|put] [путь_источник] [путь_назначения]"
    echo "Например: rsyncnv get ~/.config/nvim ~/NEOVIM"
    echo "          rsyncnv put ~/NEOVIM ~/.config/nvim"
  fi
}
[[ -f ~/.ALIAS ]] &&. ~/.ALIAS
# Автодополнение для rsyncnv
_rsyncnv_complete() {
  local cur prev words cword
  cur=${words[CURRENT]}
  prev=${words[CURRENT-1]}
  local opts="get put"

  if [[ $CURRENT -eq 2 ]]; then
    compadd $opts
    return
  fi

  if [[ "$cur" =~ '^oleg@45\\.88\\.67\\.190:' ]]; then
    local path="${cur#*:}"
    local prefix="${cur%%:*}:"
    local completions
    completions=$(ssh -p 16040 oleg@45.88.67.190 "compgen -d '${path}'" 2>/dev/null)
    compadd -- ${(f)completions/#/${prefix}}
  else
    compadd -- ${(f)$(compgen -f -- "$cur")}
  fi
}
autoload -U compinit
compinit
compdef _rsyncnv_complete rsyncnv

if [ -d "$HOME/.local/bin" ] ; then
  case ":$PATH:" in
    *:"$HOME/.local/bin":*)
      # Путь уже есть, ничего не делаем
      ;;
    *)
      # Пути еще нет, добавляем его в начало
      export PATH="$HOME/.local/bin:$PATH"
      ;;
  esac
fi


