import { reject } from 'lodash';

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

router.get('/', async function (req, res, next) {
  try {
    console.log('Promise check');
    var course_instance_id = res.locals.course_instance.id;
    res.locals.seasonalResults = await getSeasonalResults(course_instance_id);
    res.locals.liveResults = await getLiveResults(course_instance_id);
    res.render(__filename.replace(/\.js$/, '.ejs'), res.locals);
  } catch (err) {
    next(err);
  }
});

// error handling middleware that accepts the error passed through next()
router.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Something went wrong!');
});

// ---------
// FUNCTIONS
// ---------
// TODO: Function to get USER INFO (user_id as parameter)


// Function to get SEASONAL RESULTS
function getSeasonalResults(course_instance_id) {
  return new Promise((resolve, reject) => {
    sqldb.query(sql.get_seasonal_results, [course_instance_id], function(err, result) {
      if (err) {
        reject(err);
      } else {
        resolve(result.rows);
      }
    });
  });
}
// Function to get LIVE RESULTS
function getLiveResults(course_instance_id) {
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


// TODO: Function to get ALL-TIME RESULTS


module.exports = router;
