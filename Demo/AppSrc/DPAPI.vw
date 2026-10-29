Use Windows.pkg
Use DFClient.pkg
Use cTextEdit.pkg

Use cDPAPI.pkg

Deferred_View Activate_oDPAPIView for ;
Object oDPAPIView is a dbView
    Set Border_Style to Border_Thick
    Set Size to 145 401
    Set Location to 2 2
    Set Label to "DPAPI"
    Object oDPAPI is a cDPAPI
    End_Object

    Object oDataToEncryptForm is a Form
        Set Location to 5 70
        Set Size to 13 325
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to JMode_Right
        Set Label to "Data to encrypt"
        Set peAnchors to anTopLeftRight
    End_Object

    Object oDescriptionForm is a Form
        Set Location to 20 70
        Set Size to 13 325
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to JMode_Right
        Set Label to "Description"
        Set peAnchors to anTopLeftRight
    End_Object

    Object oEncryptButton is a Button
        Set Location to 35 70
        Set Label to 'Encrypt'
    
        Procedure OnClick
            String sDataToEncrypt sDescription sResult
            
            Get Value of oDataToEncryptForm to sDataToEncrypt
            Get Value of oDescriptionForm to sDescription
            
            Get EncryptString of oDPAPI sDataToEncrypt sDescription to sResult
            Set Value of oEncryptedResultTextEdit to sResult
        End_Procedure    
    End_Object

    Object oEncryptedResultTextEdit is a cTextEdit
        Set Location to 51 70
        Set Size to 44 325
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to JMode_Right
        Set Label to "Encrypt Result"
        Set peAnchors to anTopLeftRight
    End_Object

    Object oDecryptButton is a Button
        Set Location to 97 70
        Set Label to 'Decrypt'
    
        Procedure OnClick
            String sDataToDecrypt sDescription 
            String[] sResults
            
            Get Value of oEncryptedResultTextEdit to sDataToDecrypt
            
            Get DecryptData of oDPAPI sDataToDecrypt to sResults
            If (SizeOfArray (sResults) > 0) Begin
                Set Value of oDecryptedResultForm to sResults[0]
                Set Value of oDecryptedDescriptionForm to sResults[1]
            End
        End_Procedure    
    End_Object

    Object oDecryptedResultForm is a Form
        Set Location to 113 70
        Set Size to 13 325
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to JMode_Right
        Set Label to "Decrypted Result"
        Set peAnchors to anTopLeftRight
    End_Object

    Object oDecryptedDescriptionForm is a Form
        Set Location to 128 70
        Set Size to 13 325
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to JMode_Right
        Set Label to "Decrypted Descr"
        Set peAnchors to anTopLeftRight
    End_Object
Cd_End_Object
