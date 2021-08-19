$IEXSession = [ordered]@{
    layer                  = -1
    maxLayer               = $null
    nodryrun               = $null
    Vars                   = $null
    filter                 = @("PS*", "_", "args", "Maximum*", "MyInvocation", "CurrentlyExecutingCommand", "input", "ofS", "Command", "NoDryRun", "filePath")
    FormatEnumerationLimit = Get-Variable FormatEnumerationLimit -ValueOnly
    outputDir              = "$HOME\Desktop"
    baseName               = $null
    outputPrefix           = 'IEXHuller'
    fromScript             = $null
}
New-Variable -Name IEXSession -Value $IEXSession -Scope Script -Force

function Show-Exception {
    <#
    .SYNOPSIS
        HELPER FUNCTION :: Displays the error message.

    .DESCRIPTION
        Show-Exception displays Built-in Invoke-Expression exception details.
    #>

    Write-Host "[x] " -NoNewLine -ForegroundColor Magenta
    Write-Host "Built-in IEX exception: $($PSItem.ToString())"
}

function Invoke-Expression {
    <#
    .SYNOPSIS
        Invoke-Expression hook via shadowing.

    .DESCRIPTION
        Introducing a new implementation of Invoke-Expression (PowerShell version) to expand/output the raw input.

    .PARAMETER Commmand
        Specifies the command or expression to run. Type the command or expression or enter a variable that contains
        the command or expression. The Command parameter is required.
    #>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]$Command
    )

    PROCESS {
        $IEXSession.layer += 1
        if ($IEXSession.maxLayer -lt $IEXSession.layer) {
            $IEXSession.maxLayer = $IEXSession.layer
        }

        if ($IEXSession.nodryrun) {
            if ($IEXSession.layer -ne 0) {
                # Record every layer's expanded result
                $filePath = "$($IEXSession.outputDir)\$($IEXSession.outputPrefix)_$($IEXSession.baseName)_layer$($IEXSession.layer)_nodryrun.txt"
                Write-Output $Command | Out-File -FilePath $filePath
                Write-Host "[*] " -NoNewLine -ForegroundColor Cyan
                Write-Host "Dump Layer $($IEXSession.layer) to : $filePath"
            }

            # Invoke the original cmdlet to evaulate the expressions
            try {
                Microsoft.PowerShell.Utility\Invoke-Expression $Command
            }
            catch {
                Show-Exception
            }
        } else {
            if (($IEXSession.layer -eq 0) -and $IEXSession.fromScript) {
                # The outermost layer should trigger IEX directly
                try {
                    Microsoft.PowerShell.Utility\Invoke-Expression $Command
                }
                catch {
                    Show-Exception
                }
            } else {
                # The dry-run mode should avoid the trap of calling recursively,
                # and it'll exit once it has peeled off one (and only one) layer.
                $filePath = "$($IEXSession.outputDir)\$($IEXSession.outputPrefix)_$($IEXSession.baseName)_dryrun.txt"
                Tee-Object -InputObject $Command -FilePath $filePath
                Write-Host "[*] " -NoNewLine -ForegroundColor Cyan
                Write-Host "Dump outermost layer to : $filePath"
            }
        }
    }

    END {
        if (($IEXSession.layer -eq $IEXSession.maxLayer) -and $IEXSession.nodryrun) {
            # Expand the array
            $Global:FormatEnumerationLimit = -1
            # Make a set subtraction to get variables that assigned at runtime
            $localVars = Get-Variable -Exclude $IEXSession.filter
            $runtimeVars = $localVars | Where {$IEXSession.Vars -notcontains $_}
            # Record the new variables
            $filePath = "$($IEXSession.outputDir)\$($IEXSession.outputPrefix)_$($IEXSession.baseName)_runtime_vars.txt"
            Get-Variable runtimeVars -ValueOnly |
                Format-Table -AutoSize -Wrap |
                    Out-File -FilePath $filePath
            Write-Host "[*] " -NoNewLine -ForegroundColor Cyan
            Write-Host "Dump runtime variables to : $filePath"
            $Global:FormatEnumerationLimit = $IEXSession.FormatEnumerationLimit
        }
        $IEXSession.layer -= 1
    }
}

function Invoke-Expression2 {
    <#
    .SYNOPSIS
        Invoke-Expression wrapper.

    .PARAMETER Command
        Specifies the command or expression to run. Type the command or expression or enter a variable that contains
        the command or expression. The Command parameter is required.

    .PARAMETER NoDryRun
        The NoDryRun switch is used to instruct the function to invoke the built-in Invoke-Expression.

    .EXAMPLE
        PS C:\> Invoke-Expression2 .\testscript.ps1

    .EXAMPLE
        PS C:\> Invoke-Expression2 .\testscript.ps1 -NoDryRun

    .EXAMPLE
        PS C:\> '.testscript.ps1' | Invoke-Expression2 -NoDryRun

    .NOTES
        Artifacts included:
            * Layer 1 ~ n expanded input
            * Variables and their values created at runtime
    #>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [string]$Command,

        [Parameter(Mandatory=$false)]
        [switch]$NoDryRun
    )

    BEGIN {
        $IEXSession.Vars = Get-Variable
        $IEXSession.nodryrun = $NoDryRun
        $IEXSession.layer = $IEXSession.maxLayer = -1
        $IEXSession.outputDir = "$HOME\Desktop"
        $IEXSession.outputDir = 'of'
        $IEXSession.fromScript = $true
    }

    PROCESS {
        if (Test-Path $Command) {
            $IEXSession.outputDir = Split-Path $Command
            $IEXSession.baseName = (Get-Item $Command).BaseName
        } else {
            $IEXSession.fromScript = $false
            $IEXSession.layer += 1
        }

        # Jump into the Huller
        Invoke-Expression $Command
    }

    END {
        $IEXSession.layer = $IEXSession.maxLayer = -1
    }
}
