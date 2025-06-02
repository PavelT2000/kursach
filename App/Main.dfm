object Form2: TForm2
  Left = 0
  Top = 0
  Width = 1056
  Height = 679
  VertScrollBar.Smooth = True
  VertScrollBar.Tracking = True
  AutoScroll = True
  Caption = 'Plotify'
  Color = clBtnFace
  DockSite = True
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  ScreenSnap = True
  OnCreate = FormCreate
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  OnResize = FormResize
  TextHeight = 15
  object PaintBox1: TPaintBox
    Left = 409
    Top = 0
    Width = 631
    Height = 640
    Align = alClient
    OnMouseDown = PaintBox1MouseDown
    OnMouseMove = PaintBox1MouseMove
    OnMouseUp = PaintBox1MouseUp
    OnPaint = PaintBox1Paint
    ExplicitLeft = 415
  end
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 409
    Height = 640
    Align = alLeft
    TabOrder = 0
  end
  object Button1: TButton
    Left = 957
    Top = 0
    Width = 75
    Height = 25
    Align = alCustom
    Caption = 'Copy'
    TabOrder = 1
    OnClick = Button1Click
  end
end
