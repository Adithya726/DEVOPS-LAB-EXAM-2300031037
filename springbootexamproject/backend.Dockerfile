# Stage 1: Build the app
FROM maven:3.9.9-eclipse-temurin-21 AS builder

WORKDIR /app


COPY pom.xml .
RUN mvn dependency:go-offline


COPY src ./src

n
RUN mvn clean package -DskipTests

# Stage 2: Run the app
FROM eclipse-temurin:21-jdk

WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 2000

ENTRYPOINT ["java", "-jar", "app.jar"]
