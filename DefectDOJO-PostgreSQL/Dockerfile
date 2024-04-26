FROM defectdojo/defectdojo-django:2.29.3

USER root

RUN apt install -y ca-certificates

#ADD ./cacerts/CERT.pem /usr/local/share/ca-certificates/CERT.crt
#RUN chmod 664 /usr/local/share/ca-certificates/CERT.crt
#RUN update-ca-certificates

COPY --chown=root:defectdojo ./settings.dist.py /app/dojo/settings/
RUN chmod 775 /app/dojo/settings/settings.dist.py

#ENTRYPOINT ["/entrypoint-uwsgi.sh"]
