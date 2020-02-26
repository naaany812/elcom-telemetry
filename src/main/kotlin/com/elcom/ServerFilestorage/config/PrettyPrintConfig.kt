package com.elcom.ServerFilestorage.config

import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.SerializationFeature
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.context.annotation.Configuration
import javax.annotation.PostConstruct

@Configuration
class PrettyPrintConfig {
    @Autowired
    private val objectMapper //reuse the pre-configured mapper
            : ObjectMapper? = null


    @PostConstruct
    fun setup() {
        objectMapper!!.enable(SerializationFeature.INDENT_OUTPUT)
        //whatever else you need
    }

}