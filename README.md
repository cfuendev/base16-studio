# Base16 Gallery

~~https://cfuendev.github.io/base16-studio~~ Not deployed yet.

A tool to visually design base16 themes.

# Roadmap

**Pre-1.0**

- [x] Overall Layout
- [ ] Color picker
  - [x] Breaks HEX values down to HSL to display the picker canvas correctly
  - [x] Changes selected palette color to whatever is selected in the color picker
  - [ ] Supports RGBA, HSLA, HWBA, LCHA and HEX color codes
  - [ ] Sliders
- [ ] Highlighted code preview
  - [x] Preview text exists? (Monaco is in)
  - [ ] Preview text is not broken (Monaco works just fine)
  - [ ] Preview text actually previews the palette (Monarch syntax highlighting)

# Installation
```
# fork the repository and clone your fork
git clone https://github.com/your-fork/base16-studio

# enter the folder
cd base16-studio

# install dependencies (I use pnpm)
pnpm i

# build (I use pnpm)
pnpm run build

# run server (I use pnpm)
pnpm run dev
```