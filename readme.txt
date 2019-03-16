# React Data visualization application with PostgreSQL integration
# The backend web service was built using node.js and the front-end was built using react

### Seed
- Seed your PostgreSQL database by running query.sql (in the SQL folder) script in your database environment
- The .csv files must be in the same folder

 ### Install dependencies, but since included node_modules there should be no need
- `$npm install`

 ### Login to the database
- Create a `.env` file similar to the `.env.example.env` or modify the current file
- Include your PostgreSQL username, password, database and port.


 ### Configure the PostgreSQL query
- The query in api.js must correspond to the database table name

 ### Start your API
- `$node api.js` 

- API local endpoint: http://localhost:8080/api.json

 ### Start your Application
- `$npm start` 

- App starts on: http://localhost:3000/
