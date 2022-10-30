# syntax=docker/dockerfile:1
# 第一行是解析器指令，始终用版本1语法的最新版本

# 基于python镜像
FROM python:3.10
 
# 作者信息
MAINTAINER ZIFENGTANG
 
# 工作目录
WORKDIR /code
 
# 拷贝py文件和requirements.txt文件
ADD . /code
ADD . /
 
# pip安装依赖包
RUN pip install --upgrade pip 
RUN pip install --requirement ./requirements.txt  

COPY . .


# 执行python文件
CMD ["python","docker_test.py"]
