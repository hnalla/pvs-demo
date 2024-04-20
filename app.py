import io
from logging import Logger
from math import floor

import cv2
import numpy as np
import torch
from flask import Flask, jsonify, request
from torchvision.transforms import Resize, ToTensor

logger = Logger("app")

logger.info("Loading the model...")
# Load the model
model = torch.hub.load("ultralytics/yolov5", "yolov5s")
logger.info("Model loaded successfully!")
app = Flask(__name__)


@app.route("/predict", methods=["POST"])
def predict():
    # Get the image from the POST request
    file_image = request.files["file"].read()

    np_image = np.frombuffer(file_image, np.uint8)
    image = cv2.imdecode(np_image, cv2.IMREAD_COLOR)
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)

    results = model(image)

    results_df = results.pandas().xyxy[0]

    results_df.sort_values("confidence", ascending=False, inplace=True)
    df = results_df[["name", "confidence"]].drop_duplicates(subset="name", keep="first")
    return df.to_json(orient="records")


@app.route("/", methods=["GET"])
def health_check():
    return {"status": "ok"}


if __name__ == "__main__":
    app.run()
