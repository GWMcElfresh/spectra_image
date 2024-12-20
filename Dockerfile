FROM ghcr.io/apptainer/apptainer:latest

ARG DEBIAN_FRONTEND=noninteractive
 
RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    uuid-dev \
    libgpgme11-dev \
    squashfs-tools \
    libseccomp-dev \
    libsqlite3-dev \
    pkg-config \
    git-all \
    wget \
    libbz2-dev \
    zlib1g-dev \
    python3-dev \
    libffi-dev && \
    mkdir /GW_Python && \
    cd /GW_Python && \
    wget https://github.com/python/cpython/archive/refs/tags/v3.8.10.tar.gz && \
    tar -zxvf v3.8.10.tar.gz && \
    cd cpython-3.8.10 && \
    ./configure --prefix=/GW_Python && \ 
    cd /GW_Python/cpython-3.8.10 && \
    make && \
    make install && \
    /GW_Python/bin/pip3 --no-cache-dir install numpy scipy scikit-learn scikit-misc matplotlib tqdm sympy setuptools pandas pyyaml  && \
    /GW_Python/bin/pip3 --no-cache-dir install scSpectra && \
    /GW_Python/bin/pip3 --no-cache-dir install dill && \
    chmod -R 777 /GW_Python

RUN apt install r-base r-base-dev -y && \
    Rscript -e "install.packages('Seurat')" && \
    Rscript -e "install.packages('data.table')"

ENV NUMBA_CACHE_DIR=/work/numba_cache
ENV MPLCONFIGDIR=/work/mpl_cache

ENTRYPOINT ["/bin/bash"]
