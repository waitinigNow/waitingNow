import React, { useState, useEffect } from 'react';
import 'styles/WaitingStyles.css';
import wastebasket from 'assets/wastebasket.png';
import cart from 'assets/cart.png';
import minus from 'assets/minus.png';
import plus from 'assets/plus.png';
import cancel from 'assets/cancel.png';
import food from 'assets/food.png';
import { viewMenu } from 'api/waitingApi';

interface MenuItem {
  menuNumber: number;
  menuName: string;
  menuPrice: number;
}

interface MenuData {
  [category: string]: MenuItem[];
}

export default function MenuMain() {
  const [cartItems, setCartItems] = useState([
    { menuName: '매운 오징어볶음', quantity: 1 },
    { menuName: '크림 치즈 파스타', quantity: 1 },
    { menuName: '그릴드 삼겹살 스테이크', quantity: 1 },
    { menuName: '해산물 토마토 리조또', quantity: 1 },
    { menuName: '샐러드 파머지안 파스타', quantity: 1 },
    { menuName: '로제 크림 스파게티', quantity: 1 }
  ]);

  const [menuData, setMenuData] = useState<MenuData>({});

  const handleIncrement = (menuName: string) => {
    setCartItems((prevItems) =>
      prevItems.map((item) =>
        item.menuName === menuName ? { ...item, quantity: item.quantity + 1 } : item
      )
    );
  };

  const handleDecrement = (menuName: string) => {
    setCartItems((prevItems) =>
      prevItems.map((item) =>
        item.menuName === menuName ? { ...item, quantity: Math.max(item.quantity - 1, 0) } : item
      )
    );
  };

  const handleRemove = (menuName: string) => {
    setCartItems((prevItems) => prevItems.filter((item) => item.menuName !== menuName));
  };

  const handleAddToCart = (menu: MenuItem) => {
    const existingItem = cartItems.find((item) => item.menuName === menu.menuName);

    if (existingItem) {
      setCartItems((prevItems) =>
        prevItems.map((item) =>
          item.menuName === menu.menuName ? { ...item, quantity: item.quantity + 1 } : item
        )
      );
    } else {
      setCartItems((prevItems) => [...prevItems, { ...menu, quantity: 1 }]);
    }
  };

  useEffect(() => {
    const fetchData = async () => {
      try {
        const memberNum = localStorage.getItem('memberNumber');
        const waitingData = await viewMenu(Number(memberNum));

        // 데이터에서 카테고리별로 메뉴를 정리
        const categorizedMenu: MenuData = {};
        Object.keys(waitingData.data).forEach((category) => {
          categorizedMenu[category] = waitingData.data[category];
        });

        setMenuData(categorizedMenu);
      } catch (error) {
        console.error('Error:', error);
      }
    };

    fetchData();
  }, []);

  return (
    <>
      <div className='back'>
        <div className='background flexRow'>
          <div className='flexColumn overflowAuto'>
            {Object.keys(menuData).map((category) => (
              <div key={category} className='marginBottom40'>
                <p className='text40'>{category}</p>
                <div id='foodMenu'>
                  {menuData[category].map((menu) => (
                    <div key={menu.menuNumber} id='menuInformation' onClick={() => handleAddToCart(menu)}>
                      <img src={food} width="253px" height="253px" alt={menu.menuName} />
                      <p className='text25'>{menu.menuName}</p>
                      <p className='text20'>{menu.menuPrice}원</p>
                    </div>
                  ))}
                </div>
              </div>
            ))}
          </div>
          <div id='cart'>
            <div id='cartMenu'>
              <div id='menuTitle' className='text40'>
                &nbsp;주문 메뉴
              </div>
              <div id='oneMenu'>
                {cartItems.map((item) => (
                  <div key={item.menuName}>
                    <div id='menuContainer'>
                      {item.menuName}
                    </div>
                    <div className='flexBetween'>
                      <div className='flex alignCenter'>
                        <button className='minusbtn' onClick={() => handleDecrement(item.menuName)}>
                          <img src={minus} alt='minus' width='20px' height='20px' className='btnSet' />
                        </button>
                        <p id='num'>{item.quantity}</p>
                        <button className='minusbtn' onClick={() => handleIncrement(item.menuName)}>
                          <img src={plus} alt='plus' width='20px' height='20px' className='btnSet' />
                        </button>
                      </div>
                      <div className='alignCenter'>
                        <button className='cancelbtn' onClick={() => handleRemove(item.menuName)}>
                          삭제
                        </button>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </div>
            <div id='cartSave' className='flexColumn justifyContentSpace'>
              <button className='text40 alignCenter' id='binBtn'>
                <img src={wastebasket} width='45px' height='45px'></img>
                전체 삭제
              </button>
              <button className='text40 alignCenter' id='saveBtn'>
                선주문 완료
                <img src={cart} width='45px' height='45px'></img>
              </button>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};