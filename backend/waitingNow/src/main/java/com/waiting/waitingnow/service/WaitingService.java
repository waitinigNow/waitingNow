package com.waiting.waitingnow.service;

import com.waiting.waitingnow.domain.WaitingVO;
import com.waiting.waitingnow.persistance.MemberDAO;
import com.waiting.waitingnow.persistance.WaitingDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;


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
        int waitingNumber = waitingDAO.selectLastWaitingNumber()+1;

        waiting.setWaitingNumber(waitingNumber);
        waiting.setWaitingDate(dateFormat.format(now));
        waiting.setWaitingCustomerNumber(waitingDAO.selectCustomerNumber(waiting.getMemberNumber()));
        waiting.setWaitingAvailable(1);

        waitingDAO.insert(waiting);
    }

    /***
     * 웨이팅 없이 바로 입장하는 손님을 만드는 메소드
     * @return
     * @throws Exception
     */
    public int noWaiting(int memberNumber, int waitingPeople) throws Exception{
        WaitingVO waiting = new WaitingVO();

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date now = new Date();
        int waitingNumber = waitingDAO.selectLastWaitingNumber()+1;

        waiting.setMemberNumber(memberNumber);
        waiting.setWaitingNumber(waitingNumber);
        waiting.setWaitingDate(dateFormat.format(now));
        waiting.setWaitingAvailable(0);
        waiting.setWaitingPeople(waitingPeople);

        waitingDAO.insert(waiting);

        return waitingNumber;
    }

    public WaitingVO waitingSearchByCustomerNumber(WaitingVO waiting) throws Exception{
        WaitingVO newWaiting = waitingDAO.waitingSearchByCustomerNumber(waiting);
        newWaiting.setWaitingAvailable(2);
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

    public List<WaitingVO> waitingNowList(int memberNumber, String waitingStatus) throws Exception{
        List<WaitingVO> waitings = waitingDAO.selectWaitingListByMemberNumber(memberNumber, waitingStatus);
        if(!waitings.isEmpty()) {
            return waitings;
        }
        else {
            throw new NullPointerException("존재하지 않는 회원 번호입니다.");
        }
    }
}
