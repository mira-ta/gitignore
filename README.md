# gitignore ![scriptsize](https://img.shields.io/github/size/mira-ta/gitignore/gitignore.sh) ![stars](https://img.shields.io/github/stars/mira-ta/gitignore)

`sh` script which helps with downloading gitignore files from the web.

## Installing

There are two ways of installing script.

* Somewhere in the web there're deb package and pkgbuild file. But I do not know where they are, I suppose you to know how to install it with your package manager manually.

* Download [script](https://github.com/mira-ta/gitignore/blob/master/gitignore.sh) and use it from terminal.

## Example

To download `C.gitignore` from [this](https://github.com/github/gitignore) repository on GitHub.

```sh
$ gitignore C
```

Also you can provide different options. See help for them.

```sh
$ gitignore -h
# or
$ gitignore --help
```
