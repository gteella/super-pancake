FROM eclipse-temurin:17-jdk-alpine AS build

WORKDIR /app

COPY . .

RUN chmod +x gradlew && ./gradlew build -x test

FROM eclipse-temurin:17-jre-alpine

RUN adduser -u 1001 -S appuser

WORKDIR /app

COPY --from=build --chown=appuser:appuser /app/build/libs/*.jar app.jar

USER appuser

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
