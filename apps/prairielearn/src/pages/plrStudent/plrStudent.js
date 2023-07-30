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
    var course_instance_id = res.locals.course_instance.id;
    var course_id = res.locals.course.id;
    res.locals.seasonalResults = await getSeasonalResults(course_instance_id);
    res.locals.allTimeResults = await getAllTimeResults(course_id);
    res.locals.liveResults = await getLiveResults();

    // Get the user's display name
    res.locals.displayName = await getUserDisplayName(res.locals.authn_user.user_id);

    res.render(__filename.replace(/\.js$/, '.ejs'), res.locals);
  } catch (err) {
    console.log(err);
  }
});

// ---------
// FUNCTIONS
// ---------
// Function to get USER DISPLAY NAME
function getUserDisplayName(user_id) {
  return new Promise((resolve, reject) => {
    sqldb.queryOneRow(sql.get_user_display_name, [user_id], function(err, result) {
      if (err) {
        reject(err);
      } else {
        resolve(result.rows[0].display_name);
      }
    });
  });
}

// TODO: Function to get ACHIEVEMENTS


module.exports = router;
