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
const { getAllTimeResults } = require('../partials/plr/plrScoreboardModel');
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
    var course_instance_id = res.locals.course_instance.id;
    var course_id = res.locals.course.id;
    res.locals.seasonalResults = await getSeasonalResults(course_instance_id);
    res.locals.allTimeResults = await getAllTimeResults(course_id);
    res.locals.liveResults = await getLiveResults();

    // Non-Async Population

    res.locals.quizzes = await getQuizzes(course_instance_id);

    res.render(__filename.replace(/\.js$/, '.ejs'), res.locals);
  } catch (err) {
    console.log(err);
  }
});
// ---------
// FUNCTIONS
// ---------
// Function to get QUIZZES (With "LV" tag)
function getQuizzes(course_instance_id) { 
  return new Promise((resolve, reject) => {
    sqldb.query(sql.get_quizzes, [course_instance_id], function(err, result) {
      if (err) {
        reject(err);
      } else {
        resolve(result.rows);
      }
    });
  });
}

module.exports = router;
