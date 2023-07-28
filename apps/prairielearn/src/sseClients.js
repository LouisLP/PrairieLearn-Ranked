let clientId = 0;
const clients = new Map();

// Add a new client
function addClient(res) {
  const id = clientId++;
  clients.set(id, res);
  // Send the "connected" event to all clients
  // Number of connected clients
  const connectedData = clients.size; 
  // Send the "connected" event
  sendToClients('connected', connectedData); 

  return id;
}
// Remove an existing client (by id)
function removeClient(id) {
  if (clients.has(id)) {
    clients.get(id).end();
    clients.delete(id);
  }
}
// Send an event to all clients
function sendToClients(event, data) {
  clients.forEach((client) => client.write(`event: ${event}\ndata: ${JSON.stringify(data)}\n\n`));
}
// Clean up closed connections
function cleanupClients() {
  clients.forEach((client, id) => {
    if (client.closed) {
      clients.delete(id);
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
