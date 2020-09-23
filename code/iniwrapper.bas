Attribute VB_Name = "iniwrapper"
Declare Function WritePrivateProfileString Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationname As String, ByVal lpKeyName As Any, ByVal lsString As Any, ByVal lplFilename As String) As Long
Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationname As String, ByVal lpKeyName As String, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long

Public Function loadINI(INIPath As String, ININame As String, KeySection As String, KeyKey As String) As String

Dim lngResult As Long
Dim strFileName
Dim strResult As String * 50

strFileName = App.Path & "\" & INIPath & "\" & ININame & ".ini" 'Declare your ini file !
lngResult = GetPrivateProfileString(KeySection, KeyKey, strFileName, strResult, Len(strResult), strFileName)

If lngResult = 0 Then

    'An error has occurred
    'Call MsgBox("An error has occurred while calling the API function", vbExclamation)
    
Else

    loadINI = Trim(strResult)

End If

End Function

Public Function saveINI(INIPath As String, ININame As String, KeySection As String, KeyKey As String, KeyValue As String) As String

Dim lngResult As Long
Dim strFileName

strFileName = App.Path & "\" & INIPath & "\" & ININame & ".ini" 'Declare your ini file !
lngResult = WritePrivateProfileString(KeySection, KeyKey, KeyValue, strFileName)

If lngResult = 0 Then

    'An error has occurred
    'Call MsgBox("An error has occurred while calling the API function", vbExclamation)

End If

End Function

