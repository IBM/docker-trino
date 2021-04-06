#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
ARG PRESTO_VERSION

FROM debian:buster-slim AS builder
ARG PRESTO_VERSION

RUN apt update && \
    apt -y install wget unzip

RUN wget -c https://github.com/IBM/presto-db2/releases/download/${PRESTO_VERSION}/presto-db2-${PRESTO_VERSION}.zip
RUN unzip presto-db2-$PRESTO_VERSION.zip && rm -f presto-db2-$PRESTO_VERSION.zip

# Consume historial image from Trino
FROM ghcr.io/trinodb/presto:$PRESTO_VERSION

USER root
# Update centos packages
# RUN dnf upgrade -y && dnf autoremove

USER presto:presto
# Add Db2 connector
COPY --from=builder --chown=presto:presto presto-db2-* /usr/lib/presto/plugin/db2

RUN chmod +x ./run-presto.sh
ENTRYPOINT ["./run-presto.sh"]
