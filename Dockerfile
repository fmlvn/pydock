FROM python:3-slim
MAINTAINER Viet Hung Nguyen <hvn@familug.org>

RUN apt-get -qy update && apt-get install -y tmux nano python3-doc w3m vim && rm -rf /var/lib/apt/lists/*
RUN cp /usr/share/vim/vim74/vimrc_example.vim /root/.vimrc
RUN pip install ipython flake8
RUN mkdir /app ; echo "include /usr/share/nano/python.nanorc\nset autoindent" > /root/.nanorc; \
    echo 'echo "Use nano filename.py to code. Ctrl-X to save/quit.\nPress Ctrl-B o to switch pane, press Ctrl-B n to switch window"' >> /root/.bashrc
WORKDIR /app
ENTRYPOINT tmux new-session -s pymi -d 'w3m /usr/share/doc/python3/html/index.html' \; new-window 'ipython' \; split-window -h \; attach
