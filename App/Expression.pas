unit Expression;

interface
uses Vcl.ExtCtrls,System.Classes, Vcl.StdCtrls,Vcl.Forms, Vcl.Controls, Math;
type TExpression = Class(TPanel)

public

procedure ReSize;
constructor Create(Sender: TComponent);
var Edit:TEdit;
colBox:TColorBox;
removeBtn:TButton;
visibleBtn:TButton;
end;

implementation

constructor TExpression.Create(Sender: TComponent);
begin
inherited Create(Sender);


self.Edit:=TEdit.Create(self);
self.Edit.Parent:=self;
self.Edit.AutoSize:=true;
//self.Edit.Alignment:=TACenter;


self.colBox:=TColorBox.Create(self);
self.colBox.Parent:=self;

self.removeBtn:=TButton.Create(self);
self.removeBtn.Parent:=self;
self.removeBtn.Caption:='✕';

self.visibleBtn:=TButton.Create(self);
self.visibleBtn.Parent:=self;
self.visibleBtn.Caption:='👁';


end;
procedure TExpression.ReSize;
begin

  self.Width:=self.Parent.Width;
  self.Height:=50;
  Edit.Width:=Round(self.Width*(3/4));
  Edit.Height:=self.Height;
  Edit.Font.Size:=14;

  colBox.Width:=self.Width-self.Edit.Width;
  colBox.left:=edit.Width;
  colBox.Height:=round(self.Height/2);
  colBox.Top:=self.Height-colBox.Height;

  visibleBtn.Height:=colbox.Top;
  visibleBtn.Width:=removeBtn.Height;
  visibleBtn.Left:=colBox.Left+round((colbox.Width-visibleBtn.Width*2)/2);

  removeBtn.Height:=visibleBtn.Height;
  removeBtn.Width:=visibleBtn.Width;
  removeBtn.Left:=visibleBtn.Left+visibleBtn.Width;




end;





end.
