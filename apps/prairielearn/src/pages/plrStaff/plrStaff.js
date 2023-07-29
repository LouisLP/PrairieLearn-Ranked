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
const { getLiveResults } = require('../partials/plr/plrScoreboardModel');
const { getSeasonalResults } = require('../partials/plr/plrScoreboardModel');
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
    // Async Scoreboard Population
    res.locals.seasonalResults = await getSeasonalResults();
    res.locals.liveResults = await getLiveResults();

    // Non-Async Population
    var course_instance_id = res.locals.course_instance.id;

    getQuizzes(course_instance_id, function (err, quizzes) {
      if (ERR(err, next)) return;
      res.locals.quizzes = quizzes;
    });

    res.render(__filename.replace(/\.js$/, '.ejs'), res.locals);
  } catch (err) {
    console.log(err);
  }
});
// ---------
// FUNCTIONS
// ---------
// Function to get QUIZZES (With "LV" tag)
function getQuizzes(course_instance_id, callback) {
  sqldb.query(sql.get_quizzes, [course_instance_id], function (err, result) {
    if (ERR(err, callback)) return;
    callback(null, result.rows);
  });
}

module.exports = router;
