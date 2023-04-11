FROM maven:3.9.1-amazoncorretto-19@sha256:f03397d19ff99a9348bcd29b42eacd96cba06bc88ccaf6acf1603706e8dd80e1 AS BUILDER
WORKDIR /dockerdb
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src /dockerdb/src
RUN mvn package -DskipTests
FROM amazoncorretto:19-alpine@sha256:21cc27d3f3a4a79b32c060bd55576a22922a2a70bfe7a6b3a886ad8119ecc174
WORKDIR /app
RUN addgroup --system javauser
RUN adduser -S -s /bin/false -G javauser javauser
COPY --from=builder /dockerdb/target/dockerdb-0.0.1-SNAPSHOT.jar /app/application.jar
RUN chown -R javauser:javauser /app
EXPOSE 8080
USER javauser
CMD ["java", "-jar", "application.jar"]

#docker build -t person .
#docker run -p 80:8080 --name person --rm -d person
#docker run -p 80:8080 -e DB_URL=host.docker.internal --name person --rm -d person - Connect to host
#docker run -p 80:8080 -e DB_URL=dockerdb --name person --rm -d person

#docker network create mynetwork
#docker run --name dockerdbpsql
#--network mynetwork -p 5442:5432
#-e POSTGRES_DB=dockerdb
#-e POSTGRES_USER=person -e POSTGRES_PASSWORD=person
#-d postgres:alpine
#docker run --network mynetwork -e DB_URL=dockerdbpsql -e DB_PORT=5432 -it person


