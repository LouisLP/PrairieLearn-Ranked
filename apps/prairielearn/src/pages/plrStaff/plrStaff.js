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

    res.locals.quizzes = await getQuizzes(course_instance_id);

    res.render(__filename.replace(/\.js$/, '.ejs'), res.locals);
  } catch (err) {
    console.log(err);
  }
});

// Route to handle the update_quiz endpoint (POST request)
router.post('/', async (req, res) => {
  try {
    const { assessment_id, course_instance_id } = req.body;


    console.log('Received data:', assessment_id, course_instance_id);
    // Call the setQuizFlag function to update the is_live status for the quiz
    await setQuizFlag(assessment_id, course_instance_id);

    // Respond with a success status
    res.sendStatus(200);
  } catch (err) {
    console.error('Error updating quiz is_live status:', err);
    // Respond with an error status
    res.sendStatus(500);
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

function setQuizFlag(assessment_id, course_instance_id) {
  return new Promise((resolve, reject) => {
    sqldb.query(sql.set_live_flag, [assessment_id, course_instance_id], function (err) {
      if (err) {
        reject(err);
      } else {
        resolve();
      }
    });
  });
}

module.exports = router;
