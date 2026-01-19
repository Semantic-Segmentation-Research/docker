FROM nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    build-essential \
    git \
    wget \
    python3-pip \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgl1-mesa-glx \
    openssh-server \
    vim \
    git \
    htop \
    unzip
    

RUN pip3 install --no-cache-dir --upgrade pip
RUN pip3 install --no-cache-dir torch==2.9.0 torchvision==0.24.0 torchaudio==2.9.0 --index-url https://download.pytorch.org/whl/cu126
RUN pip3 install --no-cache-dir tensorboard
RUN pip3 install --no-cache-dir torchmetrics
RUN pip3 install --no-cache-dir kornia
RUN pip3 install --no-cache-dir gdown

RUN pip3 install --no-cache-dir matplotlib Pillow tqdm einops PyYAML cityscapesscripts
RUN pip3 install --no-cache-dir scipy

RUN apt-get update && apt-get install -y libglib2.0-0
RUN pip3 install --no-cache-dir opencv-python
RUN pip3 install --no-cache-dir "numpy<2.0"

RUN mkdir -p /home/dev
WORKDIR /home/dev

CMD ["/bin/bash"]
