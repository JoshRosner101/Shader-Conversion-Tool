$filePath = $args[0]
$outputFilePath = $args[1]

$text = Get-Content -Path $filePath -Raw
$text = $text.Replace("void mainImage( out vec4 fragColor, in vec2 fragCoord )", "void main()")
$text = $text -replace ("fragCoord","gl_FragCoord")
$text = $text -replace ("gl_FragCoord(?=[^.])","gl_FragCoord.xy")
$text = $text -replace ("fragColor","gl_FragColor")
$text = $text -replace ("iResolution","u_resolution")
$text = $text -replace ("iTime","u_time")
$text = $text -replace ("iMouse","u_mouse")

$text = "precision mediump float;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

" + $text 

Write-Output $text | Out-File $outputFilePath