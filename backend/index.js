// const express = require('express');
// const app = express();

// app.use(express.json());
// app.use(express.urlencoded({ extended: true }));

// const personData = [];

// const port = 3000;

// app.listen(port, () => {
//     console.log(`Successfully Connected to port ${port}`);
// });

// // POST API
// app.post('/api/add_person', (req, res) => {
//     console.log('Result', req.body);

//     const pdata = {
//         id: personData.length + 1,
//         pname: req.body.pname,
//         pphone: req.body.pphone,
//         pAge: req.body.pAge
//     };

//     personData.push(pdata);
//     console.log('Final Result:', pdata);

//     res.status(200).send({
//         status_code: 200,
//         message: 'Person Data Added Successfully',
//         person: pdata
//     });
// });
const express = require('express');
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const personData = [];
const port = 3000;

app.listen(port, () => {
    console.log(`Successfully Connected to port ${port}`);
});

// POST API - Add a new person
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

// GET API - Retrieve all persons
app.get('/api/get_persons', (req, res) => {
    res.status(200).send({
        status_code: 200,
        message: 'Persons Retrieved Successfully',
        persons: personData
    });
});

// GET API - Retrieve a person by ID
app.get('/api/get_person/:id', (req, res) => {
    const personId = parseInt(req.params.id);
    const person = personData.find(p => p.id === personId);
    
    if (person) {
        res.status(200).send({
            status_code: 200,
            message: 'Person Retrieved Successfully',
            person: person
        });
    } else {
        res.status(404).send({
            status_code: 404,
            message: 'Person Not Found'
        });
    }
});

// DELETE API - Remove a person by ID
app.delete('/api/delete_person/:id', (req, res) => {
    const personId = parseInt(req.params.id);
    const index = personData.findIndex(person => person.id === personId);
    
    if (index !== -1) {
        const deletedPerson = personData.splice(index, 1);
        res.status(200).send({
            status_code: 200,
            message: 'Person Deleted Successfully',
            person: deletedPerson
        });
    } else {
        res.status(404).send({
            status_code: 404,
            message: 'Person Not Found'
        });
    }
});

// PUT API - Update a person's details by ID
app.put('/api/update_person/:id', (req, res) => {
    const personId = parseInt(req.params.id);
    const index = personData.findIndex(person => person.id === personId);

    if (index !== -1) {
        personData[index] = { ...personData[index], ...req.body };
        res.status(200).send({
            status_code: 200,
            message: 'Person Updated Successfully',
            person: personData[index]
        });
    } else {
        res.status(404).send({
            status_code: 404,
            message: 'Person Not Found'
        });
    }
});
