package com.elcom.ServerFilestorage

import com.elcom.ServerFilestorage.storage.StorageProperties
import com.elcom.ServerFilestorage.storage.StorageService
import org.springframework.boot.CommandLineRunner
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.context.properties.EnableConfigurationProperties
import org.springframework.boot.runApplication
import org.springframework.context.annotation.Bean


@SpringBootApplication(scanBasePackages = ["com.elcom.ServerFilestorage.storage", "com.elcom.ServerFilestorage"])
@EnableConfigurationProperties(StorageProperties::class)
class ServerFilestorageApplication

fun main(args: Array<String>) {
    runApplication<ServerFilestorageApplication>(*args)
}

@Bean
fun init(storageService: StorageService): CommandLineRunner? {
    return CommandLineRunner { args: Array<String?>? ->
        storageService.deleteAll()
        storageService.init()
    }
}

//@Bean
//fun templateResolver(): SpringResourceTemplateResolver? { // SpringResourceTemplateResolver automatically integrates with Spring's own
//// resource resolution infrastructure, which is highly recommended.
//    val templateResolver = SpringResourceTemplateResolver()
//    templateResolver.setApplicationContext(this.applicationContext)
//    templateResolver.setPrefix("/WEB-INF/templates/")
//    templateResolver.setSuffix(".html")
//    // HTML is the default value, added here for the sake of clarity.
//    templateResolver.setTemplateMode(TemplateMode.HTML)
//    // Template cache is true by default. Set to false if you want
//// templates to be automatically updated when modified.
//    templateResolver.setCacheable(true)
//    return templateResolver
//}
//
//@Bean
//fun templateEngine(): SpringTemplateEngine? { // SpringTemplateEngine automatically applies SpringStandardDialect and
//// enables Spring's own MessageSource message resolution mechanisms.
//    val templateEngine = SpringTemplateEngine()
//    templateEngine.setTemplateResolver(templateResolver())
//    // Enabling the SpringEL compiler with Spring 4.2.4 or newer can
//// speed up execution in most scenarios, but might be incompatible
//// with specific cases when expressions in one template are reused
//// across different data types, so this flag is "false" by default
//// for safer backwards compatibility.
//    templateEngine.setEnableSpringELCompiler(true)
//    return templateEngine
//}