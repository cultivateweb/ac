#!/bin/bash

# run in terminal to learn more: curl -G https://start.spring.io

git init
git add .
git commit -m "chore: add bootstrap script to fetch Spring Boot skeleton via curl"
git branch -M main


rm get-starter.tgz.sh

curl -G https://start.spring.io/starter.tgz \
     -d applicationName=AboutCinemaApplication \
     -d artifactId=ac \
     -d dependencies=lombok,devtools,actuator,web,data-jpa,h2 \
     -d groupId=com.github.cultivateweb \
     -d javaVersion=21 \
     -d name=About-Cinema \
     -d packageName=com.github.cultivateweb.ac \
     -d type=gradle-project-kotlin \
| tar -xzf -


git add .
git commit -m "feat: replace bootstrap script with generated Spring Boot project"


mv src/main/resources/application.properties src/main/resources/application.yaml

cat > src/main/resources/application.yaml<<EOL
spring:
  application:
    name: About-Cinema
  datasource:
    url: jdbc:h2:mem:ac;DB_CLOSE_ON_EXIT=FALSE;MODE=MySQL
    driver-class-name: org.h2.Driver
    username: sa
    password:
  jpa:
    database-platform: org.hibernate.dialect.H2Dialect
  h2:
    console:
      enabled: true
      path: /h2-console
      settings:
        trace: true
        web-allow-others: true
EOL


git add .
git commit -m "config: switch to application.yaml and add database settings"
git remote add origin git@github.com:cultivateweb/ac.git
git push -u origin main

