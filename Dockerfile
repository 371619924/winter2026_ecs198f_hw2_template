# 1) Base image Debian bookworm
FROM debian:bookworm

ARG DEBIAN_FRONTEND=noninteractive

# 2) Install prerequisites (wget/git/ca-certs/bzip2) for downloading & running Miniconda and cloning repo
RUN apt-get update && apt-get install -y --no-install-recommends \
      wget \
      git \
      ca-certificates \
      bzip2 \
    && rm -rf /var/lib/apt/lists/*

# 3) Install Miniconda (latest Linux x86_64 installer) in silent/batch mode

ENV CONDA_DIR=/opt/conda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -b -u -p "${CONDA_DIR}" \
    && rm -f /tmp/miniconda.sh \
    && "${CONDA_DIR}/bin/conda" clean -afy

# Put conda on PATH
ENV PATH="${CONDA_DIR}/bin:${PATH}"

# 4) Clone the repo into the root directory 
RUN git clone https://github.com/dbarnett/python-helloworld /python-helloworld

WORKDIR /python-helloworld

CMD ["/bin/bash"]
