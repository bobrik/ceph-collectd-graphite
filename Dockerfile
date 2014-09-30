FROM ubuntu:14.04

MAINTAINER Ian Babrou <ibobrik@gmail.com>

# upgrade
RUN apt-get update
RUN apt-get upgrade -y

# ceph
RUN apt-get install -y ceph

# collectd
RUN apt-get --no-install-recommends -y install collectd libpython2.7 python-pip git-core
RUN pip install envtpl
ADD collectd.conf.tpl /etc/collectd/collectd.conf.tpl

# collectd-ceph
RUN git clone https://github.com/rochaporto/collectd-ceph.git /tmp/collectd-ceph
RUN mkdir /usr/lib/collectd/plugins
RUN mv /tmp/collectd-ceph/plugins /usr/lib/collectd/plugins/ceph
RUN rm -rf /tmp/collectd-ceph

# ceph config dir should be available
VOLUME /etc/ceph

ADD ./run.sh /run.sh
CMD /run.sh
