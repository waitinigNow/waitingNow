import React from "react";
import { Route, Routes } from "react-router-dom";
import SignUpPage from "pages/signup";

interface RouterProps {
  isAuthenticated: boolean;
}

export default function Router() {
  return (
    <>
      <Routes>
        <>
          <Route path="/signup" element={<SignUpPage />} />
        </>
      </Routes>
    </>
  );
}
