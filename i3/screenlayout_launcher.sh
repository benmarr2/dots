#!/bin/bash

layout=$(ls ~/.screenlayout/*.sh | xargs -n 1 basename | rofi -dmenu -p "Screen Layout")

[ -n "$layout" ] && bash "$HOME/.screenlayout/$layout"
