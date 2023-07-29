var sqldb = require('@prairielearn/postgres');

const path = require('path');
// Construct the path to plrStudent.sql
const sqlFilePath = path.join(__dirname, 'plrScoreboard.js');

var sql = sqldb.loadSqlEquiv(sqlFilePath);

// Function to get LIVE RESULTS
function getLiveResults() {
  return new Promise((resolve, reject) => {
    sqldb.query(sql.get_live_results, [], function(err, result) {
      if (err) {
        reject(err);
      } else {
        resolve(result.rows)
      }
    });
  });
}
// Function to get SEASONAL RESULTS
function getSeasonalResults() {
  return new Promise((resolve, reject) => {
    sqldb.query(sql.get_seasonal_results, [], function(err, result) {
      if (err) {
        reject(err);
      } else {
        resolve(result.rows);
      }
    });
  });
}
// TODO: Function to get ALL-TIME RESULTS

module.exports = { 
  getLiveResults,
  getSeasonalResults
};
