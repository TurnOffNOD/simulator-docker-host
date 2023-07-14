FROM ubuntu:22.04

LABEL maintainer.name="Tong Xian"
LABEL maintainer.email="tongxian22@mails.ucas.ac.cn"

ENV TZ=Asia/Shanghai

RUN ln -snf "/usr/share/zoneinfo/$TZ" /etc/localtime \
    && echo "$TZ" > /etc/timezone \
    # solve the timezone information, without which tzdata will require manual input, but docker build cmdline can't input selection
    && sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list \
    && sed -i 's/security.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
    && apt update \
    && apt install -y apt-utils dialog \
    && echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections \
    # These are installed to get rid of "debconf: unable to initialize frontend: Dialog" error
    && apt full-upgrade -y \
    && apt install -y ca-certificates \
    && update-ca-certificates \
    && apt install -y apt-transport-https \
    && sed -i 's/http:/https:/g' /etc/apt/sources.list \
    && apt update \
    && apt install -y vim bash-completion command-not-found \
    #&& apt install build-essential git scons \
    && apt install -y build-essential gdb clang llvm lldb git m4 scons zlib1g zlib1g-dev libprotobuf-dev protobuf-compiler libprotoc-dev libgoogle-perftools-dev python3-dev python-is-python3 libboost-all-dev pkg-config python3 python3-pip pre-commit libhdf5-dev libpng-dev libboost-all-dev \
    #gem5 build dependencies with additional
    cmake python3-matplotlib python3-numpy libatlas-base-dev \
    # dramsim3 build dependencies
    swig \
    # ramulator build dependices, libgoogle-perftools-dev already have in the list of gem5
    screen tmux byobu \
    # useful utils
    #&& apt dist-upgrade -y \
    && apt clean

#RUN cd ~
#RUN mkdir sim-on-docker
#cd sim-on-docker

#RUN git clone https://github.com/gem5/gem5.git gem5-in-docker
#RUN git clone https://github.com/umd-memsys/DRAMsim3.git dramsim3-in-docker
#RUN cd gem5-in-docker


