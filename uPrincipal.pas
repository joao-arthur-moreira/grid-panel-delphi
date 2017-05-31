unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, Vcl.Imaging.pngimage;

type
  TForm1 = class(TForm)
    GridPanel1: TGridPanel;
    ImageList1: TImageList;
    Image1: TImage;
    Image2: TImage;
    procedure FormCreate(Sender: TObject);
    procedure onClickBotao(Sender: TObject);
    procedure onClickImage(Sender: TObject);
  private
    { Private declarations }
    procedure botoes;
    procedure images;

    procedure ArredondarComponente(Componente: TWinControl; const Radius: SmallInt);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ArredondarComponente(Componente: TWinControl;
  const Radius: SmallInt);
var
  R : TRect;
  Rgn : HRGN;
begin
  with Componente do
  begin
    R := ClientRect;
    Rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, Radius, Radius);
    Perform(EM_GETRECT, 0, lParam(@R));
    InflateRect(R, -5, -5);
    Perform(EM_SETRECTNP, 0, lParam(@R));
    SetWindowRgn(Handle, Rgn, True);
    Invalidate;
  end;
end;

procedure TForm1.botoes;
var
  i: Integer;
  botao: TBitBtn;
begin
  for I := 0 to 60 do
  begin
    botao := TBitBtn.Create(GridPanel1);
    botao.Width := 70;
    botao.Height:= 70;
    botao.Tag   := i;
    botao.Name  := 'btn' + IntToStr(i);
    botao.Caption := 'Botão ' + IntToStr(i) + ' livre';
    botao.OnClick := onClickBotao;
    botao.Font.Color := clGreen;
    botao.WordWrap := True;
    //ArredondarComponente(botao,10);
    botao.Layout :=  blGlyphTop;
    ImageList1.GetBitmap(0, botao.Glyph);

    GridPanel1.InsertControl(botao);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  images;
  //botoes;
end;

procedure TForm1.images;
var
  i: Integer;
  image: TImage;
begin
  for I := 0 to 60 do
  begin
    image := TImage.Create(GridPanel1);
    image.Width := 50;
    image.Height:= 50;
    image.Tag   := i;
    image.Name  := 'btn' + IntToStr(i);
    image.OnClick := onClickImage;
    image.Picture.LoadFromFile(ExtractFilePath(application.ExeName) + 'mesa_livre.png');

    GridPanel1.InsertControl(image);
  end;
end;

procedure TForm1.onClickBotao(Sender: TObject);
begin
  ShowMessage('Botão: ' + TBitBtn(Sender).Name + #13+ 'Tag: ' + IntToStr(TBitBtn(Sender).Tag) + #13 + 'Clicado!');
  TBitBtn(Sender).Font.Color := clRed;
  TBitBtn(Sender).Caption := 'Botão ocupado!';
  TBitBtn(Sender).Glyph := nil;
  ImageList1.GetBitmap(4, TBitBtn(Sender).Glyph);
end;

procedure TForm1.onClickImage(Sender: TObject);
begin
  ShowMessage('Botão: ' + TImage(Sender).Name + #13+ 'Tag: ' + IntToStr(TImage(Sender).Tag) + #13 + 'Clicado!');
  TImage(Sender).Picture := nil;
  TImage(Sender).Picture.LoadFromFile(ExtractFilePath(application.ExeName) + 'mesa_ocupada_48x48.png');
end;

end.
