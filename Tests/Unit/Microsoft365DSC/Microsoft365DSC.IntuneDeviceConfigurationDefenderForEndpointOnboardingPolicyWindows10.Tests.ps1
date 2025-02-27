[CmdletBinding()]
param(
)
$M365DSCTestFolder = Join-Path -Path $PSScriptRoot `
                        -ChildPath '..\..\Unit' `
                        -Resolve
$CmdletModule = (Join-Path -Path $M365DSCTestFolder `
            -ChildPath '\Stubs\Microsoft365.psm1' `
            -Resolve)
$GenericStubPath = (Join-Path -Path $M365DSCTestFolder `
    -ChildPath '\Stubs\Generic.psm1' `
    -Resolve)
Import-Module -Name (Join-Path -Path $M365DSCTestFolder `
        -ChildPath '\UnitTestHelper.psm1' `
        -Resolve)

$Global:DscHelper = New-M365DscUnitTestHelper -StubModule $CmdletModule `
    -DscResource "IntuneDeviceConfigurationDefenderForEndpointOnboardingPolicyWindows10" -GenericStubModule $GenericStubPath
Describe -Name $Global:DscHelper.DescribeHeader -Fixture {
    InModuleScope -ModuleName $Global:DscHelper.ModuleName -ScriptBlock {
        Invoke-Command -ScriptBlock $Global:DscHelper.InitializeScript -NoNewScope
        BeforeAll {

            $secpasswd = ConvertTo-SecureString "f@kepassword1" -AsPlainText -Force
            $Credential = New-Object System.Management.Automation.PSCredential ('tenantadmin@mydomain.com', $secpasswd)

            Mock -CommandName Confirm-M365DSCDependencies -MockWith {
            }

            Mock -CommandName Get-PSSession -MockWith {
            }

            Mock -CommandName Remove-PSSession -MockWith {
            }

            Mock -CommandName Update-MgDeviceManagementDeviceConfiguration -MockWith {
            }

            Mock -CommandName New-MgDeviceManagementDeviceConfiguration -MockWith {
            }

            Mock -CommandName Remove-MgDeviceManagementDeviceConfiguration -MockWith {
            }

            Mock -CommandName New-M365DSCConnection -MockWith {
                return "Credentials"
            }

            # Mock Write-Host to hide output during the tests
            Mock -CommandName Write-Host -MockWith {
            }

            Mock -CommandName Get-MgDeviceManagementDeviceConfigurationAssignment -MockWith {
            }

        }
        # Test contexts
        Context -Name "The IntuneDeviceConfigurationDefenderForEndpointOnboardingPolicyWindows10 should exist but it DOES NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    AdvancedThreatProtectionAutoPopulateOnboardingBlob = $True
                    AdvancedThreatProtectionOffboardingBlob = "FakeStringValue"
                    AdvancedThreatProtectionOffboardingFilename = "FakeStringValue"
                    AdvancedThreatProtectionOnboardingBlob = "FakeStringValue"
                    AdvancedThreatProtectionOnboardingFilename = "FakeStringValue"
                    AllowSampleSharing = $True
                    Description = "FakeStringValue"
                    DisplayName = "FakeStringValue"
                    EnableExpeditedTelemetryReporting = $True
                    Id = "FakeStringValue"
                    Ensure = "Present"
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgDeviceManagementDeviceConfiguration -MockWith {
                    return $null
                }
            }
            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Absent'
            }
            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }
            It 'Should Create the group from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName New-MgDeviceManagementDeviceConfiguration -Exactly 1
            }
        }

        Context -Name "The IntuneDeviceConfigurationDefenderForEndpointOnboardingPolicyWindows10 exists but it SHOULD NOT" -Fixture {
            BeforeAll {
                $testParams = @{
                    AdvancedThreatProtectionAutoPopulateOnboardingBlob = $True
                    AdvancedThreatProtectionOffboardingBlob = "FakeStringValue"
                    AdvancedThreatProtectionOffboardingFilename = "FakeStringValue"
                    AdvancedThreatProtectionOnboardingBlob = "FakeStringValue"
                    AdvancedThreatProtectionOnboardingFilename = "FakeStringValue"
                    AllowSampleSharing = $True
                    Description = "FakeStringValue"
                    DisplayName = "FakeStringValue"
                    EnableExpeditedTelemetryReporting = $True
                    Id = "FakeStringValue"
                    Ensure = 'Absent'
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgDeviceManagementDeviceConfiguration -MockWith {
                    return @{
                        AdditionalProperties = @{
                            '@odata.type' = "#microsoft.graph.windowsDefenderAdvancedThreatProtectionConfiguration"
                            advancedThreatProtectionOffboardingBlob = "FakeStringValue"
                            allowSampleSharing = $True
                            advancedThreatProtectionOffboardingFilename = "FakeStringValue"
                            enableExpeditedTelemetryReporting = $True
                            advancedThreatProtectionAutoPopulateOnboardingBlob = $True
                            advancedThreatProtectionOnboardingBlob = "FakeStringValue"
                            advancedThreatProtectionOnboardingFilename = "FakeStringValue"
                        }
                        Description = "FakeStringValue"
                        DisplayName = "FakeStringValue"
                        Id = "FakeStringValue"

                    }
                }
            }

            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should Remove the group from the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Remove-MgDeviceManagementDeviceConfiguration -Exactly 1
            }
        }
        Context -Name "The IntuneDeviceConfigurationDefenderForEndpointOnboardingPolicyWindows10 Exists and Values are already in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    AdvancedThreatProtectionAutoPopulateOnboardingBlob = $True
                    AdvancedThreatProtectionOffboardingBlob = "FakeStringValue"
                    AdvancedThreatProtectionOffboardingFilename = "FakeStringValue"
                    AdvancedThreatProtectionOnboardingBlob = "FakeStringValue"
                    AdvancedThreatProtectionOnboardingFilename = "FakeStringValue"
                    AllowSampleSharing = $True
                    Description = "FakeStringValue"
                    DisplayName = "FakeStringValue"
                    EnableExpeditedTelemetryReporting = $True
                    Id = "FakeStringValue"
                    Ensure = 'Present'
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgDeviceManagementDeviceConfiguration -MockWith {
                    return @{
                        AdditionalProperties = @{
                            '@odata.type' = "#microsoft.graph.windowsDefenderAdvancedThreatProtectionConfiguration"
                            advancedThreatProtectionOffboardingBlob = "FakeStringValue"
                            allowSampleSharing = $True
                            advancedThreatProtectionOffboardingFilename = "FakeStringValue"
                            enableExpeditedTelemetryReporting = $True
                            advancedThreatProtectionAutoPopulateOnboardingBlob = $True
                            advancedThreatProtectionOnboardingBlob = "FakeStringValue"
                            advancedThreatProtectionOnboardingFilename = "FakeStringValue"
                        }
                        Description = "FakeStringValue"
                        DisplayName = "FakeStringValue"
                        Id = "FakeStringValue"

                    }
                }
            }


            It 'Should return true from the Test method' {
                Test-TargetResource @testParams | Should -Be $true
            }
        }

        Context -Name "The IntuneDeviceConfigurationDefenderForEndpointOnboardingPolicyWindows10 exists and values are NOT in the desired state" -Fixture {
            BeforeAll {
                $testParams = @{
                    AdvancedThreatProtectionAutoPopulateOnboardingBlob = $True
                    AdvancedThreatProtectionOffboardingBlob = "FakeStringValue"
                    AdvancedThreatProtectionOffboardingFilename = "FakeStringValue"
                    AdvancedThreatProtectionOnboardingBlob = "FakeStringValue"
                    AdvancedThreatProtectionOnboardingFilename = "FakeStringValue"
                    AllowSampleSharing = $True
                    Description = "FakeStringValue"
                    DisplayName = "FakeStringValue"
                    EnableExpeditedTelemetryReporting = $True
                    Id = "FakeStringValue"
                    Ensure = 'Present'
                    Credential = $Credential;
                }

                Mock -CommandName Get-MgDeviceManagementDeviceConfiguration -MockWith {
                    return @{
                        AdditionalProperties = @{
                            advancedThreatProtectionOffboardingBlob = "FakeStringValue"
                            '@odata.type' = "#microsoft.graph.windowsDefenderAdvancedThreatProtectionConfiguration"
                            advancedThreatProtectionOffboardingFilename = "FakeStringValue"
                            advancedThreatProtectionOnboardingBlob = "FakeStringValue"
                            advancedThreatProtectionOnboardingFilename = "FakeStringValue"
                        }
                        Description = "FakeStringValue"
                        DisplayName = "FakeStringValue"
                        Id = "FakeStringValue"
                    }
                }
            }

            It 'Should return Values from the Get method' {
                (Get-TargetResource @testParams).Ensure | Should -Be 'Present'
            }

            It 'Should return false from the Test method' {
                Test-TargetResource @testParams | Should -Be $false
            }

            It 'Should call the Set method' {
                Set-TargetResource @testParams
                Should -Invoke -CommandName Update-MgDeviceManagementDeviceConfiguration -Exactly 1
            }
        }

        Context -Name 'ReverseDSC Tests' -Fixture {
            BeforeAll {
                $Global:CurrentModeIsExport = $true
                $Global:PartialExportFileName = "$(New-Guid).partial.ps1"
                $testParams = @{
                    Credential = $Credential
                }

                Mock -CommandName Get-MgDeviceManagementDeviceConfiguration -MockWith {
                    return @{
                        AdditionalProperties = @{
                            '@odata.type' = "#microsoft.graph.windowsDefenderAdvancedThreatProtectionConfiguration"
                            advancedThreatProtectionOffboardingBlob = "FakeStringValue"
                            allowSampleSharing = $True
                            advancedThreatProtectionOffboardingFilename = "FakeStringValue"
                            enableExpeditedTelemetryReporting = $True
                            advancedThreatProtectionAutoPopulateOnboardingBlob = $True
                            advancedThreatProtectionOnboardingBlob = "FakeStringValue"
                            advancedThreatProtectionOnboardingFilename = "FakeStringValue"
                        }
                        Description = "FakeStringValue"
                        DisplayName = "FakeStringValue"
                        Id = "FakeStringValue"

                    }
                }
            }
            It 'Should Reverse Engineer resource from the Export method' {
                $result = Export-TargetResource @testParams
                $result | Should -Not -BeNullOrEmpty
            }
        }
    }
}

Invoke-Command -ScriptBlock $Global:DscHelper.CleanupScript -NoNewScope
