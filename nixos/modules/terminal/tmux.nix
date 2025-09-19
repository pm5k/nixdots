  { config, pkgs, ... }:

  {
    programs.tmux = {
      enable = true;
      baseIndex = 1;
      escapeTime = 20;
      historyLimit = 10000;
      keyMode = "vi";
      mouse = true;
      prefix = "C-Space";
      terminal = "tmux-256color";

      plugins = with pkgs.tmuxPlugins; [
        vim-tmux-navigator
        resurrect
        {
          plugin = catppuccin;
          extraConfig = ''
            set -g @catppuccin_flavor 'frappe'
          '';
        }
      ];

      extraConfig = ''
        # Catppuccin theme settings (flavor set in plugin config above)
        set -g @catppuccin_status_background "none"
        set -g @catppuccin_window_status_style "none"
        set -g @catppuccin_pane_status_enabled "off"
        set -g @catppuccin_pane_border_status "off"

        # Base settings
        set -ga terminal-overrides ',xterm*:Tc'
        set -g status-interval 1
        set-option -g repeat-time 1000

        # Start panes at index 1 too
        set -g pane-base-index 1
        set-window-option -g pane-base-index 1
        set -g renumber-windows on

        # VI copy mode bindings
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
        set -g set-clipboard on

        # Open panes in current dir
        bind '"' split-window -c "#{pane_current_path}"
        bind % split-window -h -c "#{pane_current_path}"

        # Custom keybinds
        bind R source-file "$HOME/.config/tmux/tmux.conf" \; display-message "Config reloaded..."
        bind ( previous-window
        bind ) next-window
        bind -n M-H previous-window
        bind -n M-L next-window
        bind-key x kill-pane

        set -g status-left-length 100
        set -g status-left ""
        set -ga status-left "#{?client_prefix,#{#[bg=#{@thm_red},fg=#{@thm_bg},bold]  #S },#{#[bg=#{@thm_bg},fg=#{@thm_green}]  #S }}"
        set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]│"
        set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_maroon}]  #{pane_current_command} "
        set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]│"
        set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_blue}]  #{=/-32/...:#{s|^$HOME|~|:#{pane_current_path}}} "
        set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_overlay_0},none]#{?window_zoomed_flag,│,}"
        set -ga status-left "#[bg=#{@thm_bg},fg=#{@thm_yellow}]#{?window_zoomed_flag,  zoom ,}"

        set -g status-right-length 100
        set -g status-right ""
        set -ga status-right "#[bg=#{@thm_bg},fg=#{@thm_blue}] 󰭦 %Y-%m-%d 󰅐 %H:%M "

        set -g status-position bottom
        set -g status-style "bg=#{@thm_bg}"
        set -g status-justify "right"

        # Rest of your beautiful styling...
        setw -g pane-border-status bottom
        setw -g pane-border-format ""
        setw -g pane-active-border-style "bg=#{@thm_bg},fg=#{@thm_overlay_0}"
        setw -g pane-border-style "bg=#{@thm_bg},fg=#{@thm_surface_0}"
        setw -g pane-border-lines single

        set -wg automatic-rename on
        set -g automatic-rename-format "Window"
        set -g window-status-format " #I#{?#{!=:#{window_name},Window},: #W,} "
        set -g window-status-style "bg=#{@thm_bg},fg=#{@thm_rosewater}"
        set -g window-status-last-style "bg=#{@thm_bg},fg=#{@thm_peach}"
        set -g window-status-activity-style "bg=#{@thm_red},fg=#{@thm_bg}"
        set -g window-status-bell-style "bg=#{@thm_red},fg=#{@thm_bg},bold"
        set -gF window-status-separator "#[bg=#{@thm_bg},fg=#{@thm_overlay_0}]│"
        set -g window-status-current-format "  #I#{?#{!=:#{window_name},Window},: #W,} "
        set -g window-status-current-style "bg=#{@thm_peach},fg=#{@thm_bg},bold"
      '';
    };
  }

