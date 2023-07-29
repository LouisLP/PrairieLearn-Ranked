import { reject } from 'lodash';

var ERR = require('async-stacktrace');
// Routing Stuff
var express = require('express');
var router = express.Router();
// Query Stuff
// var sqldb = require('@prairielearn/postgres');
// var path = require('path');
//
// var sqlFilePath = path.join(__dirname, '../partials/plr/plrScoreboard.sql');
// var sql = sqldb.loadSqlEquiv(sqlFilePath);
// SSE Stuff
var sseClients = require('../../sseClients');
// Models
const { getLiveResults } = require('../partials/plr/plrScoreboardModel')
const { getSeasonalResults } = require('../partials/plr/plrScoreboardModel')
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
    res.locals.seasonalResults = await getSeasonalResults();
    res.locals.liveResults = await getLiveResults();

    res.render(__filename.replace(/\.js$/, '.ejs'), res.locals);
  } catch (err) {
    console.log(err);
  }
});
// ---------
// FUNCTIONS
// ---------
// TODO: Function to populate available quizzes


module.exports = router;
