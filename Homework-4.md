# Exercise 4

## Problem
1. Re-do the toy example of a two-person workflow from `src/git/git-workflow.txt` (extending it to three or more people if you want).

## Solution
Many command Lines is the same as `Exercise 3`, we only point something important.
1. Since we did this on the branch `midterm`, so when using `pull` and `push`, we need to know where we pull or push clearly.
```
  git pull origin midterm
  git push origin midterm
```

2. Don't use `git merge` frequently, otherwise some teammates would be confused about it and some files may be deleted or changed to the version what you don't need.


3. When you want to merge the branch `feature-1` to the main branch (in this problem `midterm`), you should first use `git pull` to update the version and switch to the main branch. 
```
  git pull origin feature-1
  git checkout master
  git merge origin/feature-1
```
