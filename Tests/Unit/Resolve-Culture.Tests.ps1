BeforeAll {
    # Import the module
    $ModulePath = Join-Path -Path $PSScriptRoot -ChildPath '..\..\AsBuiltReport.Core\AsBuiltReport.Core.psd1'
    Import-Module $ModulePath -Force
}

Describe 'Resolve-Culture Unit Tests' {
    Context 'Function Exists' {
        It 'Should have Resolve-Culture function available' {
            InModuleScope 'AsBuiltReport.Core' {
                $Function = Get-Command -Name 'Resolve-Culture' -ErrorAction SilentlyContinue
                $Function | Should -Not -BeNullOrEmpty
            }
        }
    }

    Context 'English Culture Variants' {
        It 'Should resolve en-US to itself' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'en-US'
                $Result | Should -Be @('en-US')
            }
        }

        It 'Should resolve en-GB to en-GB, en-US' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'en-GB'
                $Result | Should -Be @('en-GB', 'en-US')
            }
        }

        It 'Should resolve en-AU to en-AU, en-GB, en-US' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'en-AU'
                $Result | Should -Be @('en-AU', 'en-GB', 'en-US')
            }
        }

        It 'Should resolve en-CA to en-CA, en-GB, en-US' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'en-CA'
                $Result | Should -Be @('en-CA', 'en-GB', 'en-US')
            }
        }

        It 'Should resolve en-NZ to en-NZ, en-GB, en-US' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'en-NZ'
                $Result | Should -Be @('en-NZ', 'en-GB', 'en-US')
            }
        }
    }

    Context 'Chinese Culture Variants' {
        It 'Should resolve zh-CN (Simplified Chinese) correctly' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'zh-CN'
                $Result | Should -Be @('zh-CN', 'zh-Hans', 'en-US')
            }
        }

        It 'Should resolve zh-TW (Traditional Chinese) correctly' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'zh-TW'
                $Result | Should -Be @('zh-TW', 'zh-Hant', 'en-US')
            }
        }

        It 'Should resolve zh-HK (Hong Kong) correctly' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'zh-HK'
                $Result | Should -Be @('zh-HK', 'zh-Hant', 'zh-TW', 'en-US')
            }
        }

        It 'Should resolve zh-Hans (Simplified) correctly' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'zh-Hans'
                $Result | Should -Be @('zh-Hans', 'zh-CN', 'en-US')
            }
        }
    }

    Context 'French Culture Variants' {
        It 'Should resolve fr-FR to fr-FR, en-US' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'fr-FR'
                $Result | Should -Be @('fr-FR', 'en-US')
            }
        }

        It 'Should resolve fr-CA to fr-CA, fr-FR, en-US' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'fr-CA'
                $Result | Should -Be @('fr-CA', 'fr-FR', 'en-US')
            }
        }

        It 'Should resolve fr-BE to fr-BE, fr-FR, en-US' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'fr-BE'
                $Result | Should -Be @('fr-BE', 'fr-FR', 'en-US')
            }
        }
    }

    Context 'Spanish Culture Variants' {
        It 'Should resolve es-ES to es-ES, en-US' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'es-ES'
                $Result | Should -Be @('es-ES', 'en-US')
            }
        }

        It 'Should resolve es-MX to es-MX, es-ES, en-US' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'es-MX'
                $Result | Should -Be @('es-MX', 'es-ES', 'en-US')
            }
        }

        It 'Should resolve es-AR to es-AR, es-ES, en-US' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'es-AR'
                $Result | Should -Be @('es-AR', 'es-ES', 'en-US')
            }
        }

        It 'Should resolve es-US to es-US, es-MX, es-ES, en-US' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'es-US'
                $Result | Should -Be @('es-US', 'es-MX', 'es-ES', 'en-US')
            }
        }
    }

    Context 'German Culture Variants' {
        It 'Should resolve de-DE to de-DE, en-US' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'de-DE'
                $Result | Should -Be @('de-DE', 'en-US')
            }
        }

        It 'Should resolve de-AT to de-AT, de-DE, en-US' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'de-AT'
                $Result | Should -Be @('de-AT', 'de-DE', 'en-US')
            }
        }

        It 'Should resolve de-CH to de-CH, de-DE, en-US' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'de-CH'
                $Result | Should -Be @('de-CH', 'de-DE', 'en-US')
            }
        }
    }

    Context 'Other Major Languages' {
        It 'Should resolve ja-JP to ja-JP, en-US' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'ja-JP'
                $Result | Should -Be @('ja-JP', 'en-US')
            }
        }

        It 'Should resolve ko-KR to ko-KR, en-US' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'ko-KR'
                $Result | Should -Be @('ko-KR', 'en-US')
            }
        }

        It 'Should resolve pt-BR to pt-BR, pt-PT, en-US' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'pt-BR'
                $Result | Should -Be @('pt-BR', 'pt-PT', 'en-US')
            }
        }

        It 'Should resolve ru-RU to ru-RU, en-US' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'ru-RU'
                $Result | Should -Be @('ru-RU', 'en-US')
            }
        }

        It 'Should resolve ar-SA to ar-SA, en-US' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'ar-SA'
                $Result | Should -Be @('ar-SA', 'en-US')
            }
        }
    }

    Context 'Language Family Fallback' {
        It 'Should fallback unmapped French variant to fr-FR' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'fr-XX'
                $Result | Should -Be @('fr-XX', 'fr-FR', 'en-US')
            }
        }

        It 'Should fallback unmapped German variant to de-DE' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'de-XX'
                $Result | Should -Be @('de-XX', 'de-DE', 'en-US')
            }
        }

        It 'Should fallback unmapped Spanish variant to es-ES' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'es-XX'
                $Result | Should -Be @('es-XX', 'es-ES', 'en-US')
            }
        }
    }

    Context 'Unknown Culture Fallback' {
        It 'Should fallback completely unknown culture to en-US' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'xx-YY'
                $Result | Should -Be @('xx-YY', 'en-US')
            }
        }

        It 'Should fallback unknown language family to en-US' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'zz-ZZ'
                $Result | Should -Be @('zz-ZZ', 'en-US')
            }
        }
    }

    Context 'Return Type' {
        It 'Should return an array' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'en-GB'
                $Result.Count | Should -BeGreaterThan 1
            }
        }

        It 'Should return at least 1 culture' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'en-US'
                $Result.Count | Should -BeGreaterOrEqual 1
            }
        }

        It 'Should always end with en-US fallback' {
            InModuleScope 'AsBuiltReport.Core' {
                $Result = Resolve-Culture -CultureName 'fr-CA'
                $Result[-1] | Should -Be 'en-US'
            }
        }
    }
}

AfterAll {
    Remove-Module -Name 'AsBuiltReport.Core' -Force -ErrorAction SilentlyContinue
}
