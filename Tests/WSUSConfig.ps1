Configuration TestWSUS {
    
    Import-DscResource -modulename cMicrosoftUpdate
 
    Node localhost {
        
        cWSUSEnable WSUSEnable {
            Enable = "True"
        }
 
        cWSUSSetServer WSUSServer {
            Url = "http://127.0.0.1:8080"
            Ensure = "Present"
        }
 
        cWSUSSetTargetGroup TargetGroupDMZ {
            TargetGroup = "DMZPrivate"
            Ensure = "Present"
        }
 
        cWSUSUpdateMode WSUSMode {
            Mode = "Notify"
        }
 
        cWSUSWindowsUpdateAccess WSUSNoAccess {
               Enable = "False"
        }
    }
}
 sl
 TestWSUS