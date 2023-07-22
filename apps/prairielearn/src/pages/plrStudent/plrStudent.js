var ERR = require('async-stacktrace');
// Routing Stuff
var express = require('express');
var router = express.Router();
// Query Stuff
var sqldb = require('@prairielearn/postgres');
var sql = sqldb.loadSqlEquiv(__filename);

// -------
// ROUTING
// -------
router.get('/', function (req, res, next) {
  getSeasonalResults(function(err, results) {
    if (ERR(err, next)) return;
    res.locals.seasonalResults = results;
    res.render(__filename.replace(/\.js$/, '.ejs'), res.locals);
  });
});

// ---------
// FUNCTIONS
// ---------
// TODO: Function to get USER INFO (user_id as parameter)


// TODO: Function to get LIVE RESULTS


// Function to get SEASONAL RESULTS
function getSeasonalResults(callback) {
  sqldb.query(sql.get_seasonal_results, [], function(err, result) {
      if (ERR(err, callback)) return;
      callback(null, result.rows);
  });
}

// TODO: Function to get ALL-TIME RESULTS


module.exports = router;