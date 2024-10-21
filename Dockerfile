FROM ubuntu:24.04
MAINTAINER juancarlos.serrano@urjc.es
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt update && apt-get install -y git

RUN useradd -ms /bin/bash ci

RUN type -p curl >/dev/null || apt install curl -y
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& apt update \
&& apt install gh -y \
&& apt install jq

COPY entrypoint.sh /home/ci
ENTRYPOINT ["/home/ci/entrypoint.sh"]
CMD ["bash"]

