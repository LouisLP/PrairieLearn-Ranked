var ERR = require('async-stacktrace');
var sqldb = require('@prairielearn/postgres');

const path = require('path');
// Construct the path to plrStudent.sql
const sqlFilePath = path.join(__dirname, 'plrStudent.js');

var sql = sqldb.loadSqlEquiv(sqlFilePath);

// // Function to get SEASONAL RESULTS
// function getSeasonalResults(callback, params) {
//   sqldb.query(sql.get_seasonal_results, params, function (err, result) {
//     if (ERR(err, callback)) return;
//     callback(null, result.rows);
//   });
// }
function getLiveResults(callback, params) {
  sqldb.query(sql.get_live_results, params, function (err, result) {
    if (ERR(err, callback)) return;
    callback(null, result.rows);
  });
}

module.exports = getLiveResults;
