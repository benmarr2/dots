#!/usr/bin/env bash

#!/usr/bin/env bash

# Kill all Polybar instances
killall -q polybar

# Wait until all bars are terminated
while pgrep -x polybar >/dev/null; do sleep 0.2; done

# Launch one bar per monitor
for m in $(polybar --list-monitors | cut -d: -f1); do
  MONITOR="$m" polybar --reload bar1 &
done

echo "Bars launched..."
