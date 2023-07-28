const clients = new Set();

// ADD NEW CLIENT
function addClient(res) {
  clients.add(res);

  // Send the number of connected clients to all clients
  const connectedData = clients.size; 
  sendToClients('connected', connectedData); 

  return res;
}

// REMOVE CLIENT
function removeClient(res) {
  if (clients.has(res)) {
    res.end();
    clients.delete(res);
  }
}

// SEND TO CLIENTS
function sendToClients(event, data) {
  clients.forEach((client) => client.write(`event: ${event}\ndata: ${JSON.stringify(data)}\n\n`));
}

// CLEAN UP CLIENTS
function cleanupClients() {
  clients.forEach((client) => {
    if (client.finished) {
      // If the response has been sent and finished
      clients.delete(client);
    }
  });
}

// Clean up every minute
setInterval(cleanupClients, 1000 * 60); 

module.exports = {
  addClient,
  removeClient,
  sendToClients,
  cleanupClients,
};
