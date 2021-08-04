#!/bin/sh

color=$1
dotfiles=~/dotfiles

configure_alacritty() {
    cat ${dotfiles}/_alacritty-base.yml ${dotfiles}/_alacritty-${color}.yml > ${dotfiles}/_alacritty.yml
}

configure_vim() {
    echo $1 > ${dotfiles}/_vim/vimcolor.vim
}

configure_tmux() {
    cat ${dotfiles}/_tmux-base.conf ${dotfiles}/_tmux-${color}.conf > ${dotfiles}/_tmux.conf
    tmux source-file ${dotfiles}/_tmux.conf
}

send_command_to_vim() {
    input_command="${@:1}"
    current_session=$(tmux display-message -p '#{session_name}')
    for _pane in $(tmux list-panes -s -t ${current_session} -F '#{window_index}.#{pane_index}'); do
        current_command=$(tmux display-message -p -t ${current_session}:${_pane} '#{pane_current_command}')
        if [ ${current_command} = vim  ]; then
            tmux send-keys -t ${_pane} "${input_command}" Enter
        fi
    done
}

configure_vim_sessions() {
    send_command_to_vim :so ~/.vimrc
}


case $color in
    dark)
        configure_alacritty
        configure_tmux
        configure_vim 'let g:ayucolor="mirage"\ncolorscheme allure\nAirlineTheme deus'
        configure_vim_sessions
        export GLAMOUR_STYLE=dark
        ;;
    light)
        configure_alacritty
        configure_tmux
        configure_vim 'let g:ayucolor="light"\ncolorscheme ayu\nAirlineTheme papercolor'
        configure_vim_sessions
        export GLAMOUR_STYLE=light
        ;;
    *)
        echo "Supported colorschemes: dark, light"
        exit 1
        ;;
esac
