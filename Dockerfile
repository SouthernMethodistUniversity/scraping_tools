# docker build -t scraping_tools:latest .
# docker run -it scraping_tools:latest   

FROM ubuntu:20.04
LABEL maintainer "Robert Kalescky <rkalescky@smu.edu>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&\
 apt-get install -y\
 firefox-geckodriver\
 xvfb\
 xserver-xephyr\
 tor\
 zsh\
 git\
 python3-pip\
 python3-tk\
 python3-dev\
 python3-xlib\
 python3-pil\
 python3-stem

RUN ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime &&\
 dpkg-reconfigure -f noninteractive tzdata

RUN pip3 install\
 selenium\
 bs4\
 pandas\
 pyautogui\
 pyvirtualdisplay\
 pyscreenshot\
 jupyterlab

RUN mkdir /data

ENTRYPOINT ["bash"]

