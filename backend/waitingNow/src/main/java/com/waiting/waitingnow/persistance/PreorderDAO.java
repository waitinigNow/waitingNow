package com.waiting.waitingnow.persistance;

import com.waiting.waitingnow.domain.PreorderVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public class PreorderDAO {

    private static final String namespace = "com.waiting.waitingnow.mapper.preorderMapper";
    private final SqlSession sqlSession;

    @Autowired
    public PreorderDAO(SqlSession sqlSession){
        this.sqlSession = sqlSession;
    }
    public void insert(PreorderVO preorder) throws Exception {
        sqlSession.insert(namespace + ".insert", preorder);
    }

    public PreorderVO selectByid(int preorderNumber) throws Exception {
        return sqlSession.selectOne(namespace + ".selectByid", preorderNumber);
    }

    public List<PreorderVO> selectByWaiting(int waitingNumber) throws Exception {
        return sqlSession.selectList(namespace + ".selectByWaiting", waitingNumber);
    }

    // TODO Mapper 등록 후 업데이트 하려면 다 지우고 다시 등록하는 것이 좋은가?
}
