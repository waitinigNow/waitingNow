package com.waiting.waitingnow.persistance;

import com.waiting.waitingnow.domain.OptionMenuVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class OptionMenuDAO {
    private static final String namespace = "com.waiting.waitingnow.mapper.optionMenuMapper";
    private final SqlSession sqlSession;

    @Autowired
    public OptionMenuDAO(SqlSession sqlSession){
        this.sqlSession = sqlSession;
    }
    public void insert(OptionMenuVO optionMenu) throws Exception {
        sqlSession.insert(namespace + ".insert", optionMenu);
    }

    public OptionMenuVO selectByid(int optionMenuKey) throws Exception {
        return sqlSession.selectOne(namespace + ".selectByid", optionMenuKey);
    }

    public List<OptionMenuVO> selectByMenu(int menuNumber) throws Exception {
        return sqlSession.selectList(namespace + ".selectByMenu", menuNumber);
    }


}
