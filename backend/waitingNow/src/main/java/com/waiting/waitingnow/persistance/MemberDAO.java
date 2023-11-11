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

    /**
     * @param memberNumber
     * @return memberVO
     * @throws Exception
     */
    public MemberVO selectByid(int memberNumber) throws Exception {
        return sqlSession.selectOne(namespace + ".selectByid", memberNumber);
    }

    /**
     * @param memberEmail
     * @return memberPW
     * @throws Exception
     */
    public String selectByMemberEmailToPW(String memberEmail) throws Exception {
        return sqlSession.selectOne(namespace + ".selectByMemberEmailToPW", memberEmail);
    }

    /**
     * @param memberEmail
     * @return memberVO
     * @throws Exception
     */
    public MemberVO selectByMemberEmailToMember(String memberEmail) throws Exception {
        return sqlSession.selectOne(namespace + ".selectByMemberEmailToMember", memberEmail);
    }

    public void updatePreorderAvailable(MemberVO member) throws Exception {
        sqlSession.update(namespace + ".updatePreorderAvailable", member);
    }
}
