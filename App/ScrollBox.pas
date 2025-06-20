﻿unit ScrollBox;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Types,
  System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, System.Generics.Collections, Expression;

type
  TScrollBox = Class(Vcl.Forms.TScrollBox)

    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;

  private
    FOnScrollVert: TNotifyEvent;

  public
    FRePaint: TNotifyEvent;
    property RePaint: TNotifyEvent read FRePaint write FRePaint;
    Property OnScrollVert: TNotifyEvent read FOnScrollVert Write FOnScrollVert;
    procedure UpdateItems;
    procedure AddItem;
    constructor Create;
    procedure RemoveClick(Sender: TObject);
    procedure Editing(Sender: TObject);
    procedure Visability(Sender: TObject);
    destructor Destroy;

  type
    Item = TExpression;

  var
    items: TList<Item>;

  end;

implementation

constructor TScrollBox.Create;
begin
  items := TList<Item>.Create;
end;

destructor TScrollBox.Destroy;
begin
  items.Destroy;
end;

procedure TScrollBox.UpdateItems;
var
  i: Integer;
begin

  i := 0;
  for var Item in self.items do
  begin

    Item.ReSize;
    Item.Top := i * Item.Height;
    Inc(i);

  end;

end;

procedure TScrollBox.AddItem;
var
  newPanel: TScrollBox.Item;
begin
  if Assigned(FRePaint) then
    FRePaint(self);
  newPanel := TScrollBox.Item.Create(self);
  newPanel.Align := TAlign.alTop;
  newPanel.Parent := self;
  newPanel.removeBtn.OnClick := RemoveClick;
  newPanel.Edit.OnChange := Editing;
  newPanel.colBox.OnChange := Editing;
  newPanel.visibleBtn.OnClick := Visability;
  newPanel.ReSize;
  self.items.Add(newPanel);

  self.UpdateItems;

end;

procedure TScrollBox.WMVScroll(var Message: TWMVScroll);
begin

  inherited;
  if Message.ScrollCode = 5 then
    self.VertScrollBar.Position := Message.Pos;
end;

procedure TScrollBox.RemoveClick(Sender: TObject);
begin

  if Sender is TButton then
  begin
    var
    btn := TButton(Sender);
    if btn.Parent is TExpression and (self.items.Count <> 1) then
    begin
      if Assigned(FRePaint) then
        FRePaint(self);
      var
      panel := TExpression(btn.Parent);
      panel.Edit.Free;
      panel.yLabel.Free;
      panel.colBox.Free;
      panel.removeBtn.Free;
      panel.visibleBtn.Free;
      panel.Free;
      items.Remove(panel);
      UpdateItems;

    end;
  end;
end;

procedure TScrollBox.Editing(Sender: TObject);
begin
  if Assigned(FRePaint) then
    FRePaint(self);
  if Sender is TEdit then
  begin
    var
    Edit := TEdit(Sender);
    if Edit.Parent is TExpression then
    begin
      var
      panel := TExpression(Edit.Parent);
      if items.IndexOf(panel) = items.Count - 1 then
      begin
        self.AddItem;
      end;

    end;
  end;

end;

procedure TScrollBox.Visability(Sender: TObject);
begin

  if Sender is TButton then
  begin
    if Assigned(FRePaint) then
      FRePaint(self);
    var
    btn := TButton(Sender);
    if btn.Caption = '👁' then
      btn.Caption := '⎯'
    else if btn.Caption = '⎯' then
      btn.Caption := '👁'

  end;
end;

end.
