#!/bin/bash

# 에러 발생 시 스크립트 중단
set -e

echo "====================================================="
echo " Starting RunPod Environment Optimization & Setup "
echo "====================================================="

# 1. 환경 변수 설정
export DEBIAN_FRONTEND=noninteractive
export PYTHONDONTWRITEBYTECODE=1
export PYTHONUNBUFFERED=1
export PIP_NO_CACHE_DIR=1

# 2. APT 시스템 패키지 설치
echo "--> Installing system packages via apt..."
apt-get update && apt-get install -y --no-install-recommends \
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
    libgl1 \
    && rm -rf /var/lib/apt/lists/*

# 3. Pip 및 빌드 툴 업데이트
echo "--> Upgrading pip, setuptools, and wheel..."
python3 -m pip install --upgrade pip setuptools wheel

# 4. PyTorch 및 CUDA 12.8 관련 라이브러리 설치
echo "--> Installing PyTorch with CUDA 12.8 for RTX 5090..."
python3 -m pip install --no-cache-dir \
    torch torchvision torchaudio \
    --index-url https://download.pytorch.org/whl/cu128

# 5. 기타 딥러닝 및 이미지 처리 종속성 패키지 설치
echo "--> Installing deep learning & image processing packages..."
python3 -m pip install --no-cache-dir \
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
    pytorch-lightning \
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

echo "====================================================="
echo " Environment Setup Completed Successfully! "
echo "====================================================="