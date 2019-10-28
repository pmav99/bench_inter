#!/usr/bin/env bash

DEPLOY_MODE="dev"

docker run \
  --rm \
  -it \
  -v /eos/jeodpp/shared/"${DEPLOY_MODE}"/etc/ld.so.conf.d/jeodpp.conf:/etc/ld.so.conf.d/jeodpp.conf:ro \
  -v /eos/jeodpp/shared/"${DEPLOY_MODE}"/lib/cpp/jeodpp:/usr/local/lib/jeodpp:ro \
  -v /eos/jeodpp/shared/"${DEPLOY_MODE}"/lib/python/jeodpp:/usr/local/lib/python2.7/dist-packages/jeodpp:ro \
  -v /eos/jeodpp/data/base/:/eos/jeodpp/data/base:ro \
  -v /eos/jeodpp/data/products/:/eos/jeodpp/data/products:ro \
  -v /eos/jeodpp/data/SRS/:/eos/jeodpp/data/SRS/:ro \
  -v $(pwd):/opt/benchmark/ \
  jeoreg.cidsn.jrc.it:5000/jeodpp-proc/interactive_benchmark:2.4.1-1 "${@}"
