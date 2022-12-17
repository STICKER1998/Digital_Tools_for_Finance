# syntax=docker/dockerfile:1
# Based On the image of Python
FROM python:3.10
# The Info of Author
MAINTAINER ZIFENGTANG
# # Setting the working directory to /code
WORKDIR /code
# # Copy the current directory contents into the container at /code
ADD . /code
# ADD . /
# pip the libs
RUN pip install --upgrade pip
RUN pip install --requirement ./requirements.txt
# Run docker_test.py when the container launches
CMD ["python","Risk_Parity.py"]
