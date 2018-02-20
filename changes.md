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

##  要改的地方：
* 目录字体
```
% 打开默认选项
% 注意我们的目录不是清华的arial 字体，此处要改。
\kvsetkeys{tongji}{
  raggedbottom,
  arialtitle}
```
* 图标的标题要求单倍行距
探索：
```
\def\tongji@define@fontsize#1#2{%
  \expandafter\newcommand\csname #1\endcsname[1][1.3]{%
    \fontsize{#2}{##1\dimexpr #2}\selectfont}}
```
定义了`\tongji@define@fontsize{wuhao}{10.5bp}`之后,\wuhao[1]是不是单倍行距？
thu的图表部分设的数值是1.5表示单倍行距。
https://liam0205.me/2013/10/17/LaTeX-Linespace/  这里介绍了行距的概念，但要求用宏包。
http://bbs.ctex.org/forum.php?mod=viewthread&tid=41619 这里说1.5就是word的单倍行距。
下面这个链接：https://tex.stackexchange.com/questions/13742/what-does-double-spacing-mean
有讨论，有空看看。
* 章节标题具体设置在.cfg中，但各级标题的具体字号设置仍需核实（在cls中）,行距也是需要核实。
* 目录中的章标题，清华的是黑体小四，咱的是宋体小四，怎么改？

##  要尝试的地方
* 使用ctex宏集的\zihao 代替\tongji@define@fontsize
* 清华的授权页支持扫描
`\includepdf{#1}`这个命令实现的，有机会可以用一下。
* 图索引，同济的少了个\addvspace{6bp}