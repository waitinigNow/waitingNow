package com.waiting.waitingnow.service;

import com.waiting.waitingnow.domain.MemberVO;
import com.waiting.waitingnow.persistance.MemberDAO;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {
    private final MemberDAO memberDAO;
    private final SessionService sessionService;

    private static final Logger logger = LoggerFactory.getLogger(MemberService.class);

    @Autowired
    public MemberService(MemberDAO memberDAO, SessionService sessionService) {
        this.memberDAO = memberDAO;
        this.sessionService = sessionService;
    }

    // 세션 확인하는 메소드도 필요함

    /***
     * 회원 가입하는 메소드
     * @param member
     * @return 회원가입여부
     */
    public void signUpMember(MemberVO member) throws Exception {
        memberDAO.insert(member);
        // return 값 고민해야함.
    }

    /***
     * 로그인 하는 메소드
     * @param member (Email, PW)
     * @param request
     * @return 로그인 되었으면, 완성된 객체 전달함. 아니면 null
     */
    public MemberVO loginMember(MemberVO member, HttpServletRequest request) throws Exception {
        String memberPassword = memberDAO.selectByMemberEmailToPW(member.getMemberEmail());
        if (memberPassword.matches(member.getMemberPassword())) {
            MemberVO full_member = memberDAO.selectByMemberEmailToMember(member.getMemberEmail());
            logger.info(full_member.getMemberName());
            SessionService.registerSession(full_member, request); //TODO 세션 등록 시 확인 여부
            return full_member;
        } else {
            return null;
        }
         /*
         @TODO PassWordEncoder 추가했을 때, 코드 변경
        if(passwordEncoder.matches(member.getMemberPassword(), memberPassword)){
            MemberVO full_member = memberDAO.selectByMemberEmailToMember(member.getMemberEmail());
            SessionService.registerSession(full_member, request);
            return "true";
        }
        else { return "false";}
        */
    }
}


