# Use GNU stow to link dotfiles into home folder

set -e

if ! command -v stow > /dev/null 2>&1; then
    echo "install GNU stow to link dotfiles"
    exit 1
fi

if [ $# -ne 1 ]; then
    echo "usage: $0 <home|work>"
    exit 1
fi

if [ $1 = "home" ]; then
    stow home
elif [ $1 = "work" ]; then
    stow work
else
    echo "usage: $0 <home|work>"
fi
