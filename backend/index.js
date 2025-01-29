const express = require('express');
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const personData = [];

const port = 3000;

app.listen(port, () => {
    console.log(`Successfully Connected to port ${port}`);
});

// POST API
app.post('/api/add_person', (req, res) => {
    console.log('Result', req.body);

    const pdata = {
        id: personData.length + 1,
        pname: req.body.pname,
        pphone: req.body.pphone,
        pAge: req.body.pAge
    };

    personData.push(pdata);
    console.log('Final Result:', pdata);

    res.status(200).send({
        status_code: 200,
        message: 'Person Data Added Successfully',
        person: pdata
    });
});
