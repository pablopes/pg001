--Ajustar identidade de replicação para suportar outros status além do PENDING
ALTER TABLE tb_outbox_event REPLICA IDENTITY FULL;