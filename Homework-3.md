# Exercise 3
## Problem
1. Install Git;
1. Create an account on Github (or use an existing if you want);
1. Set up a local repository in your project folder;
2. Create folder `homework/week3`;
3. Within it, create the following two folders and two files:

```bash
data/
text/
notes.txt
functions.py
```

and exclude folder `data/` from being tracked;

1. Add and commit everything;
1. Add line reading 'THIS IS FINE' to `notes.txt`, commit the new version with message 'a fine change';
1. Change that line to 'THIS IS GOOD', commit the new version with message 'a good change' *overwriting the previous commit* as if it never happened (make sure `git log` does not show 'a fine change');
1. Change that line to 'THIS IS BAD', save the file and close the editor to make it impossible to use `Ctrl+Z`;
1. Try to restore `notes.txt` to the state where it reads 'THIS IS GOOD';
1. Change that line to 'THIS IS THE BEST' and delete file `functions.py`, commit your changes giving your commit a name such as 'first-working';
1. Undo the previous commit using `git revert`, makes sure `functions.py` does exist and the line reads 'THIS IS GOOD';
1. Create a remote repo on Github/Bitbucket and link your local repo to it;
1. Push all the commits to the remote;
1. Try to revert `notes.txt` to the state where it reads 'THIS IS FINE' keeping all the other changes in place;
1. Commit everything pending and push to the remote;
1. Commit and push the previous homework.

## Solution
0. Make a preparation: 1) `mkdir` : create folder;  2) `echo `: create file;
1. Add and commit everything: 1) `git add .`: add everything; 2) `git commit -m "Initialization`: commit;
2. Add line reading 'THIS IS FINE' to notes.txt, commit the new version with message 'a fine change';
```
  git add notes.txt
  git commit -m "a fine change"
```
3. Change that line to 'THIS IS GOOD', commit the new version with message 'a good change' overwriting the previous 
commit as if it never happened (make sure git log does not show 'a fine change');
```
  git add notes.txt
  git commit --amend -m "a good change"
```
4. Change that line to 'THIS IS BAD', save the file and close the editor to make it impossible to use Ctrl+Z;
5. Try to restore notes.txt to the state where it reads 'THIS IS GOOD';
```
  git restore notes.txt
```
6. Change that line to 'THIS IS THE BEST' and delete file functions.py, commit your changes giving your commit a name such as 'first-working';
```
  git add .
  git commit -m "first-working"
  git tag first-working
```
7. Undo the previous commit using git revert, makes sure functions.py does exist and the line reads 'THIS IS GOOD';
```
  git revert HEAD
```
8. Create a remote repo on Github/Bitbucket and link your local repo to it;
```
  git remote add origin <url>
```
9. Push all the commits to the remote
```
  git push --set-upstream origin master
```
10. Try to revert notes.txt to the state where it reads 'THIS IS FINE' keeping all the other changes in place;
```
  git reflog -5
```
we can use this command Line to find all the logs and it shows:
```
  1363135 (HEAD -> midterm, origin/midterm) HEAD@{0}: revert: Revert "first-working"
  80f96ea (tag: first-working) HEAD@{1}: commit: first-working
  fe69fd6 HEAD@{2}: commit (amend): a good change
  02028d0 HEAD@{3}: commit: a fine change
  6e807e1 HEAD@{4}: commit: Initial -hw3
```
so we know the version should be chosen as `02028d0`
```
  git reset 02028d0  notes.txt
  git checkout notes.txt
  git add .
  git commit -m "Revert notes.txt"
```

  


