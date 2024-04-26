FROM ubuntu:22.04
RUN apt-get update
RUN apt install -y wget apt-transport-https gnupg lsb-release git curl ca-certificates
RUN apt install -y pip
RUN apt install -y python3
RUN apt-get update

# Добавляем сертификаты, если нужно
#ADD ./cacerts/CERT.pem /usr/local/share/ca-certificates/CERT.crt
#RUN chmod 664 /usr/local/share/ca-certificates/CERT.crt
#RUN update-ca-certificates

RUN python3 -m pip install semgrep