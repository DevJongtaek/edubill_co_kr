VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   6540
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9900
   LinkTopic       =   "Form1"
   ScaleHeight     =   6540
   ScaleWidth      =   9900
   StartUpPosition =   3  'Windows 기본값
   Begin VB.TextBox txtMiMoney 
      Height          =   375
      Left            =   5040
      TabIndex        =   14
      Text            =   "1000"
      Top             =   1440
      Width           =   1215
   End
   Begin VB.TextBox txtYoMoney 
      Height          =   375
      Left            =   1800
      TabIndex        =   12
      Text            =   "10000000"
      Top             =   1440
      Width           =   1215
   End
   Begin VB.TextBox txtSubCode 
      Height          =   375
      Left            =   5040
      TabIndex        =   10
      Text            =   "0171"
      Top             =   960
      Width           =   1215
   End
   Begin VB.TextBox txtMainCode 
      Height          =   375
      Left            =   1800
      TabIndex        =   8
      Text            =   "2201"
      Top             =   960
      Width           =   1215
   End
   Begin MSWinsockLib.Winsock Winsock1 
      Left            =   9360
      Top             =   120
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin VB.CommandButton Command3 
      Caption         =   "여신금전송"
      Height          =   375
      Left            =   6720
      TabIndex        =   7
      Top             =   480
      Width           =   2535
   End
   Begin VB.CommandButton Command2 
      Caption         =   "접속종료"
      Height          =   375
      Left            =   8040
      TabIndex        =   6
      Top             =   0
      Width           =   1215
   End
   Begin VB.TextBox txtPort 
      Height          =   375
      Left            =   1800
      TabIndex        =   5
      Text            =   "21101"
      Top             =   360
      Width           =   1215
   End
   Begin VB.TextBox txtIP 
      Height          =   375
      Left            =   1800
      TabIndex        =   4
      Text            =   "61.98.130.212"
      Top             =   0
      Width           =   2055
   End
   Begin VB.CommandButton Command1 
      Caption         =   "접속"
      Height          =   375
      Left            =   6720
      TabIndex        =   3
      Top             =   0
      Width           =   1215
   End
   Begin VB.ListBox lstLog 
      Height          =   4380
      Left            =   0
      TabIndex        =   0
      Top             =   1920
      Width           =   9855
   End
   Begin VB.Label Label1 
      Alignment       =   1  '오른쪽 맞춤
      Caption         =   "미수금"
      Height          =   255
      Index           =   5
      Left            =   3360
      TabIndex        =   15
      Top             =   1560
      Width           =   1455
   End
   Begin VB.Label Label1 
      Alignment       =   1  '오른쪽 맞춤
      Caption         =   "여신금"
      Height          =   255
      Index           =   4
      Left            =   120
      TabIndex        =   13
      Top             =   1560
      Width           =   1455
   End
   Begin VB.Label Label1 
      Alignment       =   1  '오른쪽 맞춤
      Caption         =   "체인점코드"
      Height          =   255
      Index           =   3
      Left            =   3360
      TabIndex        =   11
      Top             =   1080
      Width           =   1455
   End
   Begin VB.Label Label1 
      Alignment       =   1  '오른쪽 맞춤
      Caption         =   "본사코드"
      Height          =   255
      Index           =   2
      Left            =   120
      TabIndex        =   9
      Top             =   1080
      Width           =   1455
   End
   Begin VB.Label Label1 
      Alignment       =   1  '오른쪽 맞춤
      Caption         =   "PORT"
      Height          =   255
      Index           =   1
      Left            =   120
      TabIndex        =   2
      Top             =   480
      Width           =   1455
   End
   Begin VB.Label Label1 
      Alignment       =   1  '오른쪽 맞춤
      Caption         =   "IP"
      Height          =   255
      Index           =   0
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   1455
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
    Call Winsock1.Connect(txtIP.Text, CLng(txtPort.Text))
End Sub

Private Sub Command2_Click()
    Call Winsock1.Close
End Sub

Private Sub Command3_Click()
    Dim strPacket As String
    
    
    strPacket = Chr(&H2)                                    'STX
    strPacket = strPacket & "0076"                          '길이
    strPacket = strPacket & "001"                           'CMD_TYPE
    strPacket = strPacket & "000"                           '응답코드
    strPacket = strPacket & txtMainCode.Text & String(20 - Len(txtMainCode.Text), " ")        '본사코드
    strPacket = strPacket & txtSubCode.Text & String(20 - Len(txtSubCode.Text), " ")          '체인점코드
    strPacket = strPacket & Format(txtYoMoney.Text, "000000000000")    '여신금액
    strPacket = strPacket & Format(txtMiMoney.Text, "000000000000")    '미수금액
    strPacket = strPacket & Chr(&H3)                        'ETX
    
    Call Winsock1.SendData(strPacket)
    Call lstLog.AddItem(getDateTime() & "[데이터전송]='" & strPacket & "'")
End Sub

Private Sub Winsock1_Close()
    Call Winsock1.Close
    Call lstLog.AddItem(getDateTime() & "[접속종료]")
End Sub

Private Sub Winsock1_Connect()
    Call lstLog.AddItem(getDateTime() & "[연결]" & Winsock1.RemoteHostIP & ":" & CStr(Winsock1.RemotePort))
End Sub

Private Sub Winsock1_DataArrival(ByVal bytesTotal As Long)
    Dim strPacket As String
    
    Call Winsock1.GetData(strPacket, vbString)
    Call lstLog.AddItem(getDateTime() & "[데이터수신]='" & strPacket & "'")
End Sub

Public Function getDateTime() As String
    getDateTime = "[" & Format(Now, "hh:nn:ss") & "]"
End Function



