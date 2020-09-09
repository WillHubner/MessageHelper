unit Form.Helper.Message;

interface

uses
  FMX.StdCtrls,
  FMX.Layouts,
  FMX.Objects,
  FMX.Types,
  System.UiTypes,
  RegularExpressions,
  FMX.Dialogs,
  System.SysUtils,
  FMX.Ani,
  System.Generics.Collections,
  FMX.Effects,
  FMX.Forms,
  FMX.Graphics;

type
  TipoMensagem = (tmOK, tmErro);

  TFormHelper = class helper for TForm
  public

  published
    procedure Mensagem(Value : String; tpMsg : TipoMensagem);
  private
    procedure FinishIN (Sender: TObject);
    procedure FinishOUT (Sender: TObject);
    procedure onClick(Sender : TObject);

  end;

var
  FloatAnimation : TFloatAnimation;

implementation

{ TFormHelper }


procedure TFormHelper.FinishIN (Sender: TObject);
begin
  FloatAnimation.Start;
end;

procedure TFormHelper.FinishOut (Sender: TObject);
begin
  TLayout(TFloatAnimation(Sender).Parent).Destroy;
end;

procedure TFormHelper.Mensagem(Value: String; tpMsg : TipoMensagem);
var
  Texto : TLabel;
  Fundo : TRectangle;
  lytMensagem : TLayout;
  FloatAnimation1 : TFloatAnimation;
  FloatAnimation2 : TFloatAnimation;
  ShadowEffect1: TShadowEffect;
begin
  lytMensagem := TLayout.Create(self);
  lytMensagem.Parent := Self;

  lytMensagem.BringToFront;

  lytMensagem.Opacity := 0;

  lytMensagem.Size.Width := 700;
  lytMensagem.Size.Height := 100;

  lytMensagem.Position.X := (Self.Width - 700) / 2;
  lytMensagem.Position.Y := (Self.Height - 150);

  Fundo := TRectangle.Create(lytMensagem);

  Fundo.Parent := lytMensagem;

  Fundo.Stroke.Kind := TBrushKind.None;
  Fundo.Align := TAlignLayout.Client;

  case tpMsg of
    tmOK : Fundo.Fill.Color := TAlphaColorRec.Skyblue;// xFF69C0D7
    tmErro : Fundo.Fill.Color := TAlphaColorRec.Red;// xFF69C0D7
  end;

  Fundo.OnClick := OnClick;

  Fundo.Stroke.Kind := TBrushKind.None;

  Texto := TLabel.Create(lytMensagem);

  Texto.Align := TAlignLayout.Center;
  Texto.AutoSize := True;
  Texto.StyledSettings := [];
  Texto.TextSettings.Font.Size := 30;
  Texto.TextSettings.HorzAlign := TTextAlign.Center;
  Texto.Text := Value;
  Texto.FontColor := TAlphaColorRec.White;
  Texto.Parent := lytMensagem;
  Texto.BringToFront;
  Texto.Width := 700;

  FloatAnimation1 := TFloatAnimation.Create(lytMensagem);
  FloatAnimation1.Parent := lytMensagem;
  FloatAnimation1.AnimationType := TAnimationType.&In;
  FloatAnimation1.Duration := 1;
  FloatAnimation1.PropertyName := 'Opacity';
  FloatAnimation1.StartValue := 0;
  FloatAnimation1.StopValue := 1;

  FloatAnimation2 := TFloatAnimation.Create(lytMensagem);
  FloatAnimation2.Parent := lytMensagem;
  FloatAnimation2.AnimationType := TAnimationType.Out;
  FloatAnimation2.Delay := 3;
  FloatAnimation2.Duration := 1;
  FloatAnimation2.PropertyName := 'Opacity';
  FloatAnimation2.StartValue := 1;
  FloatAnimation2.StopValue := 0;

  ShadowEffect1 := TShadowEffect.Create(lytMensagem);
  ShadowEffect1.Parent := lytMensagem;
  ShadowEffect1.Distance := 3;
  ShadowEffect1.Direction := 45;
  ShadowEffect1.Softness := 0;
  ShadowEffect1.Opacity := 0;
  ShadowEffect1.ShadowColor := TAlphaColorRec.Black;

  FloatAnimation1.OnFinish:= finishIN;

  FloatAnimation := FloatAnimation2;

  FloatAnimation2.OnFinish := finishOUT;

  FloatAnimation1.Start;
end;

procedure TFormHelper.onClick(Sender: TObject);
begin
  TLayout(TFloatAnimation(Sender).Parent).Destroy;
end;

end.
