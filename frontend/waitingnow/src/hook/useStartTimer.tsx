import { useRecoilCallback } from "recoil";
import { timerStateFamily, timerActiveStateFamily } from "Storestate";

export const useStartTimer = () => {
  return useRecoilCallback(({ set }) => (id: number) => {
    set(timerActiveStateFamily(id), true);

    const interval = setInterval(() => {
      set(timerStateFamily(id), (currentTime) => {
        const newTime = currentTime - 1;
        if (newTime === 0) {
          clearInterval(interval);
          return 10 * 60; // 10분으로 리셋
        }
        return newTime;
      });
    }, 1000);

    const checkEndAndDeactivate = () => {
      set(timerStateFamily(id), (currentTime) => {
        if (currentTime === 10 * 60) {
          set(timerActiveStateFamily(id), false);
        }
        return currentTime;
      });
    };

    return () => {
      clearInterval(interval);
      checkEndAndDeactivate();
    };
  });
};
