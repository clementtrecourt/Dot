# Matugen colors for Fish

set -gx matugen_primary "{{colors.primary.default.hex}}"
set -gx matugen_on_primary "{{colors.on_primary.default.hex}}"
set -gx matugen_primary_container "{{colors.primary_container.default.hex}}"
set -gx matugen_on_primary_container "{{colors.on_primary_container.default.hex}}"

set -gx matugen_secondary "{{colors.secondary.default.hex}}"
set -gx matugen_on_secondary "{{colors.on_secondary.default.hex}}"
set -gx matugen_secondary_container "{{colors.secondary_container.default.hex}}"
set -gx matugen_on_secondary_container "{{colors.on_secondary_container.default.hex}}"

set -gx matugen_tertiary "{{colors.tertiary.default.hex}}"
set -gx matugen_on_tertiary "{{colors.on_tertiary.default.hex}}"
set -gx matugen_tertiary_container "{{colors.tertiary_container.default.hex}}"
set -gx matugen_on_tertiary_container "{{colors.on_tertiary_container.default.hex}}"

set -gx matugen_error "{{colors.error.default.hex}}"
set -gx matugen_on_error "{{colors.on_error.default.hex}}"

set -gx matugen_background "{{colors.background.default.hex}}"
set -gx matugen_on_background "{{colors.on_background.default.hex}}"

set -gx matugen_surface "{{colors.surface.default.hex}}"
set -gx matugen_on_surface "{{colors.on_surface.default.hex}}"
set -gx matugen_surface_variant "{{colors.surface_variant.default.hex}}"
set -gx matugen_on_surface_variant "{{colors.on_surface_variant.default.hex}}"

set -gx matugen_outline "{{colors.outline.default.hex}}"
set -gx matugen_shadow "{{colors.shadow.default.hex}}"
set -gx matugen_scrim "{{colors.scrim.default.hex}}"

# Optional: Fish syntax highlighting colors
set -g fish_color_normal $matugen_on_background
set -g fish_color_command $matugen_primary
set -g fish_color_keyword $matugen_secondary
set -g fish_color_quote $matugen_tertiary
set -g fish_color_redirection $matugen_primary_container
set -g fish_color_end $matugen_secondary
set -g fish_color_error $matugen_error
set -g fish_color_param $matugen_on_surface
set -g fish_color_comment $matugen_outline
set -g fish_color_selection --background=$matugen_primary_container
set -g fish_color_search_match --background=$matugen_secondary_container
