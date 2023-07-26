const ERR = require('async-stacktrace');
const express = require('express');
const router = express.Router();

const { config } = require('../../lib/config');
const sqldb = require('@prairielearn/postgres');

const sql = sqldb.loadSqlEquiv(__filename);
const sseClients = require('../../sseClients');

router.get('/', function (req, res) {
  res.locals.navPage = 'plrStaff';
  res.locals.isAuthenticated = !!res.locals.authn_user;
  const user = res.locals.authn_user.user_id;

  if (res.locals.isAuthenticated) {
    console.log('plrStaff.js: authenticated');
    console.log('plrStaff.js: user_id: ' + user);
    res.render(__filename.replace(/\.js$/, '.ejs'), res.locals);
  } else {
    console.log('plrStaff.js: not authenticated');
  }
});

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

module.exports = router;
