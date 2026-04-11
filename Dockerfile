FROM eclipse-temurin:21-jdk-alpine AS build

WORKDIR /app
COPY common common
WORKDIR /app/business-service
COPY business-service/ .

RUN chmod +x gradlew
RUN ./gradlew build -x test --no-daemon

FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/business-service/build/libs/*.jar app.jar

ENTRYPOINT ["java", "-Dspring.profiles.active=prod", "-jar", "app.jar"]