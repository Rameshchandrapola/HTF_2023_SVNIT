const express = require("express");
const lowDb = require("lowdb");
const FileSync = require("lowdb/adapters/FileSync");
const bodyParser = require("body-parser");
const { nanoid } = require("nanoid");

const db = lowDb(new FileSync('db.json'));
db.defaults({ catagorie: []}, {events: {}}).write();
const app = express();
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

const PORT = 4000;

//  Writing all the GET Requests
app.get('/catagorie',(req,res) => {
    const data = db.get("catagorie").value();
    return res.json(data);
});
app.get(`/events`,(req,res) => {
    const data = db.get("events").value();
    return res.json(data);
});
app.listen(PORT, (req,res) => {
    console.log("Backend is running on http://localhost:4000");
    console.log("Here is the Postman collection of the API https://www.getpostman.com/collections/3568635fa77a96b55e53");
})