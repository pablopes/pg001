CREATE TABLE tb_onboarding_process(
    id UUID PRIMARY KEY,
    status VARCHAR(12) NOT NULL, --IN_PROGRESS, COMPLETED, FAILED
    tenant_id UUID,
    user_id UUID,
    error_step VARCHAR(20),
    error_message TEXT,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL
);