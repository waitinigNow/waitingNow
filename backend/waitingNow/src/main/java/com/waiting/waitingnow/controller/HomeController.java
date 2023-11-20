package com.waiting.waitingnow.controller;

import com.waiting.waitingnow.DTO.NewPhoneNumberVO;
import com.waiting.waitingnow.DTO.RestResponse;
import com.waiting.waitingnow.domain.MemberVO;
import com.waiting.waitingnow.service.MemberService;
import com.waiting.waitingnow.service.SendMessageService;
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
    private final SendMessageService sendMessageService;
    RestResponse<Object> restResponse = new RestResponse<>();

    // 생성자 방식으로 의존성 주입
    @Autowired
    public HomeController(MemberService memberService, SendMessageService sendMessageService){
        this.memberService = memberService;
        this.sendMessageService = sendMessageService;
    }
    
    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    /**
     * 로그인 하는 API
     * @see @ModelAttribute를 사용할 필요가 없음, jsp를 사용하는 것이 아니기 때문에.
     * @apiNote  1. 성공적으로 로그인 했을 때
     *  / 2. 일치하는 전화번호가 없을 때, NullpointerException 발생
     *  / 3. 패스워드가 일치 하지 않을 때, IllegalArgumentException 발생
     */
    @ResponseBody
    @RequestMapping(value = { "/login" }, method = RequestMethod.POST)
    public ResponseEntity login(@RequestBody MemberVO member, HttpServletRequest request) throws Exception {
        logger.info("[로그인 요청] Phone : " + member.getMemberPhone());
        logger.info("[로그인 요청] Password : " + member.getMemberPassword());
        // 성공적으로 로그인 했을때.
        try{
            MemberVO full_member = memberService.loginMember(member, request);
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message("로그인 되었습니다.")
                    .data(full_member)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        // 일치하는 전화번호가 없을 때, NullpointerException 발생
        catch (NullPointerException e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.NOT_FOUND.value())
                    .httpStatus(HttpStatus.NOT_FOUND)
                    .message("일치하는 전화번호가 없습니다.")
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        // 비밀번호가 일치하지 않음, IllegalArgumentException 발생
        catch (IllegalArgumentException e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.FORBIDDEN.value())
                    .httpStatus(HttpStatus.FORBIDDEN)
                    .message("비밀번호가 틀렸습니다.")
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }

    /**
     * 회원가입 하는 API
     * @apiNote  1. 회원 가입을 완료했을 때
     *  / 2. 중복되는 전화번호가 있을 때
     */
    @ResponseBody
    @RequestMapping(value = { "/signup" }, method = RequestMethod.POST)
    public ResponseEntity signup(@RequestBody MemberVO member, HttpServletRequest request) throws Exception {
        // 회원 가입 완료
        if(memberService.signUpMember(member)){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.CREATED.value())
                    .httpStatus(HttpStatus.CREATED)
                    .message("Success Signup")
                    .data(member)
                    .build();
        }
        // 회원가입 실패 시, (중복된 번호가 존재할 때)
        // 중복된 번호가 존재하면, 휴대폰 인증 시 걸러짐
        else{
            MemberVO newMember = memberService.searchMember(member.getMemberPhone());
            restResponse = RestResponse.builder()
                    .code(HttpStatus.FORBIDDEN.value())
                    .httpStatus(HttpStatus.FORBIDDEN)
                    .message("duplicated Phone Number")
                    .data(newMember)
                    .build();
        }
        return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
    }

    /**
     * 전화번호 인증하는 API
     * @apiNote 1. 메세지 인증 / 2. 중복된 전화번호 / 3. 메세지 발송 오류
     */
    @ResponseBody
    @RequestMapping(value = { "/user/phone/auth" }, method = RequestMethod.POST)
    public ResponseEntity phoneAuth(@RequestBody NewPhoneNumberVO newPhoneNumber, HttpServletRequest request) throws Exception {
        try{
            // 기존에 멤버가 없으면 실행함.
            MemberVO findMember = memberService.searchMember(newPhoneNumber.getMemberPhone());
            if(findMember == null){
                java.util.Random generator = new java.util.Random();
                generator.setSeed(System.currentTimeMillis());
                String randomNumber = String.valueOf(generator.nextInt(1000000) % 1000000);

                // [signup] getNewPhoneNumber가 null일 때
                if(newPhoneNumber.getNewPhoneNumber() == null) sendMessageService.sendMessage(newPhoneNumber.getMemberPhone(), randomNumber);
                // [Phone Number Change] getNewPhoneNumber가 있으면
                else sendMessageService.sendMessage(newPhoneNumber.getNewPhoneNumber(), randomNumber);

                restResponse = RestResponse.builder()
                        .code(HttpStatus.CREATED.value())
                        .httpStatus(HttpStatus.CREATED)
                        .message("Success send Message")
                        .data(randomNumber)
                        .build();
                return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
            }
            
            // 중복되는 전화번호가 있으면, ForBidden
            else{
                restResponse = RestResponse.builder()
                        .code(HttpStatus.FORBIDDEN.value())
                        .httpStatus(HttpStatus.FORBIDDEN)
                        .message("이미 존재하는 전화번호입니다.")
                        .data(null)
                        .build();
                return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
            }
        }
        
        // 메세지 발송에 대한 오류일 때
        catch(Exception e){
            logger.info(e.getMessage());
            restResponse = RestResponse.builder()
                    .code(HttpStatus.SERVICE_UNAVAILABLE.value())
                    .httpStatus(HttpStatus.SERVICE_UNAVAILABLE)
                    .message(e.getMessage())
                    .data(null)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }


}
