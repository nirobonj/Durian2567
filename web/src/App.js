import React, { useState } from 'react';
import './App.css';
import Login from './Login';
import UploadWav from './UploadWav';
import HelloButton from './HelloButton';
function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  const handleLoginSuccess = () => {
    setIsLoggedIn(true);
  };

  return (
    <div className="App">
      {!isLoggedIn ? (
        <Login onLoginSuccess={handleLoginSuccess} />
      ) : (
        <HelloButton />
      )}
    </div>
  );
}

export default App;
