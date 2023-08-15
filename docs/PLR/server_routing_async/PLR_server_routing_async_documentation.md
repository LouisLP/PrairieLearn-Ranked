# PrairieLearn Server Asynchronous Functionality Documentation

## Introduction

PrairieLearn's live scoring system operates in real-time, updating scores, ranks, and other data asynchronously. The architecture involves PostgreSQL triggers, Server-Sent Events (SSE), and dynamic frontend updates to achieve this real-time functionality. This document aims to provide a comprehensive understanding of this system.

---

## 1. Database Notifications

### Function: `send_notification()`

- **Purpose**: Sends notifications to the front end whenever a new score is added or updated.
- **Operation**:
  - Triggers the `pg_notify` function with the channel name `'table_change_notification'`.
  - Payload is left empty.
  
### Trigger: `notify_plr_live_credentials_change`

- **Purpose**: Listens to any updates or inserts on the `PLR_live_session_credentials` table.
- **Operation**:
  - Invokes the `send_notification()` function upon detecting changes.

---

## 2. Server Event Handling

### Server Block for PLR Clients

This block manages the real-time updates sent to the PrairieLearn clients.

- **Setting up the PostgreSQL client**: System sets up a PostgreSQL client with the same configuration as the pool.
- **Handling Notifications**: Upon receiving a database notification:
  - Server logs the notification for debugging.
  - Fetches the live results using the `getLiveResults()` method from the model.
  - Results are then sent to the connected clients using `sseClients.sendToClients('scores', liveResults)`.
- **Starting the Listener**: Server starts listening to the `table_change_notification` channel of the database.
- **Handling Client Disconnect**: Server provides a route (`/sse/close`) that listens for SSE client disconnect events. This helps manage the list of connected clients.

### Server Block for PLR Staff Page

This block routes requests to the PLR Staff page, handling live updates and interactions specific to instructors or staff.

- **SSE Connection**: A route (`/live_updates`) is established for Server-Sent Events (SSE). This route sets up an SSE connection for live updates.
- **Fetching and Displaying Results**: On visiting the main PLR staff page, the system asynchronously fetches the live, seasonal, and all-time results using the corresponding model functions. These results are then rendered on the page.

### Server Block for PLR Student Page

This block routes requests to the PLR Student page, handling live updates and interactions specific to students.

- **SSE Connection**: Similar to the PLR Staff page, an SSE route (`/live_updates`) is established.
- **Fetching and Displaying Results**: When a student visits the main PLR student page, the system fetches their display name, live, seasonal, and all-time results, and renders them on the page.

---

## 3. Frontend Interactivity

### PLR Staff Page Script

This script enables the PLR Staff page to enter a fullscreen mode, which is especially useful during live sessions for display purposes. A button is provided to toggle this functionality.

### PLR Scoreboard Script

- **Initializing Data**: The initial results are fetched from the server and rendered.
- **Establishing SSE Connection**: An SSE connection is established to listen to live updates related to scores.
- **Handling Live Updates**: On receiving live score data:
  - The scores are filtered to display only those relevant to the current course instance.
  - The table of scores is updated in real-time.
- **Display Enhancements**: Special CSS classes are applied to the top three ranks for a gold, silver, and bronze appearance. The current user's score (if not in the top 3) is highlighted.
- **Handling Connection Closure**: Before the window is unloaded, a notification is sent to the server to close the SSE connection.

---

## Summary

PrairieLearn's real-time scoring system is a combination of database triggers, server-side event listeners, and frontend interactivity. The system ensures that as scores are updated in the database, they are instantly reflected to all connected users, creating a dynamic and engaging experience.
