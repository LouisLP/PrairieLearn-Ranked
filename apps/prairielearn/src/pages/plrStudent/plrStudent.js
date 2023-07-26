var ERR = require('async-stacktrace');
// Routing Stuff
var express = require('express');
var router = express.Router();
// Query Stuff
var sqldb = require('@prairielearn/postgres');
var sql = sqldb.loadSqlEquiv(__filename);
var sseClients = require('../../sseClients');

// -------
// ROUTING
// -------

// SSE ENDPOINT

router.get('/live_updates', (req, res) => {
  res.setHeader('Content-Type', 'text/event-stream');
  res.setHeader('Cache-Control', 'no-cache');
  res.setHeader('Connection', 'keep-alive');
  res.flushHeaders();

  // Add this client to the clients array and get its unique ID
  const clientId = sseClients.addClient(res);

  // Include the client's unique ID in the body of the POST request
  req.body.id = clientId;

  // Remove this client from the clients array when the connection is closed
  req.on('close', () => {
    sseClients.removeClient(clientId);
  });
});

// MAIN PAGE
router.get('/', function (req, res, next) {
  var params = {
    course_instance_id: res.locals.course_instance.id,
  };
  getSeasonalResults(function (err, seasonalResults) {
    if (ERR(err, next)) return;
    res.locals.seasonalResults = seasonalResults;
  }, params);
  getLiveResults(function (err, liveResults) {
    if (ERR(err, next)) return;
    res.locals.liveResults = liveResults;
  }, params);
  res.render(__filename.replace(/\.js$/, '.ejs'), res.locals);
});

// ---------
// FUNCTIONS
// ---------
// TODO: Function to get USER INFO (user_id as parameter)

// TODO: Function to get LIVE RESULTS

// Function to get SEASONAL RESULTS
function getSeasonalResults(callback, params) {
  sqldb.query(sql.get_seasonal_results, params, function (err, result) {
    if (ERR(err, callback)) return;
    callback(null, result.rows);
  });
}
function getLiveResults(callback, params) {
  sqldb.query(sql.get_live_results, params, function (err, result) {
    if (ERR(err, callback)) return;
    callback(null, result.rows);
  });
}

// TODO: Function to get ALL-TIME RESULTS

module.exports = router;
