
#!/bin/bash
title=$(xdotool getactivewindow getwindowname 2>/dev/null)

if [ -z "$title" ]; then
  echo "Desktop"
else
  # Extract the application name from the title
  app_name=$(echo "$title" | sed -e 's/.* - //')

  # Output the application name
  echo "$app_name"
fi

