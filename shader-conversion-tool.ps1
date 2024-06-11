$filePath = $args[0]
$outputFilePath = $args[1]
$flag = $args[2]
$text = Get-Content -Path $filePath -Raw
if($flag -eq "-r") {
    $text = $text.Replace("void main()", "void mainImage( out vec4 fragColor, in vec2 fragCoord )")
    $text = $text -replace ("precision mediump float;", "")
    $text = $text -replace ("uniform vec2 u_resolution;", "")
    $text = $text -replace ("uniform vec2 u_mouse;", "")
    $text = $text -replace ("uniform float u_time;", "")
    $text = $text -replace ("gl_FragCoord","fragCoord")
    $text = $text -replace ("gl_FragColor","fragColor")
    $text = $text -replace ("u_resolution","iResolution")
    $text = $text -replace ("u_time","iTime")
    $text = $text -replace ("u_mouse","iMouse")
}
else {
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

$($text)" 
}

Write-Output $text | Out-File $outputFilePath