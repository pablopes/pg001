DROP PUBLICATION IF EXISTS debezium_outbox_publication;

CREATE PUBLICATION debezium_outbox_publication
  FOR TABLE tb_outbox_event
  WHERE (status = 'PENDING');

ALTER ROLE erp WITH REPLICATION;
GRANT ALL PRIVILEGES ON TABLE tb_outbox_event TO erp;