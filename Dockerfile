FROM centos:centos7

ENV CALIBRE_URL=https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py \
    BOOKSTACK_VER=v2.3 \
    BOOKSTACK_PKG=BookStack.V2.3_Linux_amd64.zip 

RUN yum install -y wget unzip git \
  ###install calibre
  && wget -nv -O- ${CALIBRE_URL} | python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()" \
  && rm -rf /tmp/calibre-installer-cache \
  ###install chrome
  && wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm \
  && yum -y localinstall google-chrome-stable_current_x86_64.rpm \
  && rm -rf google-chrome-stable_current_x86_64.rpm \ 
  ###install bookstack
  && cd /opt/ \
  && wget https://github.com/TruthHun/BookStack/releases/download/${BOOKSTACK_VER}/${BOOKSTACK_PKG} \
  && unzip ${BOOKSTACK_PKG} \
  && rm -rf ${BOOKSTACK_PKG} \
  && yum clean all

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

WORKDIR /opt/bookstack/
EXPOSE 8181

ENTRYPOINT [ "/entrypoint.sh" ]
