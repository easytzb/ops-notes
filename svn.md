###SVN命令
	svn -c "/usr/local/svn/bin/svnserve -d -r /usr/local/svn/data"
	svn co svn://192.168.5.211/dj/StntsCms/trunk/v2 /webser/www/minisite --username='yangwei' --password='0220ygwi'
	tar cvfz changes.tar.gz  `svn diff -rM:N --summarize . | grep . | awk '{print $2}' | grep -E -v '^\.$'`

###只添加文件夹本身，不递归
	svn add example_folder -N

###取消svn add的文件或文件夹
	svn revert --recursive example_folder

###自动更新
	#!/bin/sh
	SVN=/webser/svn/bin/svn
	WEB=/webser/www/flow
	export LANG="zh_CN.GBK"
	$SVN update $WEB --username='hlk' --password='hengleike'

###忽略
	svn propedit svn:ignore ./
	
* 可以加*通配符如*.txt等
* 如果是文件夹，就写文件夹的名字，**不能在文件夹末尾加斜杠**
* 每个文件或者文件夹都独占一行
* 要忽略的对象都要在版本控制之外才行，如果已经在版本控制之内的文件要忽略就先导出，然后再从SVN版本控制中删除，最后再执行上面的操作

###更新仓库地址
	svn switch --relocate http://192.168.28.1/repos/test

###创建分支
	svn copy svn://server/path/to/trunk svn://server/path/to/branch/newBranch -m "Cut branch: newBranch"
	svn copy svn://120.25.221.142/web/trunk svn://120.25.221.142/web/branches/2.2.1 -m 'new branch 2.2.1'

###svn合并
一个更好的名称应该是svn diff-and-apply，这是发生的所有事件：首先两个版本库树比较，然后将区别应用到本地拷贝。

这个命令包括三个参数：

* 初始的版本树(通常叫做比较的左边)
* 最终的版本树(通常叫做比较的右边)
* 一个接收区别的工作拷贝(通常叫做合并的目标)

一旦这三个参数指定以后，两个目录树将要做比较，比较结果将会作为本地修改应用到目标工作拷贝，当命令结束后，结果同你手工修改或者是使用svn add或svn delete没有什么区别，如果你喜欢这结果，你可以提交，如果不喜欢，你可以使用svn revert恢复修改。

svn merge的语法允许非常灵活的指定三个必要的参数，如下是一些例子：

	svn merge svn://120.25.221.142/web/branches/2.3.0@2275  svn://120.25.221.142/web/branches/2.3.0@2346 my-working-copy --dry-run
	$svn merge -r 100:200 http://svn.example.com/repos/trunk my-working-copy
	$svn merge -r 100:200 http://svn.example.com/repos/trunk

第一种语法使用URL@REV的形式直接列出了所有参数，第二种语法可以用来作为比较同一个URL的不同版本的简略写法，最后一种语法表示工作拷贝是可选的，如果省略，默认是当前目录。

--dry-run 预览合并


###参考链接
[分支与合并](https://i18n-zh.googlecode.com/svn/www/svnbook-1.4/svn.branchmerge.copychanges.html)
