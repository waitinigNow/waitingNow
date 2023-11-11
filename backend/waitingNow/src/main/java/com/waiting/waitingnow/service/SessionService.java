package com.waiting.waitingnow.service;

import com.waiting.waitingnow.domain.MemberVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;


@Service
public class SessionService {

    private static final Logger logger = LoggerFactory.getLogger(SessionService.class);

    /**
     * sesstion을 확인하는 메소드
     * @param request : 생성해서 넘겨주기만 하면 됨.
     * @return session이 등록되어 있으면 memberVO / 등록 되어 있지 (memberVO) null
     */
    public MemberVO checkSession(HttpServletRequest request) {
        HttpSession session = null;
        MemberVO member = null;
        try {
            session = request.getSession();
            // 추후
            member = (MemberVO) session.getAttribute("member");
            return member;

        } catch (Exception e) {
            logger.info("로그인 되어있지 않음.");
        }
        return member;
    }

    /**
     * 세션을 등록하는 메소드
     * @param request : 생성해서 넘겨주기만 하면 됨.
     * @param member : 등록할 memberVO 객체를 주세요.
     */
    public void registerSession(HttpServletRequest request, MemberVO member) {
        HttpSession session = request.getSession();

        // 예시: 세션에 username 값을 등록하는 경우
        String username = request.getHeader("member");
        session.setAttribute("member", member);
    }


    /**
     * 세션을 해제하는 메소드
     * @param request : 생성해서 넘겨주기만 하면 됨.
     */
    public void invalidateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        if (session != null) {
            session.invalidate();
            logger.info("세션이 성공적으로 해제되었습니다.");
        } else {
            logger.info("현재 세션이 존재하지 않습니다.");
        }
    }

}
