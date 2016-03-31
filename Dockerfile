FROM centos:latest
MAINTAINER Etsuji Nakai
RUN yum -y update
RUN yum -y groupinstall "Development Tools"
RUN yum -y install epel-release && \
    yum -y install python-devel python-pip && \
           lapack-devel freetype-devel libpng-devel libjpeg-turbo-devel
RUN pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.7.1-cp27-none-linux_x86_64.whl
RUN pip install pandas scipy jupyter && \
    pip install scikit-learn matplotlib Pillow

RUN jupyter notebook --generate-config
RUN echo "c.NotebookApp.ip = '*'" >>/root/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.open_browser = False" >>/root/.jupyter/jupyter_notebook_config.py
#RUN echo "c.Application.log_level = 'DEBUG'" >>/root/.jupyter/jupyter_notebook_config.py

ADD init.sh /usr/local/bin/init.sh
RUN chmod u+x /usr/local/bin/init.sh
EXPOSE 8888
CMD ["/usr/local/bin/init.sh"]
