# TongjiThesis
同济大学硕博士论文LaTeX模板。

目前已经和学校的word版本基本一致。

主要参考资料：
* [ThuThesis 2017/12/24 5.4.3](https://github.com/xueruini/thuthesis)
* [最新版本的TongjiThesis, 即Tongji LUG 2014年的RC2版](https://sourceforge.net/projects/tongjithesis/)。 以下用`老版`代指。
* [linxdcn](https://github.com/linxdcn/TongjiThesis)同学汇总的wildwolf(据zhouyuan说，wildwolf是同济汽车学院的老师)、[svandex](https://github.com/svandex/masthesis)、[zhao-chen](https://github.com/zhao-chen/TongjiThesis)的版本。[zhouyuan有本硕博版](https://github.com/zhouyuan/tongjithesis)。主要参考了这几位校友改的封面、摘要等部分，学习其页眉设置技巧。我最终使用了[fire-emblem](https://github.com/fire-emblem/)亲手提供的fancyhdr页眉设置代码，并将其与adapt自thuthesis的`\tongji@chapter`结合，从而实现很优雅的页眉设置方式。

## 一点微小的工作
### 页眉的坑
这个页眉问题耗了我三天时间。虽然有前人的代码可以借鉴，但总会碰到新坑的。
总结一下我花这么久才解决页眉的几个原因：
1. [linxdcn](https://github.com/linxdcn/TongjiThesis)汇总的版本虽然已经解决了页眉问题，但没有使用fancyhdr，我个人比较倾向于使用新事物哈哈（虽然fancyhdr已经很老了）。
2. [fire-emblem](https://github.com/fire-emblem/)给我的fancyhdr部分的设定只能部分work（当然他的模板基于book，而我这次的重构是基于ctexbook，他的fancyhdr部分的设置是能够在老版基于book的tongjithesis完美运行的。）。即对于使用newcommand定义的页面，如摘要和目录都能work。如果用environment定义的页面的话，则无法正确设置页眉。详细来说，举个例子，对于“主要符号对照表”，我们建了个denotation环境，也就是说这个页面只有一个environment，就不能正确在该页面显示页眉。
3. 历史的进程。

###  这个页眉问题如何解决的呢？
我试了好久，终于发现了解决方法，就是在每一个environment结束的时候加上一个`\clearpage`，详见[这个commit](https://github.com/marquistj13/TongjiThesis/commit/107dc2291b2466058864f6b0dba563cb9b95055b)
原理猜测：我也不知道原因啊，我只知道，像致谢部分、目录部分、摘要部分本质上都是`chapter`，虽然它们是`chapter*`。估计每一个chapter都要手动`\clearpage`？搞不懂啊。好了，不提这么细节的东西了，解决了就ok了。

### 粗体
使用xeCJK伪斜体实现黑体的加粗。

## 主要改动
相较于老版tongjithesis，我这个版本融合了thuthesis （ThuThesis 2017/12/24 5.4.3）的很多新改动，个人认为比较大的改动如下:
1. 加入更详尽的注释。我甚至将很多宏的用法用例子进行阐述，当然详细的注释主要集中在“宏展开”的部分。这就极大地方便了模板的阅读和理解，期待校友们更多地参与到对此模板的改进。
1. 老版基于book制作，新版基于ctexbook。
1. 老版字体基于xeCJK（adobe的字体），新版采用ctex宏集(目前参考的是2018/01/28 v2.4.12《ctex宏集手册》)自带的字体配置，比如在新版windows操作系统上，采用的是中易字库+ 微软雅黑。
1. 页面设置采用geometry宏包。
1. 使用kvoptions宏包，从而可以使用key-value input的方式设置class的option
1. 使用fancyhdr宏包设置页眉页脚
1. 修改了老版的许多错误参数（当年也许是对的）。
1. 章节标题的设置使用ctex宏集提供的`\ctexset`进行设置。
1. 使用较新的性能更强的宏包替代老宏包。如etoolbox引入了LATEX kernel commands的不同实现，但功能一样;xparse提供了更强的`\NewDocumentCommand`，以替代`\newcommand`;使用subcaption替代subfig，并使用subcaption进行浮动体参数的设定等。
1. chapter标题段前距离的修改

## 运行
本人使用Texlive2017发行版，xelatex 可以编译通过。

注：
1. 我照抄了清华版的Makefile，因此可以直接在命令行使用`make thesis`进行全自动编译（默认使用 latexmk 的方式生成 pdf，latexmk仍然调用xelatex）。在类Unix系统上很容易安装make命令。在windows系统上可以安装MinGW（装好之后，打开并安装最简明核心的`msys-base`，然后将其bin目录加到path中，如我的bin目录是 `C:\tools\mingw\msys\1.0\bin`，这样就能在 `cmd` 中使用 `make` 了）。另外，用latexmk貌似比较慢啊。
1. 如果提示缺少某字体，请自行下载安装到系统中（如果你用的是windows系统，可以搜索中易的对应字体下载，如中易隶书）。
1. 原则上pdflatex,lualatex都可以编译，但目测由于字体问题无法编译通过。暂时不管这个问题了，反正xelatex用着很爽。

