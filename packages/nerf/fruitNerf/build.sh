#!/usr/bin/env bash
set -ex

# Clone the repository if it doesn't exist
git clone --branch=${FRUITNERF_VERSION} --depth=1 --recursive https://github.com/meyerls/FruitNeRF /opt/fruitnerf || \
git clone --depth=1 --recursive https://github.com/meyerls/FruitNeRF /opt/fruitnerf

# Navigate to the directory containing PyMeshLab's setup.py
cd /opt/fruitnerf 
mkdir segmentation && cd segmentation
git clone --recursive https://github.com/IDEA-Research/Grounded-Segment-Anything.git grounded_sam

pip3 install -e segment_anything 
pip3 install --no-build-isolation -e GroundingDINO
pip3 install -U opencv-python pycocotools matplotlib onnxruntime onnx ipykernel
wget https://dl.fbaipublicfiles.com/segment_anything/sam_vit_h_4b8939.pth
mkdir pretrained_checkpoint
wget https://huggingface.co/lkeab/hq-sam/resolve/main/sam_hq_vit_h.pth
mv sam_hq_vit_l.pth pretrained_checkpoint

pip3 install -U segment-anything-hq
cd /opt/fruitnerf
pip3 install -e .
ns-install-cli

wget https://zenodo.org/records/10869455/files/FruitNeRF_Real.zip -P /datasets/
wget https://zenodo.org/records/10869455/files/FruitNeRF_Synthetic.zip -P /datasets/
unzip /datasets/FruitNeRF_Real.zip -d /datasets/FruitNeRF_Real
unzip /datasets/FruitNeRF_Synthetic.zip -d /datasets/FruitNeRF_Synthetic