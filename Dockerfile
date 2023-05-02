ARG IMAGE=intersystemsdc/iris-community:2021.2.0.617.0-zpm
ARG IMAGE=intersystemsdc/iris-community
FROM $IMAGE

WORKDIR /home/irisowner/irisdev/

ARG TESTS=0
ARG MODULE="csvgen"
ARG NAMESPACE="USER"


RUN --mount=type=bind,src=.,dst=. \
    iris start IRIS && \
	iris session IRIS < iris.script && \
    ([ $TESTS -eq 0 ] || iris session iris -U $NAMESPACE "##class(%ZPM.PackageManager).Shell(\"test $MODULE -v -only\",1,1)") && \
    iris stop IRIS quietly

