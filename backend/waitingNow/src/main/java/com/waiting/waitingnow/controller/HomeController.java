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

/**
 * 로그인, 회원가입 기능
 */
@RestController
public class HomeController {
    private final MemberService memberService;

    // 생성자 방식으로 의존성 주입
    @Autowired
    public HomeController(MemberService memberService){
        this.memberService = memberService;
    }
    
    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    /**
     * @see @ModelAttribute를 사용할 필요가 없음, jsp를 사용하는 것이 아니기 때문에.
     */
    @ResponseBody
    @RequestMapping(value = { "/login" }, method = RequestMethod.POST)
    public ResponseEntity<MemberVO> login(@RequestBody MemberVO member, HttpServletRequest request) throws Exception {
        logger.info("Phone : " + member.getMemberPhone());
        try{
            MemberVO full_member = memberService.loginMember(member, request);
            return new ResponseEntity<>(full_member, HttpStatus.OK);
        }
        catch (Exception e){
            logger.info(e.toString());
            return new ResponseEntity( "Not Matched", HttpStatus.UNAUTHORIZED);
        }
    }

    @ResponseBody
    @RequestMapping(value = { "/signup" }, method = RequestMethod.POST)
    public ResponseEntity signup(@RequestBody MemberVO member, HttpServletRequest request) throws Exception {
        if(memberService.signUpMember(member)){
            return new ResponseEntity( "Success", HttpStatus.OK);
        }
        else{ return new ResponseEntity( "duplicate PhoneNumber", HttpStatus.BAD_REQUEST); }
    }

}
