# Take-home CDV

Projeto dbt local (DuckDB) que transforma os seeds de transações e clientes em staging, intermediate e marts. Não precisa de warehouse em nuvem.

## Vídeo

Link da gravação (5 minutos): ``

## Como rodar

Python >= 3.10. Comandos na raiz do repositório.

```bash
python -m venv .venv
```

Ativar a venv:

```bash
# Windows (PowerShell)
.\.venv\Scripts\Activate.ps1

# macOS / Linux
source .venv/bin/activate
```

Instalar dependências só na venv:

```bash
python -m pip install -r requirements.txt
```

Rodar o pipeline:

```bash
dbt seed
dbt run
dbt test
```

`dbt seed`, `dbt run` e `dbt test` devem terminar com exit 0.

O teste singular `assert_no_negative_position` usa `severity: warn`. Esse warn é esperado: ele sinaliza as posições líquidas negativas (oversell) e não quebra o projeto.

A pasta `.duckdb/` já vem versionada (`.gitkeep`). O arquivo `cdv.duckdb` é criado no primeiro run.

## Melhorias para origem tipo API

Não estão no código. Ficam como evolução se a origem deixar de ser CSV estático.

1. **Quarentena.** Linhas estruturalmente inválidas (por exemplo `client_id` vazio ou `quantity <= 0`) hoje saem no staging. Em produção, o payload iria para um modelo/tabela de rejeição em vez de só desaparecer.
2. **Lookback incremental.** `fact_transactions` usa watermark em `transaction_date`. Evento atrasado com data antiga não entra no merge. Uma janela de N dias atrás do máximo já materializado recuperaria correção tardia.
