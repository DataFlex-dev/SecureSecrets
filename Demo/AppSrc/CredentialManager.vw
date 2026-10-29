Use Windows.pkg
Use DFClient.pkg

Use AdvApi.h.pkg
Use GlobalFunctionsProcedures.pkg
Use cCredentialManager.pkg

Deferred_View Activate_oCredentialManagerView for ;
Object oCredentialManagerView is a dbView
    Set Border_Style to Border_Thick
    Set Size to 103 241
    Set Location to 2 2
    Set Label to "Credential Manager"

    Object oCredentialManager is a cCredentialManager
        Procedure OnCredentialWrite Integer iError String sErrorMessage
            Forward Send OnCredentialWrite iError sErrorMessage

            If (iError = NO_ERROR) Begin
                Send Info_Box "Credential Written"
            End
            Else Begin
                Error DFERR_PROGRAM (SFormat ("Writing Credential Failed. Error: %1, %2", iError, sErrorMessage))
            End
        End_Procedure

        Procedure OnCredentialDelete Integer iError String sErrorMessage
            Forward Send OnCredentialDelete iError sErrorMessage

            If (iError = NO_ERROR) Begin
                Send Info_Box "Credential Deleted"
            End
            Else Begin
                Error DFERR_PROGRAM (SFormat ("Delete Credential Failed. Error: %1, %2", iError, sErrorMessage))
            End
        End_Procedure

        Procedure OnCredentialRename Integer iError String sErrorMessage
            Forward Send OnCredentialRename iError sErrorMessage

            If (iError = NO_ERROR) Begin
                Send Info_Box "Credential Renamed"
            End
            Else Begin
                Error DFERR_PROGRAM (SFormat ("Rename Credential Failed. Error: %1, %2", iError, sErrorMessage))
            End
        End_Procedure

        Procedure OnCredentialReadError Integer iError String sErrorMessage
            Forward Send OnCredentialReadError iError sErrorMessage

            Error DFERR_PROGRAM (SFormat ("Read Credential Failed. Error: %1, %2", iError, sErrorMessage))
        End_Procedure
    End_Object

    Object oTargetForm is a Form
        Set Location to 5 75
        Set Size to 13 100
        Set Label to "Target"
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to JMode_Right
        Set Form_Margin to CRED_MAX_GENERIC_TARGET_NAME_LENGTH
        Set peAnchors to anTopLeftRight
    End_Object

    Object oLifeSpanComboForm is a ComboForm
        Set Location to 20 75
        Set Size to 13 100
        Set Label to "LifeSpan"
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to JMode_Right
        Set Entry_State to False
        Set Combo_Sort_State to False
        Set peAnchors to anTopLeftRight
    
        Procedure Combo_Fill_List
            Integer dwPersist
            String sValue
            
            Send Combo_Add_Item "None"
            Send Combo_Add_Item "Session"
            Send Combo_Add_Item "Local Machine"
            
            Get pdwPersists of oCredentialManager to dwPersist
            Get Combo_Value dwPersist to sValue
            Set Value to sValue
        End_Procedure
        
        Procedure OnChange
            String sValue
            Integer iItem
            
            Get Value to sValue
            Get Combo_Item_Matching sValue to iItem
            Set pdwPersists of oCredentialManager to iItem
        End_Procedure
    End_Object

    Object oSecretToWriteForm is a Form
        Set Location to 35 75
        Set Size to 13 100
        Set Label to "Secret to write"
        Set Label_Justification_Mode to JMode_Right
        Set Label_Col_Offset to 2
        Set Form_Margin to CRED_MAX_CREDENTIAL_BLOB_SIZE
        Set peAnchors to anTopLeftRight
    End_Object

    Object oWriteButton is a Button
        Set Location to 35 180
        Set Label to 'Write'
        Set peAnchors to anTopRight

        Procedure OnClick
            String sTarget sSecret

            Get Value of oTargetForm to sTarget
            Get Value of oSecretToWriteForm to sSecret

            Set psTargetName of oCredentialManager to sTarget
            Send WriteSecret of oCredentialManager sSecret
        End_Procedure
    End_Object

    Object oReadCredentialButton is a Button
        Set Location to 50 180
        Set Label to 'Read'
        Set peAnchors to anTopRight

        Procedure OnClick
            String sTarget sSecret

            Get Value of oTargetForm to sTarget
            Set psTargetName of oCredentialManager to sTarget
            Get ReadSecret of oCredentialManager to sSecret
            Set Value of oReadCredentialResultsForm to sSecret
        End_Procedure
    End_Object

    Object oReadCredentialResultsForm is a Form
        Set Location to 50 75
        Set Size to 13 100
        Set Label to "Credential read back"
        Set Label_Justification_Mode to JMode_Right
        Set Label_Col_Offset to 2
        Set peAnchors to anTopLeftRight
    End_Object

    Object oDeleteCredentialButton is a Button
        Set Location to 65 75
        Set Label to 'Delete Credential'
        Set Size to 14 100
        Set peAnchors to anTopLeftRight

        Procedure OnClick
            String sTarget

            Get Value of oTargetForm to sTarget
            Set psTargetName of oCredentialManager to sTarget
            Send DeleteSecret of oCredentialManager
        End_Procedure
    End_Object

    Object oNewTargetForm is a Form
        Set Location to 81 75
        Set Size to 13 100
        Set Label to "New Target"
        Set Label_Col_Offset to 2
        Set Label_Justification_Mode to JMode_Right
        Set peAnchors to anTopLeftRight
    End_Object

    Object oRenameCredentialButton is a Button
        Set Location to 81 180
        Set Label to "Rename"
        Set peAnchors to anTopRight

        Procedure OnClick
            String sOldTarget sNewTarget
            Boolean bOk

            Get Value of oTargetForm to sOldTarget
            Get Value of oNewTargetForm to sNewTarget
            Set psTargetName of oCredentialManager to sOldTarget
            Send RenameSecret of oCredentialManager sNewTarget
        End_Procedure
    End_Object
Cd_End_Object
