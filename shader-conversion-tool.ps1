param(
    [string]$source = "test.txt",
    [string]$output = "test.glsl",
    [switch]$StG
)
$text = Get-Content -Path $source -Raw
if($StG) {
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
    
    $text = "precision mediump float;`n`nuniform vec2 u_resolution;`nuniform vec2 u_mouse;`nuniform float u_time;`n`n$($text)" 
}

Write-Output $text | Out-File $output