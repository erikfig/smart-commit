# 🧠 Smart-Commit

Script shell interativo que gera uma mensagem de commit baseada nas alterações atuais do repositório, com ajuda do GitHub Copilot CLI.

Utiliza **conventional commits** e permite escolher o idioma da sugestão (`pt-br` ou `en-us`).

> Porque eu fiz? Simples, eu não gosto de interface e sou mais produtivo no meu terminal e sempre que quero uma sugestão de mensagem de commit ia no botão do VSCode, agora posso fazer via terminal. Apenas gosto pessoal.

## 📦 Requisitos

- [GitHub CLI](https://cli.github.com/) instalado (`gh`)
- Extensão Copilot CLI instalada:
  
  ```bash
  gh extension install github/gh-copilot
  ```

- Token do GitHub já autenticado via `gh auth login`

---

## 🚀 Como usar

1. Dê permissão de execução:

   ```bash
   chmod +x smart-commit
   ```

2. Faça alterações no seu repositório, e adicione ao staging:

   ```bash
   git add .
   ```

3. Execute o script:

   ```bash
   ./smart-commit
   ```

4. Selecione o idioma:

   ```
   Selecione o idioma do prompt [1 = pt-br, 2 = en-us, Enter = pt-br]:
   ```

5. O GitHub Copilot irá sugerir e **executar automaticamente** um comando `git commit` com base nas alterações.

---

## 🛠️ Estrutura do script

- Escolha de idioma com validação
- Geração automática de prompt em linguagem natural
- Integração com o `gh copilot suggest -t git`
- Execução segura e rastreável do commit gerado

---

## 🧪 Dica

Para criar um alias global:

```bash
alias smartcommit="path/para/smart-commit"
```

## 🧪 Dica 2

Se quiser usar como commando git (ex: `git smart-commit`), renomeie para git-smart-commit:

```bash
mv smart-commit ~/bin/git-smart-commit
```

Salve em um diretório de executáveis (eu tenho uma em `~/bin`) e recarregue o terminal (ou o script do bash, como uso zsh rodei: `source ~/.zshrc`).

Agora só usar: 

```bash
git smart-commit
```

---

## 📄 Licença

MIT
