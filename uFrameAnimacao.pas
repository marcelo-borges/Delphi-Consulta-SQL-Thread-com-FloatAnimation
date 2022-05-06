unit uFrameAnimacao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Ani;

type
  TframeAnimacao = class(TFrame)
    ArcoAnimacao: TArc;
    CircleAnimacao: TCircle;
    lblAnimacao: TLabel;
    FloatAnimacao: TFloatAnimation;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
