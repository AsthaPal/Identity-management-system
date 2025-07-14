var express = require('express');
var bodyParser = require('body-parser');
var path = require('path');

var app = express();
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'web/views'));
app.use('/public', express.static(__dirname + '/web/public'));

app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});

app.use(bodyParser.json()); // support json encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); 

// Deploy Smart Contract and place smart contract address here 
var ContractAddress = "0xeE306109b3C005371a7c0A953256B75e01Ac5F33";

app.get('/', function (req, res) {
  res.render("index")
});

app.get('/AddUser', function (req, res) {
  res.render("AddUser", { ContractAddress });
});

app.get('/AddUserDL', function (req, res) {
  res.render("AddUserDL", { ContractAddress });
});

app.get('/ViewRequest', function (req, res) {
  res.render("ViewRequest", { ContractAddress });
});

// ✅ FIXED: Accept GET requests for /ViewRequestDetail
app.get('/ViewRequestDetail', function (req, res) {
  const RequestIndex = req.query.RequestIndex;
  const UserAddress = req.query.UserAddress;
  const InstitutionName = req.query.InstitutionName || "Institution"; // optional fallback

  const data = {
    ContractAddress,
    RequestIndex,
    UserAddress,
    InstitutionName
  };

  res.render("ViewRequestDetail", data);
});

app.get('/RequestAccess', function (req, res) {
  res.render("RequestAccess", { ContractAddress });
});

app.get('/ViewRequest_Org', function (req, res) {
  res.render("ViewRequest_Org", { ContractAddress });
});

app.get('/ViewRequestDetail_Org', function (req, res) {
  const RequestIndex = req.query.RequestIndex;
  const UserAddress = req.query.UserAddress;
  const InstitutionName = req.query.InstitutionName || "Institution"; // optional fallback

  res.render("ViewRequestDetail_Org", {
    ContractAddress,
    RequestIndex,
    UserAddress,
    InstitutionName
  });
});


app.get('/Message', function (req, res) {
  const TransHash = req.query.TransHash;
  res.render("Message", { TransHash });
});

var server = app.listen(8080, function () {
  var host = server.address().address;
  var port = server.address().port;

  console.log("Identity Management app listening at http://%s:%s", host, port);
});
