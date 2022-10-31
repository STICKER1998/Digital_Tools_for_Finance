# Exercise 1
## Problem
- study command `grep` and the pipe operator `|`;

Create text file 'commandline-cheatsheet.txt', where for each of the following tasks, there is a line with the command(s) that does(do) it:

- create directory `temp/`;
- change working directory to `temp/` (assuming `temp/` exists);
- write 'hello world' to file called `hello.txt`;
- list all files and folders in the *parent* folder of `temp/`;
- list all currently processes running;
- kill process with ID 666;
- write the contents of environment variable `$PATH` to file `path.txt`;
- find file 'hello.txt' in the parent of the current directory;
- find all `.png` files in your home directory and subdirectories;
- find where the executable of command `echo` is located;
- find text 'Select all processes' in the manual of command `ps` (that is, in the output of command `man ps`);
- write the last 20 commands you've executed to file `commands.txt`.

Using the shell of your choice:

- write a bash script (one you could execute on a Linux server) called 'runner.sh' which prints the message provided by the user as an argument to the script; for instance,

  ```bash
  ./runner.sh 'hello'
  ```

  is supposed to display "hello";  
- write a text document describing the steps necessary for a user without superuser privileges to create a cron job on a Linux server that runs every second day at 17:00 executing script "runner.sh 'hello'" (no need to create the job, just describe the steps);
- place all files above in folder "homework/week1" (you will commit and push them once we've covered version control).


## Solution 
There are some command Lines we used
```
  mkdir temp

  cd temp

  echo "hello world" > hello.txt

  ls

  ps

  sudo kill -9 666

  echo "$PATH" > path.txt

  find .. -name "hello.txt"

  find / -name "*.png"

  whereis echo

  man ps | grep "Select all processes"

  history 20 > commands.txt

  nano runner.sh
  echo "$1"
  ./runner.sh hello
```
We can use the cron arrangement, i.e., * * * * * runner.sh;

Each star refers to the Minute, Hour, Day of Month, Month, Day of Week respectively;

We hope to run the runner.sh every second day at 17:00, only need to use 0 17 */2 instead of the first three stars;
