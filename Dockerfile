FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY otp.jar .
COPY graphs ./graphs
EXPOSE 8080
CMD ["java", "-Xmx4g", "-jar", "otp.jar", "--load", "graphs/london", "--serve"]
