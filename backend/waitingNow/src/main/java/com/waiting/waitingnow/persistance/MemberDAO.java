package com.waiting.waitingnow.persistance;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.waiting.waitingnow.domain.MemberVO;
@Repository
public class MemberDAO {
    private static final String namespace = "com.waiting.waitingnow.mapper.memberMapper";
    private final SqlSession sqlSession;

    @Autowired
    public MemberDAO(SqlSession sqlSession){
        this.sqlSession = sqlSession;
    }
    public void insert(MemberVO member) throws Exception {
        sqlSession.insert(namespace + ".insert", member);
    }

    public MemberVO selectByid(int memberNumber) throws Exception {
        return sqlSession.selectOne(namespace + ".selectByid", memberNumber);
    }

    public MemberVO selectByMemberEmail(String memberEmail) throws Exception {
        return sqlSession.selectOne(namespace + ".selectByMemberEmail", memberEmail);
    }

    public void updatePreorderAvailable(MemberVO member) throws Exception {
        sqlSession.update(namespace + ".updatePreorderAvailable", member);
    }
}
