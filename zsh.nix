{ pkgs, ... }:

{
  # ╔══════════════════════════════════════════════════════════════╗
  # ║                        SHELL (ZSH)                           ║
  # ║  Shell interactiva, Oh My Zsh, autosugerencias y resaltado   ║
  # ╚══════════════════════════════════════════════════════════════╝

  programs.zsh = {
    enable                    = true;
    enableCompletion          = true;
    autosuggestions.enable    = true;
    syntaxHighlighting.enable = true;

    # Oh My Zsh
    ohMyZsh = {
      enable  = true;
      theme   = "agnoster";
      plugins = [ "git" "sudo" ];
    };

    # Alias
    shellAliases = {
      tt  = "tmux";
      vi  = "nvim";
      ls  = "lsd --group-dirs first";
    };

    # Config personalizada para shells interactivos
    interactiveShellInit = ''
      # ── Options section ────────────────────────────────────────
      unsetopt correct
      setopt extendedglob
      setopt nocaseglob
      setopt rcexpandparam
      setopt nocheckjobs
      setopt numericglobsort
      setopt nobeep
      setopt appendhistory
      setopt histignorealldups
      setopt autocd
      setopt auto_pushd
      setopt pushd_ignore_dups
      setopt pushdminus
      setopt no_nomatch

      # ── Completion ─────────────────────────────────────────────
      autoload -Uz compinit
      compinit
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' rehash true
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' completer _expand _complete _ignored _approximate
      zstyle ':completion:*' menu select
      zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
      zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'
      zstyle ':completion:*' accept-exact '*(N)'
      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path ~/.cache/zcache

      autoload -U +X bashcompinit && bashcompinit

      # ── History ────────────────────────────────────────────────
      HISTFILE=~/.zhistory
      HISTSIZE=50000
      SAVEHIST=10000

      # ── Keybindings ────────────────────────────────────────────
      bindkey '^d'   forward-word
      bindkey '\C-H' backward-kill-word
      bindkey '^[k'  up-line-or-search
      bindkey '^[j'  down-line-or-search
    '';
  };
}
