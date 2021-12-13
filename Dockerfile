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
ARG TRINO_VERSION

FROM debian:buster-slim AS builder
ARG TRINO_VERSION

RUN apt update && \
    apt -y install wget unzip

RUN wget -c https://github.com/IBM/trino-db2/releases/download/${TRINO_VERSION}/trino-db2-${TRINO_VERSION}.zip
RUN unzip trino-db2-$TRINO_VERSION.zip && rm -f trino-db2-$TRINO_VERSION.zip

RUN wget -c https://github.com/IBM/trino-event-stream/releases/download/${TRINO_VERSION}/trino-event-stream-${TRINO_VERSION}.zip
RUN unzip trino-event-stream-${TRINO_VERSION}.zip && rm -f trino-event-stream-${TRINO_VERSION}.zip

# Consume historial image from Trino
FROM trinodb/trino:$TRINO_VERSION

USER root
# Update centos packages
RUN yum update -y

# https://nvd.nist.gov/vuln/detail/CVE-2021-44228
# Can be removed when 366 is released
RUN rm -rf /lib/trino/plugin/elasticsearch && rm -rf /lib/trino/plugin/accumulo && rm -rf /usr/lib/trino/plugin/phoenix5 && /usr/lib/trino/plugin/phoenix/

USER trino:trino
# Add Db2 connector
COPY --from=builder --chown=trino:trino trino-db2-* /usr/lib/trino/plugin/db2
COPY --from=builder --chown=trino:trino trino-event-* /usr/lib/trino/plugin/trino-event-stream
COPY run-trino.sh /usr/lib/trino/bin/run-trino
