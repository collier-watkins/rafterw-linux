{ config, pkgs, ... }:
{
    home.stateVersion = "25.05";

    home.packages = with pkgs; [
   
    ];

    home.file.".p10k.zsh" = {
        source = ../dotfiles/.p10k.zsh;
        target = ".p10k.zsh";
    };

    home.file.".p10k.zsh.tty" = {
        source = ../dotfiles/.p10k.zsh.tty;
        target = ".p10k.zsh.tty";
    };

    programs.zsh = {
        enable = true;
        syntaxHighlighting.enable = true;
        history.size = 10000;
        shellAliases = {
        ll = "ls -l";
            #rebuild = "sudo nixos-rebuild switch";
            switch = "sudo home-manager switch";
        };
        zplug = {
            enable = true;
            plugins = [
                { name = "zsh-users/zsh-autosuggestions"; }
                { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
            ];
        };
        oh-my-zsh = {
            enable = true;
            plugins = [ "git" ];
        };
        initContent = ''
            # Conditionally source Powerlevel10k configuration based on terminal type
            if [[ -n "$XDG_VTNR" && "$XDG_VTNR" -le 6 && "$TERM" == "linux" ]]; then
                [[ -f ~/.p10k.zsh.tty ]] && source ~/.p10k.zsh.tty
            else
                [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
            fi

            rebuild() {
                sudo nixos-rebuild switch --flake /etc/nixos#$1
            }
        '';
    };

    # Basic symlink for NeoVIM configs
    home.file.".config/nvim".source = ../configs/base/nvim;

    programs.htop = {
        enable = true;
        settings = {
            delay = 05;
            htop_version = "3.4.1";
            config_reader_min_version = 3;
            fields="0 48 17 18 38 39 40 2 46 47 49 1";
            hide_kernel_threads=1;
            hide_userland_threads=0;
            hide_running_in_container=0;
            shadow_other_users=1;
            show_thread_names=0;
            show_program_path=1;
            highlight_base_name=0;
            highlight_deleted_exe=1;
            shadow_distribution_path_prefix=0;
            highlight_megabytes=1;
            highlight_threads=1;
            highlight_changes=0;
            highlight_changes_delay_secs=5;
            find_comm_in_cmdline=1;
            strip_exe_from_cmdline=1;
            show_merged_command=0;
            header_margin=1;
            screen_tabs=1;
            detailed_cpu_time=0;
            cpu_count_from_one=0;
            show_cpu_usage=1;
            show_cpu_frequency=0;
            show_cpu_temperature=1;
            degree_fahrenheit=1;
            show_cached_memory=1;
            update_process_names=0;
            account_guest_in_cpu_meter=0;
            color_scheme=5;
            enable_mouse=1;
            hide_function_bar=0;
            header_layout = "three_33_34_33";
            column_meters_0 = "System Hostname Uptime Battery CPU Memory GPU";
            column_meter_modes_0 = "2 2 2 2 1 1 1";
            column_meters_1 = "LeftCPUs2 Blank Tasks DiskIO NetworkIO";
            column_meter_modes_1 = "1 2 2 2 2";
            column_meters_2 = "RightCPUs2";
            column_meter_modes_2 = 1;
            sort_direction = -1;
            tree_sort_direction = 1;
            tree_view_always_by_pid = 1;
            all_branches_collapsed = 1;
            sort_key="PERCENT_CPU";
            "screen:I/O" = "PID USER IO_PRIORITY IO_RATE IO_READ_RATE IO_WRITE_RATE PERCENT_SWAP_DELAY PERCENT_IO_DELAY Command";
        };
    };


    
}