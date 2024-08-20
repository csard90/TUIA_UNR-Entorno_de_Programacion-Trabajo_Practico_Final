FROM ubuntu
RUN apt-get update && apt-get install bc -y
COPY ./TUIA_EDP ./TUIA_EDP