# Shader Conversion Tool
 
This is a simple powershell script to convert GLSL shaders from how they're written in ShaderToy to regular GLSL shaders. This process can also be done in reverse. I've been working on implementing shaders in Balatro modding, so I have also implemented some conversion tools between that format and the others.

The script can be ran by running this command in the downloaded folder:
```powershell
./shader-conversion-tool.ps1
```

|flag|function|default|
|--|--|--|
| source | defines source file|test.txt|
| output | defines output file |test.glsl|
| edition | Balatro edition name ||
| StG | Shadertoy to GLSL ||
| BtS | Balatro to ShaderToy ||

# Examples
## ShaderToy to GLSL
Open Windows Powershell in this directory and run the command
```powershell
./shader-conversion-tool.ps1 -source test.txt -output test.glsl
```
This will convert the ShaderToy code in "test.txt" into GLSL code that will be outputted to "test.glsl".

## GLSL to ShaderToy
To convert from GLSL to ShaderToy, open Windows Powershell in this directory and run the command
```powershell
./shader-conversion-tool.ps1 -source test.glsl -output test.txt -StG
```
This will convert the GLSL code in "test.glsl" into ShaderToy code that will be outputted to "test.txt".s