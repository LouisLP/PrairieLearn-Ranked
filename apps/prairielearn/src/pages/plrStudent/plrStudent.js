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
// Models
const { getLiveResults } = require('./plrStudentModel')
const { getSeasonalResults } = require('./plrStudentModel')
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
    var course_instance_id = res.locals.course_instance.id;
    res.locals.seasonalResults = await getSeasonalResults(course_instance_id);
    res.locals.liveResults = await getLiveResults(course_instance_id);
    res.render(__filename.replace(/\.js$/, '.ejs'), res.locals);
  } catch (err) {
    console.log(err);
  }
});

// FUNCTIONS
// ---------
// TODO: Function to get USER INFO (user_id as parameter)

// TODO: Function to get ALL-TIME RESULTS


module.exports = router;
