Working with Git
================

1. [Pulling](#pulling)

Pulling
-------

If you’re on the **same** branch as the branch you’re merging in from on the remote, for example you’re merging `origin/develop` into your local `develop` branch, you should use merge with rebase.

Tower:
![Merge with Rebase](assets/git-merge-rebase.png)

**NB** This is different to a rebase, do not use Rebase, use Merge with Rebase (confusing I know).

Command line:
~~~
git pull --rebase
~~~
