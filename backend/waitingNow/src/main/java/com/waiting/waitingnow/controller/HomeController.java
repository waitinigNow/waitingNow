package com.waiting.waitingnow.controller;

import com.waiting.waitingnow.domain.MemberVO;
import com.waiting.waitingnow.service.MemberService;
import com.waiting.waitingnow.service.SendMessageService;
import jakarta.servlet.http.HttpServletRequest;
import net.nurigo.sdk.message.service.MessageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.lang.reflect.Member;

/**
 * 로그인, 회원가입 기능
 */
@RestController
public class HomeController {
    private final MemberService memberService;
    private final SendMessageService sendMessageService;
    // 생성자 방식으로 의존성 주입
    @Autowired
    public HomeController(MemberService memberService, SendMessageService sendMessageService){
        this.memberService = memberService;
        this.sendMessageService = sendMessageService;
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

    @ResponseBody
    @RequestMapping(value = { "/user/phone/auth" }, method = RequestMethod.POST)
    public ResponseEntity phoneAuth(@RequestBody MemberVO member, HttpServletRequest request) throws Exception {
        try{
            // 기존에 멤버가 없으면 실행함.
            MemberVO findMember = memberService.searchMember(member);
            if(findMember == null){
                java.util.Random generator = new java.util.Random();
                generator.setSeed(System.currentTimeMillis());
                String randomNumber = String.valueOf(generator.nextInt(1000000) % 1000000);

                sendMessageService.sendMessage(member, randomNumber);
                return new ResponseEntity(randomNumber , HttpStatus.OK);
            }
            else{
                return new ResponseEntity("duplicate Phone Number" , HttpStatus.OK);
            }
        }
        catch(Exception e){
            return new ResponseEntity(e.getMessage(), HttpStatus.BAD_REQUEST);
        }
    }
}
