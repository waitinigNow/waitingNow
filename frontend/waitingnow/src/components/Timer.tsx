import { timerUpdateSelectorFamily, timerActiveStateFamily } from "Storestate";
import { useRecoilValue } from "recoil";
import { useStartTimer } from "./useStartTimer";

// 타이머 기능
export const Timer: React.FC<{ id: number }> = ({ id }) => {
  const time = useRecoilValue(timerUpdateSelectorFamily(id));
  const startTimer = useStartTimer();

  const handleStartTimer = () => {
    startTimer(id);
  };

  const minutes = Math.floor(time / 60);
  const seconds = time % 60;

  return (
    <button className="btn-call" onClick={handleStartTimer}>
      호출 <br />
      {minutes}:{seconds.toString().padStart(2, "0")}
    </button>
  );
};
