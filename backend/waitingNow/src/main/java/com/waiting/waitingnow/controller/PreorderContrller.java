package com.waiting.waitingnow.controller;

import com.waiting.waitingnow.DTO.MenuPreorderVO;
import com.waiting.waitingnow.DTO.RestResponse;
import com.waiting.waitingnow.DTO.SetPreorderVO;
import com.waiting.waitingnow.service.MemberService;
import com.waiting.waitingnow.service.PreorderService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class PreorderContrller {
    private static final Logger logger = LoggerFactory.getLogger(PreorderContrller.class);
    private final MemberService memberService;
    private final PreorderService preorderService;
    RestResponse<Object> restResponse = new RestResponse<>();

    // 생성자 방식으로 의존성 주입
    @Autowired
    public PreorderContrller(MemberService memberService, PreorderService preorderService){
        this.memberService = memberService;
        this.preorderService = preorderService;
    }

    @RequestMapping(value = {"/preorder"}, method = RequestMethod.POST)
    public ResponseEntity preorder(@RequestBody SetPreorderVO preorder) throws Exception {
        logger.info(String.valueOf(preorder.getMenu().get(0).getMenuCount()));
        List<MenuPreorderVO> menus =  preorderService.setPreorder(preorder);
        try{
            restResponse = RestResponse.builder()
                    .code(HttpStatus.CREATED.value())
                    .httpStatus(HttpStatus.CREATED)
                    .message("")
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
