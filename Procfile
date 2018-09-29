web: java $JAVA_OPTS -Xmx256m -jar backend/target/*.war --spring.profiles.active=prod,heroku,no-liquibase --server.port=$PORT
release: chmod +x mvnw && cd backend && cp -R src/main/resources/config config && ../mvnw liquibase:update -Pheroku && cd ..
