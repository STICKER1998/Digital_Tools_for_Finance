# Exercise 2.1
## Problems
1. install a nice text editor;
2. install Python (best with anaconda or miniconda) and make sure you can run `pip` or `conda` from the command line;
3. install `cookiecutter`;
4. create a directory for the group project you are supposed to hand in as the graded assignment for this course and set up a basic structure for it (best by using cookiecutter and trimming unnecessary stuff);
5. create an environment variable `RESEARCH_PATH` (don't forget about the platform-specific '&' and '%') referencing the folder with all your projects;
6. (optional) if unhappy with Python, install R or Julia or anything of your choice;
7. install git and create an account on GitHub;
8. make sure you can run `git` from the command line (on Windows, you can install **git bash** to emulate the terminal for git-related commands).

## Solutions 
We only show the key step 4 as below:

1.Get the template using `cookiecutter`;

`cookiecutter https://github.com/drivendata/cookiecutter-data-science`

2.Git Init /add/commit/push;
`git init`, `git add .`, `git commit -m "Initial V-1.0"`,  `git push --set-upstream origin master`

3.Construct the branch `midterm` and switch to it;

`git branch midterm`

`git checkout midterm`

4.Under the branch construct some folders to upload the homeworks;

# Exercise 2.2
## Problems
1. in your favorite language, write a script to plot data in `data/coding-environment-exercise.csv`;
2. write a `Dockerfile` that would allow anyone to do the same plotting that you did, in the same language, given that the .csv file above is present in folder `data/`; anyone should be able to `cd` into some folder, copy your Dockerfile and `data/coding-environment-exercise.csv` therein, build the image, create a container, plot the data and either see the plot or be able to copy it to the local machine.

## Solutions 
1. We first write a python script `docker_test.py` which is in `scr/` and `Homework/week2/Homework2.2` to plot data in `data/coding-environment-exercise.csv`;

2. Write a `requirements.txt` to give a list of libs which should be installed;

3. Write a `Dockerfile` in order to construct a image in Doceker;

4. **Build a container image**: in the terminal, we use the command Line to construct an image (the image is named as "dtff-hw2"): `docker build  --tag dtff-hw2` ;

5. **Start a container**: After a long wait, we can start a container by the Command Line: `docker run -it -v "$(pwd)/out:/out" dtff-hw2`;  A new folder which is called `out/` would be generated in the present folder which contains the figure of the data `coding-environment-exercise.csv`;


