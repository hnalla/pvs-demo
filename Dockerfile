# Use an official Python runtime as a parent image
FROM ultralytics/yolov5:latest

# Set the working directory in the container to /app
WORKDIR /app
# Add the current directory contents into the container at /app
ADD . /app

# Install any needed packages specified in requirements.txt
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    && pip install --no-cache-dir -r requirements.txt

EXPOSE 8040
ENV FLASK_RUN_PORT=8040

CMD ["flask","run","--host=0.0.0.0","--port=8040"]
