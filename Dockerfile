FROM ubuntu:22.04 AS builder

# Install build tools and remove apt-cache afterwards
RUN apt-get -q update && apt-get install -yq --no-install-recommends \
	build-essential librtlsdr-dev rtl-sdr libmosquittopp-dev git cmake libyaml-cpp-dev \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

# Switch into our apps working directory
WORKDIR /345tomqtt

COPY . /345tomqtt

RUN cmake -B build -S . && cmake --build build

FROM ubuntu:22.04

RUN apt-get -q update && apt-get install -yq --no-install-recommends \
	librtlsdr-dev rtl-sdr libmosquittopp-dev \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

COPY --from=builder /345tomqtt/build/345toMqtt /345toMqtt
COPY ./config.yaml /config.yaml

# Run our binary on container startup
CMD ./345toMqtt
