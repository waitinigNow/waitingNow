import React from 'react';
import { useRecoilState } from 'recoil';
import { telNumber } from './RecoilState';
import backspace from 'assets/backspace.png';
import { Link } from 'react-router-dom';
import 'styles/MainTel.css';

export default function MainTel() {
  const [telInput, setTelInput] = useRecoilState(telNumber);

  const handleNumberClick = (number: string) => {
    setTelInput((prevTelInput) => prevTelInput + number);
  };

  const handleBackspaceClick = () => {
    setTelInput((prevTelInput) => prevTelInput.slice(0, -1));
  };

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    let formattedInput = e.target.value.replace(/[^\d]/g, '');
    if (formattedInput.length > 2 && formattedInput.length <= 5) {
      formattedInput = formattedInput.replace(/(\d{2})(\d{0,4})/, '$1-$2');
    } else if (formattedInput.length > 5) {
      formattedInput = formattedInput.replace(/(\d{2})(\d{0,4})(\d{0,4})/, '$1-$2-$3');
    }
    console.log('formattedInput:', formattedInput);
    setTelInput(formattedInput);
  };

  const handleSubmit = () => {
    console.log('전화번호:', telInput);
  };

  return (
    <>
      <div id="back">
        <div id="background">
          <div id="inputTel">
            <p id="informa">
              휴대폰 번호를 입력하시면 카카오톡으로 웨이팅 정보가 전송됩니다.
            </p>
            <input
              type="tel"
              id="telInput"
              value={telInput}
              onChange={handleInputChange}
            />
          </div>
          <div id="inputTelNum">
            {[1, 2, 3, 4, 5, 6, 7, 8, 9].map((number) => (
              <button
                key={number}
                className="num backgroundWhite"
                onClick={() => handleNumberClick(String(number))}
              >
                {number}
              </button>
            ))}
            <button
              className="backgroundWhite"
              onClick={handleBackspaceClick}
            >
              <img src={backspace} id="backspace" alt="backspace" />
            </button>
            <button
              className="num backgroundWhite"
              onClick={() => handleNumberClick('0')}
            >
              0
            </button>
            <Link to="/mainNum">
              <button
                type="button"
                className="input"
                value="mobileNum"
                onClick={handleSubmit}
              >
                입력
              </button>
            </Link>
          </div>
        </div>
      </div>
    </>
  );
}
