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

## Melhorias futuras

Se depois voce quiser preview por PR e integracao nativa do Pages com GitHub/GitLab, o ideal e criar um projeto novo no Cloudflare com `Git integration` desde o inicio.

## Fontes oficiais

- https://developers.cloudflare.com/pages/get-started/direct-upload/
- https://developers.cloudflare.com/pages/how-to/use-direct-upload-with-continuous-integration/
- https://developers.cloudflare.com/pages/configuration/git-integration/
