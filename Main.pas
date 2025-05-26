unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,System.Generics.Collections, Expression;

type

  TScrollBox=Class(VCL.Forms.TScrollBox)


    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;

  private
    FOnScrollVert: TNotifyEvent;

  public
   Property OnScrollVert:TNotifyEvent read FOnScrollVert Write FonScrollVert;
   procedure UpdateItems;
   procedure AddItem;
   constructor Create;
   procedure RemoveClick(Sender: TObject);
   procedure Editing(Sender: TObject);
   procedure Visability(Sender: TObject);
   type Item =TExpression;
   var items:TList<Item>;


  end;

  TForm2 = class(TForm)
    ScrollBox1: TScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
{$R *.dfm}
constructor TScrollBox.Create;
begin
items:=TList<Item>.Create;
end;


procedure TScrollBox.UpdateItems;
var i:integer;
begin


i:=0;
for var item in self.Items do
begin

item.ReSize;
item.Top:=i*item.Height;
Inc(i);

end;



end;
procedure TScrollBox.AddItem;
var newPanel:TScrollBox.Item;
begin
newPanel:=TScrollBOX.Item.Create(self);
newPanel.Align:=TAlign.alTop;
newPanel.Parent:=self;
newPanel.removeBtn.OnClick:=RemoveClick;
newPanel.Edit.OnChange:=Editing;
newPanel.visibleBtn.OnClick:=visability;
newPanel.ReSize;
self.items.Add(newPanel);

self.UpdateItems;

end;
procedure TScrollBox.WMVScroll(var Message: TWMVScroll);
begin

   inherited;
   if Message.ScrollCode=5 then
   self.VertScrollBar.Position:=Message.Pos;
end;



procedure TForm2.Button1Click(Sender: TObject);
begin
ScrollBox1.AddItem;
end;

procedure TScrollBox.RemoveClick(Sender: TObject);
begin

  if Sender is TButton then
  begin
    var btn := TButton(Sender);
    if btn.Parent is TExpression then
    begin
      var panel := TExpression(btn.Parent);
      panel.Free;
      items.Remove(panel);
      UpdateItems;
    end;
  end;
end;

procedure TScrollBox.Editing(Sender: TObject);
begin
 if Sender is TEdit then
  begin
  var edit := TEdit(Sender);
  if edit.Parent is TExpression then
    begin
    var panel := TExpression(edit.Parent);
    if items.IndexOf(panel)=items.Count-1 then
    begin
    Form2.ScrollBox1.AddItem;
    end;

    end;
  end;

end;
procedure TScrollBox.Visability(Sender: TObject);
begin

  if Sender is TButton then
  begin
    var btn := TButton(Sender);
    if btn.Caption='👁' then
      btn.Caption:='⎯'
    else if btn.Caption='⎯' then
    btn.Caption:='👁'

  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
ScrollBox1.Create;
ScrollBox1.AddItem;


end;



procedure TForm2.FormResize(Sender: TObject);
begin
ScrollBox1.Width:=round((1/3)*self.Width);
ScrollBox1.DoubleBuffered:=false ;
ScrollBox1.UpdateItems;
end;

end.
