Use Windows.pkg
Use DFClient.pkg

Use cCredentialManager.pkg

Deferred_View Activate_oProtectStringView for ;
Object oProtectStringView is a dbView
    Set Border_Style to Border_Thick
    Set Size to 85 300
    Set Location to 2 2
    Set Label to "Protect String"

    Object oPlainTextForm is a Form
        Set Location to 5 50
        Set Size to 13 188
        Set Label to "Plain text:"
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to JMode_Right
        Set peAnchors to anTopLeftRight
    End_Object
    
    Object oCredentialManager is a cCredentialManager
    End_Object

    Object oProtectButton is a Button
        Set Location to 20 50
        Set Label to "Protect"
    
        Procedure OnClick
            String sPlainText sProtectedText
            
            Get Value of oPlainTextForm to sPlainText
            Get ProtectPlainText of oCredentialManager sPlainText to sProtectedText
            Set Value of oProtectedValueForm to sProtectedText
        End_Procedure    
    End_Object

    Object oProtectedValueForm is a Form
        Set Location to 36 50
        Set Size to 13 188
        Set peAnchors to anTopLeftRight
        Set Label to "Protected:"
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to JMode_Right
    End_Object

    Object oCheckButton is a Button
        Set Location to 36 243
        Set Label to "Check"
        Set peAnchors to anTopRight
    
        Procedure OnClick
            String sValue
            Boolean bIsProtected
            
            Get Value of oProtectedValueForm to sValue
            Get IsCredentialProtected of oCredentialManager sValue to bIsProtected
            If (bIsProtected) Begin
                Send Info_Box "Value is protected"
            End
            Else Begin
                Send Info_Box "Value is NOT protected"
            End
        End_Procedure    
    End_Object

    Object oUnProtectButton is a Button
        Set Location to 51 50
        Set Label to "Unprotect"
    
        Procedure OnClick
            String sPlainText sProtectedText
            
            Get Value of oProtectedValueForm to sProtectedText
            Get UnProtectValue of oCredentialManager sProtectedText to sPlainText
            Set Value of oUnprotectedForm to sPlainText
        End_Procedure    
    End_Object

    Object oUnprotectedForm is a Form
        Set Location to 67 50
        Set Size to 13 188
        Set peAnchors to anTopLeftRight
        Set Label to "Unprotected:"
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to JMode_Right
    End_Object
Cd_End_Object
