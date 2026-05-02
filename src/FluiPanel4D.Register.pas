unit FluiPanel4D.Register;

interface

uses
  System.Classes, FluiPanel4D;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('FLUI', [TFluiPanel]);
end;

end.
