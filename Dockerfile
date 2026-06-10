# Etapa 1: construcción — compila la aplicación con Maven
FROM eclipse-temurin:17-jdk AS build
WORKDIR /app
COPY mvnw pom.xml ./
COPY .mvn .mvn
COPY src src
RUN ./mvnw -B package -DskipTests

# Etapa 2: ejecución — solo el JRE y el jar final
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/spring-petclinic-*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
