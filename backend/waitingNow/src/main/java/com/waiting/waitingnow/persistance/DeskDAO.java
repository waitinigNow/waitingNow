package com.waiting.waitingnow.persistance;

import com.waiting.waitingnow.DTO.SendDeskVO;
import com.waiting.waitingnow.DTO.SitDeskVO;
import com.waiting.waitingnow.domain.DeskAssignVO;
import com.waiting.waitingnow.domain.DeskVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class DeskDAO {

    private static final String namespace = "com.waiting.waitingnow.mapper.deskMapper";
    private static final String AssignNamespace = "com.waiting.waitingnow.mapper.deskAssignMapper";

    private final SqlSession sqlSession;

    @Autowired
    public DeskDAO(SqlSession sqlSession){
        this.sqlSession = sqlSession;
    }
    public void insert(DeskVO desk) throws Exception {
        sqlSession.insert(namespace + ".insert", desk);
    }

    public DeskVO selectByid(int memberNumber) throws Exception {
        return sqlSession.selectOne(namespace + ".selectByid", memberNumber);
    }

    /**
     * 
     * @param memberNumber
     * @return 가게 테이블 번호, 테이블 수용인원
     * @throws Exception
     */
    public List<SendDeskVO> selectByMember(int memberNumber) throws Exception {
        return sqlSession.selectList(namespace + ".selectByMember", memberNumber);
    }

    public void update(DeskVO desk) throws Exception {
        sqlSession.update(namespace + ".update", desk);
    }

    public void delete(DeskVO desk) throws Exception {
        sqlSession.delete(namespace + ".delete", desk);
    }

    public void assignDesk(DeskAssignVO deskAssignVO) throws Exception{
        deskAssignVO.setDeskAssignKey(lastAssignDeskKey());
        sqlSession.insert(AssignNamespace + ".insert", deskAssignVO);
    }

    public DeskAssignVO searchAssignDesk(DeskAssignVO deskAssignVO) throws Exception{
        return sqlSession.selectOne(AssignNamespace + ".selectDeskAssign", deskAssignVO);
    }

    public int lastAssignDeskKey() throws Exception{
        return (int)sqlSession.selectOne(AssignNamespace + ".lastAssignDeskKey")+1;
    }

    /**
     * 테이블이 앉을 수 있는 상황인지 파악하는 메소드
     * @param deskAssignVO (멤버와 테이블 번호로)
     * @return 0이면 앉을 수 있음 (현재 사용하고 있지 않음)
     */
    public int deskSitAvailable(DeskAssignVO deskAssignVO) throws Exception{
        return sqlSession.selectOne(AssignNamespace + ".selectDeskSitAvailable", deskAssignVO);
    }

    /**
     * 멤버 번호로만 테이블이 앉을 수 있는 상황인지 파악하는 메소드
     * @param memberNumber (멤버 번호로)
     * @return 0이면 앉을 수 있음 (현재 사용하고 있지 않음)
     */
    public List<DeskAssignVO> deskSitAvailableList(int memberNumber) throws Exception{
        return sqlSession.selectList(AssignNamespace + ".deskSitAvailableList", memberNumber);
    }

    public void assignOutDesk(DeskAssignVO deskAssignVO) throws Exception{
        sqlSession.delete(AssignNamespace + ".delete", deskAssignVO);
    }
}
