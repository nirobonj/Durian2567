import React, { useState } from 'react';

const UploadWav = () => {
  const [file, setFile] = useState(null);
  const [error, setError] = useState(null);

  const handleChange = (event) => {
    const selectedFile = event.target.files[0];
    const allowedTypes = ['audio/wav', 'audio/wave'];

    if (selectedFile && allowedTypes.includes(selectedFile.type)) {
      setFile(selectedFile);
      setError('');
    } else {
      setFile(null);
      setError('Please select a valid WAV file.');
    }
  };

  const handleSubmit = async (event) => {
    event.preventDefault();
    const accessToken = localStorage.getItem('accessToken');
    console.log(accessToken);
    if (!accessToken) {
      console.error('Access token is missing or expired.');
      return;
    }

    const formData = new FormData();
    formData.append('audio', file);

    try {
      const response = await fetch('http://localhost:3000/upload', {
        method: 'POST',
        headers: {
          Authorization: `Bearer ${accessToken}`,
        },
        body: formData,
      });

      if (!response.ok) {
        throw new Error('Failed to upload WAV file.');
      }

      console.log('WAV file uploaded successfully.');
      // Handle success, e.g., show success message
    } catch (error) {
      console.error('Error uploading WAV file:', error.message);
      // Handle error, e.g., show error message
    }
  };

  return (
    <div>
      <h2>Upload WAV File</h2>
      <form onSubmit={handleSubmit}>
        <input type="file" onChange={handleChange} accept=".wav, .wave" />
        {error && <div style={{ color: 'red' }}>{error}</div>}
        <button type="submit" disabled={!file}>Upload</button>
      </form>
    </div>
  );
};

export default UploadWav;
