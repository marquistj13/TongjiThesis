## 改动
* 使用latex的标准book class `\LoadClass[12pt,a4paper,openany]{book}`
使用`ctexbook` `\LoadClass[a4paper,openany,UTF8,zihao=-4,scheme=plain]{ctexbook}`
* `\RequirePackage`部分主要参考自thuthesis
*  xparse 提供了LATEX2ε的\newcommand macro的一种高性能的替代，即 \NewDocumentCommand
* 去掉了tj的`\RequirePackage{hypernat}`,hypernat比较老了（2001年的），它的功能是使得natbib 的multiple sequential citations (e.g [3,2,1]) will be compressed to [1-3], where the '1' and the '3' are (color)linked to the bibliography.但现在不用这个hypernat也可以实现了，我推测是其他宏包自带了这些功能，不细细追究了。
* 使用geometry进行页面尺寸的设置。
* 将footskip设为0.54cm（原tj的为1.5cm）
* 去掉了所有`\if@openright`的判断，因为没这个需求。这样也能简化代码逻辑。
* 使用fancyhdr设置页眉页脚
* 原模板的图表字体用大五，现在改成了五号
* 并排图形。\pkg{subfigure}、\pkg{subfig} 已经不再推荐，用新的\pkg{subcaption}. 
需要注意的是，由于我们的新模板中使用了subcaption的浮动体的配置，并且加载了subcaption，就不能再加载subfig了（两个包有冲突），因此我们再也无法使用subfig提供的`\subfloat`命令了。不用这么悲伤，我们可以使用subcaption的`subcaptionbox`直接将其替换即可。同时注意标题在`subcaptionbox`中是必选参数，即用`{}`,而非`\subfloat`的`[]`
* 增加xeCJK伪斜体伪粗体选项。
* 关键词加粗
* chapter段前距离修改

##  要尝试的地方
* 使用ctex宏集的\zihao 代替\tongji@define@fontsize
* 清华的授权页支持扫描
`\includepdf{#1}`这个命令实现的，有机会可以用一下。


## 修改经验：一点微小的工作
### 页眉的坑
这个页眉问题耗了我三天时间。虽然有前人的代码可以借鉴，但总会碰到新坑的。
总结一下我花这么久才解决页眉的几个原因：
1. [linxdcn](https://github.com/linxdcn/TongjiThesis)汇总的版本虽然已经解决了页眉问题，但没有使用fancyhdr，我个人比较倾向于使用新事物哈哈（虽然fancyhdr已经很老了）。
2. [fire-emblem](https://github.com/fire-emblem/)给我的fancyhdr部分的设定只能部分work（当然他的模板基于book，而我这次的重构是基于ctexbook，他的fancyhdr部分的设置是能够在老版基于book的tongjithesis完美运行的）。即对于使用newcommand定义的页面，如摘要和目录都能work。如果用environment定义的页面的话，则无法正确设置页眉。详细来说，举个例子，对于“主要符号对照表”，我们建了个denotation环境，也就是说这个页面只有一个environment，就不能正确在该页面显示页眉。
3. 历史的进程。

###  这个页眉问题如何解决的呢？
我试了好久，终于发现了解决方法，就是在每一个environment结束的时候加上一个`\clearpage`，详见[这个commit](https://github.com/marquistj13/TongjiThesis/commit/107dc2291b2466058864f6b0dba563cb9b95055b)。
原理猜测：我也不知道原因啊，我只知道，像致谢部分、目录部分、摘要部分本质上都是`chapter`，虽然它们是`chapter*`。估计每一个chapter都要手动`\clearpage`？搞不懂啊。好了，不提这么细节的东西了，解决了就ok了。

### 粗体
使用xeCJK伪斜体实现黑体的加粗。

