{ config, colors }:

{
  home.file.".config/neofetch/config.conf".text = ''
    print_info() {
        prin ""
        info title
        info underline

        info "\e[34m  " distro
        # info "\e[31m " model
        info "\e[31m " kernel
        info "\e[32m " packages
        info "\e[33m " uptime
        info "\e[34m " wm
        # info "\e[37m󰹑 " resolution
        info "\e[35m " shell
        info "\e[36m " term
        info "\e[37m " term_font
        # info "\e[31m " cpu
        # info "\e[37m " disk

        # info " " gpu
        # info " " memory

        prin "$(color 0)▂▂ $(color 1)▂▂ $(color 2)▂▂ $(color 3)▂▂ $(color 4)▂▂ $(color 5)▂▂ $(color 6)▂▂ $(color 7)▂▂ "
    }

    title_fqdn="off"
    kernel_shorthand="on"
    distro_shorthand="on"
    uptime_shorthand="tiny"
    memory_percent="off"
    memory_unit="mib"
    package_managers="on"
    shell_path="off"
    shell_version="on"
    speed_type="bios_limit"
    speed_shorthand="off"
    cpu_brand="on"
    cpu_cores="logical"
    gpu_type="dedicated"
    refresh_rate="on"
    gtk_shorthand="off"
    gtk2="on"
    gtk3="on"
    de_version="on"
    bold="off"
    underline_enabled="on"
    underline_char="-"
    separator=" • "
    color_blocks="on"
    block_width=3
    block_height=1
    col_offset="auto"
    bar_char_elapsed="-"
    bar_char_total="="
    bar_border="on"
    bar_length=15
    bar_color_elapsed="distro"
    bar_color_total="distro"
    image_backend="kitty"
    image_source="${./. + "/assets/nix-snowflake.png"}"
    image_size="256px"
    image_loop="on"
    ascii_distro="nixos"
    ascii_colors=(distro)
    ascii_bold="on"
    thumbnail_dir="${config.home.homeDirectory}/.cache/thumbnails/neofetch"
    crop_mode="fit"
    crop_offset="center"
    yoffset=1
    xoffset=1
    stdout="off"

  '';
}
