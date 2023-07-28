// let clientId = 0;
// const clients = new Map();
//
// function addClient(res) {
//   const id = clientId++;
//   clients.set(id, res);
//
//   // Send the "connected" event to all clients
//   const connectedData = clients.size; // get the number of connected clients
//   sendToClients('connected', connectedData); // send the connected event
//
//   return id; // return the clientId
// }
// function removeClient(id) {
//   if (clients.has(id)) {
//     clients.get(id).end();
//     clients.delete(id);
//   }
// }
//
// function sendToClients(event, data) {
//   clients.forEach((client) => client.write(`event: ${event}\ndata: ${JSON.stringify(data)}\n\n`));
// }
//
// function cleanupClients() {
//   clients.forEach((client, id) => {
//     if (client.closed) {
//       clients.delete(id);
//     }
//   });
// }
// setInterval(cleanupClients, 1000 * 60); // Clean up every minute
//
// module.exports = {
//   addClient,
//   removeClient,
//   sendToClients,
//   cleanupClients,
// };
const clients = new Set();

function addClient(res) {
  clients.add(res);

  // Send the "connected" event to all clients
  const connectedData = clients.size; // get the number of connected clients
  sendToClients('connected', connectedData); // send the connected event

  return res; // return the response object itself
}

function removeClient(res) {
  if (clients.has(res)) {
    res.end();
    clients.delete(res);
  }
}

function sendToClients(event, data) {
  clients.forEach((client) => client.write(`event: ${event}\ndata: ${JSON.stringify(data)}\n\n`));
}

function cleanupClients() {
  clients.forEach((client) => {
    if (client.finished) {  // If the response has been sent and finished
      clients.delete(client);
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

