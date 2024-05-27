#!/bin/sh

curl -s 'http://192.168.1.126:8080/photo.jpg' -o /home/thib/image/ipcam/$(date +"%Y_%m_%d_%I_%M_%p_%S").jpg
