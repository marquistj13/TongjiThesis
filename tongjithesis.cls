\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{tongjithesis}
[2018/02/15 2 Tongji University Thesis Template]
\hyphenation{Tongji-Thesis}
% \textsc 将所有字符大写。用于强调。
\def\tongjithesis{\textsc{TongjiThesis}}
\def\version{2}


\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=tongji,
  prefix=tongji@,
  setkeys=\kvsetkeys}

\newif\iftongji@master
\newif\iftongji@doctor
\define@key{tongji}{degree}{%
  \tongji@masterfalse
  \tongji@doctorfalse
  \expandafter\csname tongji@#1true\endcsname}

% 数字式引用 以及 作者-年份引用
\newif\iftongji@numeric
\tongji@numerictrue % 默认为数字式引用
\newif\iftongji@authoryear
\define@key{tongji}{bibtype}{%
  \tongji@numericfalse
  \tongji@authoryearfalse
  \expandafter\csname tongji@#1true\endcsname}

% 学术型|专业型|同等学力
\newif\iftongji@academic
\tongji@academictrue % 默认为学术型
\newif\iftongji@profession
\newif\iftongji@equaleducation
\define@key{tongji}{degreetype}{%
  \tongji@academicfalse
  \tongji@professionfalse
  \tongji@equaleducationfalse
  \expandafter\csname tongji@#1true\endcsname}


% 封面的electronic选项（打印时删除）
\DeclareBoolOption{electronic}
% 论文是否保密
\DeclareBoolOption{secret}%
% 目录中英文是否用 Times new roman 字体（默认关闭）
%\DeclareBoolOption{romantoc}
% 章节标题中的英文以及标号是否用 Times new roman 字体（默认打开）

\DeclareBoolOption{romantitle}
\IfFileExists{/dev/null}{}{\PassOptionsToClass{fontset=windowsold}{ctexbook}}  %simhei字体

% 以往，为LATEX 文档配置中文支持是一件相当繁琐的事情。默认情况下，CTEX 宏集能自
% 动检测用户使用的编译方式和操作系统，选择合适的底层支持和字库，从而简化配置过程。
% 在Windows Vista 及以后的Windows 操作系统上，采用的是中易字库+ 微软雅黑。
% CTEX 宏集预定义的中文字库还定义了一些字体命令。
% \songti，\heiti，\fangsong，\kaishu，\lishu，\youyuan，\yahei
% 等价的，CJK命令为\CJKfamily{zhsong}等。


% \option{raggedbottom} 选项（默认打开）
% \raggedbottom 是tex的。如果没有调用\raggedbottom，那么tex就会尽量使得所有page的bottom margins相等，而这个命令就是告诉tex不要这么搞，即我们允许不同page的bottom margins不一样。这个设定在我们不希望一大段材料跨页的时候很重要。.  
\DeclareBoolOption{raggedbottom}
%
% 在脚注标记中使用 \pkg{pifont} 的带圈数字（默认打开），此选项生成的带圈数字更漂亮。
\DeclareBoolOption{pifootnote}
%
% 将选项传递给 \pkg{ctexbook}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}

% 打开默认选项。
\kvsetkeys{tongji}{
  raggedbottom,
  pifootnote,
  romantitle}

% 解析用户传递过来的选项，并加载 \pkg{ctexbook}。
% 强制指定一个degree选项。
\ProcessKeyvalOptions*
  \iftongji@master\relax\else
    \iftongji@doctor\relax\else
        \ClassError{tongjithesis}%
                   {Please specify thesis degree in option: \MessageBreak
                    degree=[master | doctor]}{}      
    \fi
  \fi
% 杜绝非法的degreetype选项。
\iftongji@academic\relax\else
  \iftongji@profession\relax\else
    \iftongji@equaleducation\relax\else
        \ClassError{tongjithesis}{Unknown degree type option.\MessageBreak Please check your degree type option, good luck!}{}  
    \fi
  \fi
\fi
% 杜绝非法的bibtype选项。
\iftongji@numeric\relax\else
  \iftongji@authoryear\relax\else    
      \ClassError{tongjithesis}{Unknown bib type option.\MessageBreak Please check your bib type option, good luck!}{}  
   \fi
\fi

% 使用 \XeTeX\ 引擎时，\pkg{fontspec} 宏包会被 \pkg{xeCJK} 自动调用。传递
% 给 \pkg{fontspec} 宏包 \option{no-math} 选项，避免部分数学符号字体自动调整
% 为 CMR。其他引擎下没有这个问题，这一行会被无视。
\PassOptionsToPackage{no-math}{fontspec}

% , 设置 Times New Roman，Helvetic.
% 这是txfonts的替代品，即txfonts.sty分成了俩独立的package：newtxtext 和 newtxmath
\RequirePackage[defaultsups]{newtxtext}
\RequirePackage{newtxmath}

%将伪粗体与伪斜体的选项传递给xeCJK package
\PassOptionsToPackage{AutoFakeBold=1.2,AutoFakeSlant}{xeCJK}
% 使用 \CTeX\ 宏宝的默认中文字体配置，支持不同引擎
\LoadClass[a4paper,openany,UTF8,zihao=-4,scheme=plain]{ctexbook}

% etoolbox 引入了LATEX kernel commands的不同实现，但功能一样。
\RequirePackage{etoolbox}

% 提供了一个\ifxetex 判断命令，用于判断是否运行在xetex模式。
% 科普一下，我们使用xelatex，其实也是调用的xetex，只是预加载了LaTeX format，而
% xetex预加载的是plain tex。xetex的特性：Unicode input and right-to-left typesetting。
% 关于各种tex的简单区别详见：https://tex.stackexchange.com/questions/296616/questions-regarding-the-distinction-between-xetex-and-xelatex-and-how-they-relat/296623
\RequirePackage{ifxetex}

% xparse 提供了LATEX2ε的\newcommand macro的一种高性能的替代，即 \NewDocumentCommand
% 详见此处介绍：https://www.texdev.net/2010/05/23/from-newcommand-to-newdocumentcommand/
\RequirePackage{xparse}

% \AmSTeX\ 宏包，用来排出更加漂亮的公式。
\RequirePackage{amsmath,amssymb}

% 使用 Courier 字体
\RequirePackage{courier}

% 图形支持宏包
\RequirePackage{graphicx}

%  并排图形。\pkg{subfigure}、\pkg{subfig} 已经不再推荐，用新的 \pkg{subcaption}。
%  注意subfig是subfigure的替代，它们都是用来broke a figure into subfigures, 老同济模板中用的\subfloat命令就是来自，subfig。
% 但subfig很久没维护了，因此该用较新的subcaption 
\RequirePackage[labelformat=simple]{subcaption}

% \pkg{pdfpages} 宏包便于我们插入扫描后的授权页和声明页 PDF 文档。
\RequirePackage{pdfpages}
\includepdfset{fitpaper=true}

% 更好的列表环境。三个基本的list environments：enumerate, itemize and description增加很多选项，自由度更大。
\RequirePackage[shortlabels]{enumitem}
%  environ使得我们在创建新的环境的时候可以定义new author interface
\RequirePackage{environ}

% This package suppresses page numbers and headings from appearing on empty pages. 例如 \cleardoublepage 创建的空白页。
\RequirePackage{emptypage} 

% 禁止 \LaTeX 自动调整多余的页面底部空白，并保持脚注仍然在底部。
% 脚注按页编号。
\iftongji@raggedbottom
  \RequirePackage[bottom,perpage,hang]{footmisc}
  \raggedbottom
\else
  \RequirePackage[perpage,hang]{footmisc}
\fi
% pifont有很多Pi fonts，如Dingbats（杂锦字体）, Symbol, etc
\iftongji@pifootnote
  \RequirePackage{pifont}
\fi

% 利用 \pkg{CJKfntef} 实现汉字的下划线和盒子内两段对齐，并可以避免
% \cs{makebox}\oarg{width}\oarg{s} 可能产生的 underful boxes。
\RequirePackage{CJKfntef}

% 定理类环境宏包，其中 \pkg{amsmath} 选项用来兼容 \AmSTeX\ 的宏包
\RequirePackage[amsmath,thmmarks,hyperref]{ntheorem}

% 表格控制
\RequirePackage{array}
\RequirePackage{longtable}
% 使用三线表：\cs{toprule}，\cs{midrule}，\cs{bottomrule}。
\RequirePackage{booktabs}

% 参考文献引用宏包。使用biblatex包
\iftongji@numeric
  \RequirePackage[backend=biber,style=gb7714-2015,gbpub=false,isbn=false,doi=false,gbtitlelink=true,url=false,sortlocale=zh__pinyin]{biblatex} 
\else
  \iftongji@authoryear % 若需使用author-year格式的文献引用，可将style选择为：gb7714-2015ay
    \RequirePackage[backend=biber,style=gb7714-2015ay,gbpub=false,isbn=false,doi=false,gbtitlelink=true,url=false,sortlocale=zh__pinyin]{biblatex} 
  \fi
\fi
% 参考文献宏包的其他选项：
% gbpub=false :用于去除参考文献中的出版地不详、出版者不详等信息
% 后边 isbn 和 doi 选项同理

% 生成有书签的 pdf 及其开关，请结合 gbk2uni 避免书签乱码。
\RequirePackage{hyperref}
\ifxetex
  \hypersetup{%
    CJKbookmarks=true}
\else
  \hypersetup{%
    unicode=true,
    CJKbookmarks=false}
\fi
\hypersetup{%
  linktoc=all,
  bookmarksnumbered=true,
  bookmarksopen=true,
  bookmarksopenlevel=1,
  breaklinks=true,
  colorlinks=false,
  plainpages=false,
  pdfpagelabels, %将\thepage写入pdf，使得阅读器可以显示‘ii (4 of 40)’ rather than simply ‘4 of 40’. 貌似不设这个选项也行？
  pdfborder=0 0 0}
% 设置 url 样式，与上下文一致
\urlstyle{same}

% 页面设置
\RequirePackage{geometry}
\geometry{
	a4paper, % 210 * 297mm
	hcentering,%将hmarginratio设为1:1，即left=right
	ignoreall,%body部分不包含top,bottom,left,right，即textheight就是正文的高度。
	textheight=246.2mm,%297-25.4x2
	bottom=25.4mm,
	nomarginpar,%即\marginparwidth=0pt and \marginparsep=0pt
	left=31.7mm,%注意left=right
	headheight=5mm,
	headsep=5.4mm,	%页眉距顶端要求2cm。即25.4-20=5.4
	footskip=5.4mm}	%\footskip指的是baseline of last line of text andbaseline of footer的距离

% 利用 \pkg{fancyhdr} 设置页眉页脚
\RequirePackage{fancyhdr}

% 正文小四号 (12bp) 字，行距为固定值 20 bp
\renewcommand\normalsize{%
  \@setfontsize\normalsize{12bp}{20bp}%
  \abovedisplayskip=10bp \@plus 2bp \@minus 2bp %\abovedisplayskip用来调整math相关的skip，其它三个也是同样的功能。其解释详见The texbook
  \abovedisplayshortskip=10bp \@plus 2bp \@minus 2bp
  \belowdisplayskip=\abovedisplayskip
  \belowdisplayshortskip=\abovedisplayshortskip}
% \fontsize的内部实现就是：
% \DeclareRobustCommand{\fontsize}[2]{\set@fontsize \baselinestretch {#1}{#2}}
% 而\@setfontsize具有三个参数，对于我们上面的用法\@setfontsize\normalsize{12bp}{20bp}
% 展开为：
% \@nomath\normalsize
% \ifx\protect\@typeset@protect\let\@currsize\normalsize\fi
% \fontsize{12bp}{20bp}\selectfont
% 第一行确保LaTeX to disallow \normalsize in math mode。
% 第二行将\@currsize设为\normalsize，第三行调用\fontsize，字体12bp，行距20bp
% 以上解释来自：https://tex.stackexchange.com/questions/112492/setfontsize-vs-fontsize

% 根据习惯定义字号。
\def\tongji@define@fontsize#1#2{%
  \expandafter\newcommand\csname #1\endcsname[1][1.3]{%
    \fontsize{#2}{##1\dimexpr #2}\selectfont}}
% \fontsize{size}{skip} 其中，skip就是行之间的baseline to baseline的距离，即行距。
% \selectfont 用来使得字体的配置生效
% 关于 #1 \dimexpr #2,其实就是#1 和 #2相乘。其中\dimexpr来自etex，而目前的tex基本上都自带了etex的高效实现来替代原tex（来源请求）。
% 以上的例子我们用\tongji@define@fontsize{chuhao}{42bp}展开就是这样：
% \newcommand \chuhao [1][1.3]{\fontsize{42bp}{#1\dimexpr 42bp}\selectfont}}
% 其中，[1][1.3]表示只有一个参数，该参数默认为1.3
\tongji@define@fontsize{chuhao}{42bp}
\tongji@define@fontsize{xiaochu}{36bp}
\tongji@define@fontsize{yihao}{26bp}
\tongji@define@fontsize{xiaoyi}{24bp}
\tongji@define@fontsize{erhao}{22bp}
\tongji@define@fontsize{xiaoer}{18bp}
\tongji@define@fontsize{sanhao}{16bp}
\tongji@define@fontsize{xiaosan}{15bp}
\tongji@define@fontsize{sihao}{14bp}
\tongji@define@fontsize{banxiaosi}{13bp}
\tongji@define@fontsize{xiaosi}{12bp}
\tongji@define@fontsize{dawu}{11bp}
\tongji@define@fontsize{wuhao}{10.5bp}
\tongji@define@fontsize{xiaowu}{9bp}
\tongji@define@fontsize{liuhao}{7.5bp}
\tongji@define@fontsize{xiaoliu}{6.5bp}
\tongji@define@fontsize{qihao}{5.5bp}
\tongji@define@fontsize{bahao}{5bp}

% 定义页眉和页脚。
% 定义三种页眉页脚格式：
% \begin{itemize}
% \item \texttt{tongji@empty}：页眉页脚都没有
% \item \texttt{tongji@plain}：只显示页脚的页码。\cs{chapter} 自动调用
% \cs{thispagestyle\{tongji@plain\}}。
% \item \texttt{tongji@headings}：页眉页脚同时显示
% \end{itemize}
\fancypagestyle{tongji@empty}{%
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}
  }
\fancypagestyle{tongji@plain}{%
  \fancyhead{}
  \fancyfoot[C]{\songti\wuhao\thepage}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}}
\fancypagestyle{tongji@headings}{%
  \fancyhead{}
  \fancyhead[RO]{\wuhao\songti\leftmark}
  \fancyhead[LE]{\wuhao\songti\tongji@schoolname~\tongji@capply~\tongji@cheadingtitle}
  \fancyfoot{}
  \fancyfoot[C]{\songti\wuhao\thepage}
  \renewcommand{\headrulewidth}{0.4pt}
  \renewcommand{\footrulewidth}{0pt}}


\renewcommand\frontmatter{%
  \clearpage
  \@mainmatterfalse
  \pagenumbering{Roman}
  \pagestyle{tongji@empty}
  }
% 注意\mainmatter的heading设置除了在这设以外，还需要在下面的\ctexset的pagestyle域进行设置。
\renewcommand\mainmatter{%
  \cleardoublepage %强迫第一章的首页从右边开始，在双面打印中，即奇数页在右边。
  \@mainmattertrue
  \pagenumbering{arabic}
  \pagestyle{tongji@headings}
  % \renewcommand\thesection{\arabic{chapter}.\ \arabic{section}}                                                      %各级标题以及图标序号格式修改（增加序号中点后的空格）
  % \renewcommand\thesubsection{\arabic{chapter}.\ \arabic{section}.\ \arabic{subsection}}
  % \renewcommand\thesubsubsection{\arabic{chapter}.\ \arabic{section}.\ \arabic{subsection}.\ \arabic{subsubsection}}
  % \renewcommand\thefigure{\arabic{chapter}.\ \arabic{figure}}
  % \renewcommand\thetable{\arabic{chapter}.\ \arabic{table}}
  }
\renewcommand\backmatter{%
  \clearpage
  \@mainmattertrue
  % \renewcommand\thesection{\Alph{chapter}.\ \arabic{section}}                                                      %附录中的chapter需要使用英文标号
  % \renewcommand\thesubsection{\Alph{chapter}.\ \arabic{section}.\ \arabic{subsection}}
  % \renewcommand\thesubsubsection{\Alph{chapter}.\ \arabic{section}.\ \arabic{subsection}.\ \arabic{subsubsection}}
  % \renewcommand\thefigure{\Alph{chapter}.\ \arabic{figure}}
  % \renewcommand\thetable{\Alph{chapter}.\ \arabic{table}}
  }


% 全文首行缩进 2 字符，标点符号用全角
\ctexset{%
  punct=quanjiao,
  space=auto,
  autoindent=true}
% \ctexset的详细介绍见《ctex宏集手册》，我现在看的是2018/01/28 v2.4.12
% 它有很多实用选项，如chapter/name = {第,章},section/name = {\S},

% 利用 \pkg{enumitem} 命令调整默认列表环境间的距离，以符合中文习惯。
\setlist{nosep}

% 脚注符合中文习惯，数字带圈。
% 生成带圈的脚注数字，最多处理到 10。
\def\tongji@textcircled#1{%
  \ifnum\value{#1} >9
    \ClassError{tongjithesis}%
      {Too many footnotes in this page.}{Keep footnote less than 10.}
  \fi
  \iftongji@pifootnote%
    \ding{\the\numexpr\value{#1}+171\relax}%
  \else%
    \textcircled{\xiaoliu\arabic{#1}}%
  \fi}
\renewcommand{\thefootnote}{\tongji@textcircled{footnote}}
\renewcommand{\thempfootnote}{\tongji@textcircled{mpfootnote}}
% 关于footnote marking的更改，可以参考：https://en.wikibooks.org/wiki/LaTeX/Footnotes_and_Margin_Notes		
% 定义脚注分割线，字号（宋体小五），以及悬挂缩进（1.5字符）。
\def\footnoterule{\vskip-3\p@\hrule\@width0.3\textwidth\@height0.4\p@\vskip2.6\p@}
\let\tongji@footnotesize\footnotesize
\renewcommand\footnotesize{\tongji@footnotesize\xiaowu[1.5]}
\footnotemargin1.5em\relax
% \cs{@makefnmark} 默认是上标样式，而在脚注部分要求为正文大小。利用\cs{patchcmd}
% 动态调整 \cs{@makefnmark} 的定义
\let\tongji@makefnmark\@makefnmark
\def\tongji@@makefnmark{\hbox{{\normalfont\@thefnmark}}}
\pretocmd{\@makefntext}{\let\@makefnmark\tongji@@makefnmark}{}{}
\apptocmd{\@makefntext}{\let\@makefnmark\tongji@makefnmark}{}{}

% 允许太长的公式断行、分页等。
\allowdisplaybreaks[4]
\renewcommand\theequation{\ifnum \c@chapter>\z@ \thechapter.\fi\@arabic\c@equation}

% 公式距前后文的距离由 4 个参数控制，参见 \cs{normalsize} 的定义
% 定理标题使用黑体，正文使用宋体，冒号隔开。
% 定理环境格式设置（环境标题和环境正文字体设置）统一放置到 .cfg 文件中


% 设置浮动对象和文字之间的距离
% 语法举例：{10pt plus 1.0pt minus 2.0pt} The plus and minus parts allow the space to stretch or shrink (the greater they are, the more it stretches or shrinks when needed).
\setlength{\floatsep}{12bp \@plus4pt \@minus1pt} %vertical distance between two floats
\setlength{\intextsep}{12bp \@plus4pt \@minus2pt} % distance between floats inserted inside the page text (using h) and the text proper. 即，对于插入正文中的float，这个\intextsep指的是图片上部和下部距离正文的距离。
\setlength{\textfloatsep}{12bp \@plus4pt \@minus2pt}%  distance between floats on the top or the bottom and the text
% 注：清华的都设为20bp了，而不是12bp，我们tj的更紧凑一些。
\setlength{\@fptop}{0bp \@plus1.0fil}
\setlength{\@fpsep}{12bp \@plus2.0fil}
\setlength{\@fpbot}{0bp \@plus1.0fil}


% 下面这组命令使浮动对象的缺省值稍微宽松一点，从而防止浮动对象占据过多的文本页面，
% 也可以防止在很大空白的浮动页上放置很小的图形。
\renewcommand{\textfraction}{0.15} %即，一个page的text的最小比例是0.15，默认是0.2。当然如果浮动对象占的比例太大，就会移到另一个页面。
\renewcommand{\topfraction}{0.85} %页面顶部至多有0.85的空间被浮动对象填充。
\renewcommand{\bottomfraction}{0.65}%同理，这个是底部的。
\renewcommand{\floatpagefraction}{0.60}%一个float page(a page containing no text,
% only floats.)被浮动对象占的比例最少是0.6


% 定制浮动图形和表格标题样式
% 图表标题字体为宋体五号
% 去掉图表号后面的冒号。图序与图名文字之间空一个汉字符宽度。
% 图：caption 在下，段前空 6 磅，段后空 12 磅，单倍行距
% 表：caption 在上，段前空 6 磅，段后空 6 磅，单倍行距
% 不管 caption 出现在什么位置，\cs{aboveskip} 总是出现在标题和浮动体之间的距离
\let\old@tabular\@tabular
\def\tongji@tabular{\wuhao[1.5]\old@tabular}
% 注：\DeclareCaptionLabelFormat 来自subcaption包。
\DeclareCaptionLabelFormat{tongji}{{\wuhao[1.5]\normalfont #1~#2}}
\DeclareCaptionLabelSeparator{tongji}{\hspace{1em}}
\DeclareCaptionFont{tongji}{\wuhao[1.5]}
\captionsetup{labelformat=tongji,labelsep=tongji,font=tongji}
\captionsetup[table]{position=top,belowskip={12bp-\intextsep},aboveskip=6bp}
\captionsetup[figure]{position=bottom,belowskip={6bp-\intextsep},aboveskip=6bp}
\captionsetup[sub]{font=tongji,skip=6bp}
\renewcommand{\thesubfigure}{(\alph{subfigure})}
\renewcommand{\thesubtable}{(\alph{subtable})}

% 我们采用 \pkg{longtable} 来处理跨页的表格。同样我们需要设置其默认字体为五号。
\let\tongji@LT@array\LT@array
\def\LT@array{\wuhao[1.5]\tongji@LT@array} % set default font size

% 简单的表格使用三线表推荐用 \cs{hlinewd}。如果表格比较复杂还是用 \pkg{booktabs} 的命
% 令好一些。
\def\hlinewd#1{%
  \noalign{\ifnum0=`}\fi\hrule \@height #1 \futurelet
    \reserved@a\@xhline}

% 章节标题具体设置在.cfg中,各级标题格式设置在本文件后边。

% 如果章节题目中的英文要使用 Times new roman，那么就加上 rmfamily
\def\tongji@title@font{%
  \iftongji@romantitle\rmfamily\else\heiti\fi}


% \pkg{fancyhdr} 定义页眉页脚很方便，但是有一个非常隐蔽的坑。通过 \pkg{fancyhdr}
% 定义的样式在第一次被调用时会修改 \cs{chaptermark}，这会导致页眉信息错误（多余
% 章号并且英文大写）
% thuthesis对此专门进行了解决：
\AtBeginDocument{%
  \pagestyle{tongji@empty}
  \renewcommand{\chaptermark}[1]{\@mkboth{\CTEXthechapter\hskip\ccwd#1}{}}}


% 各级标题格式设置。
% 语法：\ifthenelse{<test>}{<then clause>}{<else clause>}
% \newcommand\tongji@chapter@titleformat[1]{
%    \ifthenelse
%       {\equal{#1}{\eabstractname}}%S
%       {\bfseries #1}%
%       {#1}%
%   }
% 注：同济的英文摘要以及各章标题都要加粗，故不需要\ifthenelse的判断了。
\ctexset{%
  chapter={ %章标题
    afterindent=true, % afterindent 选项用于设置章节标题后首段的缩进。
    pagestyle={tongji@headings},%这句用来保证章首页的页眉正确
    % 注意我们在前面\mainmatter时已经定义过\pagestyle{tongji@headings}
  % 了，但必须在这里重新应用一次，用来保证章首页的页眉正确。
    beforeskip={2bp},%设置章节标题前的垂直间距
    aftername=\hskip\ccwd, %控制章节编号与标题内容之间的距离
    % \ccwd 为一个汉字的宽度。在ctex宏集中有介绍。
    afterskip={18bp}, %控制章节标题与后面下方之间的距离
    format={\centering\bfseries\tongji@title@font\sanhao[1.8]},
    % format 项用于控制章节标题的全局格式，作用域为章节名字和随后的标题内容。可以用于
    % 控制章节标题的对齐方式、整体字体字号等格
    nameformat=\relax,
    numberformat=\relax,
    titleformat=\bfseries,
    lofskip=0pt, %控制插图目录（.lof）中，章之间的插图标题的距离
    lotskip=0pt,%控制表格目录（.lot）中，章之间的表格标题的距离
  },
  section={ %一级节标题
    afterindent=true,
    beforeskip={24bp \@plus 1ex \@minus .2ex},
    afterskip={13bp \@plus .2ex},
    format={\tongji@title@font\xiaosan[1.8]},
	numberformat={\tongji@title@font\sanhao[1]},
  },
  subsection={
    afterindent=true,
    beforeskip={12bp \@plus 1ex \@minus .2ex},
    afterskip={13bp \@plus .2ex},
    format={\tongji@title@font \sihao[1.8]},
    numberformat={\tongji@title@font\xiaosan[1]},
  },
  subsubsection={
    afterindent=true,
    beforeskip={12bp \@plus 1ex \@minus .2ex},
    afterskip={13bp \@plus .2ex},
    format={\tongji@title@font\xiaosi[1.8]},
	numberformat={\tongji@title@font\banxiaosi[1]},
  },
  paragraph/afterindent=true,
  subparagraph/afterindent=true}

 % 目录调教： 摘要、Abstract等不能出现在目录中。清华的模板还需要本科论文的摘要等也出现在目录中，thuthesis的作者们因此才会使用更灵活的\NewDocumentCommand。
 % 我们同济的虽然没有这个需求，我还是将其直接拿过来，便于提高姿势水平。
 % \NewDocumentCommand旨在替代\newcommand. 它是xparse宏包的主要命令。
 % 这个命令的灵活性体现在参数的指定上，我们必须让它知道参数个数、类型以及其它信息。
 % 如{s o m o}中，s表示一个optional star，如果这个命令调用的时候带*，那么就会产生一个\BooleanTrue，进而可以使用\IfBooleanF，\IfBooleanT和\IfBooleanTF,而o选项表示可选参数，m是强制参数。
 % 举个例子：对于's o o m',如果输入‘*[Foo]{Bar}’，那么#1 = \BooleanTrue，#2 = Foo，#3 = -NoValue-，#4 = Bar。
% 下面定义的用法是：\cs{tongji@chapter*}\oarg{tocline}\marg{title}\oarg{header}: tocline 是出现在目录中的条目，如果为空则此 chapter 不出现在目录中，如果省略表示目录出现 title；title 是章标题；header 是页眉出现的标题，如果忽略则取 title。
% 这个宏体现了 \TeX\ macro 的力量！
\newcounter{tongji@bookmark}
\NewDocumentCommand\tongji@chapter{s o m o}{
  \IfBooleanF{#1}{%如果调用的时候不带*，那么#1 = \BooleanFalse
    \ClassError{tongjithesis}{You have to use the star form: \string\tongji@chapter*}{}
  }%
  \clearpage 
  \phantomsection%\phantomsection是给hyperref用的。使它能够jump to the correct page, in other words it puts a hyper marker on the page. For example a starred section or chapter added to the TOC would normally refer to the wrong place without \phantomsection
  % \IfValueTF {<argument>} {<true code>} {<false code>}
  \IfValueTF{#2}
  {%若第一个o对应的可选参数没有提供，那么#2=-NoValue-,此判断为false。
    \ifthenelse{\equal{#2}{}}
    {%第二个参数有，但为空，此 chapter 不出现在目录中
      \addtocounter{tongji@bookmark}\@ne
      \pdfbookmark[0]{#3}{tongjichapter.\thetongji@bookmark}
      }
    {%第二个参数有，且不为空，则将其加入目录
      \addcontentsline{toc}{chapter}{#3}
      % \addcontentsline{ext}{unit}{text}
      % ext是扩展名toc (table of contents), lof (list of figures), or lot (list of tables).
      % unit，对于toc来说就是这些名字：part, chapter, section等
    }
  }
  {%若没有指定该参数（即#2=-NoValue-），表示目录出现title
    \addcontentsline{toc}{chapter}{#3}
  }% 
  \chapter*{#3}%
  \IfValueTF{#4}  
  {%提供了第四个参数，即header
    \ifthenelse{\equal{#4}{}}
    {\@mkboth{}{}}%页眉为空为空
    {%页眉为提供的#4
      \thispagestyle{fancy}
      \fancyhead{}
      \fancyhead[RO,LE]{#4}
      \fancyfoot{}
      \fancyfoot[C]{\songti\wuhao\thepage}
      \renewcommand{\headrulewidth}{0.4pt}
      \renewcommand{\footrulewidth}{0pt}
    }
    % 注：此命令等同于\markboth{left}{right}
    % 也就是定义一个“left-hand heading” 和“righthand heading”
    % 这样，\leftmark读出来的就是我们设的left，\rightmark就是我们设的right
    % 通过这种方式，我们可以很方便地设置页眉。
  }
  {%header 是页眉出现的标题，如果没有提供header参数，则取 title作为页眉
     \thispagestyle{fancy}
     \fancyhead{}
      \fancyhead[RO,LE]{#3}
      \fancyfoot{}
      \fancyfoot[C]{\songti\wuhao\thepage}
      \renewcommand{\headrulewidth}{0.4pt}
      \renewcommand{\footrulewidth}{0pt}      
  }
}


% 目录最多四层，即: x.x.x.x，对应的命令和层序号分别是：
% \cs{chapter}(0), \cs{section}(1), \cs{subsection}(2), \cs{subsubsection}(3)
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}
% The secnumdepth counter controls printing of section numbers
% The setting\setcounter{secnumdepth}{level} suppresses heading numbers at any depth > level,


% 每章标题行前空 6 磅，后空 0 磅。如果使用目录项中英文要使用 Arial，那么就加上 \cs{sffamily}。
% 章节名中英文用 Arial 字体，页码仍用 Times。
% 减小目录项中的导引小点跟页码之间的留白
% 目录生成命令。
\renewcommand\tableofcontents{%
  \tongji@chapter*[]{\contentsname}[\wuhao\songti\tongji@schoolname~\tongji@capply~\contentsname] 
  \xiaosi[1.5]\@starttoc{toc}\normalsize\clearpage}
% 同济要求目录的行距为18磅
% 调整目录样式，允许指定目录字体。
%\iftongji@arialtoc
%  \def\tongji@toc@font{\sffamily}
%\fi

% 调整目录特殊要求，重定义缩进量
% 研究生学位论文写作指南中规定：目录中的章标题行居左书写，一级节标题行缩进 1 个
% 汉字符（2个字符），二级节标题行缩进 2 个汉字符（4个字符）
 \RequirePackage{titletoc}
 \contentsmargin{0em}
 \titlecontents{chapter}[0em]{\filright}%
           {\xiaosi\songti\thecontentslabel\enspace}%
               {\xiaosi\songti}{\dotfill\contentspage}[\addvspace{0pt}]
 \titlecontents{section}[1em]{\addvspace{0pt}}%
           {\xiaosi\songti \thecontentslabel\enspace}%
               {\xiaosi\songti}{\dotfill\contentspage}[\addvspace{0pt}]
 \titlecontents{subsection}[2em]{\addvspace{0pt}}%
           {\xiaosi\songti\thecontentslabel\enspace}%
               {\xiaosi\songti}{\dotfill\contentspage}[\addvspace{0pt}]

% 封面和封底
% 方便的定义封面的一些替换命令
% 注意\define@key的语法，即\define@key{fam}{key}{对参数#1的处理,即handler}
% 使用kvoptions的\define@key之后，就可以key-val的方式设置封面的数据了
\def\tongji@def@term#1{%
  \define@key{tongji}{#1}{\csname #1\endcsname{##1}}
  \expandafter\gdef\csname #1\endcsname##1{%
    \expandafter\gdef\csname tongji@#1\endcsname{##1}}
  \csname #1\endcsname{}}
% 解析：假设我们使用\tongji@def@term{secretlevel}，展开之后就是：
% \define@key{tongji}{secretlevel}{\secretlevel{#1}}
% \gdef\secretlevel#1{\gdef\tongji@secretlevel{#1}}
% \secretlevel{}
% 前辈们很明智地定义了三个东西，不设置的时候为空。还可以手动设置。很强啊。

% 定义密级参数。
\tongji@def@term{secretlevel}
\tongji@def@term{secretyear}
% 论文中英文题目
\tongji@def@term{ctitle}
\tongji@def@term{cheadingtitle}
\tongji@def@term{etitle}
% 作者、导师、副导师（校外）老师。
\tongji@def@term{cauthor}
\tongji@def@term{csupervisor}
\tongji@def@term{cassosupervisor}
\tongji@def@term{eauthor}
\tongji@def@term{esupervisor}
\tongji@def@term{eassosupervisor}
% 学位中英文
\tongji@def@term{cdegree}
\tongji@def@term{edegree}
% 院系中英文名称。
\tongji@def@term{cdepartment}
\tongji@def@term{edepartment}
% 学位中英文名称。
\tongji@def@term{cmajor}
\tongji@def@term{emajor}
% 论文成文日期。
\tongji@def@term{cdate}
\tongji@def@term{edate}
% 为了兼容老版本同济模板的封面定义,仍然使用majorfirst，majorsecond
% 这里majorfirst表示学科门类如工学、理学，majorsecond表示一级学科或二级学科。
\tongji@def@term{cmajorfirst}
\tongji@def@term{cmajorsecond}
\tongji@def@term{emajorfirst}
\tongji@def@term{emajorsecond}
% 定义基金支持
\tongji@def@term{cfunds}
\tongji@def@term{efunds}
% 学号
\tongji@def@term{studentnumber}
% 校名
% \tongji@def@term{eschoolname}

% 通过 \cs{tongjisetup} 统一设置封面信息。
% 由上可见，封面和封底有一大堆信息需要设置，为了简化操作界面，提供一
% 个 \cs{tongjisetup} 命令支持 key/value 的方式来设置。key 就是前面各个设置项的
% 名字。\note[说明：]{只能设置普通项，不支持环境项，
% 如 \texttt{cabstract} 和 \texttt{eabstract}。} 由于这些设置项被 \cs{makecover}
% 调用，所以此命令需要在 \cs{makecover} 之前被调用。
\def\tongjisetup{\kvsetkeys{tongji}}


% 封面第一页
\newlength{\tongji@title@width}
\def\tongji@put@title#1{\makebox{\hb@xt@ \tongji@title@width{#1}}}
% 这个\hb@xt@是啥玩意儿？
\newcommand{\tongji@first@titlepage}
{
  \begin{center}
    \vspace*{0cm}
    % \parbox[position][height][inner-pos]{width}{text}
    \parbox[t][1.8cm][t]{\textwidth}
    {%
      \hspace*{11.2cm}
      \iftongji@secret{\sanhao\tongji@secret@title}
        \else\rule{1cm}{0cm}
      \fi
      \\[0.1cm]
%        \parbox[t][9cm][t]{\paperwidth-10cm}{
    %\hspace*{.4cm} 
      \iftongji@electronic{{\kaishu\xiaosi\bfseries\itshape\tongji@thesistype （打印时删除）}}
        \else\rule{1cm}{0cm}
      \fi
    }
    \\[-.9cm] %TODO:需要伪斜体？
    \parbox[t][1.8cm][t]{\textwidth}
    {%
      \centering\hspace*{.3cm}
      \includegraphics[width=10cm]{tongji-whole-logo.eps}
    }
    \\[-.6cm] % logo
    \parbox[t][9cm][t]{\paperwidth-7cm}
    { 
      % \renewcommand{\baselinestretch}{1} %单倍行距
      \begin{center}
            \erhao[1]{{\bfseries\lishu\tongji@capply}}
            \iftongji@academic{\par\vskip 1.8cm}
            \else \iftongji@profession{\par\vskip 0.4cm \sihao[1]{{\bfseries\lishu（专业学位）}} \par\vskip 0.9cm}
                    \else \iftongji@equaleducation {\par\vskip 0.4cm \sihao[1]{{\bfseries\lishu（同等学力）}} \par\vskip 0.9cm}                        
                          \fi
                    \fi
            \fi
            % \linespread{0.7}
            % \linespread{0.7}相当于\renewcommand{\baselinestretch}{0.7}
            % 需要执行\selectfont才能生效。
            \erhao[2]{\bfseries\heiti\tongji@ctitle}
            \par\vskip -0.3cm
            \ifx\cfunds\@empty\else
              {\parbox[t]{\paperwidth-7cm}{\begin{center}\zihao{-4}\linespread{1.3}\selectfont\tongji@cfunds\end{center}}}
              \par\vskip 20bp
            \fi
      \end{center}
    }
    \vskip -0.4cm 
    \hspace*{1.2cm}
    \parbox[t][8.5cm][t]{\textwidth}
    {
      {
        \fangsong\sanhao[1.5]        
        \begin{center}
          
          \setlength{\extrarowheight}{4pt}          
          \iftongji@profession
            \setlength{\tongji@title@width}{6em}
            \ifxetex % todo: ugly codes
              \begin{tabular}{p{\tongji@title@width}@{}c@{\extracolsep{8pt}}p{7cm}l}
            \else
              \begin{tabular}{p{\tongji@title@width}c@{\extracolsep{8pt}}p{7cm}l}
            \fi              
            \tongji@put@title{\tongji@cauthortitle}        & \tongji@title@sep 
            & \tongji@cauthor\\
            \tongji@put@title{\tongji@cstudentnumbertitle} & \tongji@title@sep 
            & \tongji@studentnumber\\
            \tongji@put@title{\tongji@cdepartmenttitle}    & \tongji@title@sep 
            & \tongji@cdepartment\\                
            \tongji@put@title{\tongji@cmajorfirsttitleprofession}    & \tongji@title@sep
            & \tongji@cmajorfirst\\
            \tongji@put@title{\tongji@cmajorsecondtitleprofession}   & \tongji@title@sep
            & \tongji@cmajorsecond\\ 
            \tongji@put@title{\tongji@csupervisortitle}    & \tongji@title@sep 
            & \tongji@csupervisor\\
            \ifx\tongji@cassosupervisor\@empty\else
              \tongji@put@title{\tongji@cassosupertitle}   & \tongji@title@sep 
              & \tongji@cassosupervisor\\
            \fi
          \else
            \ifx\tongji@cassosupervisor\@empty
              \setlength{\tongji@title@width}{4em}
            \else
              \setlength{\tongji@title@width}{5em}
            \fi                        
            \ifxetex % todo: ugly codes
              \begin{tabular}{p{\tongji@title@width}@{}c@{\extracolsep{8pt}}p{7cm}l}
            \else
              \begin{tabular}{p{\tongji@title@width}c@{\extracolsep{8pt}}p{7cm}l}
            \fi              
            \tongji@put@title{\tongji@cauthortitle}        & \tongji@title@sep 
            & \tongji@cauthor\\
            \tongji@put@title{\tongji@cstudentnumbertitle} & \tongji@title@sep 
            & \tongji@studentnumber\\
            \tongji@put@title{\tongji@cdepartmenttitle}    & \tongji@title@sep 
            & \tongji@cdepartment\\
            \tongji@put@title{\tongji@cmajorfirsttitle}    & \tongji@title@sep
            & \tongji@cmajorfirst\\
            \tongji@put@title{\tongji@cmajorsecondtitle}   & \tongji@title@sep
            & \tongji@cmajorsecond\\
            \tongji@put@title{\tongji@csupervisortitle}    & \tongji@title@sep 
            & \tongji@csupervisor\\
            \ifx\tongji@cassosupervisor\@empty\else
              \tongji@put@title{\tongji@cassosupertitle}   & \tongji@title@sep 
              & \tongji@cassosupervisor\\
            \fi
          \fi               
          \end{tabular}
      \end{center}}
    }
    \\[1.3cm]
    % \vskip2cm
    \begin{center}
     {\sanhao\songti\tongji@cdate}
    \end{center}
  \end{center}
} % end of titlepage

% 英文封面
\newcommand{\engcover}
{%
  \begin{center}
      \vspace*{0.5cm} 
  %    \parbox[b][1.8cm][t]{\textwidth}{
        %\hspace*{11.2cm}\iftongji@secret{\sanhao\tongji@secret@title}\else\rule{1cm}{0cm}\fi\\[-0.1cm]
  %      \hspace*{-0.1cm}\includegraphics[scale=0.16]{tongjilogo.png}}
  %      \vskip -0.9cm
      \vspace*{0.5cm} 
      % \parbox[position][height][inner-pos]{width}{text}
      \parbox[t][1.8cm][t]{\textwidth}
      {%
        \centering\hspace*{.3cm}
        \includegraphics[width=10cm]{tongji-whole-logo.eps}
      }
      \\[-.6cm] % logo
      \vspace*{0.3cm}
      \parbox[t][9cm][t]{\paperwidth-6cm}
      {
        % \renewcommand{\baselinestretch}{1}
        \begin{center}
              \sihao[1.3]{\tongji@eapply}
              \par\vskip 1.4cm 
              \xiaoer[1.5]{\bfseries\sffamily\tongji@etitle}
              \par\vskip 14pt
              \ifx\efunds\@empty\else
                \xiaosi[1.3]{\tongji@efunds}
                \par\vskip 20bp
              \fi
        \end{center}
      }
       %\vskip 0.5cm 
      \hspace*{1.2cm}
      \parbox[t][8.7cm][t]{\textwidth}
      {
        \sanhao[1.5] 
        \begin{center}
          \begin{tabular}{lp{6cm}} 
            Candidate :         & \tongji@eauthor       \\
            Student Number :    & \tongji@studentnumber \\
            School/Department : & \tongji@edepartment   \\
            Discipline :        & \tongji@emajorfirst   \\
            Major :             & \tongji@emajorsecond  \\
            Supervisor :        & \tongji@esupervisor \\
            \ifx\tongji@eassosupervisor\@empty\else
              Associate Supervisor : & \tongji@eassosupervisor \\
            \fi     
          \end{tabular}
        \end{center}
      }
      \vskip -2cm 
      \begin{center}
        \sanhao\tongji@edate 
      \end{center}
  \end{center}
} % end of english cover

% \newcommand\tongji@underline[2][6em]{\hskip1pt\underline{\hb@xt@ #1{\hss#2\hss}}\hskip3pt}

% 原创性声明
\newcommand{\tongji@declareshortname@mk}
{%
  \vspace*{-0.1cm} % shit code!
  \begin{center}
    \erhao\heiti\tongji@declarename
  \end{center}
  \vskip18pt\sihao[2.03]\par
  \tongji@declaretext\par
  \vskip8.9cm
  \begingroup
    \parindent0pt\xiaosi
    \hspace*{5.5cm}\tongji@authorsig\relax\hspace*{1cm}\\[3pt]
    \hspace*{9.5cm}\tongji@date\relax\hspace*{1cm}
  \endgroup
}

% 授权页面
\newcommand{\tongji@authorization@mk}
{%
  \vspace*{-0.1cm} % shit code!
  \begin{center}
    \erhao\heiti\tongji@authtitle
  \end{center}
  \vskip18pt\sihao[2.03]\par
  \tongji@authorization\par
  \vskip7.9cm
  \begingroup
    \parindent0pt\xiaosi
    \hspace*{5.5cm}\tongji@authorsig\relax\hspace*{1cm}\\[3pt]
    \hspace*{9.5cm}\tongji@date\relax\hspace*{1cm}
  \endgroup
}

% 摘要
% 摘要最好以环境的形式出现（否则命令的形式会导致开始结束的括号距离太远，我不喜
% 欢），这就必须让环境能够自己保存内容留待以后使用。使用 \pkg{environ} 的
% \cs{Collect@Body} 来实现。
\newcommand{\tongji@@cabstract}[1]{\long\gdef\tongji@cabstract{#1}}
\newenvironment{cabstract}{\Collect@Body\tongji@@cabstract}{}
\newcommand{\tongji@@eabstract}[1]{\long\gdef\tongji@eabstract{#1}}
\newenvironment{eabstract}{\Collect@Body\tongji@@eabstract}{}
%   不同论文格式关键词之间的分割不太相同，我们用 \cs{ckeywords} 和
%    \cs{ekeywords} 来收集关键词列表，然后用本命令来生成符合要求的格式。
%    \begin{macrocode}
\def\tongji@parse@keywords#1{
  \define@key{tongji}{#1}{\csname #1\endcsname{##1}}
  \expandafter\gdef\csname tongji@#1\endcsname{}
  \expandafter\gdef\csname #1\endcsname##1{
    \@for\reserved@a:=##1\do{
      \expandafter\ifx\csname tongji@#1\endcsname\@empty\else
        \expandafter\g@addto@macro\csname tongji@#1\endcsname{%
          \ignorespaces\csname tongji@#1@separator\endcsname}
      \fi
      \expandafter\expandafter\expandafter\g@addto@macro%
        \expandafter\csname tongji@#1\expandafter\endcsname\expandafter{\reserved@a}}}}
% 利用 \cs{tongji@parse@keywords} 来定义，内部通过 \cs{tongji@ckeywords} 和
% \cs{tongji@ekeywords} 来引用。
\tongji@parse@keywords{ckeywords}
\tongji@parse@keywords{ekeywords}
\newcommand{\tongji@makeabstract}{%
  \cleardoublepage % always openright for Abstract
  \tongji@chapter*[]{\cabstractname}[\wuhao\songti\tongji@schoolname~\tongji@capply~\cabstractname] % no tocline
  \pagenumbering{Roman}
  \tongji@cabstract
  \vskip12bp
  \setbox0=\hbox{{\bfseries\heiti\tongji@ckeywords@title}}
  \noindent\hangindent\wd0\hangafter1
    \box0\tongji@ckeywords
  % \cleardoublepage % always openright for Abstract  
  \tongji@chapter*[]{\eabstractname}[\wuhao\tongji@eschoolname~\tongji@edegree~\eabstractname] % no tocline
  \tongji@eabstract
  \vskip12bp
  \setbox0=\hbox{{\bfseries Key Words:\enskip}}
  \noindent\hangindent\wd0\hangafter1
    \box0\tongji@ekeywords}


% 生成封面总命令。
\newcommand{\makecover}{
  \phantomsection
  \pdfbookmark[-1]{\tongji@ctitle}{ctitle}
  \normalsize%
  \begin{titlepage}
    \tongji@first@titlepage
    \cleardoublepage
    \engcover
    \cleardoublepage
    \tongji@authorization@mk
    \cleardoublepage
    \tongji@declareshortname@mk
  \end{titlepage}
  \normalsize
  \tongji@makeabstract
  \let\@tabular\tongji@tabular}
   
% 主要符号对照表  
% 根据清华v5.2.1的改动进行重设，即利用 \pkg{enumitem} 改造环境定义，更直观。
\newenvironment{denotation}[1][2.5cm]{
  \tongji@chapter*{\tongji@denotation@name}[\wuhao\songti\tongji@schoolname~\tongji@capply~\tongji@denotation@name]
  \vskip-30bp\xiaosi[1.6]\begin{tongji@denotation}[labelwidth=#1]
}{%
  \end{tongji@denotation}
  \clearpage
}
\newlist{tongji@denotation}{description}{1}
\setlist[tongji@denotation]{%
  nosep,
  font=\normalfont,
  align=left,
  leftmargin=!, % sum of the following 3 lengths
  labelindent=0pt,
  labelwidth=2.5cm,
  labelsep*=0.5cm,
  itemindent=0pt,
}

% 致谢以及声明
\NewDocumentEnvironment{acknowledgement}{}{%
\tongji@chapter*[\tongji@ackname]{\tongji@ackname}[\wuhao\songti\tongji@schoolname~\tongji@capply~\tongji@ackname] 
\fangsong 
 }{\clearpage}
% \let\ack\acknowledgement

% 参考文献 调整
% 兼容参考文献的老命令
\let\inlinecite\parencite
% 全局字体
\renewcommand{\bibfont}{\zihao{5}\songti}%宋体五号
% \setlength{\bibitemsep}{0ex}
\setlength{\bibnamesep}{0ex}
\setlength{\bibinitsep}{0ex}
% 解决参考文献页眉问题（当存在附录时，参考文献页眉会出问题）
\newcommand\printTJbibliography{\printbibliography[heading=bibintoc]\clearpage}

% 图表索引
% 定义图表以及公式目录样式
\def\tongji@starttoc#1{% #1: float type, prepend type name in \listof*** entry.
  \let\oldnumberline\numberline
  \def\numberline##1{\oldnumberline{\csname #1name\endcsname\hskip.4em ##1}}
  \@starttoc{\csname ext@#1\endcsname}
  \let\numberline\oldnumberline}  
\def\tongji@listof#1{% #1: float type
  \@ifstar
    {%带星的不加入目录，如\listoftables*
      \tongji@chapter*[]{\csname list#1name\endcsname}[\wuhao\songti\tongji@schoolname~\tongji@capply~\csname list#1name\endcsname]
      \tongji@starttoc{#1}
      \clearpage}
    {%加入目录
     \tongji@chapter*{\csname list#1name\endcsname}[\wuhao\songti\tongji@schoolname~\tongji@capply~\csname list#1name\endcsname]
     \tongji@starttoc{#1}
     \clearpage}
  }
\renewcommand\listoffigures{\tongji@listof{figure}}
% \renewcommand*\l@figure{\addvspace{6bp}\@dottedtocline{1}{0em}{4em}}
\renewcommand*\l@figure{\@dottedtocline{1}{0em}{4em}}
\renewcommand{\@dotsep}{2}              %改变索引中点间距
\renewcommand\listoftables{\tongji@listof{table}}
\let\l@table\l@figure
%   本命令只是为了生成公式列表，所以这个 caption 是假的。如果要编号最好用
%    equation 环境，如果是其它编号环境，请手动添加添加 \cs{equcaption}。
% 用法如下：
%
% \cs{equcaption}\marg{counter}
%
% \marg{counter} 指定出现在索引中的编号，一般取 \cs{theequation}，如果你是用
%  \pkg{amsmath} 的 \cs{tag}，那么默认是 \cs{tag} 的参数；除此之外可能需要你
% 手工指定。
% \LaTeX\ 默认没有公式索引，此处定义自己的 \cs{listofequations}。
\def\ext@equation{loe}
\def\equcaption#1{%
  \addcontentsline{\ext@equation}{equation}%
                  {\protect\numberline{#1}}}
\newcommand\listofequations{\tongji@listof{equation}}
\let\l@equation\l@figure


% 附录
\fancypagestyle{tongji@appendix@heading}{%
  \fancyhead{}
  \fancyhead[RO,LE]{\wuhao\songti\tongji@schoolname~\tongji@capply~\appendixname}
  \fancyfoot{}
  \fancyfoot[C]{\songti\wuhao\thepage}
  \renewcommand{\headrulewidth}{0.4pt}
  \renewcommand{\footrulewidth}{0pt}
  }
\let\tongji@appendix\appendix
\renewenvironment{appendix}{% 
  \ctexset{%附录仍属于mainmattertrue才能正确编号成附录A的形式
  % 因此，此处的pagestyle仍然会沿用我们前面设的chapter的pagestyle，而我们需要更改附录的页眉，因此需要重新设置一下页眉。
    chapter/pagestyle={tongji@appendix@heading}%这句用来保证章首页的页眉正确
    } 
  \pagestyle{tongji@appendix@heading} % 这一句是保证附录非章首页的其他页面的也没正确。
  \let\title\tongji@appendix@title
  \tongji@appendix}{%
  \let\title\@gobble  \clearpage}

% 个人简历
\newenvironment{resume}{%
  \tongji@chapter*{\tongji@resume@title}[\wuhao\songti\tongji@schoolname~\tongji@capply~\tongji@resume@title] 
  \wuhao[1.5] 
  \setlist[enumerate,1]{leftmargin=2em}   %设置enumerate左间隙距离
  }{\clearpage}

\newcommand{\resumeitem}[1]{\vspace{2.5em}{\bfseries\wuhao\heiti\leftline{#1}}\par} 

% 书脊
% 单独使用书脊命令会在新的一页产生竖排书脊。
\NewDocumentCommand{\shuji}{O{\tongji@ctitle} O{\tongji@cauthor}}{%
  \newpage\thispagestyle{empty}%
  \fangsong\ifxetex\addCJKfontfeatures*{RawFeature={vertical:}}\fi
  \xiaosan\ziju{0.4}%
  \noindent\hfill\rotatebox[origin=lt]{-90}{\makebox[\textheight]{#1\hfill#2}}}
  
% 在模板文档结束时即装入配置文件，这样用户就能在导言区进行相应的修改。
\AtEndOfClass{\input{tongjithesis.cfg}}
\AtEndOfClass{\sloppy}

\endinput
%%
%% End of file `tongjithesis.cls'.
