CREATE TABLE tb_outbox_event(
    id UUID PRIMARY KEY,
    aggregate_id UUID NOT NULL,
    type VARCHAR(100) NOT NULL, -- Tipo do Evento: TENANT_CREATE, USER_CREATE
    payload JSONB NOT NULL,
    status VARCHAR(20), -- Status do evento: PENDING, SEND, FAILED
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    published_at TIMESTAMP WITH TIME ZONE
);