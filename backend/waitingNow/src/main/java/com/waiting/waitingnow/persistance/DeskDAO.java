package com.waiting.waitingnow.persistance;

import com.waiting.waitingnow.DTO.SendDeskVO;
import com.waiting.waitingnow.domain.DeskVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class DeskDAO {

    private static final String namespace = "com.waiting.waitingnow.mapper.deskMapper";
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
}
