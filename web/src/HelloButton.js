import React, { useState, useEffect } from 'react';

const HelloButton = () => {
  const [message, setMessage] = useState('');
  
  useEffect(() => {
    // Fetch hello message when component mounts
    fetchHelloMessage();
  }, []);

  const fetchHelloMessage = async () => {
    const token = localStorage.getItem('accessToken');
    if (!token) {
      console.error('Access token not found');
      return;
    }

    try {
      const response = await fetch('http://localhost:3000/hello', {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`,
        },
      });
      const data = await response.json();
      setMessage(data.message);
    } catch (error) {
      console.error('Error fetching hello message:', error);
    }
  };

  return (
    <div>
      <button onClick={fetchHelloMessage}>Say Hello</button>
      <div>{message}</div>
    </div>
  );
};

export default HelloButton;
