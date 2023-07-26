let clientId = 0;
const clients = new Map();

function addClient(res) {
  clients.set(clientId, res);
  return clientId++;  // Increment the ID after returning
}

function removeClient(id) {
  clients.delete(id);
}

function sendToClients(event, data) {
  clients.forEach(client => 
    client.write(`event: ${event}\ndata: ${JSON.stringify(data)}\n\n`)
  );
}

function cleanupClients() {
  clients.forEach((client, id) => {
    if (client.closed) {
      clients.delete(id);
    }
  });
}

setInterval(cleanupClients, 1000 * 60); // Clean up every minute

module.exports = {
  addClient,
  removeClient,
  sendToClients,
  cleanupClients,
};

