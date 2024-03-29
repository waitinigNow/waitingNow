package com.waiting.waitingnow.persistance;

import com.waiting.waitingnow.DTO.MenuPreorderVO;
import com.waiting.waitingnow.domain.MenuVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MenuDAO {
    private static final String namespace = "com.waiting.waitingnow.mapper.menuMapper";
    private final SqlSession sqlSession;

    @Autowired
    public MenuDAO(SqlSession sqlSession){
        this.sqlSession = sqlSession;
    }

    public void insert(MenuVO menu) throws Exception {
        sqlSession.insert(namespace + ".insert", menu);
    }

    public MenuVO selectByid(int menuNumber) throws Exception {
        return sqlSession.selectOne(namespace + ".selectByid", menuNumber);
    }

    /**
     * 메뉴 번호로 선주문 정보를 조회하는 메소드
     * @param menuNumber (메뉴 번호)
     * @return 선주문 정보(MenuPreorderVO)
     * @throws Exception
     */
    public MenuPreorderVO selectPreorderVOByid(int menuNumber) throws Exception {
        return sqlSession.selectOne(namespace + ".selectPreorderVOByid", menuNumber);
    }

    public List<MenuVO> selectByMember(int memberNumber) throws Exception {
        return sqlSession.selectList(namespace + ".selectByMember", memberNumber);
    }

    public void update(MenuVO menu) throws Exception {
        sqlSession.update(namespace + ".update", menu);
    }

    public void delete(int memberNumber) throws Exception {
        sqlSession.delete(namespace + ".delete", memberNumber);
    }
}
