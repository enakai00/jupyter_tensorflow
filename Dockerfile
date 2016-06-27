FROM centos:7
MAINTAINER Etsuji Nakai
RUN yum -y update
RUN yum -y groupinstall "Development Tools"
RUN yum -y install epel-release && \
    yum -y install python-devel python-pip lapack-devel freetype-devel \
           libpng-devel libjpeg-turbo-devel ImageMagick
RUN pip install https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.9.0-cp27-none-linux_x86_64.whl
RUN pip install pandas scipy jupyter && \
    pip install scikit-learn matplotlib Pillow && \
    pip install google-api-python-client

RUN jupyter notebook --generate-config && \
    ipython profile create
RUN echo "c.NotebookApp.ip = '*'" >>/root/.jupyter/jupyter_notebook_config.py && \
    echo "c.NotebookApp.open_browser = False" >>/root/.jupyter/jupyter_notebook_config.py && \
    echo "c.InteractiveShellApp.matplotlib = 'inline'" >>/root/.ipython/profile_default/ipython_config.py  
#RUN echo "c.Application.log_level = 'DEBUG'" >>/root/.jupyter/jupyter_notebook_config.py

ADD init.sh /usr/local/bin/init.sh
RUN chmod u+x /usr/local/bin/init.sh
EXPOSE 8888
CMD ["/usr/local/bin/init.sh"]
