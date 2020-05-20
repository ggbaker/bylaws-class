# Bylaws

This repository provides a class for typesetting governing documents (such as bylaws or corporate charters). The format is *very* roughly inspired by the formatting of the bylaws of the [National Association of Parliamentarians](https://www.parliamentarians.org).

This was mostly a hobby project for me, combining an interest in parliamentary law and typesetting. Most governing documents I've come across are very utilitarian documents, and this arose out of an attempt to produce a well-typeset set of bylaws without sacrificing legibility and ease of reference.

This repository also contains a sample constitution and bylaws (from an organization I'm involved in) to illustrate the features.

N.B. I don't recommend maintaining the master version of any governing documents in LaTeX code, due to continuity issues if future maintainers don't know LaTeX. (Obviously this advice doesn't apply if your organization is filled with people who know LaTeX.)

## Prequisites

1. XeLaTeX - This should be included in the full version of any standard TeX installation. Some standard editors may automatically use the correct compiler, but you may have to change it manually in settings. (XeLaTeX enables the use of system fonts.)
2. [Libertinus Typefaces](https://github.com/alif-type/libertinus) - This is a fork of the popular Linux Libertine family. I use it because it has better math support, though obviously that's of little use in a governing document.
3. A variety of other LaTeX packages, all of which should be part of any sufficiently complete standard TeX distribution.

* Of course, please feel free to modify the code to meet your own needs. Typefaces are specified using the fontspec package, so it should be easy enough to change it to one better suiting your needs. If you're happy to use stanard LaTeX fonts, you might be able to remove the lines relating to typeface specification and then use the standard LaTeX compiler. 

At some point, I will get around to making this package work with a standard LaTeX install. Mainly that means using standard LaTeX typefaces (such as the default Computer Modern).

## Installation

Just put the cls file in the same directory as your tex file. If you're using git to maintain your documents, you could include this module as a submodule and then put a symlink to the class file.

## Structure

### Titles

This class is designed to potentially typeset multiple governing documents (say a constitution and bylaws) into a single file. There are thus two titling commands

1. The standard \title{}, \date{}, and \maketitle commands

These commands produce a cover title page. The date command should be used to state adopted/amended dates. For example:

```
\title{Constitution and Bylaws of the Sample Organization}
\date{Adopted, July 2015\\ As amended, May 2020}
```

Note, the \maketitle command is very basic. It will only format the title and date. Any author specified is ignored.

2. The \doctitle[date]{title} command

This command produces a title at the top of the page and should be used at the start of a document like the bylaws. The optional argument should be used for a last amended/adopted date. For example

\doctitle[As amended, May 2020]{Bylaws of the Sample Organization}

(this command also resets the article (chapter) counter so the first use of \article (or \chapter) will produce Article I.)

I recommend putting a \pagebreak before starting a new document, so the title goes at the top of a new page.

### Articles, Sections, and Subsections

This class uses the following formating and numbering:

Article III
Officers

Section 2. Duties of Officers.
     2.1. President. The duties of the president shall be as follows:
         2.1.1. Preside and preserve order at all meetings; and
         2.1.2. Represent the organization at public events.

This class is built on top of the standard "report" class, and so builds on its features.

0. The \preamble command will produce an unnumbered heading for a preamble. If you have a preamble and it's written as a numbered article, you shouldn't use this command.

1. The \article{} command produces a new article. (It also produces a label for that article with the same name for cross-referencing purposes.)

2. The \section{} command produces a new section, as expected.

N.B. In order to produce the formatting intended, all sections should end with a \\ linebreak. At some point, I'll figure out how to get that linebreak automatically. (I can get a linebreak before the start of a section, but I haven't figured out how to get it without doubling with the linebreak that follows the start of a new article.)

3. For lower leveled sections, the enumerate environment should be used. First-level enumerate will produce numbered subsections as (Section #).(Subsection #). Second-level enumerate is numbered (Section #).(Subsection #).(Subsubsection #). Third-level enumerate are simply lettered lists.

I generally prefer first-level level subsections to have a title. I've thus provided the \sub[] command which is identical to the \item command except that it takes an optional argument for a title. I don't recommend titles on lower level subsections, but the \sub command works just the same there.

## Automatic cross-referencing

The \artref{article name} command will automatically produce a hyperlinked cross-reference to the given article. I personally don't like to cross-reference specific sections because it's too easy to forget to update them when amending documents. You can of course, cross-reference sections, by assigning a label to them and using the \ref command as normal.

N.B. Care should be taken with a command like this, if you are using this as a master document, as it will automatically update numbers which may not be a desired affect if an explicit amendment wasn't passed. I generally feel cross-references should automatically update if an amendment changes the numbering, even if the cross-reference update wasn't explicitly included in the amendment, but others may more sticklers for the rules. 

In any event, it's worth being careful with any commands that might change text as a consequence of an edit in a different part of the file.

## Random other stuff

### Line numbering

I personally like to have line numbers running in the margin for ease of reference. By default, line numbering is disabled, but the class automatically loads the lineno package, so linenumbering can be enabled by putting everything you want numbered in a linenumbers environment.

### Draft watermark

If you want a "DRAFT" watermark page, just include "draft" as an optional argument in the document class specification.

## Some other typographic advice

### Page breaks within a text block.

I like to avoid breaking text across a page to ease legibility. Ideally, I'd set it to only page break before the start of either a new section or subsection, but I haven't gotten around to that yet. 

My dirty hack is to type the entire document first, then add forced page breaks starting from the beginning of the file down, until no improper breaks occur.

### Typesetting abreviations 

Where appropriate for a document of this sort, I try to follow Bringhurst's *The Elements of Typographic Style*. One suggestion therein is that abbreviations be formatted in letterspaced small caps. Given that many organizations have an abbreviation which might appear many times in their governing docs, it might be wise to make a command to typeset such an abbreviation appropriately. The small cap style is automatically set to be letterspaced, so all that's necessary is
```
\usepackage{xspace}
\newcommand{\ABC}{\textsc{ABC}\xspace}
```
(xpace handles proper spacing after the abbreviation).

### Margins

The margins are set at 1.2in all around. This results in lines that are longer than typically recommended by typograpers. I've picked smaller margins (longer line lengths) for two reasons:
1. Very few people sit down and read bylaws like a novel. They're reference documents, and longer lengths means fewer pages and thus less time flipping between pages.
2. Because the documents I work with tend to make heavy use of subsections (which are indented in this format), with larger margins, the subsections and lower levels would have uncomfortably short line lengths.

If you are working with a document that doesn't use levels below sections much, you might want to increase the margins just a bit. Margins are set by the geometry package near the start of the class. If you want to modify the margins, you need to edit the declaration there (loading geometry package in your tex file with different settings will cause an error.)
