package com.waiting.waitingnow.persistance;

import com.waiting.waitingnow.DTO.WaitingStatusVO;
import com.waiting.waitingnow.domain.WaitingVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class WaitingDAO {

    private static final String namespace = "com.waiting.waitingnow.mapper.waitingMapper";
    private final SqlSession sqlSession;

    @Autowired
    public WaitingDAO(SqlSession sqlSession){
        this.sqlSession = sqlSession;
    }
    public void insert(WaitingVO waiting) throws Exception {
        sqlSession.insert(namespace + ".insert", waiting);
    }

    public WaitingVO selectByid(int waitingNumber) throws Exception {
        return sqlSession.selectOne(namespace + ".selectByid", waitingNumber);
    }

    /***
     * @param waiting (waitingAvailable & memberNumber)
     */
    public List<WaitingVO> selectByWaitingAvailable(WaitingVO waiting) throws Exception {
        return sqlSession.selectList(namespace + ".selectByWaitingAvailable", waiting);
    }

    /***
     * @param waiting (waitingDate & memberNumber)
     */
    public List<WaitingVO> selectByDate(WaitingVO waiting) throws Exception {
        return sqlSession.selectList(namespace + ".selectByDate", waiting);
    }

    /***
     * @param waiting (waitingAvailable은 변경되어 전달 되어야 함)
     */
    public void updateWaitingAvailable(WaitingVO waiting) throws Exception {
        sqlSession.update(namespace + ".updateWaitingAvailable", waiting);
    }

    /***
     * @return 마지막 다음 번호 (이제 사용될 번호)
     */
    public int selectLastWaitingNumber() throws Exception {
        return (int)sqlSession.selectOne(namespace+".selectLastWaitingNumber")+1;
    }

    /***
     * @return 마지막 다음 번호 (이제 사용될 번호)
     */
    public int selectCustomerNumber(int memberNumber) throws Exception {
        return (int)sqlSession.selectOne(namespace+".selectCustomerNumber", memberNumber)+1;
    }

    public WaitingVO waitingSearchByCustomerNumber(WaitingVO waiting) throws Exception{
        return sqlSession.selectOne(namespace + ".waitingSearchByCustomerNumber",waiting);
    }

    /***
     * 현재 대기 인원 출력
     */
    public int selectPeopleByMemberNumber(int memberNumber) throws Exception {
        return (int)sqlSession.selectOne(namespace+".selectPeopleByMemberNumber", memberNumber);
    }

    public List<WaitingVO> selectWaitingListByMemberNumber(WaitingStatusVO waitingStatus) throws Exception {
        if (waitingStatus.getWaitingStatus().equals("waiting")) {
            return sqlSession.selectList(namespace + ".selectWaitingListByMemberNumber", waitingStatus);
        } else if (waitingStatus.getWaitingStatus().equals("end")) {
            return sqlSession.selectList(namespace + ".selectEndListByMemberNumber", waitingStatus);
        } else {
            throw new NullPointerException("상태가 정상적이지 않습니다! [waiting/end] 둘 중에 하나 골라주세요");
        }
    }
}
