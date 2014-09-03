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
Macros, rules, java code - everything should be highlighted properly

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
will show you every place that the Token annotation is defined and will ask you where to jump

Tagbar support
========
If you are using tagbar and have included the tags file, you will see the tree properly.

Installation
===
For now there is no package but the following methods work as expected

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
