FROM ubuntu:22.04 AS build

# Install build tools and remove apt-cache afterwards
RUN apt-get -q update && apt-get install -yq --no-install-recommends \
	build-essential librtlsdr-dev rtl-sdr libmosquittopp-dev git \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

# Switch into our apps working directory
WORKDIR /build

COPY . /build

RUN cmake -B build -S . && cmake --build build

FROM ubuntu:22.04

RUN apt-get -q update && apt-get install -yq --no-install-recommends \
	librtlsdr-dev rtl-sdr libmosquittopp-dev \
	&& apt-get clean && rm -rf /var/lib/apt/lists/*

COPY --from=build /build/345toMqtt 345toMqtt

# Run our binary on container startup
CMD ./345toMqtt
