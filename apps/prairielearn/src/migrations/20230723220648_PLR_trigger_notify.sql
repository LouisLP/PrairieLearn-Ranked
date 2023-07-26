CREATE OR REPLACE FUNCTION send_notification()
RETURNS TRIGGER AS
$$
BEGIN
  -- This will send a notification with the table name, the operation, and the new row data
  PERFORM pg_notify('table_change_notification', json_build_object('table', TG_TABLE_NAME, 'operation', TG_OP, 'newData', row_to_json(NEW))::text);
  RETURN NEW; -- This is required for AFTER triggers
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER notify_plr_live_credentials_change
AFTER UPDATE OR INSERT ON PLR_live_session_credentials
FOR EACH ROW
EXECUTE FUNCTION send_notification();