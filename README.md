# JET Gestao de Obras - deploy automatico

Este pacote foi preparado para eliminar o upload manual no Cloudflare Pages usando GitHub Actions + Wrangler no projeto atual `jet-gestao-obras`.

## Por que este fluxo

O projeto atual do Cloudflare foi criado como `Direct Upload`.
Segundo a documentacao oficial da Cloudflare, um projeto `Direct Upload` nao pode ser convertido depois para `Git integration`.
Por isso, o caminho com menor risco e sem trocar a URL atual e:

- guardar o site em um repositorio GitHub
- fazer push para a branch `main`
- deixar o GitHub Actions rodar `wrangler pages deploy`
- publicar automaticamente no projeto `jet-gestao-obras`

## Estrutura

- `index.html`: arquivo principal do site
- `.github/workflows/pages-deployment.yml`: workflow automatico de deploy

## Setup no GitHub

1. Crie um repositorio novo no GitHub.
2. Envie o conteudo desta pasta para a raiz do repositorio.
3. No repositorio, abra `Settings > Secrets and variables > Actions`.
4. Crie estes secrets:
   - `CLOUDFLARE_ACCOUNT_ID`
   - `CLOUDFLARE_API_TOKEN`
5. Faça push para a branch `main`.

## Token no Cloudflare

Crie um token com permissao:
- `Account`
- `Cloudflare Pages`
- `Edit`

## Como vai funcionar no dia a dia

1. Voce altera `index.html`
2. faz commit/push
3. o GitHub Actions publica sozinho no Cloudflare Pages

## Fluxo local pronto

O repositorio local foi preparado nesta pasta:

- `C:\Users\Cesar Filho\Documents\Codex\2026-04-20-o-que-voc-pode-fazer\Projeto-GeST-o-de-obras-JET`

O arquivo principal que continuamos editando no workspace fica aqui:

- `C:\Users\Cesar Filho\Documents\Codex\2026-04-20-o-que-voc-pode-fazer\jet-gestao-obras-84\index.html`

Scripts locais adicionados:

- `scripts\sync-site.ps1`
  - copia o `index.html` da pasta de trabalho para a raiz do repositorio
- `scripts\publish.ps1`
  - sincroniza, faz commit e envia para `main`
- `scripts\github-login.cmd`
  - abre o login do GitHub CLI mesmo quando o `gh` ainda nao entrou no PATH da janela atual

Uso sugerido:

1. Ajustar o sistema em:
   - `C:\Users\Cesar Filho\Documents\Codex\2026-04-20-o-que-voc-pode-fazer\jet-gestao-obras-84\index.html`
2. Rodar no PowerShell dentro do repositorio:
   - `.\scripts\publish.ps1 -Message "Descreva a mudanca aqui"`
3. O GitHub Actions publica no Cloudflare Pages automaticamente.

Se o GitHub CLI ainda nao estiver autenticado, rode antes:

- `gh auth login --web --git-protocol https`
- ou, se a janela disser que `gh` nao foi encontrado:
  - `.\scripts\github-login.cmd`

## Melhorias futuras

Se depois voce quiser preview por PR e integracao nativa do Pages com GitHub/GitLab, o ideal e criar um projeto novo no Cloudflare com `Git integration` desde o inicio.

## Fontes oficiais

- https://developers.cloudflare.com/pages/get-started/direct-upload/
- https://developers.cloudflare.com/pages/how-to/use-direct-upload-with-continuous-integration/
- https://developers.cloudflare.com/pages/configuration/git-integration/
