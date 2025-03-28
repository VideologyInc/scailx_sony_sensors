#!/bin/bash
set -e

CURRENT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
${CURRENT_DIR}/resources/get_reqs.sh || echo couldnt get reqs.

function init_variables() {
    readonly RESOURCES_DIR="${CURRENT_DIR}/resources"
    readonly POSTPROCESS_DIR="/usr/lib/hailo-post-processes"
    readonly DEFAULT_POSTPROCESS_SO="$POSTPROCESS_DIR/libyolo_hailortpp_post.so"
    readonly DEFAULT_HEF_PATH="$RESOURCES_DIR/yolov5s_personface_nv12.hef"
    readonly DEFAULT_JSON_CONFIG_PATH="$RESOURCES_DIR/configs/yolov5_personface.json"

    postprocess_so=$DEFAULT_POSTPROCESS_SO
    hef_path=$DEFAULT_HEF_PATH
    json_config_path=$DEFAULT_JSON_CONFIG_PATH 
    sync_pipeline=false
    num_of_src=4
    compositor_locations="sink_0::xpos=0 sink_0::ypos=0 sink_1::xpos=640 sink_1::ypos=0 sink_2::xpos=0 sink_2::ypos=640 sink_3::xpos=640 sink_3::ypos=640 "    
    print_gst_launch_only=false
    q_inst="queue leaky=no max-size-buffers=10 max-size-bytes=0 max-size-time=0"
    videosink="xvimagesink"
    additional_parameters=""
}

function print_usage() {
    echo "Multistream Detection hailo - pipeline usage:"
    echo ""
    echo "Options:"
    echo "  --help                          Show this help"
    echo "  --show-fps                      Printing fps"
    echo "  --fakesink                      Run the application without display"
    echo "  --num-of-sources NUM            Setting number of sources to given input (default and maximum value is 6)"
    echo "  --print-gst-launch              Print the ready gst-launch command without running it"
    exit 0
}


function parse_args() {
    while test $# -gt 0; do
        if [ "$1" = "--help" ] || [ "$1" == "-h" ]; then
            print_usage
            exit 0
        elif [ "$1" = "--print-gst-launch" ]; then
            print_gst_launch_only=true
        elif [ "$1" = "--show-fps" ]; then
            echo "Printing fps" 
            #grep all hailo_display but filter out GstGhostPad:
            additional_parameters="-v | grep hailo_display | grep -v GstGhostPad"
            additional_parameters="-v | grep hailo_display"

        elif [ "$1" = "--fakesink" ]; then
            echo "Running without display"
            videosink="fakesink"
            sync_pipeline=true 
        elif [ "$1" = "--num-of-sources" ]; then
            shift
            if [ $1 -gt 6 ]; then
                echo "Received number of sources: $1, but maximum number of sources is 8"
                exit 1
            fi
            echo "Setting number of sources to $1"
            num_of_src=$1
        else
            echo "Received invalid argument: $1. See expected arguments below:"
            print_usage
            exit 1
        fi
        shift
    done
}


function create_sources() {
    for ((n = 0; n < $num_of_src; n++)); do
        sources+="uridecodebin3 uri=file://$RESOURCES_DIR/detection$n.mp4 \
                name=source_$n ! videorate ! video/x-raw,framerate=30/1 ! \
                ${q_inst} ! videoconvert ! ${q_inst} ! \
                videoscale ! video/x-raw,width=640,height=640,pixel-aspect-ratio=1/1 ! \
                fun.sink_$n sid.src_$n ! queue name=comp_q_$n leaky=downstream max-size-buffers=5 \
                max-size-bytes=0 max-size-time=0 ! comp.sink_$n "
    done
}

function main() {
    init_variables $@
    parse_args $@
    create_sources

    pipeline="gst-launch-1.0 \
           funnel name=fun ! \
           ${q_inst} ! \
           synchailonet hef-path=$hef_path ! \
           ${q_inst} ! \
           hailofilter so-path=$postprocess_so config-path=$json_config_path qos=false ! \
           ${q_inst} ! \
           hailooverlay ! \
           streamiddemux name=sid compositor name=comp start-time-selection=0 $compositor_locations ! \
           ${q_inst} ! \
           videoconvert ! ${q_inst} ! \
           vpuenc_h264 qp-max=30 qp-min=18 ! websink is-live=true \
           $sources ${additional_parameters}"

    echo ${pipeline}
    if [ "$print_gst_launch_only" = true ]; then
        exit 0
    fi

    echo "Running Pipeline..."
    eval "${pipeline}"

}

main $@
