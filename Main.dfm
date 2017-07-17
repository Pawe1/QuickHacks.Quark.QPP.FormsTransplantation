object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Forms transplantation tool'
  ClientHeight = 380
  ClientWidth = 505
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
    505
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
  object GroupBox2: TGroupBox
    Left = 8
    Top = 8
    Width = 113
    Height = 55
    Caption = 'Settings'
    TabOrder = 1
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
  object Memo1: TMemo
    Left = 8
    Top = 228
    Width = 488
    Height = 144
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      '[ LOG ]')
    TabOrder = 2
    ExplicitWidth = 555
  end
  object PageControl1: TPageControl
    Left = 191
    Top = 16
    Width = 218
    Height = 194
    ActivePage = TabSheet1
    TabOrder = 3
    object TabSheet1: TTabSheet
      Caption = '1. Download'
      ExplicitLeft = 12
      ExplicitTop = 39
      ExplicitWidth = 351
      ExplicitHeight = 324
      object LabeledEdit4: TLabeledEdit
        Left = 20
        Top = 37
        Width = 173
        Height = 21
        EditLabel.Width = 45
        EditLabel.Height = 13
        EditLabel.Caption = 'Workflow'
        TabOrder = 0
      end
      object LabeledEdit5: TLabeledEdit
        Left = 20
        Top = 82
        Width = 173
        Height = 21
        EditLabel.Width = 64
        EditLabel.Height = 13
        EditLabel.Caption = 'Content type'
        Enabled = False
        TabOrder = 1
        Visible = False
      end
      object Button1: TButton
        Left = 20
        Top = 123
        Width = 173
        Height = 25
        Caption = 'Download'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = Button1Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = '2. Sanitize'
      ImageIndex = 1
      ExplicitTop = 18
      ExplicitWidth = 281
      ExplicitHeight = 165
      object Button3: TButton
        Left = 16
        Top = 75
        Width = 177
        Height = 25
        Caption = 'Sanitize XML'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = Button3Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = '3. Upload'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitWidth = 351
      ExplicitHeight = 324
      object Button2: TButton
        Left = 16
        Top = 77
        Width = 177
        Height = 25
        Caption = 'Upload'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = Button2Click
      end
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '*.xml'
    Filter = 'XML|*.xml'
    Left = 432
    Top = 8
  end
  object OpenDialog: TOpenDialog
    DefaultExt = '*.xml'
    Filter = 'XML|*.xml'
    Left = 432
    Top = 56
  end
  object NetHTTPClient: TNetHTTPClient
    Asynchronous = False
    ConnectionTimeout = 60000
    ResponseTimeout = 60000
    AllowCookies = True
    HandleRedirects = True
    UserAgent = 'Embarcadero URI Client/1.0'
    Left = 432
    Top = 112
  end
  object NetHTTPRequest: TNetHTTPRequest
    Asynchronous = False
    ConnectionTimeout = 60000
    ResponseTimeout = 60000
    Client = NetHTTPClient
    OnRequestCompleted = NetHTTPRequestRequestCompleted
    OnRequestError = NetHTTPRequestRequestError
    Left = 432
    Top = 160
  end
end
