# Function to resolve culture with fallback
function Resolve-Culture {
    <#
    .SYNOPSIS
        Resolves a culture name to a fallback chain of culture names.
    .DESCRIPTION
        Returns an array of culture names representing the fallback chain for a given culture.
        The function provides intelligent fallbacks for regional language variants.

        For example, 'fr-CA' (French-Canada) will fall back to 'fr-FR' (French-France), then 'en-US'.
        This ensures that if a specific regional translation is not available, the function will try
        the parent language, and finally fall back to en-US.

        The function includes comprehensive mappings for:
        - English variants (en-AU, en-GB, en-CA, etc.)
        - Chinese variants (simplified and traditional)
        - French, Spanish, German, Italian variants
        - Japanese, Korean, Arabic, and many other languages
    .PARAMETER CultureName
        The culture name to resolve (e.g., 'en-US', 'fr-CA', 'zh-CN').
    .OUTPUTS
        System.String[]
        Returns an array of culture names in fallback order.
    .EXAMPLE
        Resolve-Culture -CultureName 'fr-CA'

        Returns: @('fr-CA', 'fr-FR', 'en-US')
    .EXAMPLE
        Resolve-Culture -CultureName 'en-AU'

        Returns: @('en-AU', 'en-GB', 'en-US')
    .EXAMPLE
        Resolve-Culture -CultureName 'es-MX'

        Returns: @('es-MX', 'es-ES', 'en-US')
    .NOTES
        This is a private function used internally by Initialize-LocalizedData.
        Supports over 60 culture variants with intelligent fallback chains.
        If a culture is not explicitly mapped, the function will attempt to fall back to
        the parent language family (e.g., 'de-XX' -> 'de-DE' -> 'en-US').
    #>
    param([string]$CultureName)

    # Define culture mapping with fallback chain
    $CultureMappings = @{
        # English variants
        'en-AU' = @('en-AU', 'en-GB', 'en-US')
        'en-CA' = @('en-CA', 'en-GB', 'en-US')
        'en-IE' = @('en-IE', 'en-GB', 'en-US')
        'en-IN' = @('en-IN', 'en-GB', 'en-US')
        'en-NZ' = @('en-NZ', 'en-GB', 'en-US')
        'en-SG' = @('en-SG', 'en-GB', 'en-US')
        'en-ZA' = @('en-ZA', 'en-GB', 'en-US')
        'en-GB' = @('en-GB', 'en-US')
        'en-US' = @('en-US')

        # Chinese variants
        'zh-CN' = @('zh-CN', 'zh-Hans', 'en-US')     # Simplified Chinese (China)
        'zh-TW' = @('zh-TW', 'zh-Hant', 'en-US')     # Traditional Chinese (Taiwan)
        'zh-HK' = @('zh-HK', 'zh-Hant', 'zh-TW', 'en-US')  # Chinese (Hong Kong)
        'zh-SG' = @('zh-SG', 'zh-Hans', 'zh-CN', 'en-US')  # Chinese (Singapore)
        'zh-MO' = @('zh-MO', 'zh-Hant', 'zh-HK', 'en-US')  # Chinese (Macau)
        'zh-Hans' = @('zh-Hans', 'zh-CN', 'en-US')   # Simplified Chinese
        'zh-Hant' = @('zh-Hant', 'zh-TW', 'en-US')   # Traditional Chinese

        # French variants
        'fr-FR' = @('fr-FR', 'en-US')                # French (France)
        'fr-CA' = @('fr-CA', 'fr-FR', 'en-US')       # French (Canada)
        'fr-BE' = @('fr-BE', 'fr-FR', 'en-US')       # French (Belgium)
        'fr-CH' = @('fr-CH', 'fr-FR', 'en-US')       # French (Switzerland)
        'fr-LU' = @('fr-LU', 'fr-FR', 'en-US')       # French (Luxembourg)
        'fr-MC' = @('fr-MC', 'fr-FR', 'en-US')       # French (Monaco)

        # Spanish variants
        'es-ES' = @('es-ES', 'en-US')                # Spanish (Spain)
        'es-MX' = @('es-MX', 'es-ES', 'en-US')       # Spanish (Mexico)
        'es-AR' = @('es-AR', 'es-ES', 'en-US')       # Spanish (Argentina)
        'es-CL' = @('es-CL', 'es-ES', 'en-US')       # Spanish (Chile)
        'es-CO' = @('es-CO', 'es-ES', 'en-US')       # Spanish (Colombia)
        'es-PE' = @('es-PE', 'es-ES', 'en-US')       # Spanish (Peru)
        'es-VE' = @('es-VE', 'es-ES', 'en-US')       # Spanish (Venezuela)
        'es-UY' = @('es-UY', 'es-AR', 'es-ES', 'en-US')  # Spanish (Uruguay)
        'es-PY' = @('es-PY', 'es-AR', 'es-ES', 'en-US')  # Spanish (Paraguay)
        'es-BO' = @('es-BO', 'es-ES', 'en-US')       # Spanish (Bolivia)
        'es-EC' = @('es-EC', 'es-ES', 'en-US')       # Spanish (Ecuador)
        'es-US' = @('es-US', 'es-MX', 'es-ES', 'en-US')  # Spanish (United States)

        # German variants
        'de-DE' = @('de-DE', 'en-US')                # German (Germany)
        'de-AT' = @('de-AT', 'de-DE', 'en-US')       # German (Austria)
        'de-CH' = @('de-CH', 'de-DE', 'en-US')       # German (Switzerland)
        'de-LI' = @('de-LI', 'de-CH', 'de-DE', 'en-US')  # German (Liechtenstein)
        'de-LU' = @('de-LU', 'de-DE', 'en-US')       # German (Luxembourg)

        # Italian variants
        'it-IT' = @('it-IT', 'en-US')                # Italian (Italy)
        'it-CH' = @('it-CH', 'it-IT', 'en-US')       # Italian (Switzerland)
        'it-SM' = @('it-SM', 'it-IT', 'en-US')       # Italian (San Marino)
        'it-VA' = @('it-VA', 'it-IT', 'en-US')       # Italian (Vatican)

        # Japanese variants
        'ja-JP' = @('ja-JP', 'en-US')                # Japanese (Japan)

        # Portuguese variants
        'pt-PT' = @('pt-PT', 'en-US')                # Portuguese (Portugal)
        'pt-BR' = @('pt-BR', 'pt-PT', 'en-US')       # Portuguese (Brazil)
        'pt-AO' = @('pt-AO', 'pt-PT', 'en-US')       # Portuguese (Angola)
        'pt-MZ' = @('pt-MZ', 'pt-PT', 'en-US')       # Portuguese (Mozambique)

        # Russian variants
        'ru-RU' = @('ru-RU', 'en-US')                # Russian (Russia)
        'ru-BY' = @('ru-BY', 'ru-RU', 'en-US')       # Russian (Belarus)
        'ru-KZ' = @('ru-KZ', 'ru-RU', 'en-US')       # Russian (Kazakhstan)

        # Arabic variants
        'ar-SA' = @('ar-SA', 'en-US')                # Arabic (Saudi Arabia)
        'ar-EG' = @('ar-EG', 'ar-SA', 'en-US')       # Arabic (Egypt)
        'ar-AE' = @('ar-AE', 'ar-SA', 'en-US')       # Arabic (UAE)
        'ar-JO' = @('ar-JO', 'ar-SA', 'en-US')       # Arabic (Jordan)
        'ar-LB' = @('ar-LB', 'ar-SA', 'en-US')       # Arabic (Lebanon)

        # Korean variants
        'ko-KR' = @('ko-KR', 'en-US')                # Korean (South Korea)
        'ko-KP' = @('ko-KP', 'ko-KR', 'en-US')       # Korean (North Korea)

        # Dutch variants
        'nl-NL' = @('nl-NL', 'en-US')                # Dutch (Netherlands)
        'nl-BE' = @('nl-BE', 'nl-NL', 'en-US')       # Dutch (Belgium)

        # Swedish variants
        'sv-SE' = @('sv-SE', 'en-US')                # Swedish (Sweden)
        'sv-FI' = @('sv-FI', 'sv-SE', 'en-US')       # Swedish (Finland)

        # Norwegian variants
        'nb-NO' = @('nb-NO', 'en-US')                # Norwegian Bokmål
        'nn-NO' = @('nn-NO', 'nb-NO', 'en-US')       # Norwegian Nynorsk
        'no-NO' = @('no-NO', 'nb-NO', 'en-US')       # Norwegian (legacy)

        # Danish variants
        'da-DK' = @('da-DK', 'en-US')                # Danish (Denmark)
        'da-GL' = @('da-GL', 'da-DK', 'en-US')       # Danish (Greenland)

        # Finnish variants
        'fi-FI' = @('fi-FI', 'en-US')                # Finnish (Finland)

        # Polish variants
        'pl-PL' = @('pl-PL', 'en-US')                # Polish (Poland)

        # Czech variants
        'cs-CZ' = @('cs-CZ', 'en-US')                # Czech (Czech Republic)

        # Hungarian variants
        'hu-HU' = @('hu-HU', 'en-US')                # Hungarian (Hungary)

        # Turkish variants
        'tr-TR' = @('tr-TR', 'en-US')                # Turkish (Turkey)
        'tr-CY' = @('tr-CY', 'tr-TR', 'en-US')       # Turkish (Cyprus)

        # Greek variants
        'el-GR' = @('el-GR', 'en-US')                # Greek (Greece)
        'el-CY' = @('el-CY', 'el-GR', 'en-US')       # Greek (Cyprus)

        # Hebrew variants
        'he-IL' = @('he-IL', 'en-US')                # Hebrew (Israel)

        # Hindi variants
        'hi-IN' = @('hi-IN', 'en-US')                # Hindi (India)

        # Thai variants
        'th-TH' = @('th-TH', 'en-US')                # Thai (Thailand)

        # Vietnamese variants
        'vi-VN' = @('vi-VN', 'en-US')                # Vietnamese (Vietnam)
    }

    # Automatic fallback for language families not explicitly mapped
    $LanguageCode = $CultureName.Split('-')[0]
    $LanguageFallbacks = @{
        'en' = @('en-GB', 'en-US')
        'zh' = @('zh-CN', 'zh-Hans', 'en-US')
        'fr' = @('fr-FR', 'en-US')
        'es' = @('es-ES', 'en-US')
        'de' = @('de-DE', 'en-US')
        'it' = @('it-IT', 'en-US')
        'ja' = @('ja-JP', 'en-US')
        'pt' = @('pt-PT', 'en-US')
        'ru' = @('ru-RU', 'en-US')
        'ar' = @('ar-SA', 'en-US')
        'ko' = @('ko-KR', 'en-US')
        'nl' = @('nl-NL', 'en-US')
        'sv' = @('sv-SE', 'en-US')
        'no' = @('nb-NO', 'en-US')
        'nb' = @('nb-NO', 'en-US')
        'nn' = @('nn-NO', 'nb-NO', 'en-US')
        'da' = @('da-DK', 'en-US')
        'fi' = @('fi-FI', 'en-US')
        'pl' = @('pl-PL', 'en-US')
        'cs' = @('cs-CZ', 'en-US')
        'hu' = @('hu-HU', 'en-US')
        'tr' = @('tr-TR', 'en-US')
        'el' = @('el-GR', 'en-US')
        'he' = @('he-IL', 'en-US')
        'hi' = @('hi-IN', 'en-US')
        'th' = @('th-TH', 'en-US')
        'vi' = @('vi-VN', 'en-US')
    }

    # Return explicit mapping if exists
    if ($CultureMappings.ContainsKey($CultureName)) {
        return $CultureMappings[$CultureName]
    }

    # Return language family fallback if exists
    if ($LanguageFallbacks.ContainsKey($LanguageCode)) {
        return @($CultureName) + $LanguageFallbacks[$LanguageCode]
    }

    # Final fallback
    return @($CultureName, 'en-US')
}