ffmpeg \
  -f avfoundation \
  -framerate 2 \
  -pixel_format bgr0 \
  -i 1 \
  -c:v libvpx-vp9 \
  -preset ultrafast \
  -g 4 \
  -cpu-used 8 \
  -deadline realtime \
  -maxrate 128k \
  `date +%Y-%m-%d-%H-%M.webm`
