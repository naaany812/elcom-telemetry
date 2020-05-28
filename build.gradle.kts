import org.jetbrains.kotlin.contracts.model.structure.UNKNOWN_COMPUTATION.type
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    id("org.springframework.boot") version "2.2.4.RELEASE"
    id("io.spring.dependency-management") version "1.0.9.RELEASE"
    id("org.flywaydb.flyway") version "6.4.2"
    kotlin("jvm") version "1.3.61"
    kotlin("plugin.spring") version "1.3.61"
    kotlin("plugin.jpa") version "1.3.50"
}

group = "com.elcom"
version = "0.0.1-SNAPSHOT"
java.sourceCompatibility = JavaVersion.VERSION_11

val developmentOnly by configurations.creating
configurations {
    runtimeClasspath {
        extendsFrom(developmentOnly)
    }
}

repositories {
    mavenCentral()
}

dependencies {
    implementation("org.springframework.boot:spring-boot-starter-web")
    implementation("org.springframework.boot:spring-boot-starter-tomcat")
    implementation("org.springframework.boot:spring-boot-starter-thymeleaf")
    implementation("org.springframework.boot:spring-boot-starter-security")
    implementation("org.springframework.security:spring-security-test")
    implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
    implementation("org.jetbrains.kotlin:kotlin-reflect")
    implementation("org.springframework.boot:spring-boot-starter-data-jpa")
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
    developmentOnly("org.springframework.boot:spring-boot-devtools")
    annotationProcessor("org.springframework.boot:spring-boot-configuration-processor")
// https://mvnrepository.com/artifact/postgresql/postgresql

    implementation("org.postgresql", "postgresql", "42.1.4")
    implementation("org.webjars", "bootstrap", "4.4.1")
    implementation("org.webjars", "popper.js", "2.0.2")
    implementation("org.webjars", "jquery", "3.4.1")
    testImplementation("org.springframework.boot:spring-boot-starter-test") {
        exclude(group = "org.junit.vintage", module = "junit-vintage-engine")
    }
    implementation("org.postgresql", "postgresql")


}

tasks.withType<Test> {
    useJUnitPlatform()
}

tasks.withType<KotlinCompile> {
    kotlinOptions {
        freeCompilerArgs = listOf("-Xjsr305=strict")
        jvmTarget = "1.8"
    }
}

flyway {
    url = "jdbc:postgresql://localhost:5432/telemetry"
    user = "postgres"
    password = "postgres"
    schemas = arrayOf("public")
    baselineOnMigrate = true
    locations = arrayOf("filesystem:src/main/resources/db/migration")
}
/*
task migrateDatabase2(type: org.flywaydb.gradle.task.FlywayMigrateTask) {
    url = 'jdbc:h2:mem:mydb2'
    user = 'myUsr2'
    password = 'mySecretPwd2'
}*/
