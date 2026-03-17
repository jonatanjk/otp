FROM alpine/git AS lfs-resolver
RUN apk add --no-cache git-lfs && git lfs install
WORKDIR /app
COPY . .
RUN git lfs pull

FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=lfs-resolver /app/otp.jar .
COPY --from=lfs-resolver /app/graphs ./graphs
EXPOSE 8080
CMD ["java", "-Xmx4g", "-jar", "otp.jar", "--load", "graphs/london", "--serve"]
