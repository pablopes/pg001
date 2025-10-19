CREATE TABLE tb_plan(
	id UUID PRIMARY KEY NOT NULL UNIQUE,
	key VARCHAR(15) NOT NULL UNIQUE, -- free, starter, pro, enterprise
	name VARCHAR(15) NOT NULL,
	description VARCHAR(200), 
	price BIGINT NOT NULL, -- price in cents
	billing_period_months VARCHAR(10), -- MONTHLY, QUARTERLY, SEMIANNUAL, ANNUAL
	max_users INT NOT NULL, -- 0 is UNLIMITED
	max_companies INT NOT NULL, -- 0 is UNLIMITED 
	active BOOLEAN DEFAULT TRUE,
	created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
	updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE tb_tenant(
	id UUID PRIMARY KEY NOT NULL UNIQUE,
	name VARCHAR(100) NOT NULL,
	status VARCHAR(10) NOT NULL DEFAULT 'PENDING', -- PENDING, ACTIVE, SUSPENDED, CANCELLED
	billing_period_months VARCHAR(10), -- snapshot of plan period at signup
	billing_next_date TIMESTAMP WITH TIME ZONE, 
	created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
	updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
	
	plan_id UUID references tb_plan(id)
);

CREATE TABLE tb_user(
	id UUID PRIMARY KEY NOT NULL UNIQUE,
	name VARCHAR(100) NOT NULL, 
	email VARCHAR(100) NOT NULL,
	password VARCHAR(100) NOT NULL,
	profile_pic TEXT,
	is_email_verified BOOLEAN DEFAULT FALSE,
	status VARCHAR(10), -- PENDING, ACTIVE, SUSPENDED, INACTIVE
	created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
	updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
	
	tenant_id UUID NOT NULL REFERENCES tb_tenant(id)
);

CREATE TABLE tb_profile(
	id UUID PRIMARY KEY NOT NULL UNIQUE,
	key TEXT NOT NULL, -- identificador técnico imutável
	name TEXT NOT NULL, -- nome legível mutável
	description TEXT NULL, -- descrição opcional do perfil 
	
	tenant_id UUID NULL -- null -> perfil global, qualquer outro tem escopo de tenant
);

CREATE TABLE tb_permission(
	id UUID PRIMARY KEY NOT NULL UNIQUE,
	name VARCHAR(100) NOT NULL,
	description VARCHAR(100) NOT NULL
);

CREATE TABLE tb_profile_permission(
	profile_id UUID REFERENCES tb_profile(id),
	permission_id UUID REFERENCES tb_permission(id),
	
	PRIMARY KEY (profile_id, permission_id)
);

CREATE TABLE tb_user_profile(
	user_id UUID REFERENCES tb_user(id),
	profile_id UUID REFERENCES tb_profile(id),
	
	PRIMARY KEY (user_id, profile_id)
);




