package com.waiting.waitingnow.controller;

import com.waiting.waitingnow.domain.MemberVO;
import com.waiting.waitingnow.service.MemberService;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.lang.reflect.Member;

@RestController
public class UserController {

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    private final MemberService memberService;
    // 생성자 방식으로 의존성 주입
    @Autowired
    public UserController(MemberService memberService){
        this.memberService = memberService;
    }

    @ResponseBody
    @RequestMapping(value = { "/user" }, method = RequestMethod.POST)
    public ResponseEntity<Object> user(@RequestBody MemberVO member) throws Exception {
       try{
           MemberVO NewMember = memberService.searchMember(member);
           if(NewMember == null){
               throw new NullPointerException();
           }
           return new ResponseEntity<>(NewMember, HttpStatus.OK);
       }
       catch(NullPointerException e){
           return new ResponseEntity( "No matching phoneNumber", HttpStatus.BAD_REQUEST);
       }

    }
}

