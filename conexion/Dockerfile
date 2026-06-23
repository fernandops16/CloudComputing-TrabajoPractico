FROM tomcat:9.0-jdk21-openjdk

COPY dist/conexion.war /usr/local/tomcat/webapps/conexion.war

RUN apt-get update && apt-get install -y --no-install-recommends \
    fontconfig \
    && rm -rf /var/lib/lists/*
    
RUN fc-cache -f -v

EXPOSE 8080

CMD ["catalina.sh", "run"]