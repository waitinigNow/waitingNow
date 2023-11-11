package com.waiting.waitingnow.persistance;

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

    public List<DeskVO> selectByMember(int memberNumber) throws Exception {
        return sqlSession.selectList(namespace + ".selectByMember", memberNumber);
    }

    public void update(DeskVO desk) throws Exception {
        sqlSession.update(namespace + ".update", desk);
    }

    public void delete(DeskVO desk) throws Exception {
        sqlSession.delete(namespace + ".delete", desk);
    }
}
