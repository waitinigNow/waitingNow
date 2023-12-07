package com.waiting.waitingnow.service;

import com.waiting.waitingnow.DTO.SendDeskVO;
import com.waiting.waitingnow.domain.DeskAssignVO;
import com.waiting.waitingnow.domain.SentDeskAssignVO;
import com.waiting.waitingnow.domain.WaitingVO;
import com.waiting.waitingnow.persistance.DeskDAO;
import com.waiting.waitingnow.persistance.PreorderDAO;
import com.waiting.waitingnow.persistance.WaitingDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

import static java.lang.Boolean.FALSE;
import static java.lang.Boolean.TRUE;

@Service
public class DeskService {

    private final DeskDAO deskDAO;
    private final PreorderDAO preorderDAO;
    private final WaitingDAO waitingDAO;

    @Autowired
    public DeskService(DeskDAO deskDAO, PreorderDAO preorderDAO, WaitingDAO waitingDAO){
        this.deskDAO = deskDAO;
        this.preorderDAO = preorderDAO;
        this.waitingDAO = waitingDAO;
    }

    public List<SendDeskVO> selectByMember(int memberNumber) throws Exception{
        List<SendDeskVO> desks = deskDAO.selectByMember(memberNumber);
        List<DeskAssignVO> assignVO = deskDAO.deskSitAvailableList(memberNumber);
        for(int i = 0; i < assignVO.size(); i++){
            desks.get(assignVO.get(i).getDeskStoreNumber()-1).setDeskAvailable(false);
        }
        if(desks.isEmpty()){
            throw new NullPointerException("회원 번호가 일치하지 않습니다.");
        }
        return desks;
    }

    /**
     * SentDeskAssignVO : 테이블 번호가 list
     * deskAssignVO : 테이블 번호가 int
     * @param sentdeskAssignVO
     * @return
     * @throws Exception
     */
    public SentDeskAssignVO assignDesk(SentDeskAssignVO sentdeskAssignVO) throws Exception{
        int enterAvailable = 2;

        // preorderExist 값 채우기
        if(preorderDAO.selectByWaiting(sentdeskAssignVO.getWaitingNumber()).isEmpty()) sentdeskAssignVO.setPreorderExist(FALSE);
        else sentdeskAssignVO.setPreorderExist(TRUE);

        // 배열로 되어 있는 desk Number 변경
        DeskAssignVO deskAssignVO = new DeskAssignVO();
        deskAssignVO.setMemberNumber(sentdeskAssignVO.getMemberNumber()); deskAssignVO.setDeskAssignKey(sentdeskAssignVO.getDeskAssignKey()); deskAssignVO.setPreorderExist(sentdeskAssignVO.getPreorderExist()); deskAssignVO.setWaitingNumber(sentdeskAssignVO.getWaitingNumber());
        
        // deskNumber 당 할당함
        for(int deskNumber : sentdeskAssignVO.getDeskStoreNumber()){
            deskAssignVO.setDeskStoreNumber(deskNumber);
            // 0이면 앉을 수 있음 (현재 사용하고 있지 않음)
            if(deskDAO.deskSitAvailable(deskAssignVO) == 0){
                // 데스크 할당 (상태가 입장 가능일때만)
                int nowAvailable = waitingDAO.selectByid(deskAssignVO.getWaitingNumber()).getWaitingAvailable();
                if (nowAvailable == enterAvailable || nowAvailable == 1){
                    deskDAO.assignDesk(deskAssignVO);
                }
                else {
                    throw new IllegalStateException("웨이팅 상태가 입장 가능 상태가 아닙니다!");
                }
            }
            else {
                throw new IllegalStateException("현재 " + deskNumber + "번 테이블을 이용중 입니다!");
            }
        }

        // 상태를 입장 완료로 변경함
        WaitingVO waiting = new WaitingVO();
        waiting.setWaitingNumber(deskAssignVO.getWaitingNumber()); waiting.setWaitingAvailable(0); waiting.setMemberNumber(deskAssignVO.getMemberNumber());
        waitingDAO.updateWaitingAvailable(waiting);
        
        // 할당한 데스크의 정보 불러오기
        SentDeskAssignVO NewDeskAssignVO = deskDAO.searchAssignDesk(deskAssignVO);
        if(NewDeskAssignVO == null) throw new NullPointerException("뭘봐");

        return sentdeskAssignVO;
    }

    /**
     * 여러 desk번호를 받아서 배정 해제함
     * @param sentdeskAssignVO
     * @throws Exception
     */
    public void assignOutDesk(SentDeskAssignVO sentdeskAssignVO) throws Exception {

        // 배열로 되어 있는 desk Number 변경
        DeskAssignVO deskAssignVO = new DeskAssignVO();
        deskAssignVO.setMemberNumber(sentdeskAssignVO.getMemberNumber());
        deskAssignVO.setDeskAssignKey(sentdeskAssignVO.getDeskAssignKey());
        deskAssignVO.setPreorderExist(sentdeskAssignVO.getPreorderExist());
        deskAssignVO.setWaitingNumber(sentdeskAssignVO.getWaitingNumber());

        // deskNumber 한 개씩 변경함
        for (int deskNumber : sentdeskAssignVO.getDeskStoreNumber()) {
            deskAssignVO.setDeskStoreNumber(deskNumber);
            if (deskDAO.deskSitAvailable(deskAssignVO) != 1) {
                throw new IllegalStateException("배정되어 있지 않은 " + deskNumber + "번 식탁을 퇴장 처리 하는군.");
            }
            deskDAO.assignOutDesk(deskAssignVO);
        }
    }

}

