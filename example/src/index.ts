import express from 'express';

const app = express();
const PORT = 8080;

app.get('/', (req, res) => res.send('Express + TypeScript Server'));

app.listen(PORT, () =>
{
  console.log(`⚡️ Server is running at https://localhost:${PORT}`);
});
