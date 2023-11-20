package com.waiting.waitingnow.persistance;

import com.waiting.waitingnow.DTO.NewPhoneNumberVO;
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
     * @param memberPhone
     * @return memberPW
     * @throws Exception
     */
    public String selectByMemberPhoneToPW(String memberPhone) throws Exception {
        return sqlSession.selectOne(namespace + ".selectByMemberPhoneToPW", memberPhone);
    }

    /**
     * @param memberPhone
     * @return memberVO
     * @throws Exception
     */
    public MemberVO selectByMemberPhoneToMember(String memberPhone) throws Exception {
        return sqlSession.selectOne(namespace + ".selectByMemberPhoneToMember", memberPhone);
    }

    public void updatePreorderAvailable(MemberVO member) throws Exception {
        sqlSession.update(namespace + ".updatePreorderAvailable", member);
    }

    public int selectLastMemberNumber(){
        return (int)sqlSession.selectOne(namespace + ".selectLastMemberNumber")+1;
    }

    /**
     * 전화번호로 memberNumber 조회하는 메소드
     * @return memberNumber
     */
    public int selectMyMemberNumber(String memberPhone){
        return (int)sqlSession.selectOne(namespace + ".selectMyMemberNumber", memberPhone);
    }

    public void updateMember(MemberVO member) throws Exception{
        sqlSession.update(namespace + ".updateMember", member);
    }

    public MemberVO updateMemberPhone(NewPhoneNumberVO newPhoneNumber) throws Exception{
        sqlSession.update(namespace + ".updateMemberPhone" , newPhoneNumber);
        return selectByMemberPhoneToMember(newPhoneNumber.getNewPhoneNumber());
    }

    public void updatePreorder(MemberVO member) throws Exception{
        sqlSession.update(namespace+".updatePreorderAvailable", member);
    }
}
