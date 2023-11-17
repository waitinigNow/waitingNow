package com.waiting.waitingnow.controller;

import com.waiting.waitingnow.domain.MemberVO;
import com.waiting.waitingnow.requestDomain.statisticVO;
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

    @ResponseBody
    @RequestMapping(value = { "/user/setting" }, method = RequestMethod.POST)
    public ResponseEntity settingMember(@RequestBody MemberVO member) throws Exception {
        try{
            // 회원정보 업데이트 시켜줌.
            memberService.updateMember(member);
            return new ResponseEntity( "Changed!", HttpStatus.OK);
        }
        catch(Exception e){
            logger.info(e.toString());
            return new ResponseEntity<>("No matching phoneNumber", HttpStatus.BAD_REQUEST);
        }
    }

    @ResponseBody
    @RequestMapping(value = { "/user/setting/phonenumber" }, method = RequestMethod.PATCH)
    public ResponseEntity<MemberVO> userUpdatePhonenumber(@RequestBody MemberVO member) throws Exception {
        MemberVO newMember = memberService.updateMemberPhone(member);
        return new ResponseEntity<>(newMember, HttpStatus.OK);
    }

    @ResponseBody
    @RequestMapping(value = { "/user/setting/preorder" }, method = RequestMethod.POST)
    public ResponseEntity userUpdatePreorder(@RequestBody MemberVO member) throws Exception {
        try{
            memberService.updatePreorder(member);
            return new ResponseEntity("Change Preorder Available : " + member.isMemberPreorder(), HttpStatus.OK);

        }
        catch(Exception e){
            logger.info(e.toString());
            return new ResponseEntity<>("No matching phoneNumber", HttpStatus.BAD_REQUEST);
        }
    }

    @ResponseBody
    @RequestMapping(value = { "/user/setting/statistics"}, method = RequestMethod.POST)
    public void statisticsMember(@RequestBody statisticVO statistic) throws Exception {
        memberService.statisticsMember(statistic);
    }
}

