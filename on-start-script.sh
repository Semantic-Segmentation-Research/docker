cd /workspace

git clone https://github.com/Semantic-Segmentation-Research/ssl-semantic-segmentation
git config --global credential.helper store
git config --global user.name "MKHan91"
git config --global user.email "audrbz@naver.com"

mkdir -p /workspace/data
wget https://huggingface.co/datasets/mkhan91/Cityscapes/resolve/main/leftImg8bit.zip -O /workspace/data/leftImg8bit.zip
wget https://huggingface.co/datasets/mkhan91/Cityscapes/resolve/main/gtFine_trainvaltest.zip -O /workspace/data/gtFine_trainvaltest.zip

cd /workspace/data
unzip gtFine_trainvaltest.zip
unzip leftImg8bit.zip

rm -rf /workspace/data/gtFine_trainvaltest.zip
rm -rf /workspace/data/leftImg8bit.zip