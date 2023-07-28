var ERR = require('async-stacktrace');
var sqldb = require('@prairielearn/postgres');

const path = require('path');
// Construct the path to plrStudent.sql
const sqlFilePath = path.join(__dirname, 'plrStudent.js');

var sql = sqldb.loadSqlEquiv(sqlFilePath);

function getLiveResults(course_instance_id, callback) {
  sqldb.query(sql.get_live_results, [course_instance_id], function (err, result) {
    if (ERR(err, callback)) return;
    callback(null, result.rows);
  });
}

module.exports = getLiveResults;
