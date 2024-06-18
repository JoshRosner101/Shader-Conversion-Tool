param(
    [string]$source = "test.txt",
    [string]$output = "test.glsl",
    [switch]$StG,
    [switch]$BtS,
    [string]$edition
)
$text = Get-Content -Path $source -Raw
if($BtS) {
    if(-not $edition) {
        Write-Host "Must include edition to translate!"
        exit
    }
    $text = $text.Replace("return dissolve_mask(tex, texture_coords, uv);", "")
    $text = $text.Replace("return dissolve_mask(tex*colour, texture_coords, uv);", "")
    $text = $text -replace ("time", "iTime")
    $text = $text.Replace("vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )", "void mainImage( out vec4 fragColor, in vec2 fragCoord )")
    $text = $text.Replace("vec4 tex = Texel( texture, texture_coords);", "")
    $text = $text.Replace("vec4 tex = Texel(texture, texture_coords);", "")
    $text = $text.Replace("vec2 uv = (((texture_coords)*(image_details)) - texture_details.xy*texture_details.ba)/texture_details.ba;", "//This is an emulated version of $($edition). The y is time, and the x is a sin wave over time that slowly increases.`n`tvec2 $($edition) = vec2(sin(iTime)*0.4+iTime/10.0,iTime);`n`tvec2 uv = fragCoord/iResolution.xy;`n`tfragColor = vec4(1.0);")
    $text = $text -replace ("texture_details.ab", "iResolution.xy")
    $text = $text -replace ("texture_details.ba", "iResolution.yx")
    $text = $text -replace ("texture_details.a", "iResolution.x")
    $text = $text -replace ("texture_details.b", "iResolution.y")
    $text = $text -replace ("tex", "fragColor")
    $text = $text -replace ("number", "float")
}
elseif($StG) {
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