#! /bin/bash

CURRENT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
${CURRENT_DIR}/resources/get_reqs.sh || echo couldnt get reqs.

RESOURCES_DIR="${CURRENT_DIR}/resources"
POSTPROCESS_DIR="/usr/lib/hailo-post-processes"
postprocess_so="$POSTPROCESS_DIR/libyolo_hailortpp_post.so"
hef_path="$RESOURCES_DIR/yolov5s_personface_nv12.hef"
json_config_path="$RESOURCES_DIR/configs/yolov5_personface.json"
q_inst="queue"
src="v4l2src device=/dev/video0 ! video/x-raw,width=640,height=640 ! videoconvert "

PIPELINE="$src ! synchailonet hef-path=$hef_path ! $q_inst ! hailofilter so-path=$postprocess_so config-path=$json_config_path qos=false ! $q_inst ! hailooverlay ! autovideosink"
echo "pipeline: $PIPELINE"
gst-launch-1.0 $PIPELINE
