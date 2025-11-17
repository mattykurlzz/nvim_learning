# my NVIM config

## installation

```
>>> git clone https://github.com/mattykurlzz/nvim_learning.git ~/.config/nvim
```

## Depends
To be able to install some LSP features, you will need luarocks executeable which can be installed with 
```
apt install luarocks
```
To install pyright you will need npm executeable
```
apt install npm
```
for live grep feature in telescope to work you will need ripgrep: 
```
apt install ripgrep
```

## Steps to take after clone

Enter nvim at any location
```
nvim .
```

Launch Mason menu
```
:Mason
```

Install following components:
```
clangd
rust_analyzer
pyright
pyproject_fmt
jsonls
lua_ls
```

Treesitter plugin requires parsers for languages. They may be missing sometimes. If you see treesitter error when opening a file, try running this command, it usually fixes this: 
```
:H
```
If not, install needed parser by hand. For example, 
```
:TSInstall lua
```

Optionally, you can install following useful components: 
For lua: 
```
luacheck
luaformatter
```

for C/C++: 
```
clang-format
cpplint
```
If any errors occur with these, feel free to comment out entries in `null-ls` setup
