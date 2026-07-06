# .bahadiraydin

## ⚙️ Dotfiles Managed with [chezmoi](https://www.chezmoi.io/)

### Prerequisites

- [chezmoi](https://www.chezmoi.io/)
- [git-lfs](https://git-lfs.com/) — wallpapers and fonts are tracked with LFS. Without it you'll get tiny pointer files instead of real binaries.

Install git-lfs and initialize it once per user:

### Setup on a new Machine

```sh
chezmoi init --apply git@github.com:BahadirAydin/dotfiles.git
```

If you cloned manually and the binaries look like text, pull the LFS objects:

```sh
git lfs pull
```
