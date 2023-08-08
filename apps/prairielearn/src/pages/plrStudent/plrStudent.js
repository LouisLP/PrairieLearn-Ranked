const ERR = require('async-stacktrace');
// File Stuff (for filtering prohibited words)
const fs = require('fs');
const path = require('path');
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
    res.locals.course_instance_id = res.locals.course_instance.id;
    var course_id = res.locals.course.id;
    var user_id = res.locals.authn_user.user_id;

    // Get the user's display name
    res.locals.displayName = await getUserDisplayName(user_id);
    res.locals.userId = user_id; // Also pass the user_id to res.locals

    res.locals.seasonalResults = await getSeasonalResults(res.locals.course_instance_id);
    res.locals.allTimeResults = await getAllTimeResults(course_id);
    res.locals.liveResults = await getLiveResults();

    res.render(__filename.replace(/\.js$/, '.ejs'), res.locals);
  } catch (err) {
    console.log(err);
  }
});

// router.post('/', async function (req, res, next) {
//   if (req.body.__action === 'change-display-name') {
//     var userId = req.body.userId;
//     var newDisplayName = req.body.newDisplayName;

//     try {
//       await updateDisplayName(userId, newDisplayName);
//       res.redirect(req.originalUrl);
//     } catch (err) {
//       console.error(err);
//       // An error occurred, redirect back to the original page
//       res.redirect(req.originalUrl);
//     }
//   } else {
//     next(
//       ERR.make(400, 'unknown __action', {
//         body: req.body,
//         locals: res.locals,
//       }),
//     );
//   }
// });

// ---------
// FUNCTIONS
// ---------
// Function to get USER DISPLAY NAME
function getUserDisplayName(user_id) {
  return new Promise((resolve, reject) => {
    sqldb.queryOneRow(sql.get_user_display_name, [user_id], function (err, result) {
      if (err) {
        reject(err);
      } else {
        resolve(result.rows[0].display_name);
      }
    });
  });
}
// Function to check profanity
function profanityCheck(displayName) {
  // Read the prohibited words from the file
  const prohibitedWords = fs
    .readFileSync(path.join(__dirname, 'prohibitedWords.txt'), 'utf-8')
    .split('\n')
    .map((word) => word.trim());

  // Check if displayName is within the character limit
  if (displayName.length > 30) {
    throw new Error('Display name is too long (30 character limit).');
  }

  // Convert the display name to lowercase for the profanity check
  const lowerCaseDisplayName = displayName.toLowerCase();

  // Check if displayName contains any prohibited words
  if (prohibitedWords.some((word) => lowerCaseDisplayName.includes(word))) {
    throw new Error('Display name contains prohibited words.');
  }
}
// Function to change/update USER DISPLAY NAME
function updateDisplayName(userId, newDisplayName) {
  return new Promise((resolve, reject) => {
    try {
      profanityCheck(newDisplayName);
    } catch (err) {
      reject(err);
      return;
    }

    sqldb.query(sql.update_display_name, [userId, newDisplayName], function (err) {
      if (err) {
        reject(err);
      } else {
        resolve();
      }
    });
  });
}

// TODO: Function to get ACHIEVEMENTS

module.exports = router;
