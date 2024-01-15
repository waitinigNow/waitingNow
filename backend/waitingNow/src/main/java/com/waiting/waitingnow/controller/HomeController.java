package com.waiting.waitingnow.controller;

import com.waiting.waitingnow.DTO.NewPhoneNumberVO;
import com.waiting.waitingnow.DTO.RestResponse;
import com.waiting.waitingnow.config.JwtTokenService;
import com.waiting.waitingnow.domain.MemberVO;
import com.waiting.waitingnow.service.MemberService;
import com.waiting.waitingnow.service.SendMessageService;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;


/**
 * 로그인, 회원가입 기능
 */
@RestController
public class HomeController {
    private final MemberService memberService;
    private final SendMessageService sendMessageService;
    private final JwtTokenService jwtTokenService;

    @Autowired
    private ServletContext servletContext;

    @Autowired
    private PasswordEncoder passwordEncoder;

    RestResponse<Object> restResponse = new RestResponse<>();

    // 생성자 방식으로 의존성 주입
    @Autowired
    public HomeController(MemberService memberService, SendMessageService sendMessageService, JwtTokenService jwtTokenService){
        this.memberService = memberService;
        this.sendMessageService = sendMessageService;
        this.jwtTokenService = jwtTokenService;
    }

    public String randomAuthNumber(){
        java.util.Random generator = new java.util.Random();
        generator.setSeed(System.currentTimeMillis());
        String randomNumber = String.valueOf(generator.nextInt(1000000) % 1000000);

        return randomNumber;
    }
    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    /**
     * [ 로그인 하는 API ]
     * @apiNote  1. 성공적으로 로그인 했을 때
     *  / 2. 일치하는 전화번호가 없을 때, NullpointerException 발생
     *  / 3. 패스워드가 일치 하지 않을 때, IllegalArgumentException 발생
     * @throws NullPointerException 일치하는 전화번호가 없을 때
     * @throws IllegalArgumentException 패스워드가 일치 하지 않을 때
     */
    @ResponseBody
    @RequestMapping(value = { "/login" }, method = RequestMethod.POST)
    public ResponseEntity login(@RequestBody MemberVO member, HttpServletRequest request) throws Exception {
        logger.info("[로그인 요청] Phone : " + member.getMemberPhone());
        logger.info("[로그인 요청] Password : " + member.getMemberPassword());
        // 성공적으로 로그인 했을때.
        try{
            MemberVO full_member = memberService.loginMember(member, request);
            String token = jwtTokenService.generateToken(Integer.toString(full_member.getMemberNumber()));
            servletContext.setAttribute(token,full_member);
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message(token)
                    .data(full_member)
                    .build();
            System.out.println(restResponse.toString());
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
     * [ 회원가입 하는 API ]
     * @apiNote  1. 회원 가입을 완료했을 때 / 2. 중복되는 전화번호가 있을 때
     */
    @ResponseBody
    @RequestMapping(value = { "/signup" }, method = RequestMethod.POST)
    public ResponseEntity signup(@RequestBody MemberVO member, HttpServletRequest request) throws Exception {
        // 회원 가입 완료
        try{
            memberService.signUpMember(member);
            restResponse = RestResponse.builder()
                    .code(HttpStatus.CREATED.value())
                    .httpStatus(HttpStatus.CREATED)
                    .message("Success Signup")
                    .data(member)
                    .build();
        }
        // 회원가입 실패 시, (중복된 번호가 존재할 때)
        // 중복된 번호가 존재하면, 휴대폰 인증 시 걸러짐
        catch (IllegalStateException e){
            MemberVO newMember = memberService.searchMemberByPhone(member.getMemberPhone());
            restResponse = RestResponse.builder()
                    .code(HttpStatus.FORBIDDEN.value())
                    .httpStatus(HttpStatus.FORBIDDEN)
                    .message(e.getMessage())
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
        // 기존에 멤버가 존재하는 경우
        logger.info("호출");
        try{
            memberService.searchMemberByPhone(newPhoneNumber.getMemberPhone());
            restResponse = RestResponse.builder()
                    .code(HttpStatus.FORBIDDEN.value())
                    .httpStatus(HttpStatus.FORBIDDEN)
                    .message("이미 존재하는 전화번호입니다.")
                    .data(null)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());

        }
        // 기존에 멤버가 없으면 실행함.
        catch(NullPointerException e){
            // 인증번호 생성
            String randomNumber = randomAuthNumber();

            // 전화번호 인증 할 번호가 memberPhone에 담겨서 날라옴.
            sendMessageService.sendAuthMessage(newPhoneNumber.getMemberPhone(), randomNumber);

            restResponse = RestResponse.builder()
                    .code(HttpStatus.CREATED.value())
                    .httpStatus(HttpStatus.CREATED)
                    .message("Success send Message")
                    .data(randomNumber)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
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
