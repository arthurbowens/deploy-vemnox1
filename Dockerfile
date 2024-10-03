#
# Build stage
#
FROM maven:3.8.4-openjdk-17 AS build

WORKDIR /app

COPY pom.xml . 
COPY src ./src  

# Build do Maven SEM testes unitarios
RUN mvn clean package -DSkipTests=true

#
# Package stage
#
FROM openjdk:17-jdk-alpine

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar
# ENV PORT=8080
EXPOSE 8080
ENTRYPOINT ["java","-jar","vemnox1.jar"]