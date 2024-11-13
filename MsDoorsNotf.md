## 🔔 Notificações e Alertas

Adicione notificações para interagir com o jogador. Aqui estão algumas formas de exibir alertas e mensagens personalizadas:

### MsdoorsNotify

Com a API `MsdoorsNotify`, é possível criar notificações visuais e auditivas no estilo **Doors**. Exemplo de uso:

```lua
MsdoorsNotify(
    "Título da Notificação 🚨",
    "Essa é uma notificação personalizada para alertas importantes.",
    "Razão do Alerta",
    "rbxassetid://6023426923",  -- Imagem personalizada (ID do Roblox)
    Color3.new(0, 1, 0),        -- Cor personalizada (opcional)
    5                           -- Duração (em segundos)
)
```

| Parâmetro     | Descrição                                       |
|---------------|-------------------------------------------------|
| `title`       | Título principal da notificação                 |
| `description` | Conteúdo da notificação                         |
| `reason`      | Explicação para a notificação                   |
| `image`       | ID da imagem (opcional, padrão é "doors")       |
| `color`       | Cor do texto e detalhes (opcional)              |
| `time`        | Duração (em segundos) da exibição (opcional)    |

---
