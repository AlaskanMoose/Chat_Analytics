var dotenv = require("dotenv").config(),
  express = require("express"),
  pg = require("pg"),
  cors = require("cors"),
  app = express();

//Allowed cors in localhost
app.use(cors());

//Database Config .env
const config = {
  user: process.env.PG_USER,
  database: process.env.PG_DATABASE,
  password: process.env.PG_PASS,
  port: process.env.PG_PORT
};

//Documentation for node-postgres: https://node-postgres.com/
const pool = new pg.Pool(config);

//All the members
app.get("/api/members", (req, res, next) => {
  pool.connect(function(err, client, done) {
    if (err) {
      console.log("Can not connect to the DB because of " + err);
    }
    client.query("SELECT * FROM members", function(err, result) {
      done();
      if (err) {
        console.log(err);
        res.status(400).send(err);
      }
      res.status(200).send(result.rows);
    });
  });
});

// Retrieves all the members from the database
app.get("/api.json", (req, res, next) => {
  pool.connect(function(err, client, done) {
    if (err) {
      console.log("Can not connect to the DB because of " + err);
    }
    client.query("SELECT * FROM members", function(err, result) {
      done();
      if (err) {
        console.log(err);
        res.status(400).send(err);
      }
      res.status(200).send(result.rows);
    });
  });
});

// Most popular zipcode per user
app.get("/api/zipcodeunique", (req, res, next) => {
  pool.connect(function(err, client, done) {
    if (err) {
      console.log("Can not connect to the DB because of " + err);
    }
    let memberid = req.body;
    client.query(`SELECT count(zip) as y, zip as label 
      FROM locations group by zip where memberid = ${memberid}`, function(err, result) {
      done();
      if (err) {
        console.log(err);
        res.status(400).send(err);
      }
      res.status(200).send(result.rows);
    });
  });
});

// Retrieves the most zipcode among all users 
// tells you which areas your users are concentrated in
app.get("/api/zipcode", (req, res, next) => {
  pool.connect(function(err, client, done) {
    if (err) {
      console.log("Can not connect to the DB because of " + err);
    }
    client.query(`SELECT count(zip) as y, zip as label 
      FROM personal_info group by zip
      order by count(zip)`, function(err, result) {
      done();
      if (err) {
        console.log(err);
        res.status(400).send(err);
      }
      res.status(200).send(result.rows);
    });
  });
});

// Queries through the messages table to find the number of 
// messages being sent throughout the 24 hour period.
// Extracts the hour from the createdAt timestamp in messages
app.get("/api/messages", (req, res, next) => {
  pool.connect(function(err, client, done) {
    if (err) {
      console.log("Can not connect to the DB because of " + err);
    }
    client.query(`SELECT CASE 
    WHEN h > 0  AND h <= 1  THEN '1'
    WHEN h > 1  AND h <= 2 THEN '2'
    WHEN h > 2 AND h <= 3 THEN '3'
    WHEN h > 3 AND h <= 4 THEN '4'
    WHEN h > 4 AND h <= 5 THEN '5'
    WHEN h > 5 AND h <= 6 THEN '6'
    WHEN h > 6 AND h <= 7 THEN '7'
    WHEN h > 7 AND h <= 8 THEN '8'
    WHEN h > 8 AND h <= 9 THEN '9'
    WHEN h > 9 AND h <= 10 THEN '10'
    WHEN h > 10 AND h <= 11 THEN '11'
    WHEN h > 11 AND h <= 12 THEN '12'
    WHEN h > 12 AND h <= 13 THEN '13'
    WHEN h > 13 AND h <= 14 THEN '14'
    WHEN h > 14 AND h <= 15 THEN '15'
    WHEN h > 15 AND h <= 16 THEN '16'
    WHEN h > 16 AND h <= 17 THEN '17'
    WHEN h > 17 AND h <= 18 THEN '18'
    WHEN h > 18 AND h <= 19 THEN '19'
    WHEN h > 19 AND h <= 20 THEN '20'
    WHEN h > 20 AND h <= 21 THEN '21'
    WHEN h > 21 AND h <= 22 THEN '22'
    WHEN h > 22 AND h <= 23 THEN '23'
    WHEN h > 23            THEN '24'

   END AS label
   ,count(*) AS y
  FROM  (
  SELECT extract(hour from createdat) AS h
  FROM   messages
  ) as x
  GROUP  BY h
  ORDER  BY h  ASC
  LIMIT  24;`, function(err, result) {
      done();
      if (err) {
        console.log(err);
        res.status(400).send(err);
      }
      res.status(200).send(result.rows);
    });
  });
});

// Retrieves the most popular devices among users
// joins the device and personal_info table and group 
// by name of the device. 
app.get("/api/device", (req, res, next) => {
  pool.connect(function(err, client, done) {
    if (err) {
      console.log("Can not connect to the DB because of " + err);
    }
    client.query(`select count(p.deviceid) as y, d.device as label
                from device d
                left join personal_info p on
                d.deviceid = p.deviceid
                group by label;`, function(err, result) {
      done();
      if (err) {
        console.log(err);
        res.status(400).send(err);
      }
      res.status(200).send(result.rows);
    });
  });
});

// Retrieves the most common age amoung users grouped
// by their zipcode. mode() function returns the most 
// commonly occuring value in a column
app.get("/api/age", (req, res, next) => {
  pool.connect(function(err, client, done) {
    if (err) {
      console.log("Can not connect to the DB because of " + err);
    }
    client.query(`SELECT zip as label, 
        mode() within group (order by age) as y 
        from personal_info group by zip;`, function(err, result) {
      done();
      if (err) {
        console.log(err);
        res.status(400).send(err);
      }
      res.status(200).send(result.rows);
    });
  });
});
//Server
app.listen(8080, function() {
  console.log("API listening on http://localhost:8080/api.json");
});
