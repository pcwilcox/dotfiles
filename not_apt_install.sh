#!/bin/bash -e

GITDIR="${HOME}/git"
LOG="${HOME}/.dotfiles/install_log"

. notices

clone_if_missing()
{
	TARGETDIR=$2
	if [ -d "$TARGETDIR" ]; then
		pushd "$TARGETDIR"
		git pull
	else
		clone_if_missing "$1" "$TARGETDIR"
		pushd "$TARGETDIR"
	fi
}

bot "Installing non-packaged things now"

running "Installing universal-ctags..."
clone_if_missing git@github.com:universal-ctags/ctags.git "${GITDIR}"/ctags > "$LOG" 2>&1 \
	&& pushd "${GITDIR}"/ctags >> "$LOG" 2>&1 \
	&& ./autogen.sh  >> "$LOG" 2>&1 \
	&& ./configure --prefix=/usr/local >> "$LOG" 2>&1 \
	&& make  >> "$LOG" 2>&1 \
	&& sudo make install >> "$LOG" 2>&1 \
	&& popd >> "$LOG" 2>&1 \
	|| error "couldn't install ctags"
ok

running "Installing has..."
clone_if_missing git@github.com:kdabir/has.git "${GITDIR}"/has >> "$LOG" 2>&1 \
	&& pushd "${GITDIR}"/has >> "$LOG" 2>&1 \
	&& sudo make install >> "$LOG" 2>&1 \
	&& popd >> "$LOG" 2>&1 \
	|| error "couldn't install has"
ok

running "Installing bats..."
clone_if_missing git@github.com:bats-core/bats-core.git "${GITDIR}"/bats-core >> "$LOG" 2>&1 \
	&& pushd "${GITDIR}"/bats-core >> "$LOG" 2>&1 \
	&& ./install.sh $HOME >> "$LOG" 2>&1 \
	&& popd >> "$LOG" 2>&1 \
	|| error "couldn't install bats"
ok

running "Installing diff-so-fancy..."
clone_if_missing git@github.com:so-fancy/diff-so-fancy.git "${GITDIR}"/diff-so-fancy >> "$LOG" 2>&1 \
	&& cp -u "${GITDIR}"/diff-so-fancy/diff-so-fancy $HOME/bin/diff-so-fancy >> "$LOG" 2>&1 \
	|| error "couldn't install diff-so-fancy"
ok

running "Installing emojify..."
sudo sh -c "curl https://raw.githubusercontent.com/mrowa44/emojify/master/emojify -o /usr/local/bin/emojify && chmod +x /usr/local/bin/emojify" >> "$LOG" 2>&1 \
	|| error "couldn't install emojify"
ok

running "Installing exercism..."
pushd "$GITDIR" >> "$LOG" 2>&1 \
	&& mkdir -p exercism >> "$LOG" 2>&1 \
	&& pushd exercism >> "$LOG" 2>&1 \
	&& wget https://github.com/exercism/cli/releases/download/v3.0.13/exercism-3.0.13-linux-x86_64.tar.gz >> "$LOG" 2>&1 \
	&& tar -xvzf exercism-3.0.13-linux-x86_64.tar.gz >> "$LOG" 2>&1 \
	&& mv exercism "$HOME/bin/exercism" >> "$LOG" 2>&1 \
	&& popd && popd \
	|| error "couldn't install exercism"
ok

running "Installing rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh >> "$LOG" 2>&1 \
	|| error "couldn't install rust"
ok

running "Installing starship..."
curl -fsSL https://starship.rs/install.sh | bash >> "$LOG" 2>&1 \
	|| error "couldn't install starship"
ok

running "Installing ripgrep..."
cargo install ripgrep >> "$LOG" 2>&1 p
ok

running "Installing node..."
curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash - sudo apt-get install -y nodejs >> "$LOG" 2>&1 \
	|| error "couldn't install node"
ok
