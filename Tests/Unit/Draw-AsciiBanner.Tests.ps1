BeforeAll {
    # Import the module
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\..\AsBuiltReport.Core\AsBuiltReport.Core.psd1'
    Import-Module $ModulePath -Force
}

Describe 'Draw-AsciiBanner Unit Tests' {
    Context 'Function Exists' {
        It 'Should have Draw-AsciiBanner function available' {
            InModuleScope 'AsBuiltReport.Core' {
                $Function = Get-Command -Name 'Draw-AsciiBanner' -ErrorAction SilentlyContinue
                $Function | Should -Not -BeNullOrEmpty
            }
        }
    }

    Context 'Basic Functionality' {
        It 'Should call Write-Host when drawing banner' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Write-Host { }
                Draw-AsciiBanner -Lines @('Test') -TextColor 'Cyan' -SeparatorColor 'Cyan'
                Should -Invoke Write-Host -Times 3
            }
        }

        It 'Should draw separators and text with single line' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Write-Host { }
                Draw-AsciiBanner -Lines @('Test Line') -TextColor 'Green' -SeparatorColor 'Yellow'
                Should -Invoke Write-Host -Times 3
            }
        }

        It 'Should draw separators and text with multiple lines' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Write-Host { }
                Draw-AsciiBanner -Lines @('Line 1', 'Line 2', 'Line 3') -TextColor 'White' -SeparatorColor 'Cyan'
                Should -Invoke Write-Host -Times 5
            }
        }

        It 'Should use specified text color' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Write-Host { }
                Draw-AsciiBanner -Lines @('Test') -TextColor 'Red' -SeparatorColor 'Blue'
                Should -Invoke Write-Host -ParameterFilter { $ForegroundColor -eq 'Red' } -Times 1
            }
        }

        It 'Should use specified separator color' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Write-Host { }
                Draw-AsciiBanner -Lines @('Test') -TextColor 'Red' -SeparatorColor 'Blue'
                Should -Invoke Write-Host -ParameterFilter { $ForegroundColor -eq 'Blue' } -Times 2
            }
        }

        It 'Should handle empty lines array' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Write-Host { }
                Draw-AsciiBanner -Lines @() -TextColor 'Cyan' -SeparatorColor 'Cyan'
                Should -Invoke Write-Host -Times 2
            }
        }

        It 'Should accept custom separator length' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Write-Host { }
                Draw-AsciiBanner -Lines @('Test') -TextColor 'Cyan' -SeparatorColor 'Cyan' -SeparatorLength 80
                Should -Invoke Write-Host -Times 3
            }
        }
    }

    Context 'Parameter Validation' {
        It 'Should accept Lines parameter as string array' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Write-Host { }
                { Draw-AsciiBanner -Lines @('Test1', 'Test2') -TextColor 'Cyan' -SeparatorColor 'Cyan' } | Should -Not -Throw
            }
        }

        It 'Should accept TextColor parameter' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Write-Host { }
                { Draw-AsciiBanner -Lines @('Test') -TextColor 'Green' -SeparatorColor 'Cyan' } | Should -Not -Throw
            }
        }

        It 'Should accept SeparatorColor parameter' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Write-Host { }
                { Draw-AsciiBanner -Lines @('Test') -TextColor 'Cyan' -SeparatorColor 'Yellow' } | Should -Not -Throw
            }
        }

        It 'Should accept SeparatorLength parameter' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Write-Host { }
                { Draw-AsciiBanner -Lines @('Test') -TextColor 'Cyan' -SeparatorColor 'Cyan' -SeparatorLength 100 } | Should -Not -Throw
            }
        }

        It 'Should use default SeparatorLength of 60 when not specified' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Write-Host { param($Object) $script:LastSeparator = $Object }
                Draw-AsciiBanner -Lines @() -TextColor 'Cyan' -SeparatorColor 'Cyan'
                $script:LastSeparator.Length | Should -Be 60
            }
        }
    }

    Context 'Content Formatting' {
        It 'Should add padding to text lines' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Write-Host { param($Object) $script:Output += @($Object) }
                $script:Output = @()
                Draw-AsciiBanner -Lines @('Test') -TextColor 'Cyan' -SeparatorColor 'Cyan'
                $TextLine = $script:Output | Where-Object { $_ -match 'Test' }
                $TextLine | Should -BeLike '  Test'
            }
        }

        It 'Should format multiple lines correctly' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Write-Host { param($Object) $script:Output += @($Object) }
                $script:Output = @()
                Draw-AsciiBanner -Lines @('Line1', 'Line2') -TextColor 'Cyan' -SeparatorColor 'Cyan'
                $script:Output[1] | Should -BeLike '  Line1'
                $script:Output[2] | Should -BeLike '  Line2'
            }
        }

        It 'Should use horizontal line character for separator' {
            InModuleScope 'AsBuiltReport.Core' {
                Mock Write-Host { param($Object) $script:Output += @($Object) }
                $script:Output = @()
                Draw-AsciiBanner -Lines @() -TextColor 'Cyan' -SeparatorColor 'Cyan'
                # Check separator line properties instead of exact character match
                # This handles encoding differences between PS 5.1 and PS 7.x
                $separator = $script:Output[0]
                $separator.Length | Should -Be 60
                # Verify all characters in the separator are the same
                $uniqueChars = $separator.ToCharArray() | Select-Object -Unique
                $uniqueChars.Count | Should -Be 1
                # Verify it's the expected Unicode character (0x2500)
                [int][char]$uniqueChars[0] | Should -Be 0x2500
            }
        }
    }

    Context 'Integration with Console Colors' {
        It 'Should accept standard console color for text' {
            InModuleScope 'AsBuiltReport.Core' {
                $Colors = @('Cyan', 'Yellow', 'Green', 'Red', 'Blue')
                Mock Write-Host { }
                foreach ($Color in $Colors) {
                    { Draw-AsciiBanner -Lines @('Test') -TextColor $Color -SeparatorColor 'Cyan' } | Should -Not -Throw
                }
            }
        }

        It 'Should accept standard console color for separator' {
            InModuleScope 'AsBuiltReport.Core' {
                $Colors = @('Cyan', 'Yellow', 'Green', 'Red', 'Blue')
                Mock Write-Host { }
                foreach ($Color in $Colors) {
                    { Draw-AsciiBanner -Lines @('Test') -TextColor 'White' -SeparatorColor $Color } | Should -Not -Throw
                }
            }
        }
    }
}

AfterAll {
    Remove-Module -Name 'AsBuiltReport.Core' -Force -ErrorAction SilentlyContinue
}
