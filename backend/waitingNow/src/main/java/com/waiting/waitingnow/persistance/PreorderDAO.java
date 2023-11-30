package com.waiting.waitingnow.persistance;

import com.waiting.waitingnow.DTO.MenuPreorderVO;
import com.waiting.waitingnow.DTO.SetPreorderVO;
import com.waiting.waitingnow.domain.OptionMenuVO;
import com.waiting.waitingnow.domain.OptionPreorderVO;
import com.waiting.waitingnow.domain.PreorderVO;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public class PreorderDAO {

    private static final String namespace = "com.waiting.waitingnow.mapper.preorderMapper";
    private static final String OptionNamespace = "com.waiting.waitingnow.mapper.optionPreorderMapper";
    private final SqlSession sqlSession;

    @Autowired
    public PreorderDAO(SqlSession sqlSession){
        this.sqlSession = sqlSession;
    }
    public void insert(SetPreorderVO setpreorder) throws Exception {
        for(MenuPreorderVO menu : setpreorder.getMenu()){
            // preorder 하나씩 등록함
            int preorderNumber = selectLastNumber();
            PreorderVO preorder = new PreorderVO();

            preorder.setPreorderNumber(preorderNumber);
            preorder.setWaitingNumber(setpreorder.getWaitingNumber());
            preorder.setMenuNumber(menu.getMenuNumber());
            preorder.setPreorderMenuCount(menu.getMenuCount());

            sqlSession.insert(namespace + ".insert", preorder);

            //option에서도 등록해야함
            for(List<OptionMenuVO> options : menu.getMenuOption().values()){
                for(OptionMenuVO option : options){
                    OptionPreorderVO optionPreorder = new OptionPreorderVO();
                    optionPreorder.setOptionPreorderKey(selectOptionLastNumber());
                    optionPreorder.setPreorderNumber(preorderNumber);
                    optionPreorder.setOptionMenuKey(option.getOptionMenuKey());

                    sqlSession.insert(OptionNamespace + ".insert", optionPreorder);
                }
            }
        }
    }

    public PreorderVO selectByid(int preorderNumber) throws Exception {
        return sqlSession.selectOne(namespace + ".selectByid", preorderNumber);
    }

    /***
     * 웨이팅 번호로 preorderVO 조회
     * @param waitingNumber
     * @return
     * @throws Exception
     */
    public List<PreorderVO> selectByWaiting(int waitingNumber) throws Exception {
        List<PreorderVO> preorders = sqlSession.selectList(namespace + ".selectByWaiting", waitingNumber);
        return preorders;
    }

    /***
     * 선주문 번호로 optionPreorderVO 조회
     * @param preorderNumber
     * @return
     * @throws Exception
     */
    public List<OptionPreorderVO> selectOptionsByPreorderNumber(int preorderNumber) throws Exception{
        return sqlSession.selectList(OptionNamespace + ".selectOptionsByPreorderNumber", preorderNumber);
    }

    public int selectLastNumber() throws Exception{
        return (int)sqlSession.selectOne(namespace+".selectLastNumber")+1;
    }


    public int selectOptionLastNumber() throws Exception{
        return (int)sqlSession.selectOne(OptionNamespace+".selectOptionLastNumber")+1;
    }

    // TODO Mapper 등록 후 업데이트 하려면 다 지우고 다시 등록하는 것이 좋은가?
}
