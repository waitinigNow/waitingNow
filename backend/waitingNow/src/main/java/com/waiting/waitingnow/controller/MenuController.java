package com.waiting.waitingnow.controller;

import com.waiting.waitingnow.DTO.RestResponse;
import com.waiting.waitingnow.config.JwtTokenService;
import com.waiting.waitingnow.domain.MenuVO;
import com.waiting.waitingnow.service.MenuService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
public class MenuController {
    private static final Logger logger = LoggerFactory.getLogger(MenuController.class);
    private final MenuService menuService;
    RestResponse<Object> restResponse = new RestResponse<>();
    private final JwtTokenService jwtTokenService;
    // 생성자 방식으로 의존성 주입
    @Autowired
    public MenuController(MenuService menuService, JwtTokenService jwtTokenService){
        this.menuService = menuService;
        this.jwtTokenService = jwtTokenService;
    }

    @RequestMapping(value = {"/menu"}, method = RequestMethod.GET)
    public ResponseEntity menuView(@RequestHeader("token") String token) throws Exception {
        // 1. menu 조회 기능
        try{
            int memberNumber = Integer.valueOf(jwtTokenService.getUsernameFromToken(token));
            Map<String, List<MenuVO>> menus = menuService.selectByMember(memberNumber);
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message(memberNumber + "번 사장의 메뉴 리스트")
                    .data(menus)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        // 2. 일치하는 사장님 회원 번호가 없을 때
        catch (NullPointerException e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.NOT_FOUND.value())
                    .httpStatus(HttpStatus.NOT_FOUND)
                    .message("일치하는 사장님의 회원번호가 없습니다")
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }
}
