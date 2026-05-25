-- JET Gestão de Obras - Histórico de status de materiais
-- Rodar no Supabase SQL Editor

ALTER TABLE public.materiais ADD COLUMN IF NOT EXISTS status_history jsonb DEFAULT '[]';
