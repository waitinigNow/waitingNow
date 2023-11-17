package com.waiting.waitingnow.service;

import com.waiting.waitingnow.domain.MemberVO;
import com.waiting.waitingnow.domain.WaitingVO;
import com.waiting.waitingnow.persistance.MemberDAO;
import com.waiting.waitingnow.persistance.WaitingDAO;
import com.waiting.waitingnow.requestDomain.DateVO;
import com.waiting.waitingnow.requestDomain.statisticVO;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.reflect.Member;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@Service
public class MemberService {
    private final MemberDAO memberDAO;
    private final WaitingDAO waitingDAO;
    private final SessionService sessionService;

    private static final Logger logger = LoggerFactory.getLogger(MemberService.class);

    @Autowired
    public MemberService(MemberDAO memberDAO, SessionService sessionService, WaitingDAO waitingDAO) {
        this.memberDAO = memberDAO;
        this.sessionService = sessionService;
        this.waitingDAO = waitingDAO;
    }

    // 세션 확인하는 메소드도 필요함

    /***
     * 회원 가입하는 메소드
     * @param member
     * @return 회원가입여부
     */
    public boolean signUpMember(MemberVO member) throws Exception {
        member.setMemberNumber(memberDAO.selectLastMemberNumber());
        // TODO 이메일 중복만 확인함.
        if(memberDAO.selectByMemberPhoneToMember(member.getMemberPhone())==null){
            memberDAO.insert(member);
            return true;
        }
        return false;
    }

    /***
     * 로그인 하는 메소드
     * @param member (Phone, PW)
     * @param request
     * @return 로그인 되었으면, 완성된 객체 전달함. 아니면 null
     */
    public MemberVO loginMember(MemberVO member, HttpServletRequest request) throws Exception {
        String memberPassword = memberDAO.selectByMemberPhoneToPW(member.getMemberPhone());
        if (memberPassword.matches(member.getMemberPassword())) {
            MemberVO full_member = memberDAO.selectByMemberPhoneToMember(member.getMemberPhone());
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

    public MemberVO searchMember(MemberVO member) throws Exception{
        return memberDAO.selectByMemberPhoneToMember(member.getMemberPhone());
    }

    public void updateMember(MemberVO member) throws Exception{
        memberDAO.updateMember(member);
    }
    public MemberVO updateMemberPhone(MemberVO member) throws Exception{
        return memberDAO.updateMemberPhone(member);
    }

    public void updatePreorder(MemberVO member) throws Exception{
        memberDAO.updatePreorder(member);
    }

    public void statisticsMember(statisticVO statistic) throws Exception{

        WaitingVO waiting = new WaitingVO();
        waiting.setMemberNumber(memberDAO.selectMyMemberNumber(statistic.getMemberPhone()));
        waiting.setWaitingDate(statistic.getWaitingDate()+ " %");
        List<WaitingVO> waitings = waitingDAO.selectByDate(waiting);

    }

}



