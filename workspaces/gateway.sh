#!/usr/bin/env bash
# ==============================================================
# OpenClaw Gateway Auto-Runner
# Keeps the gateway running, auto-restarts on crash/exit.
# Usage: ./gateway.sh [start|stop|status|logs]
# ==============================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PID_FILE="/tmp/openclaw-gateway.pid"
LOG_FILE="/tmp/openclaw-gateway.log"

# --- Gateway settings (edit as needed) ---
GATEWAY_PORT="${OPENCLAW_GATEWAY_PORT:-18789}"
RESTART_DELAY=5        # seconds to wait before restarting
MAX_RESTARTS=10        # max consecutive restarts before giving up
RESTART_WINDOW=300     # reset restart counter after this many seconds of uptime

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() { echo -e "[$(date '+%Y-%m-%d %H:%M:%S')] $*"; }

start_gateway() {
    if is_running; then
        echo -e "${YELLOW}Gateway is already running (PID: $(cat "$PID_FILE"))${NC}"
        return 0
    fi

    echo -e "${GREEN}Starting OpenClaw Gateway...${NC}"
    nohup bash -c '
        restart_count=0
        max_restarts='"$MAX_RESTARTS"'
        restart_delay='"$RESTART_DELAY"'
        restart_window='"$RESTART_WINDOW"'

        while true; do
            start_time=$(date +%s)
            echo "[$(date "+%Y-%m-%d %H:%M:%S")] Starting gateway (attempt $((restart_count + 1)))..."

            openclaw gateway run 2>&1

            exit_code=$?
            end_time=$(date +%s)
            uptime=$((end_time - start_time))

            echo "[$(date "+%Y-%m-%d %H:%M:%S")] Gateway exited with code $exit_code after ${uptime}s"

            # Reset counter if it ran long enough
            if [ "$uptime" -ge "$restart_window" ]; then
                restart_count=0
            fi

            restart_count=$((restart_count + 1))

            if [ "$restart_count" -ge "$max_restarts" ]; then
                echo "[$(date "+%Y-%m-%d %H:%M:%S")] ERROR: Max restarts ($max_restarts) reached. Giving up."
                rm -f '"$PID_FILE"'
                exit 1
            fi

            echo "[$(date "+%Y-%m-%d %H:%M:%S")] Restarting in ${restart_delay}s... ($restart_count/$max_restarts)"
            sleep "$restart_delay"
        done
    ' >> "$LOG_FILE" 2>&1 &

    local pid=$!
    echo "$pid" > "$PID_FILE"
    echo -e "${GREEN}Gateway auto-runner started (PID: $pid)${NC}"
    echo -e "Logs: ${YELLOW}$LOG_FILE${NC}"
}

stop_gateway() {
    if ! is_running; then
        echo -e "${YELLOW}Gateway is not running.${NC}"
        # Still try to stop any orphaned gateway process
        pkill -f "openclaw gateway" 2>/dev/null || true
        return 0
    fi

    local pid
    pid=$(cat "$PID_FILE")
    echo -e "${RED}Stopping gateway auto-runner (PID: $pid)...${NC}"

    # Kill the wrapper and all children
    kill -- -"$pid" 2>/dev/null || kill "$pid" 2>/dev/null || true
    pkill -f "openclaw gateway" 2>/dev/null || true

    rm -f "$PID_FILE"
    echo -e "${GREEN}Stopped.${NC}"
}

status_gateway() {
    if is_running; then
        local pid
        pid=$(cat "$PID_FILE")
        echo -e "${GREEN}Gateway auto-runner is running (PID: $pid)${NC}"
        openclaw gateway status 2>/dev/null || openclaw status 2>/dev/null || true
    else
        echo -e "${RED}Gateway auto-runner is not running.${NC}"
    fi
}

show_logs() {
    if [ -f "$LOG_FILE" ]; then
        tail -f "$LOG_FILE"
    else
        echo "No log file found at $LOG_FILE"
    fi
}

is_running() {
    [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null
}

# --- Main ---
case "${1:-start}" in
    start)  start_gateway ;;
    stop)   stop_gateway ;;
    restart)
        stop_gateway
        sleep 2
        start_gateway
        ;;
    status) status_gateway ;;
    logs)   show_logs ;;
    *)
        echo "Usage: $0 {start|stop|restart|status|logs}"
        exit 1
        ;;
esac
