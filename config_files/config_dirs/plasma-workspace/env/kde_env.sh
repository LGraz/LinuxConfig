export PATH="$HOME/LinuxConfig/bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.npm-global/bin:$HOME/node_modules/.bin:$PATH:/usr/bin/vendor_perl"
export BROWSER=/bin/firefox
export TERMINAL=/usr/bin/kitty
export EDITOR=/usr/bin/micro
export VISUAL=/usr/bin/code
export KDE_ENV=TRUE
export SHELL=/bin/zsh
export OPENBLAS_NUM_THREADS=$(( $(nproc) - 3 < 1 ? 1 : $(nproc) - 3 ))
