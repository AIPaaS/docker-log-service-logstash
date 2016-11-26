FROM centos:7

# Delete CentOS installation log
RUN rm -Rf /var/log/anaconda  
  
# Install Filebeat
# See https://www.elastic.co/downloads/beats/filebeat for current version
# https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.0.0-x86_64.rpm
# https://download.elastic.co/beats/filebeat/filebeat-1.3.1-x86_64.rpm
RUN curl -LO https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.0.0-x86_64.rpm && \
  yum localinstall -y filebeat-5.0.0-x86_64.rpm && \
  rm -f filebeat-5.0.0-x86_64.rpm && \
  yum clean all && \
  rm -f /var/log/yum.log

# Plugins install
/usr/share/logstash/bin/logstash-plugin install logstash-input-beats

# Copy configuration file  
COPY filebeat.yml /etc/filebeat/

# Copy entrypoint script
COPY fb_start.sh /
RUN chmod 777 fb_start.sh

# Declare log directory as volumes, for use of --volumes-from
VOLUME ["/var/log"]

#ENTRYPOINT ["/fb_start.sh"]
CMD ["/fb_start.sh"]