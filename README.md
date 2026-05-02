# FluiPanel4D

<p align="center">
  <img src="https://github.com/TheJoaoVitorio/FluiToast4D/blob/master/assets/FLUI-logo.png" alt="FluiPanel4D" width="400">
</p>

O **FluiPanel4D** é um componente de painel arredondado de alta qualidade para Delphi (VCL), desenvolvido para trazer um visual moderno e refinado às suas aplicações. Utilizando GDI+ para renderização de alta precisão e *Window Regions* para clipping real de conteúdo, ele entrega um acabamento profissional comparável aos componentes premium do mercado, como o CurvyPanel da TMS.


## ✨ Características e Recursos

*   **Bordas Arredondadas Perfeitas:** Anti-aliasing de alta qualidade via GDI+ que elimina serrilhados.
*   **Clipping Real (Window Regions):** Componentes internos são cortados automaticamente pelas curvas do painel.
*   **Totalmente Customizável:** Controle de arredondamento, cor e espessura da borda diretamente no Object Inspector.
*   **Nativo VCL:** Herda de `TCustomPanel`, respeitando `Align`, `Anchors` e demais propriedades padrão.
*   **WYSIWYG:** Visualize todas as alterações em tempo de design dentro do IDE do Delphi.

## 🚀 Como Usar

### Instalação
1.  Abra o arquivo **`FluiPanel4D.dpk`** no seu Delphi.
2.  No **Project Manager**, clique com o botão direito em `FluiPanel4D.bpl` e selecione **Install**.
3.  O componente `TFluiPanel` aparecerá na paleta **'FLUI'**.

### Exemplo via Código
```pascal
procedure TForm1.ConfigurarPainel;
begin
  FluiPanel1.Rounding := 25;
  FluiPanel1.BorderColor := clSkyBlue;
  FluiPanel1.BorderWidth := 2;
  FluiPanel1.Color := clWhite;
  FluiPanel1.Caption := 'Meu Painel Moderno';
end;
```

## ⚙️ Propriedades e Configurações

| Object Inspector | Descrição | Padrão |
| :--- | :--- | :--- |
| **Rounding** | Define o raio de arredondamento das quinas. | 10 |
| **BorderColor** | Cor da borda do painel. Use `clNone` para ocultar. | `clNone` |
| **BorderWidth** | Espessura da borda (aceita valores decimais). | 1.0 |
| **Color** | Cor de fundo do painel. | `clBtnFace` |
| **Caption** | Texto centralizado exibido no painel. | `''` |

## 🛠️ Dica de Uso
Para obter o melhor efeito visual, combine o `TFluiPanel` com cores sóbrias e bordas finas (ex: `BorderWidth := 1.2`). Graças ao clipping de região, você pode colocar imagens (`TImage`) alinhadas ao `alClient` e elas respeitarão o arredondamento das bordas sem "vazar" nos cantos.

---
Desenvolvido por [TheJoaoVitorio](https://github.com/TheJoaoVitorio)**.
