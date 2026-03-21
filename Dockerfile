FROM eclipse-temurin:21-jre-alpine
RUN apk add --no-cache curl
WORKDIR /app

RUN curl -L -o otp.jar https://github.com/jonatanjk/otp/releases/download/v1.0/otp.jar
RUN mkdir -p graphs/london && curl -L -o graphs/london/graph.obj https://github.com/jonatanjk/otp/releases/download/v1.0/graph.obj

COPY graphs/london/router-config.json graphs/london/
COPY graphs/london/otp-config.json graphs/london/
COPY graphs/london/build-config.json graphs/london/

EXPOSE 8080
CMD ["java", "-Xmx2g", "-XX:+UseContainerSupport", "-jar", "otp.jar", "--load", "graphs/london", "--serve"]
