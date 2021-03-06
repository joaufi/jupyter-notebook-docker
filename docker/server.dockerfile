FROM centos:7

USER root

# create the /app dir for copying/mounting our application files into
RUN mkdir /app

# install system dependencies
COPY docker/bin/yum_install.sh /yum_install.sh
RUN [ "/yum_install.sh" ]

# set env vars for making use of pyenv
ENV PYENV_ROOT /pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

# clone pyenv- in essence this installs it
RUN git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT
RUN git clone https://github.com/pyenv/pyenv-virtualenv.git $PYENV_ROOT/plugins/pyenv-virtualenv

# install Python version and set it as global default version
# use --verbose here otherwise the download and install of Python could appear
# to be hanging and cancelled prematurely by the user
RUN pyenv install --verbose 3.8.1
RUN pyenv virtualenv 3.8.1 app-stackist
ENV PYENV_VERSION app-stackist

# copy contents of repository into docker /app context
COPY ./ /app

# set the working dir as the dir to open when the container is initially run
# and for any docker commands to reference after this point
WORKDIR /app

# upgrade pip to remove ugly warnings; should figure out how to build with most
# recent version of pip in pyenv
RUN pyenv exec pip install --upgrade pip

# install app and test requirements
RUN pyenv exec pip install -r requirements.txt

# optionally install vim bindings
ARG INSTALL_VIM_BINDINGS=false
RUN ./docker/bin/install_vim_bindings.sh

ENTRYPOINT jupyter notebook --ip=0.0.0.0 --port=8888 --notebook-dir=./notebooks --allow-root --no-browser
