object Form3: TForm3
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Options'
  ClientHeight = 303
  ClientWidth = 312
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 300
    Height = 253
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'General '
      object CheckBox1: TCheckBox
        Left = 13
        Top = 22
        Width = 97
        Height = 17
        Caption = 'Monochrome'
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 0
        OnClick = CheckBox1Click
      end
      object SpinEdit1: TSpinEdit
        Left = 186
        Top = 176
        Width = 51
        Height = 24
        MaxValue = 0
        MinValue = 0
        TabOrder = 1
        Value = 300
        OnChange = SpinEdit1Change
      end
      object CheckBox2: TCheckBox
        Left = 13
        Top = 179
        Width = 167
        Height = 17
        Caption = 'Scale Output Proportional :'
        TabOrder = 2
        OnClick = CheckBox2Click
      end
      object CheckBox3: TCheckBox
        Left = 13
        Top = 45
        Width = 97
        Height = 17
        Caption = 'Ignore Palette'
        TabOrder = 3
        OnClick = CheckBox3Click
      end
      object CheckBox4: TCheckBox
        Left = 13
        Top = 68
        Width = 139
        Height = 17
        Caption = 'Disable Scaled Drawer'
        TabOrder = 4
        OnClick = CheckBox4Click
      end
      object CheckBox5: TCheckBox
        Left = 13
        Top = 91
        Width = 81
        Height = 17
        Caption = 'Modified'
        TabOrder = 5
        OnClick = CheckBox5Click
      end
      object CheckBox6: TCheckBox
        Left = 13
        Top = 114
        Width = 125
        Height = 17
        Caption = 'Tranzaprent (Black)'
        TabOrder = 6
        OnClick = CheckBox6Click
      end
      object RadioGroup1: TRadioGroup
        Left = 158
        Top = 26
        Width = 129
        Height = 105
        Caption = ' Pixel Format '
        Columns = 2
        Items.Strings = (
          '4 bit'
          '8 bit'
          '16 bit'
          '24 bit'
          '32 bit')
        TabOrder = 7
        OnClick = RadioGroup1Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Jpg/Jpeg'
      ImageIndex = 1
      object Label1: TLabel
        Left = 13
        Top = 164
        Width = 103
        Height = 15
        Caption = 'Compress Qualitiy :'
      end
      object Label2: TLabel
        Left = 260
        Top = 185
        Width = 19
        Height = 15
        Caption = '0 %'
      end
      object ScrollBar1: TScrollBar
        Left = 13
        Top = 185
        Width = 225
        Height = 17
        Min = 1
        PageSize = 0
        Position = 1
        TabOrder = 0
        OnChange = ScrollBar1Change
      end
      object CheckBox7: TCheckBox
        Left = 13
        Top = 22
        Width = 74
        Height = 17
        Caption = 'Grayscale'
        TabOrder = 1
        OnClick = CheckBox7Click
      end
      object CheckBox8: TCheckBox
        Left = 13
        Top = 45
        Width = 87
        Height = 17
        Caption = 'Smoothing'
        TabOrder = 2
        OnClick = CheckBox8Click
      end
      object CheckBox9: TCheckBox
        Left = 13
        Top = 68
        Width = 74
        Height = 17
        Caption = 'Modified'
        TabOrder = 3
        OnClick = CheckBox9Click
      end
      object CheckBox10: TCheckBox
        Left = 13
        Top = 91
        Width = 125
        Height = 17
        Caption = 'Progressive Display'
        TabOrder = 4
        OnClick = CheckBox10Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = ' GIF'
      ImageIndex = 2
      object Label4: TLabel
        Left = 13
        Top = 115
        Width = 97
        Height = 15
        Caption = 'Color Reductions :'
      end
      object Label5: TLabel
        Left = 38
        Top = 144
        Width = 72
        Height = 15
        Caption = 'Dither Mode :'
      end
      object CheckBox11: TCheckBox
        Left = 13
        Top = 22
        Width = 85
        Height = 17
        Caption = 'Tranzaprent'
        TabOrder = 0
        OnClick = CheckBox11Click
      end
      object ComboBox2: TComboBox
        Left = 118
        Top = 112
        Width = 145
        Height = 23
        Style = csDropDownList
        DropDownCount = 10
        TabOrder = 1
        OnChange = ComboBox2Change
        Items.Strings = (
          'Windows20'
          'Windows256'
          'WindowsGray'
          'Monochrome'
          'GrayScale'
          'Netscape'
          'Quantize'
          'QuantizeWindows'
          'Palette      ')
      end
      object ComboBox3: TComboBox
        Left = 118
        Top = 141
        Width = 145
        Height = 23
        Style = csDropDownList
        TabOrder = 2
        OnChange = ComboBox3Change
        Items.Strings = (
          'Nearest'
          'FloydSteinberg'
          'Stucki'
          'Sierra'
          'JaJuN'
          'SteveArche'
          'Burkes'
          'Nonne')
      end
      object CheckBox12: TCheckBox
        Left = 13
        Top = 45
        Width = 78
        Height = 17
        Caption = 'Compress'
        TabOrder = 3
        OnClick = CheckBox12Click
      end
    end
    object TabSheet4: TTabSheet
      Caption = ' Png '
      ImageIndex = 3
      object Label6: TLabel
        Left = 13
        Top = 164
        Width = 103
        Height = 15
        Caption = 'Compress Qualitiy :'
      end
      object Label7: TLabel
        Left = 256
        Top = 186
        Width = 19
        Height = 15
        Caption = '0 %'
      end
      object CheckBox13: TCheckBox
        Left = 13
        Top = 22
        Width = 85
        Height = 17
        Caption = 'Tranzparent'
        TabOrder = 0
        OnClick = CheckBox13Click
      end
      object CheckBox14: TCheckBox
        Left = 13
        Top = 45
        Width = 70
        Height = 17
        Caption = 'Modified'
        TabOrder = 1
        OnClick = CheckBox14Click
      end
      object ScrollBar2: TScrollBar
        Left = 13
        Top = 185
        Width = 224
        Height = 17
        Max = 9
        Min = 1
        PageSize = 0
        Position = 1
        TabOrder = 2
        OnChange = ScrollBar2Change
      end
    end
    object TabSheet5: TTabSheet
      Caption = ' Icon '
      ImageIndex = 4
      object Label3: TLabel
        Left = 13
        Top = 146
        Width = 89
        Height = 15
        Caption = 'Icon Dimension :'
      end
      object ComboBox1: TComboBox
        Left = 112
        Top = 143
        Width = 123
        Height = 23
        Style = csDropDownList
        TabOrder = 0
        OnChange = ComboBox1Change
        Items.Strings = (
          '8x8'
          '16x16'
          '32x32'
          '48x48'
          '64x64'
          '128x128'
          '256x256')
      end
      object CheckBox15: TCheckBox
        Left = 13
        Top = 22
        Width = 85
        Height = 17
        Caption = 'Tranzparent'
        TabOrder = 1
        OnClick = CheckBox15Click
      end
      object CheckBox16: TCheckBox
        Left = 13
        Top = 45
        Width = 178
        Height = 17
        Caption = 'Supports Partial Transparency'
        TabOrder = 2
        OnClick = CheckBox16Click
      end
      object CheckBox17: TCheckBox
        Left = 13
        Top = 68
        Width = 71
        Height = 17
        Caption = 'Modified'
        TabOrder = 3
        OnClick = CheckBox17Click
      end
    end
  end
  object Button1: TButton
    Left = 215
    Top = 270
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 21
    Top = 270
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 2
    OnClick = Button2Click
  end
end
