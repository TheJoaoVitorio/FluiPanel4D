# FluiPanel4D

<p align="center">
  <img src="https://github.com/TheJoaoVitorio/FluiToast4D/blob/master/assets/FLUI-logo.png" alt="FluiPanel4D" width="400">
</p>

O **FluiPanel4D** é um componente de painel arredondado de alta qualidade para Delphi (VCL), desenvolvido para trazer um visual moderno e refinado às suas aplicações. Utilizando GDI+ para renderização de alta precisão e *Window Regions* para clipping real de conteúdo, ele entrega um acabamento profissional comparável aos componentes premium do mercado.


## ✨ Características e Recursos

*   **Bordas Arredondadas Perfeitas:** Anti-aliasing de alta qualidade via GDI+ que elimina serrilhados.
*   **Seleção de Cantos (Corners):** Escolha individualmente quais cantos deseja arredondar (`TopLeft`, `TopRight`, `BottomLeft`, `BottomRight`).
*   **Suporte a Gradientes:** Gradientes lineares configuráveis tanto para o fundo do painel quanto para as bordas.
*   **BoxShadow (Drop & Inner):** Adicione profundidade com sombras externas (Drop Shadow) e internas (Inner Shadow) totalmente customizáveis (offset, blur, cor e opacidade).
*   **Clipping Real (Window Regions):** Componentes internos são cortados automaticamente pelas curvas do painel, garantindo que nada "vaze" nas quinas.
*   **Nativo VCL:** Herda de `TCustomPanel`, respeitando todas as propriedades padrão como `Align`, `Anchors` e `Padding`.
*   **Design-Time Suport:** Visualize todas as alterações (cores, gradientes e curvas) em tempo real no IDE.

## 🚀 Como Usar

### Instalação
1.  Abra o arquivo **`FluiPanel4D.dpk`** no seu Delphi.
2.  No **Project Manager**, clique com o botão direito em `FluiPanel4D.bpl` e selecione **Install**.
3.  O componente `TFluiPanel` aparecerá na paleta **'FLUI'**.

### Exemplo via Código (Gradientes e Cantos)
```pascal
procedure TForm1.ConfigurarPainel;
begin
  // Configura arredondamento seletivo
  FluiPanel1.Rounding := 20;
  FluiPanel1.Corners := [cpTopLeft, cpTopRight]; // Apenas o topo arredondado

  // Configura Gradiente no Fundo
  FluiPanel1.EnableGradient := True;
  FluiPanel1.GradientColorStart := clWhite;
  FluiPanel1.GradientColorEnd := $00F4F4F4;
  FluiPanel1.GradientDirection := gdVertical;

  // Configura Gradiente na Borda
  FluiPanel1.BorderWidth := 1.5;
  FluiPanel1.EnableBorderGradient := True;
  FluiPanel1.BorderGradientColorStart := clSkyBlue;
  FluiPanel1.BorderGradientColorEnd := clBlue;
end;
```

## ⚙️ Propriedades e Configurações

| Categoria | Propriedade | Descrição |
| :--- | :--- | :--- |
| **Aparência** | `Rounding` | Define o raio de arredondamento. |
| **Aparência** | `Corners` | Conjunto de cantos para arredondar. |
| **Borda** | `BorderColor` | Cor sólida da borda (use `clNone` para ocultar). |
| **Borda** | `BorderWidth` | Espessura da borda. |
| **Gradiente Fundo** | `EnableGradient` | Ativa o gradiente no fundo do painel. |
| **Gradiente Fundo** | `GradientColorStart/End` | Cores inicial e final do gradiente de fundo. |
| **Gradiente Fundo** | `GradientDirection` | Direção (`Vertical`, `Horizontal`, `Diagonal`). |
| **Gradiente Borda** | `EnableBorderGradient` | Ativa o gradiente especificamente na borda. |
| **Gradiente Borda** | `BorderGradientColorStart/End` | Cores inicial e final do gradiente da borda. |
| **Drop Shadow** | `DropShadowEnabled` | Ativa a sombra externa. |
| **Drop Shadow** | `DropShadowBlur/Alpha` | Intensidade do desfoque e opacidade da sombra externa. |
| **Drop Shadow** | `DropShadowOffset X/Y` | Deslocamento horizontal e vertical da sombra externa. |
| **Inner Shadow** | `InnerShadowEnabled` | Ativa a sombra interna. |
| **Inner Shadow** | `InnerShadowBlur/Alpha` | Intensidade do desfoque e opacidade da sombra interna. |
| **Inner Shadow** | `InnerShadowOffset X/Y` | Deslocamento horizontal e vertical da sombra interna. |

## 🛠️ Dica de Uso
O **FluiPanel4D** é perfeito para criar interfaces modernas estilo "Card". Ao desabilitar o arredondamento nos cantos inferiores (`cpBottomLeft`, `cpBottomRight`), você pode criar abas superiores perfeitas que se conectam a outros elementos da interface, mantendo o clipping interno para imagens e outros controles.

---
Desenvolvido por [TheJoaoVitorio](https://github.com/TheJoaoVitorio)**.
