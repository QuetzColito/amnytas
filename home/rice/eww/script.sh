#!/bin/bash

playerctl -F metadata mpris:artUrl -i firefox | sed -e 's/file:\/\///'
