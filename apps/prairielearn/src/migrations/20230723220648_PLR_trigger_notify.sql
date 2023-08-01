-- This trigger is what sends a notification to our front end that a new score has been added.
CREATE
OR REPLACE FUNCTION send_notification () RETURNS TRIGGER AS $$ 
BEGIN 
   -- This will send a notification with the table name, the operation, and the new row data
   PERFORM pg_notify(
      'table_change_notification',
      ''
   );

   RETURN NEW;
   -- This is required for AFTER triggers
END;

$$ LANGUAGE plpgsql;

-- This trigger listens to updates on the PLR_live_session_credentials table.
CREATE TRIGGER notify_plr_live_credentials_change
AFTER
UPDATE
OR INSERT ON PLR_live_session_credentials FOR EACH ROW
EXECUTE FUNCTION send_notification ();
