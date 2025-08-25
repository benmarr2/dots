
#!/usr/bin/env bash

# Wait until all bars are terminated
while pgrep -x polybar >/dev/null; do sleep 0.2; done

# Launch only on HDMI-0
MONITOR="HDMI-0" polybar --reload bar1 &

echo "Bar launched on HDMI-0"

