#FROM jeodpp.jrc.ec.europa.eu:443/jeodpp-proc/jeodpp_service_inter_py2_deb9:2.1.4
FROM jeoreg.cidsn.jrc.it:5000/jeodpp-proc/jeodpp_service_inter_py2_deb9:2.1.4

ARG http_proxy=''
ARG https_proxy=''
ARG HTTP_PROXY=''
ARG HTTPS_PROXY=''

ENV BENCHMARK_DIR='/opt/benchmark/'

# install pip
RUN set -xeu; \
    apt update -yq; \
    apt install --no-install-recommends -yq wget; \
    rm -rf /var/lib/apt/lists/*; \
    wget https://bootstrap.pypa.io/get-pip.py -O get-pip.py; \
    python get-pip.py; \
    rm get-pip.py;

# Install requirements
COPY requirements.txt /tmp/requirements.txt
RUN set -xeu; \
    echo $(pip --version); \
    pip install --no-cache -r /tmp/requirements.txt; \
    mkdir -p $BENCHMARK_DIR;

WORKDIR $BENCHMARK_DIR
ENTRYPOINT ["python"]

COPY run_concurrent.py run_serial.py timer.py query_params.csv $BENCHMARK_DIR
