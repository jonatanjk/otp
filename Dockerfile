FROM eclipse-temurin:21-jre-alpine
RUN apk add --no-cache curl
WORKDIR /app

ARG GITHUB_TOKEN
RUN curl -L -H "Authorization: token ${GITHUB_TOKEN}" -H "Accept: application/octet-stream" \
    -o otp.jar https://api.github.com/repos/jonatanjk/otp/releases/assets/375938070
RUN mkdir -p graphs/london && curl -L -H "Authorization: token ${GITHUB_TOKEN}" -H "Accept: application/octet-stream" \
    -o graphs/london/graph.obj https://api.github.com/repos/jonatanjk/otp/releases/assets/375938069

COPY graphs/london/router-config.json graphs/london/
COPY graphs/london/otp-config.json graphs/london/
COPY graphs/london/build-config.json graphs/london/

EXPOSE 8080
CMD ["java", "-Xmx4g", "-jar", "otp.jar", "--load", "graphs/london", "--serve"]
