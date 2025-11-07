object Form2: TForm2
  Left = 259
  Top = 120
  Caption = '        Viewer'
  ClientHeight = 122
  ClientWidth = 89
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 137
    Height = 172
    AutoSize = True
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 103
    Width = 89
    Height = 19
    Panels = <
      item
        Text = 'X :'
        Width = 20
      end
      item
        Width = 50
      end
      item
        Text = 'Y :'
        Width = 20
      end
      item
        Width = 50
      end
      item
        Text = 'BitCount :'
        Width = 60
      end
      item
        Width = 30
      end
      item
        Text = 'Used :'
        Width = 40
      end
      item
        Width = 50
      end>
    ExplicitTop = 282
    ExplicitWidth = 424
  end
end
