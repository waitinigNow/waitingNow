import CheckboxList from "./CheckboxList";

export default function WaitingList() {
  return (
    <>
      <div className="table-list">
        <div className="table-text">
          <span>배정하실 테이블을 선택해주세요.</span>
        </div>
        {/* <div className="waiting-index">
          <span></span>
        </div>
        <div className="waiting-info">
          <span className="waiting-phone"></span>
          <div className="waiting-detail">
            <div className="waiting-people">
              <span></span>
            </div>
            <div className="waiting-time">
              <span>웨이팅 시간</span>
            </div>
          </div>
        </div>
        <div className="btn-switch-block">
        </div> */}
        <div>
          <CheckboxList />
        </div>
      </div>
    </>
  );
}
