# disable fish greeting and vi mode
set fish_greeting
fish_vi_key_bindings

#===============================================#
#           enable starship prompt
#===============================================#
set --export STARSHIP_CONFIG ~/.config/fish/starship/starship-simple.toml

if status is-interactive
    function starship_transient_prompt_func
      starship module character
    end
    starship init fish | source
    enable_transience
end


#===============================================#
#           aliases and functions
#===============================================#
source ~/.config/fish/aliases.fish
source ~/.config/fish/functions.fish


#===============================================#
#           zoxide and thefuck
#===============================================#
zoxide init fish | source
thefuck --alias | source


fastfetch
