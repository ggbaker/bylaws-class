\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bylaws}[2020/05/17 by G. Baker]

\LoadClass[12pt]{report}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Optional arguments

% draft argument to create a draft watermark
\DeclareOption{draft}{
  \RequirePackage{draftwatermark}
  \SetWatermarkText{\TitleFont{DRAFT}}
}

%% Use the report class as a base. All options passed to this file get
%% passed to  the report class
%%%%%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Margins

\RequirePackage[
  left=1.2in,
  right=1.2in,
  top=1.2in,
  bottom=1.2in,
  ]{geometry}

\RequirePackage{setspace}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Typefaces

\RequirePackage{fontspec}

% Default typefaces
\setmainfont[
  Mapping=tex-text,
  Ligatures=TeX,
  Numbers=Lowercase,
  UprightFeatures={
    Numbers=Lowercase,
    SmallCapsFeatures={
      Letters=UppercaseSmallCaps,
      LetterSpace=6}},
  BoldFeatures={
    Numbers=Lowercase,
    SmallCapsFeatures={
      Letters=UppercaseSmallCaps,
      LetterSpace=6}},
  ]{Libertinus Serif}

%% Title typeface
% Creates a style for the title. Meant to be used in all caps, hence the
% extra spacing and lack of kerning.
\newfontfamily\TitleFont[UprightFeatures={
  LetterSpace=10,
  WordSpace=1.3,
  Kerning=Off}
]{Libertinus Serif Display}

% Creates a general purpose display style for titles. Meant for standard
% text (not all caps)
\newfontfamily\DisplayFont[]{Libertinus Serif Display}

% Creates a spaced version of the standard typeface, for use in all
% caps. Will be used for article headings.
\newfontfamily\CAPS[LetterSpace=10,
  Kerning=Off,
  WordSpace=1.05]{Libertinus Serif}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Format document title

% The usual \title command produces a cover sheet. I recommend using
% this only when multiple documents (such as a constitution and bylaws)
% are combined into one document

\renewcommand{\maketitle}{
  \begin{titlepage}
    \begin{center}
      \vspace*{15\baselineskip}
      {\LARGE \TitleFont \MakeUppercase{\@title}\par}
      \vspace{1.5em}
      {\LARGE \DisplayFont \@date \par}
    \end{center}
  \end{titlepage}
}

% The \doctitle command produces a title heading at the start of a page
% and can be used multiple times in a file
\newcommand{\doctitle}[2][]{
  % reset the article (chapter) counter
  \setcounter{chapter}{0}
  \renewcommand*{\theHchapter}{chX.\the\value{chapter}}
  % format the title
  \centerline{\large \TitleFont
      \MakeUppercase{#2}}
  \centerline{{\large \DisplayFont #1}}
  \vspace{\baselineskip}
  }


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Set up article and section formats

\RequirePackage[explicit]{titlesec}
\RequirePackage{etoolbox}  % Don't remember why this is needed
% Required for conditional statements for headings with optional titles
\RequirePackage{xifthen}
% changes formatting or Article heading so as to not take an entire page
\makeatletter
\patchcmd{\chapter}{\if@openright\cleardoublepage\else\clearpage\fi}{}{}{}
\makeatother

%% Restyle the report class's chapter heading as an Article heading
\renewcommand{\thechapter}{\Roman{chapter}}
\titleformat{\chapter}[display]
{\CAPS\fillast\scshape}               
{\uppercase{Article} \thechapter}{0pt}{\uppercase{#1}\\}[]                                  
\titlespacing{\chapter}               
{0pt}{0pt}{0pt}

%% Create an article command that both calls the report chapter command
%% and creates a label for cross-referencing
\newcommand{\article}[1]{\chapter{#1}\label{#1}}
%% Define the preamble command (just makes an unnumbered article)
\newcommand{\preamble}{\chapter*{Preamble}}

%% Restyle the section heading
\renewcommand{\thesection}{\arabic{section}}
\titleformat{\section}[runin]               
{\normalfont\bfseries}                 
{Section \textbf{\thesection.}}{.3em}
{\ifthenelse{\equal{#1}{}}{}{\textbf{#1.}}}
\titlespacing{\section}
{0pt}{0pt}{0.7em}                           

%% Restyle the enumerate environment for subsections
\RequirePackage{paralist} 
\RequirePackage{enumitem}

% Removes the vertical white space between subsections
\setlist{nolistsep}
% Changes the indent of the subsections
\setdefaultleftmargin{4em}{3.17em}{1.7em}{1.7em}{1em}{1em}
% Changes the numbering styles for subsections and sections
\renewcommand{\labelenumi}{\theenumi\textbf{.}}
\renewcommand{\theenumi}{\textbf{\thesection.\arabic{enumi}}}
\renewcommand{\labelenumii}{\theenumii\textbf{.}}          
\renewcommand{\theenumii}{\textbf{\theenumi.\arabic{enumii}}}
\renewcommand{\theenumiii}{\textbf{\Alph{enumiii}}}          

%% The \sub command augments the \item command, allowing for a title
\newcommand{\sub}[1][]{
  \ifthenelse{\equal{#1}{}}{\item}{\item\textbf{#1.}}
  }


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Other stuff

% For automatic reference links
\RequirePackage{hyperref}
% automatically format article cross-reference
\newcommand{\artref}[1]{Article \ref{#1}}

% For optional line numbers
\RequirePackage{lineno}