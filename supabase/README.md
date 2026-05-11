# Supabase RLS

Etapa 1: permitir acesso somente para usuarios autenticados, sem separar cargos/perfis ainda.

Ordem sugerida:
1. Rodar `rls-etapa-1-authenticated.sql` no SQL Editor do Supabase.
2. Testar login, leitura e escrita nas telas principais.
3. Se algo quebrar, rodar `rls-rollback-disable.sql`.

Nesta etapa o Storage nao e alterado, para nao afetar anexos, PDFs e imagens.
