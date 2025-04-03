-- ./postgres/initdb/init.sql
-- This script runs automatically on first container start if the data directory is empty.
-- It runs *after* the database specified by POSTGRES_DB is created.
-- It connects to the database specified by POSTGRES_DB (e.g., 'myappdb').

-- Example: Create a sample table in the main application database
CREATE TABLE IF NOT EXISTS public.users (
   user_id SERIAL PRIMARY KEY,
   username VARCHAR(50) UNIQUE NOT NULL,
   created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Example: Insert some initial data
INSERT INTO public.users (username) VALUES
   ('admin'),
   ('testuser')
ON CONFLICT (username) DO NOTHING; -- Avoid errors if script runs multiple times somehow

-- Example: Grant privileges if needed (the user specified by POSTGRES_USER owns the DB by default)
-- GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO myappuser; -- Use POSTGRES_USER value
-- ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO myappuser;

-- Add any other initial schema setup here
