package com.waiting.waitingnow.service;

import com.waiting.waitingnow.DTO.SendDeskVO;
import com.waiting.waitingnow.domain.DeskVO;
import com.waiting.waitingnow.persistance.DeskDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeskService {

    private final DeskDAO deskDAO;
    @Autowired
    public DeskService(DeskDAO deskDAO){
        this.deskDAO = deskDAO;
    }

    public List<SendDeskVO> selectByMember(int memberNumber) throws Exception{
        List<SendDeskVO> desks = deskDAO.selectByMember(memberNumber);
        if(desks.isEmpty()){
            throw new NullPointerException("회원 번호가 일치하지 않습니다.");
        }
        return desks;
    }
}
