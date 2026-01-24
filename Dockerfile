FROM nvidia/cuda:12.6.3-cudnn-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    wget \
    python3-pip \
    unzip \
    vim \
    htop \
    openssh-server \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*
    

RUN pip3 install --no-cache-dir --upgrade pip
RUN pip3 install --no-cache-dir torch==2.9.0 torchvision==0.24.0 torchaudio==2.9.0 --index-url https://download.pytorch.org/whl/cu126
RUN pip3 install --no-cache-dir tensorboard
RUN pip3 install --no-cache-dir torchmetrics
RUN pip3 install --no-cache-dir kornia
RUN pip3 install --no-cache-dir gdown
RUN pip3 install --no-cache-dir sconf
RUN pip3 install --no-cache-dir omegaconf
RUN pip3 install --no-cache-dir lmdb
RUN pip3 install --no-cache-dir scikit-image
RUN pip3 install --no-cache-dir lpips
RUN pip3 install --no-cache-dir pytorch-lightning==1.9.0

RUN pip3 install --no-cache-dir matplotlib Pillow tqdm einops PyYAML cityscapesscripts
RUN pip3 install --no-cache-dir scipy

RUN apt-get update && apt-get install -y libglib2.0-0
RUN pip3 install --no-cache-dir opencv-python
RUN pip3 install --no-cache-dir "numpy<2.0"
RUN pip3 install --no-cache-dir albumentations

RUN mkdir -p /home/dev
WORKDIR /home/dev

CMD ["/bin/bash"]
