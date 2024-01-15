package com.waiting.waitingnow.service;

import com.waiting.waitingnow.DTO.NewPhoneNumberVO;
import com.waiting.waitingnow.domain.MemberVO;
import com.waiting.waitingnow.domain.WaitingVO;
import com.waiting.waitingnow.persistance.MemberDAO;
import com.waiting.waitingnow.persistance.WaitingDAO;
import com.waiting.waitingnow.DTO.DateVO;
import com.waiting.waitingnow.DTO.StatisticVO;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MemberService {
    private final MemberDAO memberDAO;
    private final WaitingDAO waitingDAO;
    private final SessionService sessionService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    private static final Logger logger = LoggerFactory.getLogger(MemberService.class);

    @Autowired
    public MemberService(MemberDAO memberDAO, SessionService sessionService, WaitingDAO waitingDAO) {
        this.memberDAO = memberDAO;
        this.sessionService = sessionService;
        this.waitingDAO = waitingDAO;
    }

    // 세션 확인하는 메소드도 필요함

    /***
     * 회원 가입하는 메소드 [비밀번호 인코딩]
     * @param member
     * @return 회원가입여부
     */
    public void signUpMember(MemberVO member) throws Exception {
        member.setMemberNumber(memberDAO.selectLastMemberNumber());
        String inputPW = member.getMemberPassword();
        member.setMemberPassword(passwordEncoder.encode(inputPW));
        
        // 전화번호 중복이면 오류 발생, 아니면 회원가입 진행
        if(memberDAO.selectByMemberPhoneToMember(member.getMemberPhone()) != null){
            throw new IllegalStateException("이미 가입된 아이디가 있습니다.");
        }
        else{
            memberDAO.insert(member);
        }
        

    }

    /***
     * 로그인 하는 메소드 
     * 암호화 된 비밀번호로 수정함
     * @param member (Phone, PW)
     * @param request
     * @return 로그인 되었으면, 완성된 객체 전달함. 아니면 null
     */
    public MemberVO loginMember(MemberVO member, HttpServletRequest request) throws Exception {
        String memberPassword = memberDAO.selectByMemberPhoneToPW(member.getMemberPhone());
        if (passwordEncoder.matches(member.getMemberPassword(), memberPassword)) {
            MemberVO full_member = memberDAO.selectByMemberPhoneToMember(member.getMemberPhone());
            logger.info(full_member.getMemberName());
            // SessionService.registerSession(full_member, request); //세션 등록 필요 X
            return full_member;
        } else {
            throw new IllegalArgumentException("Not matched Password");
        }

    }

    /**
     * 전화번호로 회원 찾는 메소드
     * @param memberPhone
     * @return
     * @throws NullPointerException : 일치하는 전화번호가 없을 때, 발생 시킴
     */
    public MemberVO searchMemberByPhone(String memberPhone) throws Exception{
        MemberVO member = memberDAO.selectByMemberPhoneToMember(memberPhone);
        if(member == null){
            throw new NullPointerException("일치하는 전화번호 없음");
        }
        return member;
    }

    /**
     * 회원번호로 회원 찾는 메소드
     * @param memberNumber
     * @return
     * @throws NullPointerException : 일치하는 전화번호가 없을 때, 발생 시킴
     */
    public MemberVO searchMember(int memberNumber) throws Exception{
        MemberVO member = memberDAO.selectByid(memberNumber);
        if(member == null){
            throw new NullPointerException("일치하는 전화번호 없음");
        }
        return member;
    }

    public void updateMember(MemberVO member) throws Exception{
        memberDAO.updateMember(member);
    }

    public MemberVO updateMemberPhone(NewPhoneNumberVO newPhoneNumber) throws Exception{
        if(memberDAO.selectByMemberPhoneToMember(newPhoneNumber.getMemberPhone()) == null) {
            throw new NullPointerException("일치 하는 전화번호 없음");
        }
        else if(newPhoneNumber.getNewPhoneNumber().matches(newPhoneNumber.getMemberPhone())){
            throw new IllegalArgumentException("두 전화번호가 동일 합니다.");
        }
        return memberDAO.updateMemberPhone(newPhoneNumber);
    }

    public boolean updatePreorder(MemberVO member) throws Exception{
        memberDAO.updatePreorder(member);
        return memberDAO.selectByid(member.getMemberNumber()).isMemberPreorder();
    }

    public DateVO statisticsMember(StatisticVO statistic) throws Exception{
        WaitingVO waiting = new WaitingVO();
        waiting.setMemberNumber(statistic.getMemberNumber());
        waiting.setWaitingDate(statistic.getWaitingDate()+ " %");
        List<WaitingVO> waitings = waitingDAO.selectByDate(waiting);
        DateVO date = new DateVO();
        for(int i=0;i<waitings.size();i++){
            String times = waitings.get(i).getWaitingDate();
            date.setCustomer(Integer.valueOf(times.substring(11, 13)));
        }
        return date;
    }
}



