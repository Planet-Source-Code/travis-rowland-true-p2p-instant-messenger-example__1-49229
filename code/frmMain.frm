VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form frmMain 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "P2P Messenger Example"
   ClientHeight    =   3135
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6855
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3135
   ScaleWidth      =   6855
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdSendHost 
      Caption         =   "Host"
      Height          =   375
      Left            =   1440
      TabIndex        =   13
      Top             =   1080
      Width           =   1215
   End
   Begin VB.ListBox lstHosts 
      Height          =   2595
      Left            =   5520
      TabIndex        =   11
      Top             =   360
      Width           =   1215
   End
   Begin VB.TextBox txtPort 
      Height          =   375
      Left            =   2760
      TabIndex        =   10
      Text            =   "4672"
      Top             =   840
      Width           =   1335
   End
   Begin VB.TextBox txtIP 
      Height          =   405
      Left            =   2760
      TabIndex        =   9
      Text            =   "127.0.0.1"
      Top             =   360
      Width           =   1335
   End
   Begin VB.TextBox txtMessages 
      Height          =   1215
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   6
      Top             =   1800
      Width           =   3975
   End
   Begin VB.CommandButton cmdBoot 
      Caption         =   "BOOT!"
      Height          =   375
      Left            =   2760
      TabIndex        =   5
      Top             =   1320
      Width           =   1335
   End
   Begin VB.CommandButton cmdSendClient 
      Caption         =   "Client"
      Height          =   375
      Left            =   120
      TabIndex        =   2
      Top             =   1080
      Width           =   1215
   End
   Begin VB.TextBox txtMessage 
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Top             =   360
      Width           =   2535
   End
   Begin VB.ListBox lstClients 
      Height          =   2595
      Left            =   4200
      TabIndex        =   0
      Top             =   360
      Width           =   1215
   End
   Begin MSWinsockLib.Winsock sckListen 
      Index           =   0
      Left            =   2760
      Top             =   1080
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin MSWinsockLib.Winsock sckConnect 
      Index           =   0
      Left            =   3240
      Top             =   1080
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin VB.Label Label6 
      Caption         =   "Send a message to the selected:"
      Height          =   255
      Left            =   120
      TabIndex        =   14
      Top             =   840
      Width           =   2535
   End
   Begin VB.Label Label5 
      Caption         =   "Hosts:"
      Height          =   255
      Left            =   5520
      TabIndex        =   12
      Top             =   120
      Width           =   1215
   End
   Begin VB.Label Label4 
      Caption         =   "BOOT IP and Port:"
      Height          =   255
      Left            =   2760
      TabIndex        =   8
      Top             =   120
      Width           =   1455
   End
   Begin VB.Label Label3 
      Caption         =   "Received Messages:"
      Height          =   255
      Left            =   120
      TabIndex        =   7
      Top             =   1560
      Width           =   2175
   End
   Begin VB.Label Label2 
      Caption         =   "Clients:"
      Height          =   255
      Left            =   4200
      TabIndex        =   4
      Top             =   120
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "Type your message here:"
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   2535
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'This is the variable that I use for "sleeping" the program, it allows you to pause the program
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Private Sub cmdBoot_Click()

Load sckConnect(sckConnect.UBound + 1)                      'Load a new socket, make it unique
sckConnect(sckConnect.UBound).RemoteHost = txtIP            'Set the socket remote IP to who you want to connect to
sckConnect(sckConnect.UBound).RemotePort = txtPort          'Set the socket remote port to the remote user's open port
sckConnect(sckConnect.UBound).Connect                       'Initiate the socket

lstHosts.AddItem sckConnect.UBound                          'Add the user to the active host list
lstHosts.ItemData(lstHosts.NewIndex) = sckConnect.UBound    'Give that user a unique index number in the list

End Sub

Private Sub cmdSendClient_Click()

If lstClients.Text = "" Then                                                                                                                'Make sure they have a client selected, or the program will crash

    MsgBox "SELECT A CLIENT!"                                                                                                               'Create the message box that tells them to select a client
    
Else

    txtMessages.SelText = "TO " & sckListen(lstClients.Text).RemoteHostIP & " (Client " & lstClients.Text & "): " & txtMessage & vbCrLf     'Update your messages box with the text you are sending
    sckListen(lstClients.Text).SendData txtMessage                                                                                          'Send the other person your message
    txtMessage = ""                                                                                                                         'Reset the text box so you don't have to erase every time you want to send a new message
    
End If

End Sub

Private Sub cmdSendHost_Click()

'The comments in the Sub above apply to this one as well, respectively

If lstHosts.Text = "" Then

    MsgBox "SELECT A HOST!"
    
Else

    txtMessages.SelText = "TO " & sckConnect(lstHosts.Text).RemoteHostIP & " (Host " & lstHosts.Text & "): " & txtMessage & vbCrLf
    sckConnect(lstHosts.Text).SendData txtMessage
    txtMessage = ""
    
End If

End Sub

Private Sub Form_Load()

Call saveINI("config", "p2p", "Working Variables", "P2PCount", "0")                     'Reset our known users count, so we can use the counter to load IP's from our IP file

sckListen(0).LocalPort = loadINI("config", "p2p", "Connection Settings", "LocalPort")   'Load the port from the ini file that we are going to listen on
sckListen(0).Listen                                                                     'Start listening for new connections so that we can allow people to connect to us

End Sub

Private Sub sckConnect_Close(Index As Integer)

For a = 0 To lstHosts.ListCount - 1         'Create a for loop so we can loop through all the users in the list box

    If lstHosts.ItemData(a) = Index Then    'Oh, we found the user who disconnected, let's remove them from the list box
    
        lstHosts.RemoveItem a               'This is where we actually remove them
        
    Exit For                                'Since we removed them, we do not need to look for them anymore, so terminate the for loop

    End If                                  'Exit the IF statement

Next                                        'We looked at one user in the list, they were not the one we were looking for, lets look some more

sckConnect(Index).Close                     'Let's make sure that we are not wastefully using a port, let's close it so that someone else can use it to connect to us

End Sub

Private Sub sckConnect_DataArrival(Index As Integer, ByVal bytesTotal As Long)

Dim strData As String                                                                                               'Create a new variable so that we can manipulate the received data

sckConnect(Index).GetData strData                                                                                   'Let's set the data that we just got to our variable so we can work with it
txtMessages.SelText = "FROM " & sckConnect(Index).RemoteHostIP & " (Client " & Index & "): " & strData & vbCrLf     'Of course the only data we are getting right now is text, so let's add the message to our messages box and read it

End Sub

Private Sub sckListen_Close(Index As Integer)

'The comments in Sub sckConnect_Close apply to this one as well, respectively

For a = 0 To lstClients.ListCount - 1

    If lstClients.ItemData(a) = Index Then
    
        lstClients.RemoveItem a
        
    Exit For

    End If

Next

sckListen(Index).Close

End Sub

Private Sub sckListen_ConnectionRequest(Index As Integer, ByVal requestID As Long)

Load sckListen(sckListen.UBound + 1)                                                                    'Someone wants to connect, let's load a new, unique winsock for them so they are able to
sckListen(sckListen.UBound).Accept requestID                                                            'Allow them to connect

lstClients.AddItem sckListen.UBound                                                                     'Add the user to our active client list
lstClients.ItemData(lstClients.NewIndex) = sckListen.UBound                                             'Give that user a unique index number in the list

Call Sleep(10)                                                                                          'We need to time out for a little bit to allow the winsock packets to be split up, so we can send some data
DoEvents                                                                                                'Just something extra, but handy - http://msdn.microsoft.com/library/default.asp?url=/library/en-us/vbcon98/html/vbconusingdoevents.asp

Dim strP2PCount As String                                                                               'Create a new variable to work with

strP2PCount = loadINI("config", "p2p", "Working Variables", "P2PCount")                                 'Load the number of IP's that we currently know so we can loop through our IP file and send the IP addresses individually to the person connecting so they know other people they need to connect to on the network

For i = 0 To strP2PCount                                                                                'Create a for loop so we can loop through the IP file

    If strP2PCount > 0 Then                                                                             'Make sure the number is not 0, because that is a waste of time
    
        Dim strResult As String                                                                         'Create a new variable that we will use to load the IP file data into
        
        Open App.Path & "\data\p2p.dat" For Random As #1                                                'Open our IP file and load the IP's that we know
        Get #1, strP2PCount, strResult                                                                  'Set our variable to the current IP that we are loading
        Close #1                                                                                        'Close the file so we are not hogging it from anyone else
        
        sckListen(sckListen.UBound).SendData strResult                                                  'Send the person that is connecting the IP that we just loaded
        
    Else                                                                                                'The number of IP's is 0
    
        Exit For                                                                                        'So we exit this, because it will be a waste of our time if we have no IP addresses to send
        
    End If                                                                                              'Exit the IF statement
    
    Call Sleep(10)                                                                                      'Hold up a bit so that the packets will be split, or else they will mash together and it will not look right for the recipient
    DoEvents                                                                                            'Something handy - http://msdn.microsoft.com/library/default.asp?url=/library/en-us/vbcon98/html/vbconusingdoevents.asp
    
Next i                                                                                                  'Continue with our loop until it is finished, so we can send the client all of the IP addresses that we know

strP2PCount = loadINI("config", "p2p", "Working Variables", "P2PCount")                                 'Load the IP counter again

strP2PCount = strP2PCount + 1                                                                           'Increment it by 1 because someone just connected to us, we know a new IP

Call saveINI("config", "p2p", "Working Variables", "P2PCount", strP2PCount)                             'Save the new IP count number

Dim strWrite As String                                                                                  'Create a new variable that we will use to write the new IP we know to our IP file

strWrite = sckListen(sckListen.UBound).RemoteHostIP & " " & sckListen(sckListen.UBound).RemotePort      'Set our write variable to the user's IP address and the port that they are using (this is not the port that they have open, I am just using the one they are connected to you on as an example so you can see how it would work)

Open App.Path & "\data\p2p.dat" For Random As #1                                                        'Open our IP file so we can write to it
Put #1, strP2PCount, strWrite                                                                           'Write the new IP we know along with the port so that we can give it out to everyone who connects to us from now on
Close #1                                                                                                'Close the file so we are not hogging it

End Sub

Private Sub sckListen_DataArrival(Index As Integer, ByVal bytesTotal As Long)

Dim strData As String                                                                                               'We have an incoming message from a connected client, make a variable for it

sckListen(Index).GetData strData                                                                                    'Set our new message to the variable we just created
txtMessages.SelText = "FROM " & sckListen(Index).RemoteHostIP & " (Client " & Index & "): " & strData & vbCrLf      'Update our messages box so we can read our new message

End Sub
