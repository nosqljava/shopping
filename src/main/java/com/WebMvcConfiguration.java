package com;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebMvcConfiguration implements WebMvcConfigurer {
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {

		registry.addResourceHandler("/contents/storage/**").addResourceLocations("file:///" + UploadCon.getUploadDir());

		registry.addResourceHandler("/member/storage/**").addResourceLocations("file:///" + UploadMem.getUploadDir());

	}

//	@Override
//	public void addCorsMappings(CorsRegistry registry) {
//		registry.addMapping("/**").allowedOriginPatterns("*") // React 앱의 URL, 2.4 부터 allowedOriginPatterns 사용
//				.allowedMethods("GET", "POST", "PUT", "DELETE")
//				.allowedHeaders("*")
//				.allowCredentials(true);
//	}

}