FROM nvidia/cuda:12.6.3-cudnn9-devel-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    wget \
    curl \
    unzip \
    vim \
    htop \
    openssh-server \
    python3-pip \
    python3-dev \
    python3-venv \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgl1-mesa-glx \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --upgrade pip setuptools wheel

RUN python3 -m pip install --no-cache-dir \
    torch==2.9.0 torchvision==0.24.0 torchaudio==2.9.0 \
    --index-url https://download.pytorch.org/whl/cu126

RUN python3 -m pip install --no-cache-dir \
    tensorboard \
    torchmetrics \
    kornia \
    timm \
    gdown \
    sconf \
    omegaconf \
    lmdb \
    scikit-image \
    lpips \
    pytorch-lightning==1.9.0 \
    matplotlib \
    Pillow \
    tqdm \
    einops \
    PyYAML \
    cityscapesscripts \
    scipy \
    opencv-python \
    "numpy<2.0" \
    albumentations \
    pandas \
    seaborn

WORKDIR /home/dev

CMD ["/bin/bash"]
