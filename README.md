vim-jape
===

Jape tool support for vim. This includes the following for now:

* Syntax highlighting
* Indentation
* Snippets through [Ultisnips](https://github.com/SirVer/ultisnips)
* [Tagbar](https://github.com/majutsushi/tagbar) support
* Jump to definitions of annotations with ctags

Syntax highlighting
========
Macros, rules, java code - everything should be highlighted properly. Look at this gorgeous screenshot

![Syntax highlighting](https://github.com/nikolavp/vim-jape/blob/master/images/syntax.png "Syntax highlighting")

Indentation
========
You should be able to rely on the auto formatting provided by vim-jape. You can even format all your current files with the following:

```shell
find -name '*.jape' -exec vim {} -c 'normal gg=GZZ' \;
```
isn't this awesome(of course check the diff before making the changes blindly)

Snippets
========
If you are using the excellent [Ultisnips](https://github.com/SirVer/ultisnips) you will get the following snippets:

* imports - creates an import block with a default static import for gate.Utils.\*
* gram - creates a grammar file heading
* rule - creates a rule *without* a java on the right hand side
* jrule - creates a rule *with* java on the right hand side
* lhsmacro - creates a macro
* bra - creates a matching annotation expression
* look - creates a matching lookup expression with filters
* tok - creates a token matching expression with filters

Ctags for jumping to definitions
========
This is not part of vim per se but it is used in the tagbar support. There is an example ctags file that adds support for rules and macros through patters.
You can append it(copy it) in ~/.ctags. Then run

```bash
ctags -R *
```

on your top level directory with jape grammars. This will produce a tags file that contains the different recognized definitions in your file. Then you should point vim to your tags file with
```vim
:set tags+=<path-to-tags-file>
```
you can then jump to definition of a resource by placing the cursor on top of it and pressing *^]*(ctrl + ]). Press *^t*(ctrl + t) to go back.

Sometimes there are many definitions for a single annotation, in those cases ^] will jump to the first match. If you want to jump to a specific definition use :ts <resource-name> to get a list and choose the exact tag by it's number. For example

```vim
:ts Location
```
will show you every place that the *Location* annotation is defined and will ask you where to jump

Tagbar support
========
If you are using tagbar and have included the tags file, you will see the tree properly.  Look at this gorgeous screenshot
![Tagbar screenshot](https://github.com/nikolavp/vim-jape/blob/master/images/tagbar.png "Tagbar screenshot")

Installation
===
For now there is no package but the following methods work as expected

Vimballs
==========

Download the vmb from [our release page](https://github.com/nikolavp/vim-jape/releases) and run the following

```shell
vim -S vim-jape-1.0.vmb
```


Pathogen
==========

If you are using [pathogen](https://github.com/tpope/vim-pathogen)

```shell
cd ~/.vim/bundle
git clone git://github.com/nikolavp/vim-jape.git
```

Neobundle
==========

If you are using [Neobundle](https://github.com/Shougo/neobundle.vim) then add the following to your vimrc file

```vim
NeoBundle 'nikolavp/vim-jape', {
            \ 'autoload' : {
            \   'filetypes': ['jape'],
            \ },
            \}
```

you will have to restart so neobundle asks to you install the plugin

Vundle
==========
If you are using [Vundle](https://github.com/gmarik/Vundle.vim) then add the following to your vimrc file

```vim
Plugin 'nikolavp/vim-jape'
```

Development
===

Some things to note in the repository:

* https://github.com/aktau/github-release is needed to create a release
* The makefile is generated with https://github.com/c9s/vim-makefile

Creating a release
===========
You can run the following:

```bash

git tag -a <new-version> -m 'A comment describing the tag'
git push --tags
export V=<new-version>
make vimball VERSION=$V
export GITHUB_TOKEN=<your-token>
github-release release --user nikolavp --repo vim-jape --tag v1.0 --name 'First release' --description 'General availability release for the vim-jape plugin' --file "vim-jape-${V}.vmb"
```

