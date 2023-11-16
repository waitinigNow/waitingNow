import React, { Component } from 'react';

class MainForm extends Component {
  render() {
    return (
      <div id="back">
        <div id="background">
          <div id="waitingInformation">
            <div id="waitingTime">
              <div class="bottom" id="textBox">
                <font color="#FFFFFF" id="font_small">
                  현재대기
                </font>
                <font color="#FFFFFF" id="font_big">
                  5
                  {/* 여기는 이제 앞에 대기 남은 팀 가져오기 */}
                </font>
                <font color="#FFFFFF" id="font_small">
                  팀
                </font>
              </div>
            </div>
            <a id="goWaiting" href="/">
              <font size="100" color="#FFFFFF">
                웨이팅 접수
              </font>
            </a>
          </div>
        </div>
      </div>
    );
  }
}

export default MainForm;