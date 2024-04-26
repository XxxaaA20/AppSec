FROM goharbor/trivy-adapter-photon:v2.8.3

USER root

RUN yum install -y inotify-tools

RUN yum install -y curl

RUN mkdir /home/scanner/reports

COPY ./scanner/entrypoint.sh /home/scanner/entrypoint.sh
COPY ./scanner/inotifywait.sh /home/scanner/inotifywait.sh
COPY ./scanner/inotifywaitdel.sh /home/scanner/inotifywaitdel.sh
COPY ./scanner/parser.sh /home/scanner/parser.sh

RUN chown scanner:scanner -R /home/scanner

# При необходимости добавляем сертификаты в образ
#ADD ./cacerts/CERT.pem /harbor_cust_cert/CERT.crt

USER scanner

ENTRYPOINT ["/home/scanner/entrypoint.sh"]