FROM raspbian/stretch:latest

MAINTAINER Zane Claes <zane@technicallywizardry.com>

USER root

RUN apt-get clean -y && apt-get update -y && apt-get dist-upgrade -y && \
    apt-get install --no-install-recommends -y \
      python3-pip python-serial && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip3 install --upgrade setuptools wheel
RUN pip3 install --upgrade prometheus_client pyserial

# TEMP fix for Raspberry Pi speed
RUN apt-get -yqq update && \
    apt-get -yqq --no-install-recommends install git
RUN git clone https://github.com/zaneclaes/python-OBD.git && \
    cd python-OBD && \
    git checkout zkc-send-speed && \
    pip3 install -e ./

COPY obd-monitor.py /usr/bin/obd-monitor.py
RUN chmod +x /usr/bin/obd-monitor.py
CMD /usr/bin/obd-monitor.py

EXPOSE 8000
