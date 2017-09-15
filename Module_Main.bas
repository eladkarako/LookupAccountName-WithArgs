Attribute VB_Name = "Module_Main"
Private Declare Function LookupAccountName Lib "advapi32.dll" Alias "LookupAccountNameA" (ByVal lpSystemName As String, ByVal lpAccountName As String, ByVal Sid As String, ByRef cbSid As Long, ByVal ReferencedDomainName As String, ByRef cbReferencedDomainName As Long, ByRef peUse As Long) As Long
Private Declare Function IsValidSid Lib "advapi32.dll" (ByRef pSid As Any) As Long
Private Declare Function ConvertSidToStringSid Lib "advapi32.dll" Alias "ConvertSidToStringSidA" (ByVal Sid As String, ByRef lpStringSid As Long) As Long
Private Declare Sub CopyMemory Lib "kernel32.dll" Alias "RtlMoveMemory" (ByRef Destination As Any, ByRef Source As Any, ByVal length As Long)
Private Declare Function GlobalFree Lib "kernel32.dll" (ByVal hMem As Long) As Long
 
 
Private Function get_sid(lpSystemName As String, lpAccountName As String) As String
  On Error Resume Next
  get_sid = ""

  Dim Sid As String
  Dim Domain As String
  Dim peUse As Long
  
  Dim sResult_DOMAIN As String
  Dim sResult_SID As String
   
  Sid = String$(255, 0&)
  Domain = String$(255, 0&)
  sResult_DOMAIN = String$(255, 0&)
  sResult_SID = String$(255, 0&)
  
  Call LookupAccountName(lpSystemName, lpAccountName, Sid, 255, Domain, 255, peUse)
  If (IsValidSid(ByVal Sid) = 0&) Then Exit Function
  
  Call ConvertSidToStringSid(Sid, peUse)
  Call CopyMemory(ByVal sResult_SID, ByVal peUse, 255)
  
  sResult_DOMAIN = Left$(Domain, InStr(vbNull, Domain, vbNullChar, vbBinaryCompare) - vbNull)
  sResult_SID = Left$(sResult_SID, InStr(vbNull, sResult_SID, vbNullChar, vbBinaryCompare) - vbNull)
  Call GlobalFree(peUse)
  
  get_sid = sResult_SID & "," & sResult_DOMAIN
End Function


Private Function get_sid_witharg()
  On Error Resume Next
  get_sid_witharg = ""
  
  Dim s As String
  s = Command$
  s = Replace(s, Chr$(34), "")
  s = Replace(s, Chr$(39), "")
  
  
  Dim args() As String
  args = Split(s)

  Dim username As String
  username = ""
  username = args(0)

  
  If username = "" Then Exit Function
  
  
  Dim machinename As String
  machinename = ""
  machinename = args(1)
  If machinename = "" Then machinename = vbNullString


  Dim modes As String
  modes = 0
  modes = args(2)
  '0 comma
  '1 just sid
  '2 just domain


  Dim answer As String
  answer = get_sid(machinename, username)
  get_sid_witharg = answer
  
  Dim tmp() As String
  tmp = Split(answer, ",")
  If modes = "1" Then get_sid_witharg = tmp(0)
  If modes = "2" Then get_sid_witharg = tmp(1)

End Function

Public Sub Main()
  'MsgBox "input " + Command$
  'MsgBox get_sid_witharg()

 WriteStdOut get_sid_witharg()
End Sub

