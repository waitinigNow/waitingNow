package com.waiting.waitingnow.service;

import com.waiting.waitingnow.domain.WaitingVO;
import com.waiting.waitingnow.persistance.MemberDAO;
import com.waiting.waitingnow.persistance.WaitingDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;


@Service
public class WaitingService {

    private final MemberDAO memberDAO;
    private final WaitingDAO waitingDAO;
    @Autowired
    public WaitingService(MemberDAO memberDAO, WaitingDAO waitingDAO) {
        this.memberDAO = memberDAO;
        this.waitingDAO = waitingDAO;
    }

    public WaitingVO selectByid(int waitingNumber) throws Exception{
        WaitingVO waiting = waitingDAO.selectByid(waitingNumber);
        if(waiting != null) {
            return waiting;
        }
        else {
            throw new NullPointerException("존재하지 않는 웨이팅 번호입니다.");
        }
    }

    public void insert(WaitingVO waiting) throws Exception{
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date now = new Date();

        waiting.setWaitingNumber(waitingDAO.selectLastWaitingNumber());
        waiting.setWaitingDate(dateFormat.format(now));
        waiting.setWaitingCustomerNumber(waitingDAO.selectCustomerNumber(waiting.getMemberNumber()));
        waiting.setWaitingAvailable("대기");

        waitingDAO.insert(waiting);
    }

    public WaitingVO waitingSearchByCustomerNumber(WaitingVO waiting) throws Exception{
        WaitingVO newWaiting = waitingDAO.waitingSearchByCustomerNumber(waiting);
        newWaiting.setWaitingAvailable("입장 가능");
        return newWaiting;
    }

    public WaitingVO waitingChangeStatus(WaitingVO waiting) throws Exception{
        WaitingVO newWaiting = waitingSearchByCustomerNumber(waiting);
        newWaiting.setWaitingAvailable(waiting.getWaitingAvailable());
        waitingDAO.updateWaitingAvailable(newWaiting);
        return selectByid(newWaiting.getWaitingNumber());
    }

    public int waitingNowPeople(int memberNumber) throws Exception{
        return waitingDAO.selectPeopleByMemberNumber(memberNumber);
    }
}
