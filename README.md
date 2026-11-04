# NUT Ragtech (add-on customizado para Home Assistant)

Add-on do Home Assistant que compila o Network UPS Tools (NUT) da fonte,
incluindo o driver `ragtech` para nobreaks Ragtech (Easy Pro / NEP / TORO /
INNERGIE / OneUP, USB CDC-ACM, VID 0x04D8 PID 0x000A).

## Como usar

1. Crie um repositório no seu GitHub e envie esta pasta (a raiz deve conter
   `repository.yaml` e a pasta `nut-ragtech/`).
2. No Home Assistant: **Configurações → Add-ons → Loja de add-ons →
   (menu ⋮) → Repositórios → adicione a URL do seu repositório**.
3. Instale o add-on **"NUT Ragtech (driver ragtech)"**.
4. Configure a porta (use o caminho `/dev/serial/by-id/...`), a senha e, se
   necessário, `va` (1200 para o modelo 4162) e `allow_shutdown`.
5. Inicie o add-on e confira os logs.
6. Adicione a integração **NUT** no HA: host `localhost`, porta `3493`,
   usuário `upsmon`, senha configurada.

## Observações

- O build da fonte pode levar alguns minutos na primeira instalação.
- `full_access: true` é usado para acesso à porta serial (incluindo by-id).
- O driver desabilita shutdown por padrão; ative `allow_shutdown` apenas se
  tiver como religar o nobreak manualmente.
