unit FluiPanel4D;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Graphics,
  Winapi.Windows, Winapi.GDIPOBJ, Winapi.GDIPAPI, Winapi.Messages;

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

    function ColorToGPColor(AColor: TColor; AAlpha: Byte = 255): TGPColor;
    procedure UpdateRegion;
    procedure BuildPath(APath: TGPGraphicsPath; ARect: TGPRectF; ARadius: Single);
  protected
    procedure Paint; override;
    procedure Resize; override;
    procedure CreateWnd; override;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
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
    property StyleName;
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

  ControlStyle := ControlStyle + [csAcceptsControls, csOpaque];
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

procedure TFluiPanel.CreateWnd;
begin
  inherited;
  UpdateRegion;
end;

procedure TFluiPanel.BuildPath(APath: TGPGraphicsPath; ARect: TGPRectF; ARadius: Single);
var
  LDiameter: Single;
begin
  LDiameter := ARadius * 2;

  // Top-Left
  if cpTopLeft in FCorners then
    APath.AddArc(ARect.X, ARect.Y, LDiameter, LDiameter, 180, 90)
  else
    APath.AddLine(ARect.X, ARect.Y, ARect.X, ARect.Y);

  // Top-Right
  if cpTopRight in FCorners then
    APath.AddArc(ARect.X + ARect.Width - LDiameter, ARect.Y, LDiameter, LDiameter, 270, 90)
  else
    APath.AddLine(ARect.X + ARect.Width, ARect.Y, ARect.X + ARect.Width, ARect.Y);

  // Bottom-Right
  if cpBottomRight in FCorners then
    APath.AddArc(ARect.X + ARect.Width - LDiameter, ARect.Y + ARect.Height - LDiameter, LDiameter, LDiameter, 0, 90)
  else
    APath.AddLine(ARect.X + ARect.Width, ARect.Y + ARect.Height, ARect.X + ARect.Width, ARect.Y + ARect.Height);

  // Bottom-Left
  if cpBottomLeft in FCorners then
    APath.AddArc(ARect.X, ARect.Y + ARect.Height - LDiameter, LDiameter, LDiameter, 90, 90)
  else
    APath.AddLine(ARect.X, ARect.Y + ARect.Height, ARect.X, ARect.Y + ARect.Height);

  APath.CloseFigure;
end;

procedure TFluiPanel.UpdateRegion;
var
  LPath: TGPGraphicsPath;
  LRegion: TGPRegion;
  LHandle: HRGN;
  LGraphics: TGPGraphics;
  LRound: Single;
begin
  if not HandleAllocated then Exit;

  LRound := FRounding;
  if LRound < 1 then
  begin
    SetWindowRgn(Handle, 0, True);
    Exit;
  end;

  if LRound * 2 > Width then LRound := Width / 2;
  if LRound * 2 > Height then LRound := Height / 2;

  LPath := TGPGraphicsPath.Create;
  try
    // Region inflated for smooth anti-alias edges
    BuildPath(LPath, MakeRect(-1.0, -1.0, Width + 2.0, Height + 2.0), LRound + 1);

    LGraphics := TGPGraphics.Create(Handle);
    try
      LRegion := TGPRegion.Create(LPath);
      try
        LHandle := LRegion.GetHRGN(LGraphics);
        if LHandle <> 0 then
        begin
          if SetWindowRgn(Handle, LHandle, True) = 0 then
            DeleteObject(LHandle);
        end;
      finally
        LRegion.Free;
      end;
    finally
      LGraphics.Free;
    end;
  finally
    LPath.Free;
  end;
end;

procedure TFluiPanel.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TFluiPanel.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
end;

procedure TFluiPanel.Paint;
var
  LGraphics: TGPGraphics;
  LPath: TGPGraphicsPath;
  LBrush: TGPBrush;
  LBorderBrush: TGPBrush;
  LPen: TGPPen;
  LTextRect: TRect;
  LRound: Single;
  LOffset: Single;
  LRectF: TGPRectF;
  LGPMode: LinearGradientMode;
begin
  if (Width <= 1) or (Height <= 1) then Exit;

  LGraphics := TGPGraphics.Create(Canvas.Handle);
  try
    LGraphics.SetSmoothingMode(SmoothingModeAntiAlias);
    LGraphics.SetPixelOffsetMode(PixelOffsetModeHighQuality);

    LRound := FRounding;
    if LRound * 2 > Width then LRound := Width / 2;
    if LRound * 2 > Height then LRound := Height / 2;

    LOffset := FBorderWidth / 2;
    LRectF := MakeRect(0.0, 0.0, Width * 1.0, Height * 1.0);

    LPath := TGPGraphicsPath.Create;
    try
      if LRound > 0 then
        BuildPath(LPath, MakeRect(LOffset, LOffset, Width - FBorderWidth, Height - FBorderWidth), LRound - LOffset)
      else
        LPath.AddRectangle(MakeRect(LOffset, LOffset, Width - FBorderWidth, Height - FBorderWidth));

      case FGradientDirection of
        gdVertical: LGPMode := LinearGradientModeVertical;
        gdHorizontal: LGPMode := LinearGradientModeHorizontal;
        gdForwardDiagonal: LGPMode := LinearGradientModeForwardDiagonal;
        gdBackwardDiagonal: LGPMode := LinearGradientModeBackwardDiagonal;
      else
        LGPMode := LinearGradientModeVertical;
      end;

      // Background
      if FEnableGradient then
        LBrush := TGPLinearGradientBrush.Create(LRectF, ColorToGPColor(FGradientColorStart),
          ColorToGPColor(FGradientColorEnd), LGPMode)
      else
        LBrush := TGPSolidBrush.Create(ColorToGPColor(Color));

      try
        LGraphics.FillPath(LBrush, LPath);
      finally
        LBrush.Free;
      end;

      // Border
      if ((FBorderColor <> clNone) or FEnableBorderGradient) and (FBorderWidth > 0) then
      begin
        if FEnableBorderGradient then
          LBorderBrush := TGPLinearGradientBrush.Create(LRectF, 
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

      // Caption
      if Caption <> '' then
      begin
        Canvas.Brush.Style := bsClear;
        Canvas.Font.Assign(Font);
        LTextRect := Rect(0, 0, Width, Height);
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
  UpdateRegion;
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
    UpdateRegion;
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
    UpdateRegion;
    Invalidate;
  end;
end;

end.
