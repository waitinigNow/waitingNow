package com.waiting.waitingnow.service;

import com.waiting.waitingnow.DTO.SendDeskVO;
import com.waiting.waitingnow.domain.DeskAssignVO;
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

    public DeskAssignVO assignDesk(DeskAssignVO deskAssignVO) throws Exception{
        int enterAvailable = 2;

        // preorderExist 값 채우기
        if(preorderDAO.selectByWaiting(deskAssignVO.getWaitingNumber()).isEmpty()) deskAssignVO.setPreorderExist(FALSE);
        else deskAssignVO.setPreorderExist(TRUE);

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
            throw new IllegalStateException("현재 테이블을 이용중 입니다!");
        }

        // 상태를 입장 완료로 변경함
        WaitingVO waiting = new WaitingVO();
        waiting.setWaitingNumber(deskAssignVO.getWaitingNumber()); waiting.setWaitingAvailable(0); waiting.setMemberNumber(deskAssignVO.getMemberNumber());
        waitingDAO.updateWaitingAvailable(waiting);
        
        // 할당한 데스크의 정보 불러오기
        DeskAssignVO NewDeskAssign = deskDAO.searchAssignDesk(deskAssignVO);
        if(NewDeskAssign == null) throw new NullPointerException("뭘봐");

        return NewDeskAssign;
    }

    public void assignOutDesk(DeskAssignVO deskAssignVO) throws Exception{
        if(deskDAO.deskSitAvailable(deskAssignVO) != 1){
            throw new IllegalStateException("배정되어 있지 않은 식탁을 퇴장 처리 하는군.");
        }
        deskDAO.assignOutDesk(deskAssignVO);
    }
}
