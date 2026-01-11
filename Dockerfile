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

RUN pip3 install --no-cache-dir matplotlib Pillow tqdm einops PyYAML cityscapesscripts
RUN pip3 install --no-cache-dir scipy

RUN apt-get update && apt-get install -y libglib2.0-0
RUN pip3 install --no-cache-dir opencv-python
RUN pip3 install --no-cache-dir "numpy<2.0"

# 개발용 디렉토리
RUN mkdir -p /home/dev
WORKDIR /home/dev

# ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libtcmalloc_minimal.so.4

CMD ["/bin/bash"]


#### cud121-corrmatch docker image ####
# CUDA 12.1 + Cudnn8 + nvcc(development)
# FROM nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04

# # runtime 라이브러리 우선순위 설정
# ENV CUDA_HOME=/usr/local/cuda
# ENV LD_LIBRARY_PATH=/usr/lib/wsl/lib:/usr/local/nvidia/lib64:/usr/local/cuda/lib64
# ENV NVIDIA_VISIBLE_DEVICES=all
# ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility

# ENV DEBIAN_FRONTEND=noninteractive \
#     CUDA_HOME=/usr/local/cuda \
#     PATH=/usr/local/cuda/bin:${PATH}

# # stub libcuda 제거
# RUN rm -f /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1 || true

# # system package
# RUN apt-get update && apt-get upgrade -y && apt-get install -y \
#     build-essential \
#     git \
#     wget \
#     python3-pip \
#     libsm6 \
#     libxext6 \
#     libxrender-dev \
#     libgl1-mesa-glx \
#     openssh-server \
#     vim \
# && rm -rf /var/lib/apt/lists/*

# # PyTorch + 기타 라이브러리 (cu121 휠 사용)
# RUN python3 -m pip install --upgrade pip && \
#     python3 -m pip install --index-url https://download.pytorch.org/whl/cu121 \
#         torch==2.1.0 torchvision==0.16.0 torchaudio==2.1.0 && \
#     python3 -m pip install \
#         "numpy<2.0" \
#         matplotlib \
#         Pillow \
#         tqdm \
#         einops \
#         PyYAML


# # 개발용 디렉토리
# RUN mkdir -p /home/dev
# WORKDIR /home/dev

# # 필요 시 tcmalloc
# # ENV LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libtcmalloc_minimal.so.4

# CMD ["/bin/bash"]

# DOCKER-FILE
# 이미지를 만드는 설계도
# 

########################################### 25-8-21 New Image ##############################################################


# # CUDA 12.1 + Cudnn8 + nvcc(development)
# FROM nvidia/cuda:12.1.1-cudnn8-devel-ubuntu22.04

# # 기본 환경
# ENV DEBIAN_FRONTEND=noninteractive \
#     CUDA_HOME=/usr/local/cuda \
#     PATH=/usr/local/cuda/bin:${PATH} \
#     PIP_NO_CACHE_DIR=1 \
#     PYTHONUNBUFFERED=1

# # ★ 런타임에서 stubs/libcuda 로드 방지
# RUN rm -f /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1 || true

# # ---- 시스템 패키지 ----
# # * upgrade 제거(재현성/용량)
# # * -dev 대신 런타임용 libxrender1
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     build-essential git wget ca-certificates \
#     python3 python3-pip python3-venv \
#     libglib2.0-0 libsm6 libxext6 libxrender1 libgl1-mesa-glx \
#     vim \
# && rm -rf /var/lib/apt/lists/*

# # pytorch cuda121
# RUN python3 -m pip install -U pip && \
#     python3 -m pip install --index-url https://download.pytorch.org/whl/cu121 \
#         torch==2.1.0 torchvision==0.16.0 torchaudio==2.1.0 && \
#     python3 -m pip install \
#         "numpy<2.0" matplotlib Pillow tqdm einops PyYAML

# # WSL 드라이버 경로 자동 감지
# # Container 실행 시 /usr/lib/wsl/lib 과 /usr/lib/wsl/drivers 를 바인드
# # 실제 드라이버 디렉토리 (libcuda.so.1.1 존재)를 찾아서 LD_LIBRARY_PATH 구성
# RUN printf '%s\n' \
# '#!/usr/bin/env bash' \
# 'set -e' \
# 'WSL_LIB="/usr/lib/wsl/lib"' \
# 'DRV_DIR="$(dirname "$(find /usr/lib/wsl/drivers -type f -name libcuda.so.1.1 2>/dev/null | head -n1)")"' \
# 'NEW_LD="$WSL_LIB"' \
# '[[ -n "$DRV_DIR" ]] && NEW_LD="$NEW_LD:$DRV_DIR"' \
# 'NEW_LD="$NEW_LD:/usr/local/nvidia/lib64:/usr/local/cuda/lib64"' \
# 'export LD_LIBRARY_PATH="$NEW_LD${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"' \
# '# 선택: PTX JIT/링커가 있을 경우에만 선로드(없으면 스킵)' \
# 'PTX_SO="$(find "$WSL_LIB" ${DRV_DIR:+ "$DRV_DIR"} -type f -name "libnvidia-ptxjitcompiler.so*" 2>/dev/null | head -n1 || true)"' \
# 'JIT_SO="$(find /usr/local/cuda/lib64 -type f -name "libnvJitLink.so*" 2>/dev/null | head -n1 || true)"' \
# 'if [[ -n "$PTX_SO" && -n "$JIT_SO" ]]; then' \
# '  export LD_PRELOAD="$PTX_SO:$JIT_SO${LD_PRELOAD:+:$LD_PRELOAD}"' \
# 'fi' \
# 'exec "$@"' \
# > /usr/local/bin/entrypoint.sh && chmod +x /usr/local/bin/entrypoint.sh

# # 작업 디렉토리
# RUN mkdir -p /home/dev
# WORKDIR /home/dev

# # 엔트리포인트/디폴트 쉘
# ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
# CMD ["bash"]
