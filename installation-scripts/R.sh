#!/usr/bin/env bash
set -e # Exit immediately if a command exits with a non-zero status
set -u # Exit immediately if an undefined variable is used

# --- Helper Functions for Output ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
fatal() { echo -e "${RED}[FATAL]${NC} $1"; exit 1; }

# --- Phase 1: Pre-flight & Discovery ---

# Determine the R version
if [ $# -eq 1 ]; then
    R_VERSION="$1"
    info "Using specified R version: $R_VERSION"
fi

R_MAJOR_VERSION=$(echo "$R_VERSION" | cut -d. -f1)
R_MINOR_VERSION=$(echo "$R_VERSION" | cut -d. -f1,2)

# Check for critical C-libraries using pkg-config (No Sudo required)
info "Checking system dependencies via pkg-config..."
if ! command -v pkg-config &> /dev/null; then
    warn "pkg-config is not installed. Skipping strict dependency checks. If compilation fails, check your C-headers."
else
    # libcurl and pcre2 are the most common failure points for R configuration
    for pkg in libcurl libpcre2-8; do
        if ! pkg-config --exists "$pkg"; then
            fatal "Missing system dependency: $pkg. Please ask your sysadmin to install the development headers (e.g., libcurl-devel or libcurl4-openssl-dev)."
        fi
    done
    info "Core C-library headers found."
fi

# Determine CPU cores for parallel compilation
CORES=$(nproc 2>/dev/null || echo 1)
info "Detected $CORES CPU cores for compilation."

# --- Phase 2: Staging & Compilation ---

PREFIX_DIR="$HOME/.local/R/$R_VERSION"
WORK_DIR=$(mktemp -d)
cd "$WORK_DIR"

TARBALL="R-${R_VERSION}.tar.gz"
DOWNLOAD_URL="https://cran.r-project.org/src/base/R-${R_MAJOR_VERSION}/${TARBALL}"

info "Downloading R $R_VERSION source code..."
if ! curl -f -O -L "$DOWNLOAD_URL"; then
    fatal "Failed to download $TARBALL. Check your internet connection or the R version number."
fi

info "Extracting..."
tar -xzf "$TARBALL"
cd "R-${R_VERSION}"

info "Configuring build (User-space: $PREFIX_DIR)..."
# Flags: User directory, build shared lib, link OpenBLAS, skip X11/GUI components
./configure --prefix="$PREFIX_DIR" \
            --enable-R-shlib || fatal "Configuration failed. Check the config.log above."
            #--without-x \
            #--with-blas="-lopenblas" \

info "Compiling R using $CORES threads..."
make -j"$CORES" || fatal "Compilation failed."

info "Installing to $PREFIX_DIR..."
make install || fatal "Installation failed."

# --- Phase 3: Linking & System Integration ---

info "Setting up symlinks in ~/.local/bin..."
mkdir -p "$HOME/.local/bin"

# Force symlinks to point to the newly installed version
ln -sf "$PREFIX_DIR/bin/R" "$HOME/.local/bin/R"
ln -sf "$PREFIX_DIR/bin/Rscript" "$HOME/.local/bin/Rscript"

# Check if ~/.local/bin is in PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    warn "~/.local/bin is NOT in your PATH. Add 'export PATH=\"\$HOME/.local/bin:\$PATH\"' to your ~/.bashrc or ~/.zshrc."
fi

# --- Phase 4: Post-Install R Configuration ---
# Bootstrap 'pak'
info "Bootstrapping 'pak' into the global library..."
# We use the absolute path to ensure we hit the exact R version we just built
"$PREFIX_DIR/bin/Rscript" -e 'if (!requireNamespace("pak", quietly = TRUE)) install.packages("pak")'

# --- Phase 5: Cleanup ---

info "Cleaning up temporary files..."
rm -rf "$WORK_DIR"

info "Installation complete! R $R_VERSION is now active."
"$HOME/.local/bin/R" --version | head -n 1
