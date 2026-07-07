#!/bin/bash

# ==============================================================================
# 사용자 설정 영역
# ==============================================================================
IMAGE_NAME="ssl-segmentation:latest"    # 빌드한 도커 이미지 이름
CONTAINER_NAME="segmentation"      # 생성할 컨테이너 이름

# 디렉토리 마운트 (현재 폴더를 컨테이너의 작업 디렉토리와 연결)
HOST_DIR=$(pwd)                    # 호스트 시스템의 현재 경로
CONTAINER_DIR="/workspace"          # Dockerfile의 WORKDIR과 일치시킴

# ==============================================================================
# 도커 실행 명령어
# ==============================================================================
echo "====================================================="
echo " Starting Docker Container: $CONTAINER_NAME"
echo " Image: $IMAGE_NAME"
echo " Mount: $HOST_DIR -> $CONTAINER_DIR"
echo "====================================================="

# 기존에 같은 이름의 컨테이너가 실행 중이거나 정지되어 있다면 삭제
if [ "$(docker ps -aq -f name=^/${CONTAINER_NAME}$)" ]; then
    echo "Removing existing container named '$CONTAINER_NAME'..."
    docker rm -f $CONTAINER_NAME > /dev/null
fi

# 도커 컨테이너 실행 (포트 관련 -p 옵션 모두 제거됨)
docker run -it \
    --gpus all \
    --name $CONTAINER_NAME \
    --rm \
    --shm-size=16g \
    -v "$HOST_DIR":"$CONTAINER_DIR" \
    -w $CONTAINER_DIR \
    $IMAGE_NAME \
    /bin/bash