-- JET Gestao de Obras - Tabela ferramentas
-- Modulo de Gestao de Ativos (Ferramentas & Equipamentos)
-- Rodar no Supabase SQL Editor

create table if not exists public.ferramentas (
  id            text primary key,
  obra          text not null,
  item          text not null,
  numero_serie  text default '',
  patrimonio    text default '',
  status        text default 'Disponível'
                  check (status in ('Disponível','Alocado','Em Manutenção','Baixado')),
  funcionario_nome text default '',
  data_alocacao date,
  motivo_baixa  text default '',
  observacao    text default '',
  created_at    timestamptz default now(),
  updated_at    timestamptz default now()
);

-- Índices para consultas por obra e status
create index if not exists ferramentas_obra_idx    on public.ferramentas (obra);
create index if not exists ferramentas_status_idx  on public.ferramentas (status);

-- RLS
alter table public.ferramentas enable row level security;

drop policy if exists "jet_auth_read_ferramentas"   on public.ferramentas;
drop policy if exists "jet_auth_insert_ferramentas" on public.ferramentas;
drop policy if exists "jet_auth_update_ferramentas" on public.ferramentas;
drop policy if exists "jet_auth_delete_ferramentas" on public.ferramentas;

create policy "jet_auth_read_ferramentas"
  on public.ferramentas for select to authenticated
  using (auth.role() = 'authenticated');

create policy "jet_auth_insert_ferramentas"
  on public.ferramentas for insert to authenticated
  with check (auth.role() = 'authenticated');

create policy "jet_auth_update_ferramentas"
  on public.ferramentas for update to authenticated
  using (auth.role() = 'authenticated')
  with check (auth.role() = 'authenticated');

create policy "jet_auth_delete_ferramentas"
  on public.ferramentas for delete to authenticated
  using (auth.role() = 'authenticated');

grant select, insert, update, delete on public.ferramentas to authenticated;

-- Habilitar Realtime
alter publication supabase_realtime add table public.ferramentas;
