-- JET Gestao de Obras - rollback RLS etapa 1
-- Use apenas se o sistema parar de carregar apos ativar o RLS.
-- Isso desativa RLS nas tabelas principais e volta ao comportamento anterior.

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
      execute format('alter table public.%I disable row level security', tbl);
    end if;
  end loop;
end $$;

commit;
