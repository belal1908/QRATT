const express = require('express');
const app = express();

app.use(express.static('public'));
app.set('view engine', 'hbs');

app.get('/', (req, res) => {
  res.render('home');
});

app.get('/create-campaign', (req, res) => {
  res.render('create-campaign');
});

const port = process.env.PORT || 3000;
app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
