package com.waiting.waitingnow.controller;

import com.waiting.waitingnow.DTO.NewPhoneNumberVO;
import com.waiting.waitingnow.DTO.RestResponse;
import com.waiting.waitingnow.config.JwtTokenService;
import com.waiting.waitingnow.domain.MemberVO;
import com.waiting.waitingnow.DTO.DateVO;
import com.waiting.waitingnow.DTO.StatisticVO;
import com.waiting.waitingnow.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
public class UserController {

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    private final MemberService memberService;
    RestResponse<Object> restResponse = new RestResponse<>();
    private final JwtTokenService jwtTokenService;
    // 생성자 방식으로 의존성 주입
    @Autowired
    public UserController(MemberService memberService, JwtTokenService jwtTokenService){
        this.memberService = memberService;
        this.jwtTokenService = jwtTokenService;
    }

    /**
     * 토근으로 user 조회하는 API
     * @apiNote 1. 회원 조회 성공 / 2. 일치하는 전화번호가 없을 때
     * */
    @ResponseBody
    @RequestMapping(value = { "/user" }, method = RequestMethod.POST)
    public ResponseEntity<Object> user(@RequestHeader("Authorization") String token) throws Exception {
       // 회원 조회 성공 시
        int memberNumber = Integer.valueOf(jwtTokenService.getUsernameFromToken(token));
        try{
           MemberVO member = memberService.searchMember(memberNumber);
           restResponse = RestResponse.builder()
                   .code(HttpStatus.OK.value())
                   .httpStatus(HttpStatus.OK)
                   .message("회원 조회 성공")
                   .data(member)
                   .build();
           return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
       }
       // 2. 일치하는 전화번호가 없을 때
       catch(NullPointerException e){
           restResponse = RestResponse.builder()
                   .code(HttpStatus.NOT_FOUND.value())
                   .httpStatus(HttpStatus.NOT_FOUND)
                   .message(e.getMessage())
                   .build();
           return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
       }
    }

    /***
     * [ 회원 정보 변경하는 api ]
     * @param member (memberPhone, 변경하고 싶은 변수)
     * @apiNote 1. 회원 정보 변경 완료 / 2. 전화번호 미일치
     * @exception NullPointerException (전화번호가 없을 때 memberService에서 에러 전달)
     */
    @ResponseBody
    @RequestMapping(value = { "/user/setting" }, method = RequestMethod.POST)
    public ResponseEntity settingMember(@RequestBody MemberVO member, @RequestHeader("Authorization") String token) throws Exception {
        try{
            // 회원정보 업데이트 시킨 후 DB에서 찾아옴
            member.setMemberNumber(Integer.valueOf(jwtTokenService.getUsernameFromToken(token)));
            memberService.updateMember(member);
            MemberVO newMember = memberService.searchMember(Integer.valueOf(jwtTokenService.getUsernameFromToken(token)));
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message("회원 변경 완료")
                    .data(newMember)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }

        catch(NullPointerException e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.NOT_FOUND.value())
                    .httpStatus(HttpStatus.NOT_FOUND)
                    .message("일치하는 전화번호가 없음.")
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }

    /***
     * [ 전화번호 변경하는 api ]
     * @param newPhoneNumber
     * @apiNote 1. 전화번호 변경 완료 / 2. 이전 전화번호 일치하는 번호 없음. (사용되지 않을 예정) / 3. 두 입력이 같을 때 (사용되지 않음)
     */
    @ResponseBody
    @RequestMapping(value = { "/user/setting/phonenumber" }, method = RequestMethod.PATCH)
    public ResponseEntity userUpdatePhonenumber(@RequestBody NewPhoneNumberVO newPhoneNumber) throws Exception {
        // 전화번호 변경 됐을 때
        try{
            MemberVO newMember = memberService.updateMemberPhone(newPhoneNumber);
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message("전화 번호 변경됨")
                    .data(newMember)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        // 기존에 일치 하는 전화 번호가 없음. 물론 전화번호 인증 때 걸러지긴 해서 사용 될 필요 없음.
        catch (NullPointerException e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.NOT_FOUND.value())
                    .httpStatus(HttpStatus.NOT_FOUND)
                    .message(e.getMessage())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        // 전화번호 입력 두개가 동일 할 때, 물론 전화번호 인증 때 걸러지긴 해서 사용 될 필요 없음.
        catch(IllegalArgumentException e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.BAD_REQUEST.value())
                    .httpStatus(HttpStatus.BAD_REQUEST)
                    .message(e.getMessage())
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }

    /***
     * [ 선주문 변경하는 api ]
     * @apiNote 1. 선주문 변경 완료 / 2. 전화 번호 미등록
     */
    @ResponseBody
    @RequestMapping(value = { "/user/setting/preorder" }, method = RequestMethod.POST)
    public ResponseEntity userUpdatePreorder(@RequestBody MemberVO member, @RequestHeader("Authorization") String token) throws Exception {
        try{
            member.setMemberNumber(Integer.valueOf(jwtTokenService.getUsernameFromToken(token)));
            boolean PreorderAvail = memberService.updatePreorder(member);
            restResponse = RestResponse.builder()
                    .code(HttpStatus.CREATED.value())
                    .httpStatus(HttpStatus.CREATED)
                    .message("[변경 완료] 현재 선주문 여부 : " + PreorderAvail)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());

        }

        catch(Exception e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.NOT_FOUND.value())
                    .httpStatus(HttpStatus.NOT_FOUND)
                    .message("전화번호를 찾을 수 없습니다.")
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
    }

    /***
     * [ 통계 확인하는 api ]
     * @apiNote 1. 통계 확인 / 2. 전화 번호 미등록
     */
    @ResponseBody
    @RequestMapping(value = { "/user/setting/statistics"}, method = RequestMethod.POST)
    public ResponseEntity<Object> statisticsMember(@RequestBody StatisticVO statistic, @RequestHeader("Authorization") String token) throws Exception {
        try{
            statistic.setMemberNumber(Integer.valueOf(jwtTokenService.getUsernameFromToken(token)));
            DateVO date = memberService.statisticsMember(statistic);
            restResponse = RestResponse.builder()
                    .code(HttpStatus.OK.value())
                    .httpStatus(HttpStatus.OK)
                    .message("[날짜] " + statistic.getWaitingDate())
                    .data(date)
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());
        }
        catch (NullPointerException e){
            restResponse = RestResponse.builder()
                    .code(HttpStatus.NOT_FOUND.value())
                    .httpStatus(HttpStatus.NOT_FOUND)
                    .message("전화번호를 찾을 수 없습니다.")
                    .build();
            return new ResponseEntity<>(restResponse, restResponse.getHttpStatus());}
    }
}

