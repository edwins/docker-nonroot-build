#FROM ubuntu
FROM centos

ARG LOCAL_USER=myuser
ARG LOCAL_USER_UID=100000
ARG LOCAL_USER_GID=100000
ARG PRIV_CMDS='/bin/ch*,/bin/cat,/bin/gzip,/bin/mkdir,/bin/ps,/bin/mv,/bin/cp,/usr/bin/apt*,/usr/bin/pip*,/bin/yum'

SHELL ["/bin/bash", "-c"]

RUN if [ -x /usr/bin/apt ]; then \
      apt-get update && apt-get -y install sudo && rm -rf /var/lib/apt/lists/*; \
    elif [ -x /bin/yum ]; then \
      yum -y update && yum -y install sudo && yum clean all; \
    fi

RUN groupadd -g $LOCAL_USER_GID $LOCAL_USER && \
    useradd  -m -g $LOCAL_USER_GID -m -s /bin/bash -u $LOCAL_USER_UID $LOCAL_USER && \
    echo "$LOCAL_USER	ALL=NOPASSWD: $PRIV_CMDS" >> /etc/sudoers

USER $LOCAL_USER
