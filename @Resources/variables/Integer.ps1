param (
    [Parameter()]
    [System.Collections.Hashtable]
    $Variable,
    [Parameter()]
    [System.Collections.Hashtable]
    $Options
)

$ini = @"
[VariableIcon$($Variable.Index)]
Meter=String
Text=$($Variable.Icon)
MeterStyle=VariableIcon | $($Options.Container)

[VariableTitle$($Variable.Index)]
Meter=String
Text=$($Variable.Name)
MeterStyle=VarTitle | $($Options.Container)

[VariableDescription$($Variable.Index)]
Meter=String
Text=$($Variable.Description)
MeterStyle=VarDescription | $($Options.Container)

[VariableValue$($Variable.Index)]
Meter=String
Text=[#$($Variable.Key)]
MeterStyle=VarStringValue | $($Options.Container)
LeftMouseUpAction=[!CommandMeasure "InputText$($Variable.Index)" "ExecuteBatch All"][!SetOption #CURRENTSECTION# FontColor "0,0,0,0"][!UpdateMeter #CURRENTSECTION#][!Redraw]

[InputText$($Variable.Index)]
Measure=Plugin
Plugin=InputText
SolidColor=[#s_RightPanelBackgroundColor]
FontColor=[#s_FontColor]
FontFace=[#s_FontFace]
FontSize=[#s_InputTextFontSize]
X=([VariableValue$($Variable.Index):X])
Y=([VariableValue$($Variable.Index):Y] + [#s_ValueYPadding])
H=[VariableValue$($Variable.Index):H]
W=([#s_RightPanelW] - ([#s_VariableXPadding] * 2))
DynamicVariables=1
DefaultValue=[#$($Variable.Key)]
Command1=[!WriteKeyValue "Variables" "$($Variable.Key)" "`$UserInput`$" "$($Options.SettingsFile)"][!Refresh][#s_OnChangeAction]
OnDismissAction=[!SetOption VariableValue$($Variable.Index) FontColor "[#s_FontColor]"][!UpdateMeter VariableValue$($Variable.Index)][!Redraw]
InputNumber=1


"@

return $ini