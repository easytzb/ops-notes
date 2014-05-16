###vim 配置文件修改方式
	vim /etc/vimrc
	//或者
	vim ~/.vimrc

###配置
	let $LANG="zh_CN.UTF-8"
	set fileencodings=utf-8,chinese,latin-1
	set termencoding=utf-8
	set fileencoding=utf-8
	set encoding=utf-8
	set number

###Ctags
[下载ctags](http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz) @ [http://ctags.sourceforge.net/](http://ctags.sourceforge.net/)

		wget http://prdownloads.sourceforge.net/ctags/ctags-5.8.tar.gz
		tar zxf ctags-5.8.tar.gz
		cd ctags-5.8
		./configure
		make
		make install

###tagbar
[下载tagbar.vmb](http://www.vim.org/scripts/download_script.php?src_id=21362) @ [vim.org](http://www.vim.org/scripts/script.php?script_id=3465)

安装

		vim tagbar.vmb
		:so % 
		:q

start

		:TagbarToggle

###tagbar-phpctags

	git clone https://github.com/vim-php/tagbar-phpctags.vim.git
	cd tagbar-phpctags.vim
	make
	mv bin/phpctags /PATH/TO/
	echo "let g:tagbar_phpctags_bin='PATH_TO_phpctags'">>/etc/vim/vimrc