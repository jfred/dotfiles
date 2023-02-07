# Functions to ease using ec2ssh to jump and tunnel
# 
# Works by providing a means to define a sever convention and pre/post
#
# Usage:
#    create a `jump_transform` script or function that accepts region, vpc and name and 
#    returns the name as defined in ec2. Will be passed to ec2ssh for any 
#    additional narrowing
# 
# Optional:
#    create jump_pre and jump_post scripts or functions that are called prior to 
#    initiating the ssh connection. Can be used to change profile or term
#    settings.

fn_exists() {
    command -v $1 > /dev/null
}

JUMP_REGION=us-east-1
jump () {
    if [ "$#" -lt 1 ]; then
        echo "Usage: jump env [target] ...ec2ssh params" >&2
        return 1
    fi

    if [[ "${1}" == "-c" ]]; then
        ec2ssh -r ${JUMP_REGION} -c
        return
    fi

    local vpc=${1}
    local svr=${2}
    local jump_svr='jump'

    # if jump name transformation is available use it
    if fn_exists 'jump_transform'; then
        svr=$(jump_transform ${JUMP_REGION} ${vpc} ${2})
        jump_svr=$(jump_transform ${JUMP_REGION} ${vpc} jump)
    fi

    # call pre helper if defined
    if fn_exists 'jump_pre'; then
        jump_pre ${vpc}
    fi

    # register post helper call if defined
    if fn_exists 'jump_post'; then
        set -o localoptions -o localtraps
        trap 'jump_post; return 1' INT
    fi

    ec2ssh -r ${JUMP_REGION} -j ${jump_svr} ${svr} ${@:3}

    # call post helper if defined
    if fn_exists 'jump_post'; then
        jump_post ${vpc}
    fi
}

TUNNEL_JUMP_PORT=
tunnel() {
    if [ "${TUNNEL_JUMP_PORT}" -eq "" ]; then
        echo "ERROR: TUNNEL_JUMP_PORT not set" >&2
        return 1
    fi
    if [ "$#" -lt 3 ]; then
        echo "Usage: tunnel env target remoteport [localport] [remote target] [jumpport] " >&2
        return 1
    fi
    jump $1 $2 -F ${6:-${TUNNEL_JUMP_PORT}} -L ${4:-${3}}:${5:-127.0.0.1}:$3
}
