object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Forms transplantation tool'
  ClientHeight = 380
  ClientWidth = 572
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    572
    380)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 69
    Width = 153
    Height = 153
    Caption = 'QPP server'
    TabOrder = 0
    object LabeledEdit1: TLabeledEdit
      Left = 16
      Top = 32
      Width = 121
      Height = 21
      EditLabel.Width = 69
      EditLabel.Height = 13
      EditLabel.Caption = 'Address : Port'
      TabOrder = 0
    end
    object LabeledEdit2: TLabeledEdit
      Left = 16
      Top = 72
      Width = 121
      Height = 21
      EditLabel.Width = 25
      EditLabel.Height = 13
      EditLabel.Caption = 'Login'
      TabOrder = 1
    end
    object LabeledEdit3: TLabeledEdit
      Left = 16
      Top = 112
      Width = 121
      Height = 21
      EditLabel.Width = 46
      EditLabel.Height = 13
      EditLabel.Caption = 'Password'
      PasswordChar = #8226
      TabOrder = 2
    end
  end
  object Button1: TButton
    Left = 216
    Top = 99
    Width = 75
    Height = 25
    Caption = 'Download'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 481
    Top = 27
    Width = 75
    Height = 25
    Caption = 'Upload'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 435
    Top = 179
    Width = 129
    Height = 25
    Caption = 'Sanitize XML'
    TabOrder = 3
    OnClick = Button3Click
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 113
    Height = 55
    Caption = 'Settings'
    TabOrder = 4
    object Button5: TButton
      Left = 59
      Top = 19
      Width = 43
      Height = 25
      Caption = 'Save'
      TabOrder = 0
      OnClick = Button5Click
    end
    object Button4: TButton
      Left = 10
      Top = 19
      Width = 43
      Height = 25
      Caption = 'Load'
      TabOrder = 1
      OnClick = Button4Click
    end
  end
  object LabeledEdit4: TLabeledEdit
    Left = 216
    Top = 30
    Width = 121
    Height = 21
    EditLabel.Width = 45
    EditLabel.Height = 13
    EditLabel.Caption = 'Workflow'
    TabOrder = 5
  end
  object LabeledEdit5: TLabeledEdit
    Left = 216
    Top = 72
    Width = 121
    Height = 21
    EditLabel.Width = 64
    EditLabel.Height = 13
    EditLabel.Caption = 'Content type'
    Enabled = False
    TabOrder = 6
    Visible = False
  end
  object Memo1: TMemo
    Left = 8
    Top = 228
    Width = 555
    Height = 144
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      '[ LOG ]')
    TabOrder = 7
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '*.xml'
    Filter = 'XML|*.xml'
    Left = 168
    Top = 8
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '*.xml'
    Filter = 'XML|*.xml'
    Left = 168
    Top = 56
  end
  object NetHTTPClient: TNetHTTPClient
    Asynchronous = False
    ConnectionTimeout = 60000
    ResponseTimeout = 60000
    AllowCookies = True
    HandleRedirects = True
    UserAgent = 'Embarcadero URI Client/1.0'
    Left = 488
    Top = 88
  end
  object NetHTTPRequest: TNetHTTPRequest
    Asynchronous = False
    ConnectionTimeout = 60000
    ResponseTimeout = 60000
    Client = NetHTTPClient
    OnRequestCompleted = NetHTTPRequestRequestCompleted
    OnRequestError = NetHTTPRequestRequestError
    Left = 376
    Top = 88
  end
end
