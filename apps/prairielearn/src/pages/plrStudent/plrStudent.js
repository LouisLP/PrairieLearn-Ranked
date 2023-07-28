var ERR = require('async-stacktrace');
// Routing Stuff
var express = require('express');
var router = express.Router();
// Query Stuff
var sqldb = require('@prairielearn/postgres');
var sql = sqldb.loadSqlEquiv(__filename);
// SSE Stuff
var sseClients = require('../../sseClients');

// -------
// ROUTING
// -------
router.get('/live_updates', (req, res) => {
  // This is the new SSE-specific route
  res.setHeader('Content-Type', 'text/event-stream');
  res.setHeader('Cache-Control', 'no-cache');
  res.setHeader('Connection', 'keep-alive');

  const clientRes = sseClients.addClient(res);

  req.on('close', () => {
    sseClients.removeClient(clientRes);
  });

  res.flushHeaders();
});

router.get('/', function (req, res, next) {
  // This route only handles rendering the page
  var course_instance_id = res.locals.course_instance.id;
  
  getSeasonalResults(course_instance_id, function (err, seasonalResults) {
    if (ERR(err, next)) return;
    res.locals.seasonalResults = seasonalResults;
  });
  
  console.log('Sanity Check 1');
  getLiveResults(course_instance_id, function (err, liveResults) {
    if (ERR(err, next)) return;
    res.locals.liveResults = liveResults;
  });

  setTimeout(function() {
    res.render(__filename.replace(/\.js$/, '.ejs'), res.locals);
  }, 500);
});

// ---------
// FUNCTIONS
// ---------
// TODO: Function to get USER INFO (user_id as parameter)


// Function to get SEASONAL RESULTS
function getSeasonalResults(course_instance_id, callback) {
  sqldb.query(sql.get_seasonal_results, [course_instance_id], function(err, result) {
      if (ERR(err, callback)) return;
      callback(null, result.rows);
  });
}

// Function to get LIVE RESULTS
function getLiveResults(course_instance_id, callback) {
  sqldb.query(sql.get_live_results, [], function(err, result) {
      if (ERR(err, callback)) return;
      callback(null, result.rows);
  });
}


// TODO: Function to get ALL-TIME RESULTS


module.exports = router;