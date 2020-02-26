package com.elcom.ServerFilestorage.config

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter
import org.springframework.security.core.userdetails.User
import org.springframework.security.core.userdetails.UserDetailsService
import org.springframework.security.provisioning.InMemoryUserDetailsManager
import org.springframework.web.cors.CorsConfiguration
import org.springframework.web.cors.CorsConfigurationSource
import org.springframework.web.cors.UrlBasedCorsConfigurationSource
import java.util.*


@Configuration
@EnableWebSecurity
class WebSecurityConfig : WebSecurityConfigurerAdapter() {
    override fun configure(http: HttpSecurity?) {
        http!!.cors().and().csrf().disable()
//        http!!.authorizeRequests().antMatchers("/", "/js/**", "/bootstrap/**", "/css/**", "/fonts/**", "/img/**").permitAll()
//                .anyRequest().authenticated()
//                .antMatchers("/admin").access("hasRole('ROLE_ADMIN')")
//                .and()
//                .formLogin()
//                .loginPage("/login")
//                .defaultSuccessUrl("/measures", true)
//                .and()
//                .logout()
//                .permitAll()
//                .invalidateHttpSession(true)
//                .logoutSuccessUrl("/login")
//                .deleteCookies("JSESSIONID")
    }

    @Bean
    override fun userDetailsService(): UserDetailsService {
        var admin = User.withDefaultPasswordEncoder()
                .username("admin")
                .password("admin")
                .roles("USER", "ADMIN")
                .build()
        var user = User.withDefaultPasswordEncoder()
                .username("user")
                .password("user")
                .roles("USER")
                .build()
        return InMemoryUserDetailsManager(user, admin)
    }

    @Bean
    fun corsConfigurationSource(): CorsConfigurationSource? {
        val configuration = CorsConfiguration()
        configuration.allowedOrigins = listOf("*")
        configuration.allowedMethods = listOf("*")
        configuration.allowedHeaders = listOf("*")
        configuration.allowCredentials = true
        val source = UrlBasedCorsConfigurationSource()
        source.registerCorsConfiguration("/**", configuration)
        return source
    }
}