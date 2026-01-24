cd /hom/dev
git clone https://github.com/MKHan91/VQ-Font.git
git clone https://github.com/MKHan91/multi-label-dicasting
git clone https://github.com/Semantic-Segmentation-Research/ssl-semantic-segmentation

git remote set-url origin https://<GIT USERNAME>:<GIT TOKEN>@github.com/MKHan91/VQ-Font.git
git config --global credential.helper store

mkdir /home/dev/ssl-semantic-segmentation/pretrained
gdown --id 1Rx0legsMolCWENpfvE2jUScT3ogalMO8 -O /home/dev/ssl-semantic-segmentation/pretrained/resnet101.pth

mkdir -p /home/dev/data

gdown --id 1mFqk39EwQLQsvo9KSW36QxSohjPongbg -O /home/dev/data/gtFine_trainvaltest.zip
gdown --id 1ux6yQeNkRw1KMsuhSeELD7wIkKZqgoLW -O /home/dev/data/leftImg8bit.zip

cd /home/dev/data
unzip gtFine_trainvaltest.zip
unzip leftImg8bit.zip

mkdir -p /home/dev/Project
mv /home/dev/VQ-Font /home/dev/Project/VQ-Font

gdown --id 1AXPuyS7SJ5r9F8rWcAB-GikTYAiN6cKT -O /hom/dev/Project/VQ-Font/taming/20260117_vq_gan_exp.zip
cd /hom/dev/Project/VQ-Font/taming
unzip 20260117_vq_gan_exp.zip

gdown --id 1WFwuW9I5ZbquxH53dipDmN2gI1XOygVA -O /home/dev/Project/VQ-Font/datasets/20260119_dataset.zip
cd /home/dev/Project/VQ-Font/datasets
unzip 20260119_dataset.zip

