+++
title = "Getting paper references with papis"
author = ["Alejandro Gallo"]
date = 2020-12-06T00:00:00+01:00
tags = ["papis"]
draft = false
+++

Today I would like to talk about how I normally
download references of papers using
the tool [Papis](https://github.com/papis/papis).
I will be writing in the future more posts about
this tool and about how it makes my life easier.

Usually when I am researching a topic and
I read a paper about it, I want to check out some references
cited in the paper.
However, I find it very tiresome to copy the reference
or the link (if any is available in the pdf),
paste it in the browser and download it with papis.
I mean, this is still ok, and sometimes I do exactly this.
But most of the times, I can do better, and I want to
tell you exactly how.

To see how this works we are going to work with the following
landmark paper:

```bibtex
@article{Theory.of.SuperBardee1957,
  author = {Bardeen, J. and Cooper, L. N. and Schrieffer, J. R.},
  doi = {10.1103/PhysRev.108.1175},
  issue = {5},
  journal = {Physical Review},
  pages = {1175--1204},
  title = {Theory of Superconductivity},
  url = {http://link.aps.org/article/10.1103/PhysRev.108.1175},
  volume = {108},
  year = {1957},
}
```

Right now when papis adds a paper through the
`doi` importer, i.e., when you do something like

```shell
papis add --from doi 10.1103/PhysRev.108.1175
```

or simply

```shell
papis add 10.1103/PhysRev.108.1175
```

you get information similar to the following
in the `info.yaml` file

```yaml
abbrev_journal_title: Phys. Rev.
author: Bardeen, J. and Cooper, L. N. and Schrieffer, J. R.
author_list:
- given_name: J.
  surname: Bardeen
- given_name: L. N.
  surname: Cooper
- given_name: J. R.
  surname: Schrieffer
citations:
- doi: 10.1007/BF01504252
- doi: 10.1098/rspa.1935.0048
- doi: 10.1016/S0031-8914(35)90097-0
- doi: 10.1103/PhysRev.74.562
- doi: 10.1098/rspa.1953.0040
- doi: 10.1103/PhysRev.97.1724
- doi: 10.1007/BFb0109284
- doi: 10.1007/BF01322787
- doi: 10.1103/PhysRev.78.477
- doi: 10.1103/PhysRev.78.487
- doi: 10.1103/PhysRev.79.845
- doi: 10.1103/PhysRev.79.167.3
- doi: 10.1103/PhysRev.80.567
- doi: 10.1103/PhysRev.81.829
- doi: 10.1103/RevModPhys.23.261
- doi: 10.1098/rspa.1952.0212
- doi: 10.1103/PhysRev.99.1140
- doi: 10.1103/PhysRev.106.162
- doi: 10.1103/PhysRev.100.1215
- doi: 10.1103/PhysRev.102.656
- doi: 10.1103/PhysRev.102.662
- doi: 10.1103/PhysRev.104.844
- doi: 10.1002/prop.19530010302
- doi: 10.1103/PhysRev.107.354
- doi: 10.1103/PhysRev.100.481
- doi: 10.1103/PhysRev.100.502
- doi: 10.1103/PhysRev.104.1189
- doi: 10.1103/PhysRev.101.1431
- doi: 10.1103/PhysRev.107.901
- doi: 10.1007/BF02856068
- doi: 10.1098/rspa.1948.0123
- doi: 10.1103/PhysRev.106.208
doc_url: http://harvest.aps.org/v2/journals/articles/10.1103/PhysRev.108.1175/fulltext
doi: 10.1103/PhysRev.108.1175
files:
- Theory-of-Superconductivity-Bardeen-J.-and-Cooper-L.-N.-and-Schrieffer-J.-R..pdf
first_page: '1175'
full_journal_title: Physical Review
issue: '5'
journal: Physical Review
last_page: '1204'
pages: 1175--1204
ref: Theory.of.SuperBardee1957
title: Theory of Superconductivity
url: http://link.aps.org/article/10.1103/PhysRev.108.1175
volume: '108'
year: '1957'
```

Take a look at the `citations` section,
we get a list of **most** `doi` strings referenced in the paper.

Papis has a command called `explore` which offers much functionality.
One of the subcommands of `explore` is called `citations`, so that
you can explore the citations in the `citations` field of your
info file.
Since explore commands are quite long, I normally define
a `bash` function or an alias to use them.
In this case I define the following function in my
[~/.bashrc](https://unix.stackexchange.com/questions/129143/what-is-the-purpose-of-bashrc-and-how-does-it-work) file

```sh
citget() {
  query=$1
  shift
  papis explore citations -s "$query" pick cmd "papis add --from doi {doc[doi]} $@"
}
```

If this seems like a magic incantation to you, let us break it down.
The help message of the `citations` command reads like

```sh
papis explore citations -h
```

```text
Usage: papis explore citations [OPTIONS] [QUERY]

  Query the citations of a paper

  Example:

  Go through the citations of a paper and export it in a yaml file

      papis explore citations 'einstein' export --format yaml einstein.yaml

Options:
  --doc-folder PATH            Apply action to a document path
  -h, --help                   Show this message and exit.
  -s, --save                   Store the citations in the document's folder
                               for later use

  --rmfile                     Remove the stored citations file
  -m, --max-citations INTEGER  Number of citations to be retrieved
```

The flag `-s` means that the citations downloaded should be stored in
a `citations.yaml` file in the document's folder.
Whichever citation we then choose, we will pass it to the
`cmd` command, which accepts a string that will be run in the shell. In this case,
we select a cited document and apply the `papis add --from doi {doc[doi]}`
format, which replaces the `{doc[doi]}` part in the format string by
the `doi` of the selected document.

Here you can see it in action, it first
checks if a citation `doi` is already in the library,
in which case the information is already there.
If the `doi` of the citation is not in our library,
then the infomation gets downloaded via [crossref](http://crossref.org).

{{< figure src="/blog/images/get-paper-references.gif" >}}

And this is pretty much it!

For comments check out the [Reddit post](https://www.reddit.com/r/commandline/comments/k8kbw5/checking_out_paper_references_easily_with_papis/).
