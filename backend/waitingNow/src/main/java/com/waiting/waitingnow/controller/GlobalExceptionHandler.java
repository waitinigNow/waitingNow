package com.waiting.waitingnow.controller;

import com.waiting.waitingnow.DTO.RestResponse;
import io.jsonwebtoken.security.SignatureException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MissingRequestHeaderException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;


@ControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @ExceptionHandler(MissingRequestHeaderException.class)
    public ResponseEntity<Object> handleMissingRequestHeaderException(MissingRequestHeaderException ex) {
        // 디버깅 목적으로 예외를 로그에 남깁니다.
        logger.error("'Authorization' 헤더가 누락되었습니다.", ex);

        RestResponse<Object> restResponse = new RestResponse<>();

        // 요구사항에 따라 응답을 사용자 정의할 수 있습니다.
        restResponse = RestResponse.builder()
                .code(HttpStatus.UNAUTHORIZED.value())
                .httpStatus(HttpStatus.UNAUTHORIZED)
                .message("'Authorization' 헤더가 누락되었습니다.")
                .build();
        return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
    }

    @ExceptionHandler(SignatureException.class)
    public ResponseEntity<Object> handleSignatureException(SignatureException ex) {
        // 디버깅 목적으로 예외를 로그에 남깁니다.
        logger.error("JWT 토큰이 정상적이지 않습니다.", ex);

        RestResponse<Object> restResponse = new RestResponse<>();

        // 요구사항에 따라 응답을 사용자 정의할 수 있습니다.
        restResponse = RestResponse.builder()
                .code(HttpStatus.UNAUTHORIZED.value())
                .httpStatus(HttpStatus.UNAUTHORIZED)
                .message("JWT 토큰이 정상적이지 않습니다.")
                .build();
        return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
    }
}