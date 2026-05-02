unit FluiPanel4D;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.ExtCtrls, Vcl.Graphics,
  Winapi.Windows, Winapi.GDIPOBJ, Winapi.GDIPAPI, Winapi.Messages;

type
  TFluiPanel = class(TCustomPanel)
  private
    FRounding: Integer;
    FBorderColor: TColor;
    FBorderWidth: Single;
    procedure SetRounding(const Value: Integer);
    procedure SetBorderColor(const Value: TColor);
    procedure SetBorderWidth(const Value: Single);
    function ColorToGPColor(AColor: TColor; AAlpha: Byte = 255): TGPColor;
    procedure UpdateRegion;
  protected
    procedure Paint; override;
    procedure Resize; override;
    procedure CreateWnd; override;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Rounding: Integer read FRounding write SetRounding default 10;
    property BorderColor: TColor read FBorderColor write SetBorderColor default clNone;
    property BorderWidth: Single read FBorderWidth write SetBorderWidth;
    
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
  FBorderColor := clNone;
  FBorderWidth := 1;
  ControlStyle := ControlStyle + [csAcceptsControls, csOpaque];
  FullRepaint := True;
  DoubleBuffered := True;
  Width := 185;
  Height := 41;
end;

function TFluiPanel.ColorToGPColor(AColor: TColor; AAlpha: Byte): TGPColor;
var
  LColor: COLORREF;
begin
  LColor := ColorToRGB(AColor);
  Result := MakeColor(AAlpha, GetRValue(LColor), GetGValue(LColor), GetBValue(LColor));
end;

procedure TFluiPanel.CreateWnd;
begin
  inherited;
  UpdateRegion;
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
    LPath.AddArc(-1, -1, (LRound * 2) + 2, (LRound * 2) + 2, 180, 90);
    LPath.AddArc(Width - (LRound * 2) - 1, -1, (LRound * 2) + 2, (LRound * 2) + 2, 270, 90);
    LPath.AddArc(Width - (LRound * 2) - 1, Height - (LRound * 2) - 1, (LRound * 2) + 2, (LRound * 2) + 2, 0, 90);
    LPath.AddArc(-1, Height - (LRound * 2) - 1, (LRound * 2) + 2, (LRound * 2) + 2, 90, 90);
    LPath.CloseFigure;

    LGraphics := TGPGraphics.Create(Handle);
    try
      LRegion := TGPRegion.Create(LPath);
      try
        LHandle := LRegion.GetHRGN(LGraphics);
        SetWindowRgn(Handle, LHandle, True);
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

procedure TFluiPanel.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
end;

procedure TFluiPanel.Paint;
var
  LGraphics: TGPGraphics;
  LPath: TGPGraphicsPath;
  LBrush: TGPSolidBrush;
  LPen: TGPPen;
  LTextRect: TRect;
  LRound: Single;
  LOffset: Single;
begin
  LGraphics := TGPGraphics.Create(Canvas.Handle);
  try
    LGraphics.SetSmoothingMode(SmoothingModeAntiAlias);
    LGraphics.SetPixelOffsetMode(PixelOffsetModeHighQuality);
    
    LRound := FRounding;
    if LRound * 2 > Width then LRound := Width / 2;
    if LRound * 2 > Height then LRound := Height / 2;
    
    LOffset := FBorderWidth / 2;

    LPath := TGPGraphicsPath.Create;
    try
      if LRound > 0 then
      begin
        LPath.AddArc(LOffset, LOffset, (LRound * 2) - FBorderWidth, (LRound * 2) - FBorderWidth, 180, 90);
        LPath.AddArc(Width - (LRound * 2) + LOffset, LOffset, (LRound * 2) - FBorderWidth, (LRound * 2) - FBorderWidth, 270, 90);
        LPath.AddArc(Width - (LRound * 2) + LOffset, Height - (LRound * 2) + LOffset, (LRound * 2) - FBorderWidth, (LRound * 2) - FBorderWidth, 0, 90);
        LPath.AddArc(LOffset, Height - (LRound * 2) + LOffset, (LRound * 2) - FBorderWidth, (LRound * 2) - FBorderWidth, 90, 90);
        LPath.CloseFigure;
      end
      else
        LPath.AddRectangle(MakeRect(LOffset, LOffset, Width - FBorderWidth, Height - FBorderWidth));

      // Background
      LBrush := TGPSolidBrush.Create(ColorToGPColor(Color));
      try
        LGraphics.FillPath(LBrush, LPath);
      finally
        LBrush.Free;
      end;

      // Border
      if (FBorderColor <> clNone) and (FBorderWidth > 0) then
      begin
        LPen := TGPPen.Create(ColorToGPColor(FBorderColor), FBorderWidth);
        try
          LPen.SetLineJoin(LineJoinRound);
          LPen.SetAlignment(PenAlignmentCenter);
          LGraphics.DrawPath(LPen, LPath);
        finally
          LPen.Free;
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

end.
