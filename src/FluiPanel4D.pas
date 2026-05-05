unit FluiPanel4D;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Graphics,
  Winapi.Windows, Winapi.GDIPOBJ, Winapi.GDIPAPI, Winapi.Messages, Vcl.Themes;

type
  TFluiGradientDirection = (gdVertical, gdHorizontal, gdForwardDiagonal, gdBackwardDiagonal);
  
  TFluiCorner = (cpTopLeft, cpTopRight, cpBottomRight, cpBottomLeft);
  TFluiCorners = set of TFluiCorner;

  TFluiPanel = class(TCustomPanel)
  private
    FRounding: Integer;
    FBorderColor: TColor;
    FBorderWidth: Single;
    FGradientColorStart: TColor;
    FGradientColorEnd: TColor;
    FGradientDirection: TFluiGradientDirection;
    FEnableGradient: Boolean;
    FEnableBorderGradient: Boolean;
    FBorderGradientColorStart: TColor;
    FBorderGradientColorEnd: TColor;
    FCorners: TFluiCorners;

    // Drop Shadow
    FDropShadowEnabled: Boolean;
    FDropShadowColor: TColor;
    FDropShadowBlur: Integer;
    FDropShadowOffsetX: Integer;
    FDropShadowOffsetY: Integer;
    FDropShadowAlpha: Byte;

    // Inner Shadow
    FInnerShadowEnabled: Boolean;
    FInnerShadowColor: TColor;
    FInnerShadowBlur: Integer;
    FInnerShadowOffsetX: Integer;
    FInnerShadowOffsetY: Integer;
    FInnerShadowAlpha: Byte;

    procedure SetRounding(const Value: Integer);
    procedure SetBorderColor(const Value: TColor);
    procedure SetBorderWidth(const Value: Single);
    procedure SetGradientColorStart(const Value: TColor);
    procedure SetGradientColorEnd(const Value: TColor);
    procedure SetGradientDirection(const Value: TFluiGradientDirection);
    procedure SetEnableGradient(const Value: Boolean);
    procedure SetEnableBorderGradient(const Value: Boolean);
    procedure SetBorderGradientColorStart(const Value: TColor);
    procedure SetBorderGradientColorEnd(const Value: TColor);
    procedure SetCorners(const Value: TFluiCorners);

    procedure SetDropShadowEnabled(const Value: Boolean);
    procedure SetDropShadowColor(const Value: TColor);
    procedure SetDropShadowBlur(const Value: Integer);
    procedure SetDropShadowOffsetX(const Value: Integer);
    procedure SetDropShadowOffsetY(const Value: Integer);
    procedure SetDropShadowAlpha(const Value: Byte);

    procedure SetInnerShadowEnabled(const Value: Boolean);
    procedure SetInnerShadowColor(const Value: TColor);
    procedure SetInnerShadowBlur(const Value: Integer);
    procedure SetInnerShadowOffsetX(const Value: Integer);
    procedure SetInnerShadowOffsetY(const Value: Integer);
    procedure SetInnerShadowAlpha(const Value: Byte);

    function ColorToGPColor(AColor: TColor; AAlpha: Byte = 255): TGPColor;
    procedure BuildPath(APath: TGPGraphicsPath; ARect: TGPRectF; ARadius: Single);
  protected
    procedure Paint; override;
    procedure Resize; override;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure AdjustClientRect(var Rect: TRect); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Rounding: Integer read FRounding write SetRounding default 10;
    property Corners: TFluiCorners read FCorners write SetCorners default [cpTopLeft, cpTopRight, cpBottomRight, cpBottomLeft];
    property BorderColor: TColor read FBorderColor write SetBorderColor default clNone;
    property BorderWidth: Single read FBorderWidth write SetBorderWidth;

    property EnableGradient: Boolean read FEnableGradient write SetEnableGradient default False;
    property GradientColorStart: TColor read FGradientColorStart write SetGradientColorStart default clWhite;
    property GradientColorEnd: TColor read FGradientColorEnd write SetGradientColorEnd default clSilver;
    property GradientDirection: TFluiGradientDirection read FGradientDirection write SetGradientDirection default gdVertical;

    property EnableBorderGradient: Boolean read FEnableBorderGradient write SetEnableBorderGradient default False;
    property BorderGradientColorStart: TColor read FBorderGradientColorStart write SetBorderGradientColorStart default clGray;
    property BorderGradientColorEnd: TColor read FBorderGradientColorEnd write SetBorderGradientColorEnd default clBlack;

    // Drop Shadow Properties
    property DropShadowEnabled: Boolean read FDropShadowEnabled write SetDropShadowEnabled default False;
    property DropShadowColor: TColor read FDropShadowColor write SetDropShadowColor default clBlack;
    property DropShadowBlur: Integer read FDropShadowBlur write SetDropShadowBlur default 10;
    property DropShadowOffsetX: Integer read FDropShadowOffsetX write SetDropShadowOffsetX default 0;
    property DropShadowOffsetY: Integer read FDropShadowOffsetY write SetDropShadowOffsetY default 5;
    property DropShadowAlpha: Byte read FDropShadowAlpha write SetDropShadowAlpha default 150;

    // Inner Shadow Properties
    property InnerShadowEnabled: Boolean read FInnerShadowEnabled write SetInnerShadowEnabled default False;
    property InnerShadowColor: TColor read FInnerShadowColor write SetInnerShadowColor default clBlack;
    property InnerShadowBlur: Integer read FInnerShadowBlur write SetInnerShadowBlur default 5;
    property InnerShadowOffsetX: Integer read FInnerShadowOffsetX write SetInnerShadowOffsetX default 0;
    property InnerShadowOffsetY: Integer read FInnerShadowOffsetY write SetInnerShadowOffsetY default 2;
    property InnerShadowAlpha: Byte read FInnerShadowAlpha write SetInnerShadowAlpha default 100;

    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property Caption;
    property Color;
    property Constraints;
    property Ctl3D;
    property UseDockManager default True;
    property DockSite;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FullRepaint;
    property Font;
    property Locked;
    property Padding;
    property ParentBiDiMode;
    property ParentBackground;
    property ParentColor;
    property ParentCtl3D;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Touch;
    property Visible;
    property StyleElements;
    property OnAlignInsertBefore;
    property OnAlignPosition;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnGetSiteInfo;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

implementation

{ TFluiPanel }

constructor TFluiPanel.Create(AOwner: TComponent);
begin
  inherited;
  FRounding := 10;
  FCorners := [cpTopLeft, cpTopRight, cpBottomRight, cpBottomLeft];
  FBorderColor := clNone;
  FBorderWidth := 1;
  FEnableGradient := False;
  FGradientColorStart := clWhite;
  FGradientColorEnd := clSilver;
  FGradientDirection := gdVertical;
  FEnableBorderGradient := False;
  FBorderGradientColorStart := clGray;
  FBorderGradientColorEnd := clBlack;

  // Drop Shadow Defaults
  FDropShadowEnabled := False;
  FDropShadowColor := clBlack;
  FDropShadowBlur := 10;
  FDropShadowOffsetX := 0;
  FDropShadowOffsetY := 5;
  FDropShadowAlpha := 150;

  // Inner Shadow Defaults
  FInnerShadowEnabled := False;
  FInnerShadowColor := clBlack;
  FInnerShadowBlur := 5;
  FInnerShadowOffsetX := 0;
  FInnerShadowOffsetY := 2;
  FInnerShadowAlpha := 100;

  ControlStyle := ControlStyle + [csAcceptsControls];
  ControlStyle := ControlStyle - [csOpaque];
  
  ParentBackground := True;
  FullRepaint := True;
  DoubleBuffered := True;
  Width := 185;
  Height := 41;
end;

function TFluiPanel.ColorToGPColor(AColor: TColor; AAlpha: Byte): TGPColor;
var
  LActualColor: TColor;
  LColorRGB: Longint;
begin
  LActualColor := AColor;
  if LActualColor = clNone then
    LActualColor := Color;
    
  LColorRGB := ColorToRGB(LActualColor);
  Result := MakeColor(AAlpha, GetRValue(LColorRGB), GetGValue(LColorRGB), GetBValue(LColorRGB));
end;

procedure TFluiPanel.AdjustClientRect(var Rect: TRect);
var
  LShadowPadding: Integer;
begin
  inherited AdjustClientRect(Rect);
  if FDropShadowEnabled then
  begin
    LShadowPadding := FDropShadowBlur + 2; // Extra buffer
    Rect.Left := Rect.Left + LShadowPadding + Abs(FDropShadowOffsetX);
    Rect.Top := Rect.Top + LShadowPadding + Abs(FDropShadowOffsetY);
    Rect.Right := Rect.Right - LShadowPadding - Abs(FDropShadowOffsetX);
    Rect.Bottom := Rect.Bottom - LShadowPadding - Abs(FDropShadowOffsetY);
  end;
end;

procedure TFluiPanel.BuildPath(APath: TGPGraphicsPath; ARect: TGPRectF; ARadius: Single);
var
  LDiameter: Single;
begin
  LDiameter := ARadius * 2;
  if LDiameter > ARect.Width then LDiameter := ARect.Width;
  if LDiameter > ARect.Height then LDiameter := ARect.Height;

  if LDiameter < 1 then
  begin
    APath.AddRectangle(ARect);
    Exit;
  end;

  APath.StartFigure;
  // Top-Left
  if cpTopLeft in FCorners then
    APath.AddArc(ARect.X, ARect.Y, LDiameter, LDiameter, 180, 90)
  else
    APath.AddLine(ARect.X, ARect.Y + LDiameter/2, ARect.X, ARect.Y);

  // Top-Right
  if cpTopRight in FCorners then
    APath.AddArc(ARect.X + ARect.Width - LDiameter, ARect.Y, LDiameter, LDiameter, 270, 90)
  else
    APath.AddLine(ARect.X + ARect.Width - LDiameter/2, ARect.Y, ARect.X + ARect.Width, ARect.Y);

  // Bottom-Right
  if cpBottomRight in FCorners then
    APath.AddArc(ARect.X + ARect.Width - LDiameter, ARect.Y + ARect.Height - LDiameter, LDiameter, LDiameter, 0, 90)
  else
    APath.AddLine(ARect.X + ARect.Width, ARect.Y + ARect.Height - LDiameter/2, ARect.X + ARect.Width, ARect.Y + ARect.Height);

  // Bottom-Left
  if cpBottomLeft in FCorners then
    APath.AddArc(ARect.X, ARect.Y + ARect.Height - LDiameter, LDiameter, LDiameter, 90, 90)
  else
    APath.AddLine(ARect.X + LDiameter/2, ARect.Y + ARect.Height, ARect.X, ARect.Y + ARect.Height);

  APath.CloseFigure;
end;

procedure TFluiPanel.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  if ParentBackground then
    inherited
  else
    Message.Result := 1;
end;

procedure TFluiPanel.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
end;

procedure TFluiPanel.Paint;
var
  LGraphics: TGPGraphics;
  LPath, LShadowPath: TGPGraphicsPath;
  LBrush: TGPBrush;
  LPathBrush: TGPPathGradientBrush;
  LBorderBrush: TGPBrush;
  LPen: TGPPen;
  LTextRect: TRect;
  LRound: Single;
  LRectF, LInnerRect, LPathRect: TGPRectF;
  LGPMode: LinearGradientMode;
  LClientRect: TRect;
  LShadowPadding: Integer;
  I: Integer;
  LAlphaStep: Double;
  LGPColor: TGPColor;
  LCount: Integer;
begin
  if (Width <= 1) or (Height <= 1) then Exit;

  // Draw background
  LClientRect := GetClientRect;
  if ParentBackground and (Parent <> nil) then
    StyleServices.DrawParentBackground(Handle, Canvas.Handle, nil, False, @LClientRect)
  else
  begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect(LClientRect);
  end;

  LGraphics := TGPGraphics.Create(Canvas.Handle);
  try
    LGraphics.SetSmoothingMode(SmoothingModeHighQuality);
    LGraphics.SetPixelOffsetMode(PixelOffsetModeHighQuality);

    LShadowPadding := 0;
    if FDropShadowEnabled then
      LShadowPadding := FDropShadowBlur + 2;

    // Base rect for the component content
    LInnerRect := MakeRect(LShadowPadding * 1.0, LShadowPadding * 1.0, 
      Width - (LShadowPadding * 2.0), Height - (LShadowPadding * 2.0));

    // Path rect adjusted for border width (using PenAlignmentCenter for reliability)
    LPathRect := LInnerRect;
    LPathRect.X := LPathRect.X + FBorderWidth / 2;
    LPathRect.Y := LPathRect.Y + FBorderWidth / 2;
    LPathRect.Width := LPathRect.Width - FBorderWidth;
    LPathRect.Height := LPathRect.Height - FBorderWidth;

    LRound := FRounding;
    if LRound * 2 > LPathRect.Width then LRound := LPathRect.Width / 2;
    if LRound * 2 > LPathRect.Height then LRound := LPathRect.Height / 2;

    // 1. Drop Shadow
    if FDropShadowEnabled and (FDropShadowBlur > 0) then
    begin
      LShadowPath := TGPGraphicsPath.Create;
      try
        BuildPath(LShadowPath, MakeRect(
          LInnerRect.X + FDropShadowOffsetX - FDropShadowBlur, 
          LInnerRect.Y + FDropShadowOffsetY - FDropShadowBlur, 
          LInnerRect.Width + FDropShadowBlur * 2, 
          LInnerRect.Height + FDropShadowBlur * 2), LRound + FDropShadowBlur);
        
        LPathBrush := TGPPathGradientBrush.Create(LShadowPath);
        try
          LPathBrush.SetCenterColor(ColorToGPColor(FDropShadowColor, FDropShadowAlpha));
          LGPColor := ColorToGPColor(FDropShadowColor, 0);
          LCount := 1;
          LPathBrush.SetSurroundColors(@LGPColor, LCount);
          
          LPathBrush.SetFocusScales(
            LInnerRect.Width / (LInnerRect.Width + FDropShadowBlur * 2),
            LInnerRect.Height / (LInnerRect.Height + FDropShadowBlur * 2)
          );
          
          LGraphics.FillPath(LPathBrush, LShadowPath);
        finally
          LPathBrush.Free;
        end;
      finally
        LShadowPath.Free;
      end;
    end;

    LPath := TGPGraphicsPath.Create;
    try
      BuildPath(LPath, LPathRect, LRound);

      case FGradientDirection of
        gdHorizontal: LGPMode := LinearGradientModeHorizontal;
        gdVertical: LGPMode := LinearGradientModeVertical;
        gdForwardDiagonal: LGPMode := LinearGradientModeForwardDiagonal;
        gdBackwardDiagonal: LGPMode := LinearGradientModeBackwardDiagonal;
      else
        LGPMode := LinearGradientModeVertical;
      end;

      // 2. Normal Background
      if FEnableGradient then
        LBrush := TGPLinearGradientBrush.Create(LPathRect, ColorToGPColor(FGradientColorStart),
          ColorToGPColor(FGradientColorEnd), LGPMode)
      else
        LBrush := TGPSolidBrush.Create(ColorToGPColor(Color));

      try
        LGraphics.FillPath(LBrush, LPath);
      finally
        LBrush.Free;
      end;

      // 3. Inner Shadow
      if FInnerShadowEnabled and (FInnerShadowBlur > 0) then
      begin
        LGraphics.SetClip(LPath);
        LAlphaStep := FInnerShadowAlpha / FInnerShadowBlur;
        for I := FInnerShadowBlur downto 1 do
        begin
          LPen := TGPPen.Create(ColorToGPColor(FInnerShadowColor, Round(LAlphaStep)), I * 2);
          try
            LPen.SetLineJoin(LineJoinRound);
            LShadowPath := TGPGraphicsPath.Create;
            try
              BuildPath(LShadowPath, MakeRect(
                LPathRect.X + FInnerShadowOffsetX, 
                LPathRect.Y + FInnerShadowOffsetY, 
                LPathRect.Width, LPathRect.Height), LRound);
              LGraphics.DrawPath(LPen, LShadowPath);
            finally
              LShadowPath.Free;
            end;
          finally
            LPen.Free;
          end;
        end;
        LGraphics.ResetClip;
      end;

      // 4. Border
      if ((FBorderColor <> clNone) or FEnableBorderGradient) and (FBorderWidth > 0.1) then
      begin
        if FEnableBorderGradient then
          LBorderBrush := TGPLinearGradientBrush.Create(LPathRect, 
            ColorToGPColor(FBorderGradientColorStart),
            ColorToGPColor(FBorderGradientColorEnd), LGPMode)
        else
          LBorderBrush := TGPSolidBrush.Create(ColorToGPColor(FBorderColor));

        try
          LPen := TGPPen.Create(LBorderBrush, FBorderWidth);
          try
            LPen.SetLineJoin(LineJoinRound);
            LPen.SetAlignment(PenAlignmentCenter);
            LGraphics.DrawPath(LPen, LPath);
          finally
            LPen.Free;
          end;
        finally
          LBorderBrush.Free;
        end;
      end;

      // 5. Caption
      if Caption <> '' then
      begin
        Canvas.Brush.Style := bsClear;
        Canvas.Font.Assign(Font);
        LTextRect := Rect(LShadowPadding, LShadowPadding, Width - LShadowPadding, Height - LShadowPadding);
        DrawText(Canvas.Handle, PChar(Caption), -1, LTextRect, 
          DT_CENTER or DT_VCENTER or DT_SINGLELINE);
      end;
    finally
      LPath.Free;
    end;
  finally
    LGraphics.Free;
  end;
end;

procedure TFluiPanel.Resize;
begin
  inherited;
  Invalidate;
end;

procedure TFluiPanel.SetBorderColor(const Value: TColor);
begin
  if FBorderColor <> Value then
  begin
    FBorderColor := Value;
    Invalidate;
  end;
end;

procedure TFluiPanel.SetBorderWidth(const Value: Single);
begin
  if FBorderWidth <> Value then
  begin
    FBorderWidth := Value;
    Invalidate;
  end;
end;

procedure TFluiPanel.SetRounding(const Value: Integer);
begin
  if FRounding <> Value then
  begin
    FRounding := Value;
    Invalidate;
  end;
end;

procedure TFluiPanel.SetEnableGradient(const Value: Boolean);
begin
  if FEnableGradient <> Value then
  begin
    FEnableGradient := Value;
    Invalidate;
  end;
end;

procedure TFluiPanel.SetGradientColorEnd(const Value: TColor);
begin
  if FGradientColorEnd <> Value then
  begin
    FGradientColorEnd := Value;
    Invalidate;
  end;
end;

procedure TFluiPanel.SetGradientColorStart(const Value: TColor);
begin
  if FGradientColorStart <> Value then
  begin
    FGradientColorStart := Value;
    Invalidate;
  end;
end;

procedure TFluiPanel.SetGradientDirection(const Value: TFluiGradientDirection);
begin
  if FGradientDirection <> Value then
  begin
    FGradientDirection := Value;
    Invalidate;
  end;
end;

procedure TFluiPanel.SetBorderGradientColorEnd(const Value: TColor);
begin
  if FBorderGradientColorEnd <> Value then
  begin
    FBorderGradientColorEnd := Value;
    Invalidate;
  end;
end;

procedure TFluiPanel.SetBorderGradientColorStart(const Value: TColor);
begin
  if FBorderGradientColorStart <> Value then
  begin
    FBorderGradientColorStart := Value;
    Invalidate;
  end;
end;

procedure TFluiPanel.SetEnableBorderGradient(const Value: Boolean);
begin
  if FEnableBorderGradient <> Value then
  begin
    FEnableBorderGradient := Value;
    Invalidate;
  end;
end;

procedure TFluiPanel.SetCorners(const Value: TFluiCorners);
begin
  if FCorners <> Value then
  begin
    FCorners := Value;
    Invalidate;
  end;
end;

procedure TFluiPanel.SetDropShadowEnabled(const Value: Boolean);
begin
  if FDropShadowEnabled <> Value then
  begin
    FDropShadowEnabled := Value;
    Realign;
    Invalidate;
  end;
end;

procedure TFluiPanel.SetDropShadowColor(const Value: TColor);
begin
  if FDropShadowColor <> Value then
  begin
    FDropShadowColor := Value;
    Invalidate;
  end;
end;

procedure TFluiPanel.SetDropShadowBlur(const Value: Integer);
begin
  if FDropShadowBlur <> Value then
  begin
    FDropShadowBlur := Value;
    Realign;
    Invalidate;
  end;
end;

procedure TFluiPanel.SetDropShadowOffsetX(const Value: Integer);
begin
  if FDropShadowOffsetX <> Value then
  begin
    FDropShadowOffsetX := Value;
    Realign;
    Invalidate;
  end;
end;

procedure TFluiPanel.SetDropShadowOffsetY(const Value: Integer);
begin
  if FDropShadowOffsetY <> Value then
  begin
    FDropShadowOffsetY := Value;
    Realign;
    Invalidate;
  end;
end;

procedure TFluiPanel.SetDropShadowAlpha(const Value: Byte);
begin
  if FDropShadowAlpha <> Value then
  begin
    FDropShadowAlpha := Value;
    Invalidate;
  end;
end;

procedure TFluiPanel.SetInnerShadowEnabled(const Value: Boolean);
begin
  if FInnerShadowEnabled <> Value then
  begin
    FInnerShadowEnabled := Value;
    Invalidate;
  end;
end;

procedure TFluiPanel.SetInnerShadowColor(const Value: TColor);
begin
  if FInnerShadowColor <> Value then
  begin
    FInnerShadowColor := Value;
    Invalidate;
  end;
end;

procedure TFluiPanel.SetInnerShadowBlur(const Value: Integer);
begin
  if FInnerShadowBlur <> Value then
  begin
    FInnerShadowBlur := Value;
    Invalidate;
  end;
end;

procedure TFluiPanel.SetInnerShadowOffsetX(const Value: Integer);
begin
  if FInnerShadowOffsetX <> Value then
  begin
    FInnerShadowOffsetX := Value;
    Invalidate;
  end;
end;

procedure TFluiPanel.SetInnerShadowOffsetY(const Value: Integer);
begin
  if FInnerShadowOffsetY <> Value then
  begin
    FInnerShadowOffsetY := Value;
    Invalidate;
  end;
end;

procedure TFluiPanel.SetInnerShadowAlpha(const Value: Byte);
begin
  if FInnerShadowAlpha <> Value then
  begin
    FInnerShadowAlpha := Value;
    Invalidate;
  end;
end;

end.