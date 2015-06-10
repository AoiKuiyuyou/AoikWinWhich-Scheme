[:var_set('', """
#/ Compile command
aoikdyndocdsl -s README.src.md -n aoikdyndocdsl.ext.all::nto -g README.md
""")]\
[:var_set('source_file_name', 'aoikwinwhich.ss')]\
[:var_set('source_file_url', '/src/aoikwinwhich/aoikwinwhich.ss')]\
[:HDLR('heading', 'heading')]\
# AoikWinWhich
[AoikWinWhich](https://github.com/AoiKuiyuyou/AoikWinWhich) written in Scheme.

Tested working with:
- DrRacket 6.1.1
- Windows 8.1
- Windows earlier versions should work but not tested

## Table of Contents
[:toc(beg='next', indent=-1)]

## Setup
Clone this git repository to local:
```
git clone https://github.com/AoiKuiyuyou/AoiWinWhich-Scheme
```

In the local repository directory, the source file is
[[:var('source_file_name')]]([:var('source_file_url')]).

Use program **Racket** to run:
```
Racket src/aoikwinwhich/aoikwinwhich.ss
```

## Usage
See [usage](https://github.com/AoiKuiyuyou/AoikWinWhich#how-to-use) in the
general project [AoikWinWhich](https://github.com/AoiKuiyuyou/AoikWinWhich).
