# Copilot instructions

## Build, test, and lint

There is no automated test suite or test runner configured. Validate the full flake with:

```sh
nix flake check
```

To evaluate or build one host at a time, use its flake configuration name (`fw` or `crom`):

```sh
nix eval .#nixosConfigurations.fw.config.system.build.toplevel.drvPath
nix build .#nixosConfigurations.fw.config.system.build.toplevel
```

Replace `fw` with `crom` to check the desktop host. The `nix eval` command is a focused, single-host evaluation; `nix build` builds that host's system closure.

Format or check only the files being changed:

```sh
nixfmt path/to/file.nix
nixfmt --check path/to/file.nix
stylua nvim/lua/path/to/file.lua
stylua --check nvim/lua/path/to/file.lua
shfmt -w scripts/path/to/script.sh
shfmt -d scripts/path/to/script.sh
```

Nix formatting uses `nixfmt`; Lua formatting is configured by `nvim/stylua.toml`. `nixfmt`, `stylua`, and `shfmt` are included in the NixOS/Home Manager configuration.

## Architecture

- `flake.nix` is the entry point. It exports NixOS configurations `fw` and `crom` and the repository overlays. Both host definitions pass flake `inputs` and `outputs` to their modules.
- `nix/system/<host>/` contains each machine's hardware and host-specific settings. Both hosts compose shared system modules from `nix/system/modules/` and the shared `nix/system/lichess/` configuration.
- `nix/home/<host>/` defines each host's Home Manager configuration. These import `nix/home/common.nix` and then host-specific modules; reusable Home Manager modules and user services live under `nix/home/modules/` and `nix/home/services/`.
- `nix/overlays/` assembles package additions from `nix/pkgs/` and package modifications. The shared system module `nix/system/modules/common.nix` applies both overlays.
- `nvim/` is a standalone LazyVim-based Neovim configuration. Home Manager links it from the repository into `~/.config/nvim` rather than managing its files as generated configuration.

## Repository conventions

- Put reusable options and configuration in shared modules; keep hardware and host-specific values in the matching `fw` or `crom` module. Host-specific modules compose shared modules through NixOS/Home Manager `imports`.
- Pass flake dependencies through module arguments (`inputs`/`outputs`) rather than hard-coding external flake data in reusable modules.
- `custom.darkTheme` is declared by both the system and Home Manager common modules. The Home Manager option mirrors `osConfig.custom.darkTheme`, so shared user modules can use `config.custom.darkTheme`; shared Home Manager settings use it for both GTK and the dconf desktop color scheme.
- Keep `system.stateVersion` and `home.stateVersion` unchanged during routine package or configuration updates; they are compatibility settings, not the current NixOS release.
- `flake.lock` pins external inputs. Update it through Nix flake commands when intentionally changing dependencies.
