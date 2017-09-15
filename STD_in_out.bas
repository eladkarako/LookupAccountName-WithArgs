Attribute VB_Name = "Module_STD_in_out"
'==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-=='
'==-==- Use any of the 2 functions down here, remember to use the             -=='
'==-==- reLink shortcut, this will enable you to access Standard in and out   -=='
'==-==- Stream.                                                               -=='
'==-==-                                                                       -=='
'==-==-    1. add module STD_in_out.bas to vb project.                        -=='
'==-==-    2. work, use the ReadStdIn and WriteStdOut as you needed.          -=='
'==-==-    3. save project, make exe.                                         -=='
'==-==-    4. patch (relink) project exe with shortcut                        -=='
'==-==-    ("C:\Program Files\Microsoft Visual Studio\vb98\LINK.EXE"          -=='
'==-==-                 /EDIT /SUBSYSTEM:CONSOLE <yourfile.exe>)              -=='
'==-==-       ("patch" is simply dropping exe on the reLink shortcut.         -=='
'==-==-    5. your exe will work now.                                         -=='
'==-==-                                             Created By Elad Karako    -=='
'==-==-                                             2008. Israel.             -=='
'==-==-                                                                       -=='
'==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-=='

Private Declare Function GetStdHandle Lib "kernel32" (ByVal nStdHandle As Long) As Long
Private Declare Function ReadFile Lib "kernel32" (ByVal hFile As Long, lpBuffer As Any, ByVal nNumberOfBytesToRead As Long, lpNumberOfBytesRead As Long, lpOverlapped As Any) As Long
Private Declare Function WriteFile Lib "kernel32" (ByVal hFile As Long, lpBuffer As Any, ByVal nNumberOfBytesToWrite As Long, lpNumberOfBytesWritten As Long, lpOverlapped As Any) As Long
Private Const STD_OUTPUT_HANDLE = -11&
Private Const STD_INPUT_HANDLE = -10&


Public Function ReadStdIn(Optional ByVal NumBytes As Long = -1) As String
    Dim StdIn As Long
    Dim Result As Long
    Dim Buffer As String
    Dim BytesRead As Long
    StdIn = GetStdHandle(STD_INPUT_HANDLE)
    Buffer = Space$(1024)
    Do
        Result = ReadFile(StdIn, ByVal Buffer, Len(Buffer), BytesRead, ByVal 0&)
        If Result = 0 Then
            Err.Raise 1001, , "Unable to read from standard input"
        End If
        ReadStdIn = ReadStdIn & Left$(Buffer, BytesRead)
    Loop Until BytesRead < Len(Buffer)
End Function

Public Sub WriteStdOut(ByVal Text As String)
    Dim StdOut As Long
    Dim Result As Long
    Dim BytesWritten As Long
    StdOut = GetStdHandle(STD_OUTPUT_HANDLE)
    Result = WriteFile(StdOut, ByVal Text, Len(Text), BytesWritten, ByVal 0&)
    If Result = 0 Then
        Err.Raise 1001, , "Unable to write to standard output"
    ElseIf BytesWritten < Len(Text) Then
        Err.Raise 1002, , "Incomplete write operation"
    End If
End Sub
