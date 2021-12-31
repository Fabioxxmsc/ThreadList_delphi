object frmMenu: TfrmMenu
  Left = 0
  Top = 0
  Caption = 'Menu'
  ClientHeight = 201
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonIniciar: TButton
    Left = 8
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Iniciar'
    TabOrder = 0
    OnClick = ButtonIniciarClick
  end
  object ButtonParar: TButton
    Left = 128
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Parar'
    TabOrder = 1
    OnClick = ButtonPararClick
  end
end
