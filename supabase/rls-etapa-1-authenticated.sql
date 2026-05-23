-- JET Gestao de Obras - RLS etapa 1
-- Objetivo: bloquear acesso anonimo direto e permitir leitura/escrita somente para usuarios autenticados.
-- Seguro para rodar mais de uma vez no Supabase SQL Editor.
-- Nao altera Storage nesta etapa.

begin;

do $$
declare
  tbl text;
  tables text[] := array[
    'aditivos',
    'materiais',
    'funcionarios',
    'rdo',
    'todos',
    'despesas',
    'estoque',
    'pedidos',
    'fornecedores',
    'cotacoes',
    'ferramentas',
    'companies'
  ];
begin
  foreach tbl in array tables loop
    if to_regclass(format('public.%I', tbl)) is not null then
      execute format('alter table public.%I enable row level security', tbl);

      execute format('drop policy if exists "jet_auth_read_%s" on public.%I', tbl, tbl);
      execute format('drop policy if exists "jet_auth_insert_%s" on public.%I', tbl, tbl);
      execute format('drop policy if exists "jet_auth_update_%s" on public.%I', tbl, tbl);
      execute format('drop policy if exists "jet_auth_delete_%s" on public.%I', tbl, tbl);

      execute format(
        'create policy "jet_auth_read_%s" on public.%I for select to authenticated using (auth.role() = ''authenticated'')',
        tbl, tbl
      );

      execute format(
        'create policy "jet_auth_insert_%s" on public.%I for insert to authenticated with check (auth.role() = ''authenticated'')',
        tbl, tbl
      );

      execute format(
        'create policy "jet_auth_update_%s" on public.%I for update to authenticated using (auth.role() = ''authenticated'') with check (auth.role() = ''authenticated'')',
        tbl, tbl
      );

      execute format(
        'create policy "jet_auth_delete_%s" on public.%I for delete to authenticated using (auth.role() = ''authenticated'')',
        tbl, tbl
      );

      execute format('grant select, insert, update, delete on public.%I to authenticated', tbl);
    end if;
  end loop;
end $$;

commit;

-- Teste rapido depois de rodar:
-- 1. Abra o sistema em aba anonima: deve pedir login.
-- 2. Faca login e confirme se a tela inicial carrega.
-- 3. Teste salvar um aviso, abrir uma obra, criar uma despesa pequena de teste e excluir.
