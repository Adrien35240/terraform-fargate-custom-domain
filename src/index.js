const express = require('express')
const app = express()
const port = 80
app.set('view engine', 'pug');
app.get('/', (req, res) => {
    res.send('Hello World! updated v7')
})

app.listen(port, () => {
    console.log(`Example app listening on port http://localhost:${port}`)
})
