#GPG_VERSION=gnupg-2.2.3
all:
	#curl -o ${GPG_VERSION}.tar.bz2 -SL "https://gnupg.org/ftp/gcrypt/gnupg/${GPG_VERSION}.tar.bz2"
	#curl -o ${GPG_VERSION}.tar.bz2.sig -SL "https://gnupg.org/ftp/gcrypt/gnupg/${GPG_VERSION}.tar.bz2.sig"
	wget "https://gnupg.org/ftp/gcrypt/gnupg/${GPG_VERSION}.tar.bz2"
	wget "https://gnupg.org/ftp/gcrypt/gnupg/${GPG_VERSION}.tar.bz2.sig"
	tar xf ${GPG_VERSION}.tar.bz2
	ln -s ${GPG_VERSION} gpg
	cd ${GPG_VERSION} && make -f build-aux/speedo.mk native INSTALL_PREFIX=/usr/local -j4
	ldconfig

.PHONY: all
