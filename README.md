# TongjiThesis
## 总览
同济大学硕博士论文LaTeX模板。

效果预览：请到[这里下载PDF](https://github.com/marquistj13/TongjiThesis/releases/latest)。
注意：由于我们不经常打tag，因此release界面往往不是最新的，请在本页面下载最新模板。

本次修改的发起者：
* [marquistj13](https://github.com/marquistj13)
* [CNchence](https://github.com/CNchence)
* [Wenda](https://github.com/Williamwenda)

贡献者列表:[请点击这里](https://github.com/marquistj13/TongjiThesis/graphs/contributors)。

主要参考资料：
* [ThuThesis 2017/12/24 5.4.3](https://github.com/xueruini/thuthesis)
* [老版的TongjiThesis, 即Tongji LUG 2014年的RC2版](https://sourceforge.net/projects/tongjithesis/)。 以下用`老版`代指。
* [linxdcn](https://github.com/linxdcn/TongjiThesis)同学汇总的wildwolf、[svandex](https://github.com/svandex/masthesis)、[zhao-chen](https://github.com/zhao-chen/TongjiThesis)的版本。[zhouyuan有本硕博版](https://github.com/zhouyuan/tongjithesis)。主要参考了这几位校友改的封面、摘要等部分，学习其页眉设置技巧。我最终使用了[fire-emblem](https://github.com/fire-emblem/)亲手提供的fancyhdr页眉设置代码，并将其与adapt自thuthesis的`\tongji@chapter`结合，从而实现很优雅的页眉设置方式。
* 各种LaTex宏包的文档。


## 如何运行
使用 Texlive2018 发行版，并更新其自带的`biblatex-gb7714-2015`宏包，否则无法使用。

>推荐下载最新版的Texlive。  
由于本模板参考文献部分依赖`biblatex-gb7714-2015`宏包的2018版本，因此最好安装Texlive最新版，Texlive2018 自带的`biblatex-gb7714-2015`宏包依然较老，推荐使用其包管理器更新此宏包，如若更新失败（我更新了好几次都失败了，它还把我的这个宏包给删了，郁闷），那么可按照 [官方页面](https://github.com/hushidong/biblatex-gb7714-2015) 的安装介绍，在你的tex安装目录搜索`biblatex-gb7714-2015`文件夹，将该文件夹中的四个文件替换为[官方页面](https://github.com/hushidong/biblatex-gb7714-2015) 提供的文件即可。

注：
1. 基本的编译步骤是：`tex,biber,tex,tex`(这里的tex替换成你常用的`tex`，如`xelatex`)。一般的前端都可以定制成一键运行这些步骤，如emacs的`C-c C-a`，vscode的 LaTeX Workshop 插件，WinEdt自带的编译按键等。
1. 首选`xelatex`编译，次选`pdflatex`，`lualatex`貌似也能用。
1. 使用`xelatex`时，如果提示缺少某字体，请自行下载安装到系统中（如果你用的是windows系统，可以搜索中易的对应字体下载，如中易隶书）。

## 实用技能 以及 注意事项
__免责声明：__ 以下内容不属于本模板的主要维护范畴，如对以下内容有任何疑问，请自行搜索解决，请勿提issue，谢谢。
### 关于 author year 的引用
默认使用数字上标的引用格式，若想使用author-year格式，可在cls文件中搜索biblatex，按照该处的说明进行修改。

>_注意：_ 学校word模板中的author-year格式在正文中是符合国标的，但参考文献列表明显是numeric的，这么混用不能忍啊！本模板严格遵循国标，如对此有疑问，请通过借酒消愁等方式解决。

### 关于参考文献bib的生成
推荐使用 Zotero 进行文献管理和bib生成，其中bib的生成推荐使用 Zotero 的 `Better Bib(La)TeX` 插件。
如果你也用zotero管理文献的话，可以参考 [这里](https://marquistj13.github.io/MyBlog/2018/05/zotero-export/#%E8%B0%83%E6%95%99better-bibtex-%E6%8F%92%E4%BB%B6%E7%94%9F%E6%88%90%E7%9A%84bib%E6%96%87%E4%BB%B6%E7%9A%84field) 的文献库导出设置，这样就可以方便地将bib文件的language域删掉或另行处理，（很久以前需要删掉这个language域，现在不确定是否需要删，没时间测试了，诸位自行定夺）。

## 本模板对老模板的主要改动
相较于老版tongjithesis，我这个版本融合了thuthesis （ThuThesis 2017/12/24 5.4.3）的很多新改动，个人认为比较大的改动如下:
1. 加入更详尽的注释。我甚至将很多宏的用法用例子进行阐述，当然详细的注释主要集中在“宏展开”的部分。这就极大地方便了模板的阅读和理解，期待校友们更多地参与到对此模板的改进。
1. 老版基于book制作，新版基于ctexbook。
1. 新版采用ctex宏集(`目前参考的是2018/01/28 v2.4.12《ctex宏集手册》`)自带的字体配置，比如在新版windows操作系统上，采用的是中易字库+ 微软雅黑。
1. 页面设置采用geometry宏包。
1. 使用kvoptions宏包，从而可以使用key-value input的方式设置class的option
1. 使用fancyhdr宏包设置页眉页脚
1. 修改了老版的许多错误参数（当年也许是对的）。
1. 章节标题的设置使用ctex宏集提供的`\ctexset`进行设置。
1. 使用较新的性能更强的宏包替代老宏包。如etoolbox引入了LATEX kernel commands的不同实现，但功能一样;xparse提供了更强的`\NewDocumentCommand`，以替代`\newcommand`;使用subcaption替代subfig，并使用subcaption进行浮动体参数的设定等。
1. chapter标题段前距离的修改
1. 各级标题上下间隙调整
1. 增加degreetype选项
1. 使用biblatex包实现参考文献的引用
1. 增加author-year的引用。
